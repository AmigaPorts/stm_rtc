/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "msm_rtc.h"
#include "usart.h"
#include "gpio.h"

// CubeMX doesn't generate defines with bit number of user-defined pin names

#if defined(STM32F031x6)
#define D0_Pos 4
#define A0_Pos 8
#define NCS0_Pos 15
#define NRD_Pos 12
#define NWR_Pos 13
#elif defined(STM32F030x6)
#define D0_Pos 8
#define A0_Pos 8
#define NCS0_Pos 6
#define NRD_Pos 1
#define NWR_Pos 0
#else
#error Unknown STM!
#endif

#define BV(x) (1 << (x))
#define READ_MASK (BV(NRD_Pos) | BV(NCS0_Pos))
#define WRITE_MASK (BV(NWR_Pos) | BV(NCS0_Pos))
#define MODE_OUT(x) BV((x) * 2)
#define HISPEED(x) (3 << ((x) * 2))

/**
 * @brief MSM6242 register codes (address lines decoding)
 *
 */
typedef enum _tMsmReg {
	MSM_SECONDS_1 = 0,
	MSM_SECONDS_10,
	MSM_MINUTES_1,
	MSM_MINUTES_10,
	MSM_HOURS_1,
	MSM_HOURS_10,
	MSM_DAY_1,
	MSM_DAY_10,
	MSM_MONTH_1,
	MSM_MONTH_10,
	MSM_YEAR_1,
	MSM_YEAR_10,
	MSM_DAY_OF_WEEK,
	MSM_CONTROL_D,
	MSM_CONTROL_E,
	MSM_CONTROL_F,
	MSM_ADDR_COUNT
} tMsmReg;

void msmRtcInit(void) {
	// Speed up data lines
	D0_GPIO_Port->OSPEEDR |= (
		HISPEED(D0_Pos + 0) | HISPEED(D0_Pos + 1) |
		HISPEED(D0_Pos + 2) | HISPEED(D0_Pos + 3)
	);

	// Print hello message
	// printf(
	// 	"RTC_INIT: %lu%lu.%lu%lu.%lu%lu %lu%lu:%lu%lu:%lu%lu\r\n",
	// 	// Date
	// 	((RTC->DR & RTC_DR_DT_Msk) >> RTC_DR_DT_Pos),
	// 	((RTC->DR & RTC_DR_DU_Msk) >> RTC_DR_DU_Pos),
	// 	((RTC->DR & RTC_DR_MT_Msk) >> RTC_DR_MT_Pos),
	// 	((RTC->DR & RTC_DR_MU_Msk) >> RTC_DR_MU_Pos),
	// 	((RTC->DR & RTC_DR_YT_Msk) >> RTC_DR_YT_Pos),
	// 	((RTC->DR & RTC_DR_YU_Msk) >> RTC_DR_YU_Pos),
	// 	// Time
	// 	((RTC->TR & RTC_TR_HT_Msk) >> RTC_TR_HT_Pos),
	// 	((RTC->TR & RTC_TR_HU_Msk) >> RTC_TR_HU_Pos),
	// 	((RTC->TR & RTC_TR_MNT_Msk) >> RTC_TR_MNT_Pos),
	// 	((RTC->TR & RTC_TR_MNU_Msk) >> RTC_TR_MNU_Pos),
	// 	((RTC->TR & RTC_TR_ST_Msk) >> RTC_TR_ST_Pos),
	// 	((RTC->TR & RTC_TR_SU_Msk) >> RTC_TR_SU_Pos)
	// );
	D0_GPIO_Port->MODER = 0;
}

static volatile uint32_t s_pMsmFields[MSM_ADDR_COUNT] = {
	 0 << D0_Pos,  1 << D0_Pos,  2 << D0_Pos,  3 << D0_Pos,
	 4 << D0_Pos,  5 << D0_Pos,  6 << D0_Pos,  7 << D0_Pos,
	 8 << D0_Pos,  9 << D0_Pos, 10 << D0_Pos, 11 << D0_Pos,
	12 << D0_Pos, 13 << D0_Pos, 14 << D0_Pos, 15 << D0_Pos
};

// #define USE_ASM

#if defined(USE_ASM)

const uint16_t uwModerDataOut = (
	MODE_OUT(D0_Pos + 0) | MODE_OUT(D0_Pos + 1) |
	MODE_OUT(D0_Pos + 2) | MODE_OUT(D0_Pos + 3)
);
volatile const uint16_t uwWriteMask = WRITE_MASK;
volatile const uint16_t uwReadMask = READ_MASK;
volatile GPIO_TypeDef *pPortD0 = D0_GPIO_Port;
volatile GPIO_TypeDef *pPortA0 = A0_GPIO_Port;

static inline __attribute__((always_inline)) void rtcInitAsm(void) {
	// Done once, r9-r3 are permanently used up
	__asm__ __volatile__(
		".thumb \n"
		"ldr r0, =uwModerDataOut \n"
		"mov r9, r0 \n"
		"ldr r0, =s_pMsmFields \n"
		"mov r8, r0 \n"
		"ldr r7, =pPortD0 \n"
		"ldr r6, =pPortA0 \n"
		"ldr r5, =uwWriteMask \n"
		"ldr r4, =uwReadMask \n"
		"movs r3, %0\n"
		::
			"i"(0xF << 2)
	);
}

static inline __attribute__((always_inline)) void rtcReadWriteProcessAsm(void) {
	const uint8_t ubOffsA0 = A0_Pos - 2;
	const uint16_t uwOffsModer = offsetof(GPIO_TypeDef, MODER);
	const uint16_t uwOffsOdr = offsetof(GPIO_TypeDef, ODR);
	const uint16_t uwOffsIdr = offsetof(GPIO_TypeDef, IDR);
	__asm__ __volatile__ (
		".thumb \n"
		".syntax unified \n"
		".2: \n"
		"ldr r0, [r6, %3] \n"
		"tst r0, r4 \n"
		"beq .1 \n"

		"tst r0, r5 \n"
		"bne .3 \n"

		// WRITE stuff
		"b .3 \n"

		// READ stuff
		".1: \n"
		// "ldr r0, [r6] \n" // not needed since read with status bits
		"lsrs r0, %0 \n"
		"ands r0, r3 \n"
		"add r0, r8 \n"
		"ldr r0, [r0] \n"
		"str r0, [r7, %2] \n" // output value
		"mov r0, r9 \n"
		"str r0, [r7, %1] \n" // set to "out"
		"movs r0, #0 \n"
		"str r0, [r7, %1] \n" // set to "in" once again

		// "Return"
		".3: \n"
		::
			"i"(ubOffsA0), "i"(uwOffsModer), "i"(uwOffsOdr), "i"(uwOffsIdr)
	);
}
#else
static inline  __attribute__((always_inline)) void rtcReadWriteProcess(void) {
	// uint32_t ulStatus = NRD_GPIO_Port->IDR;
	// // NWR/NRD may not occur right on CS edge, thus check for both pins at once
	// if((ulStatus & READ_MASK) == 0) {
	// 	// Read desired register number from address lines
	// 	// ARM uses byte addressing so shift a bit less
	// 	uint32_t ulAddr = (ulStatus >> (A0_Pos - 2)) & (0xF << 2); // read addr asap
	// 	// Output cached value
	// 	D0_GPIO_Port->ODR = *(uint32_t*)&((uint8_t*)s_pMsmFields)[ulAddr];
	// 	// Switch data to output
	// 	D0_GPIO_Port->MODER = (
	// 		MODE_OUT(D0_Pos + 0) | MODE_OUT(D0_Pos + 1) |
	// 		MODE_OUT(D0_Pos + 2) | MODE_OUT(D0_Pos + 3)
	// 	);
	// 	// Switch data to input to not trash data lines
	// 	D0_GPIO_Port->MODER = 0;
	// }
	// else if((ulStatus & WRITE_MASK) == 0) {
	// 	// Write - TIME CRITICAL!
	// 	uint32_t ulAddr = A0_GPIO_Port->IDR; // read addr asap
	// 	uint32_t ulData = D0_GPIO_Port->IDR; // read data asap
	// 	ulAddr >>=  A0_Pos;
	// 	ulData >>= D0_Pos;
	// 	// printf("WRITE: %x %x\r\n", ubAddr, ubData);
	// }
}
#endif

static const uint8_t s_pWeekStm2Msm[] = {0, 1, 2, 3, 4, 5, 6, 0};

void msmRtcLoop(void) {
#if defined(USE_ASM)
	rtcInitAsm();
	while(1) {
		rtcReadWriteProcessAsm();
	}
#else
	uint32_t ulReg;
	while(1) {
		// TODO Shifts are different on different chips - overflows & underflows

		// // Update seconds units
		// rtcReadWriteProcess();
		ulReg = RTC->TR;
		// rtcReadWriteProcess();
		s_pMsmFields[MSM_SECONDS_1] = ulReg << (D0_Pos - RTC_TR_SU_Pos);

		// // Update seconds tens
		// rtcReadWriteProcess();
		// ulReg = RTC->TR;
		// rtcReadWriteProcess();
		// ulReg = ulReg << (D0_Pos - RTC_TR_ST_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_SECONDS_10] = ulReg;

		// // Update minutes units
		// rtcReadWriteProcess();
		// ulReg = RTC->TR;
		// rtcReadWriteProcess();
		// ulReg = ulReg >> (RTC_TR_MNU_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_MINUTES_1] = ulReg;

		// // Update minutes tens
		// rtcReadWriteProcess();
		// ulReg = RTC->TR;
		// rtcReadWriteProcess();
		// ulReg = ulReg >> (RTC_TR_MNT_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_MINUTES_10] = ulReg;

		// // Update hour units
		// rtcReadWriteProcess();
		// ulReg = RTC->TR;
		// rtcReadWriteProcess();
		// ulReg = ulReg >> (RTC_TR_HU_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_HOURS_1] = ulReg;

		// // Update hour tens
		// rtcReadWriteProcess();
		// ulReg = RTC->TR;
		// rtcReadWriteProcess();
		// ulReg = ulReg >> (RTC_TR_HT_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_HOURS_10] = ulReg;

		// // Read day/month/year/dayOfWeek
		// rtcReadWriteProcess();
		// ulReg = RTC->DR;

		// // Update day
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_DAY_1] = ulReg << (D0_Pos - RTC_DR_DU_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_DAY_10] = ulReg << (D0_Pos - RTC_DR_DT_Pos);

		// // Update month
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_MONTH_1] = ulReg << (RTC_DR_MU_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// ulVal = ulReg & RTC_DR_MT_Msk;
		// s_pMsmFields[MSM_MONTH_10] = ulVal >> (RTC_DR_MT_Pos - D0_Pos);

		// // Update week day
		// // MSM: 0 is sunday, 1 is monday
		// // STM: 0 is forbidden, 1 is monday, 7 is sunday
		// rtcReadWriteProcess();
		// ulVal = ulReg >> RTC_DR_WDU_Pos;
		// rtcReadWriteProcess();
		// ulVal &= 7;
		// rtcReadWriteProcess();
		// ulVal = s_pWeekStm2Msm[ulVal];
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_DAY_OF_WEEK] = ulVal << D0_Pos;

		// // Update year
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_YEAR_1] = ulReg >> (RTC_DR_YU_Pos - D0_Pos);
		// rtcReadWriteProcess();
		// s_pMsmFields[MSM_YEAR_10] = ulReg >> (RTC_DR_YT_Pos - D0_Pos);
	}
#endif
}

void SysTick_Handler(void) {
	// Systick interrupts are reason for timing errors occuring periodically
	// so we're going to permanently disable it.
	SysTick->CTRL = 0;    //Disable Systick
}

void EXTI4_15_IRQHandler(void) {
	uint32_t ulStatus = A0_GPIO_Port->IDR;
  if(__HAL_GPIO_EXTI_GET_IT(GPIO_PIN_12)) {
		// printf("READ\r\n");
		// Read desired register number from address lines
		// ARM uses byte addressing so shift a bit less
		uint32_t ulAddr = (ulStatus >> (A0_Pos - 2)) & (0xF << 2); // read addr asap
		// Output cached value
		D0_GPIO_Port->ODR = *(uint32_t*)&((uint8_t*)s_pMsmFields)[ulAddr];
		// Switch data to output
		D0_GPIO_Port->MODER = (
			MODE_OUT(D0_Pos + 0) | MODE_OUT(D0_Pos + 1) |
			MODE_OUT(D0_Pos + 2) | MODE_OUT(D0_Pos + 3)
		);
		// Switch data to input to not trash data lines
		D0_GPIO_Port->MODER = 0;
		__HAL_GPIO_EXTI_CLEAR_IT(GPIO_PIN_12);
  }
  if(__HAL_GPIO_EXTI_GET_IT(GPIO_PIN_13)) {
		// printf("WRITE\r\n");
		// Write - TIME CRITICAL!
		uint32_t ulAddr = A0_GPIO_Port->IDR; // read addr asap
		uint32_t ulData = D0_GPIO_Port->IDR; // read data asap
		ulAddr >>=  A0_Pos;
		ulData >>= D0_Pos;
		// printf("WRITE: %x %x\r\n", ubAddr, ubData);
		__HAL_GPIO_EXTI_CLEAR_IT(GPIO_PIN_13);
	}
}

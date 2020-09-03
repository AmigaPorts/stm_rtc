/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "msm_rtc.h"
#include "main.h"
#include <stdio.h>

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
#elif defined(STM32G070xx)
#define D0_Pos 0
#define A0_Pos 2
#define NCS0_Pos 15
#define NRD_Pos 13
#define NWR_Pos 12
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
	printf(
		"RTC_INIT: %lu%lu.%lu%lu.%lu%lu %lu%lu:%lu%lu:%lu%lu\r\n",
		// Date
		((RTC->DR & RTC_DR_DT_Msk) >> RTC_DR_DT_Pos),
		((RTC->DR & RTC_DR_DU_Msk) >> RTC_DR_DU_Pos),
		((RTC->DR & RTC_DR_MT_Msk) >> RTC_DR_MT_Pos),
		((RTC->DR & RTC_DR_MU_Msk) >> RTC_DR_MU_Pos),
		((RTC->DR & RTC_DR_YT_Msk) >> RTC_DR_YT_Pos),
		((RTC->DR & RTC_DR_YU_Msk) >> RTC_DR_YU_Pos),
		// Time
		((RTC->TR & RTC_TR_HT_Msk) >> RTC_TR_HT_Pos),
		((RTC->TR & RTC_TR_HU_Msk) >> RTC_TR_HU_Pos),
		((RTC->TR & RTC_TR_MNT_Msk) >> RTC_TR_MNT_Pos),
		((RTC->TR & RTC_TR_MNU_Msk) >> RTC_TR_MNU_Pos),
		((RTC->TR & RTC_TR_ST_Msk) >> RTC_TR_ST_Pos),
		((RTC->TR & RTC_TR_SU_Msk) >> RTC_TR_SU_Pos)
	);
	D0_GPIO_Port->MODER = 0;
}

static uint32_t s_pMsmFields[MSM_ADDR_COUNT] = {
	 0 << D0_Pos,  1 << D0_Pos,  2 << D0_Pos,  3 << D0_Pos,
	 4 << D0_Pos,  5 << D0_Pos,  6 << D0_Pos,  7 << D0_Pos,
	 8 << D0_Pos,  9 << D0_Pos, 10 << D0_Pos, 11 << D0_Pos,
	12 << D0_Pos, 13 << D0_Pos, 14 << D0_Pos, 15 << D0_Pos
};

static inline __attribute__((always_inline)) void rtcReadWriteProcess(void) {
	uint32_t ulStatus = NRD_GPIO_Port->IDR;
	// NWR/NRD may not occur right on CS edge, thus check for both pins at once
	if((ulStatus & WRITE_MASK) == 0) {
		// Write - TIME CRITICAL!
		uint8_t ubAddr = A0_GPIO_Port->IDR >> A0_Pos; // read addr asap
		uint8_t ubData = D0_GPIO_Port->IDR >> D0_Pos; // read data asap
		// printf("WRITE: %x %x\r\n", ubAddr, ubData);
	}
	else
	if((ulStatus & READ_MASK) == 0) {
		// Read desired register number from address lines
		// ARM uses byte addressing so shift a bit less
		uint32_t ulAddr = (A0_GPIO_Port->IDR >> (A0_Pos - 2)) & (0xF << 2); // read addr asap
		// printf("READ! %lu\r\n", ulAddr);
		// Output cached value
		D0_GPIO_Port->ODR = *(uint32_t*)&((uint8_t*)s_pMsmFields)[ulAddr];
		// Switch data to output
		D0_GPIO_Port->MODER = (
			MODE_OUT(D0_Pos + 0) | MODE_OUT(D0_Pos + 1) |
			MODE_OUT(D0_Pos + 2) | MODE_OUT(D0_Pos + 3)
		);
		// Switch data to input to not trash data lines
		D0_GPIO_Port->MODER = 0;
	}
}

static const uint8_t pWeekStm2Msm[] = {0, 1, 2, 3, 4, 5, 6, 0};

#define shiftFromTo(Reg, From, To) (((From) > (To)) ? ((Reg) >> ((From) - (To))) : ((Reg) << ((To) - (From))))

void msmRtcLoop(void) {
	uint32_t ulReg, ulVal;
	while(1) {
		// TODO Shifts are different on different chips - overflows & underflows
		// Get hours/minutes/seconds
		rtcReadWriteProcess();
		ulReg = RTC->TR;

		// Update seconds
		rtcReadWriteProcess();
		s_pMsmFields[MSM_SECONDS_1] = shiftFromTo(ulReg, RTC_TR_SU_Pos, D0_Pos);
		rtcReadWriteProcess();
		s_pMsmFields[MSM_SECONDS_10] = shiftFromTo(ulReg, RTC_TR_ST_Pos, D0_Pos);

		// Update minutes
		rtcReadWriteProcess();
		s_pMsmFields[MSM_MINUTES_1] = shiftFromTo(ulReg, RTC_TR_MNU_Pos, D0_Pos);
		rtcReadWriteProcess();
		s_pMsmFields[MSM_MINUTES_10] = shiftFromTo(ulReg, RTC_TR_MNT_Pos, D0_Pos);

		// Update hour
		rtcReadWriteProcess();
		s_pMsmFields[MSM_HOURS_1] = shiftFromTo(ulReg, RTC_TR_HU_Pos, D0_Pos);
		rtcReadWriteProcess();
		s_pMsmFields[MSM_HOURS_10] = shiftFromTo(ulReg, RTC_TR_HT_Pos, D0_Pos);

		// Read day/month/year/dayOfWeek
		rtcReadWriteProcess();
		ulReg = RTC->DR;

		// Update day
		rtcReadWriteProcess();
		s_pMsmFields[MSM_DAY_1] = shiftFromTo(ulReg, RTC_DR_DU_Pos, D0_Pos);
		rtcReadWriteProcess();
		s_pMsmFields[MSM_DAY_10] = shiftFromTo(ulReg, RTC_DR_DT_Pos, D0_Pos);

		// Update month
		rtcReadWriteProcess();
		s_pMsmFields[MSM_MONTH_1] = shiftFromTo(ulReg, RTC_DR_MU_Pos, D0_Pos);
		rtcReadWriteProcess();
		ulVal = ulReg & RTC_DR_MT_Msk;
		s_pMsmFields[MSM_MONTH_10] = shiftFromTo(ulVal, RTC_DR_MT_Pos, D0_Pos);

		// Update week day
		// MSM: 0 is sunday, 1 is monday
		// STM: 0 is forbidden, 1 is monday, 7 is sunday
		rtcReadWriteProcess();
		ulVal = ulReg >> RTC_DR_WDU_Pos;
		rtcReadWriteProcess();
		ulVal &= 7;
		rtcReadWriteProcess();
		ulVal = pWeekStm2Msm[ulVal];
		rtcReadWriteProcess();
		s_pMsmFields[MSM_DAY_OF_WEEK] = ulVal << D0_Pos;

		// Update year
		rtcReadWriteProcess();
		s_pMsmFields[MSM_YEAR_1] = shiftFromTo(ulReg, RTC_DR_YU_Pos, D0_Pos);
		rtcReadWriteProcess();
		s_pMsmFields[MSM_YEAR_10] = shiftFromTo(ulReg, RTC_DR_YT_Pos, D0_Pos);
	}
}

void SysTick_Handler(void) {
	// Interrupts are reason for timing errors occuring periodically
	// so we're going to permanently disable interrupts.
	// Can be only done in supervisor mode, e.g. in interrupts themselves
	// so let's do it here.
	__disable_irq();
}

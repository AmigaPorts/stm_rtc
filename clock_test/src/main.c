#include <stdio.h>
#include <stdint.h>

#define RTC_BASE 0xDC0000
#define RTC_FIELD(offs) (void*)(RTC_BASE + ((offs) << 2))

volatile uint16_t *pRtcSecondUnits = (volatile uint16_t*)RTC_FIELD(0);
volatile uint16_t *pRtcSecondTens = (volatile uint16_t*)RTC_FIELD(1);
volatile uint16_t *pRtcMinuteUnits = (volatile uint16_t*)RTC_FIELD(2);
volatile uint16_t *pRtcMinuteTens = (volatile uint16_t*)RTC_FIELD(3);
volatile uint16_t *pRtcHourUnits = (volatile uint16_t*)RTC_FIELD(4);
volatile uint16_t *pRtcHourTens = (volatile uint16_t*)RTC_FIELD(5);
volatile uint16_t *pRtcDayUnits = (volatile uint16_t*)RTC_FIELD(6);
volatile uint16_t *pRtcDayTens = (volatile uint16_t*)RTC_FIELD(7);
volatile uint16_t *pRtcMonthUnits = (volatile uint16_t*)RTC_FIELD(8);
volatile uint16_t *pRtcMonthTens = (volatile uint16_t*)RTC_FIELD(9);
volatile uint16_t *pRtcYearUnits = (volatile uint16_t*)RTC_FIELD(10);
volatile uint16_t *pRtcYearTens = (volatile uint16_t*)RTC_FIELD(11);

#define MAX_TESTS 500U

void checkLoop(const char *szName, volatile uint16_t *pVar) {
	uint16_t uwErrors = 0;
	uint8_t ubRef = *pVar & 0xF;
	for(uint16_t i = 0; i < MAX_TESTS; ++i) {
		uint8_t ubRead = *pVar & 0xF;
		if(ubRef != ubRead) {
			printf("%hhu ", ubRead);
			++uwErrors;
		}
		ubRef = ubRead;
	}
	printf(
		"\n%s check, errors: %hu/%hu (%u%%)",
		szName, uwErrors, MAX_TESTS, (uwErrors * 100U) / MAX_TESTS
	);
}

int main(void) {

	// Check each field separately
	checkLoop("Second units", pRtcSecondUnits);
	checkLoop("Second tens", pRtcSecondTens);
	checkLoop("Minute units", pRtcMinuteUnits);
	checkLoop("Minute tens", pRtcMinuteTens);
	checkLoop("Hour units", pRtcHourUnits);
	checkLoop("Hour tens", pRtcHourTens);
	checkLoop("Day units", pRtcDayUnits);
	checkLoop("Day tens", pRtcDayTens);
	checkLoop("Month units", pRtcMonthUnits);
	checkLoop("Month tens", pRtcMonthTens);
	checkLoop("Year units", pRtcYearUnits);
	checkLoop("Year tens", pRtcYearTens);

	// Display time
	printf(
		"Time: %d'%d.%d'%d.%d'%d %d'%d:%d'%d:%d'%d\n",
		*pRtcDayTens & 0xF, *pRtcDayUnits & 0xF,
		*pRtcMonthTens & 0xF, *pRtcMonthUnits & 0xF,
		*pRtcYearTens & 0xF, *pRtcYearUnits & 0xF,
		*pRtcHourTens & 0xF, *pRtcHourUnits & 0xF,
		*pRtcMinuteTens & 0xF, *pRtcMinuteUnits & 0xF,
		*pRtcSecondTens & 0xF, *pRtcSecondUnits & 0xF
	);
}

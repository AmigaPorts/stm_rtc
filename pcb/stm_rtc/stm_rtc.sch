EESchema Schematic File Version 4
LIBS:stm_rtc-cache
EELAYER 29 0
EELAYER END
$Descr A4 8268 11693 portrait
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C_Small C1
U 1 1 5CCDF8E3
P 1850 6300
F 0 "C1" H 1942 6346 50  0000 L CNN
F 1 "100nF" H 1942 6255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1850 6300 50  0001 C CNN
F 3 "~" H 1850 6300 50  0001 C CNN
	1    1850 6300
	1    0    0    -1  
$EndComp
Text Notes 1700 6050 0    79   ~ 0
uC Decoupling
$Comp
L Device:C_Small C3
U 1 1 5CCE071B
P 2350 6300
F 0 "C3" H 2442 6346 50  0000 L CNN
F 1 "100nF" H 2442 6255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2350 6300 50  0001 C CNN
F 3 "~" H 2350 6300 50  0001 C CNN
	1    2350 6300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 5CCE0BAC
P 2850 6300
F 0 "C4" H 2942 6346 50  0000 L CNN
F 1 "100nF" H 2942 6255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2850 6300 50  0001 C CNN
F 3 "~" H 2850 6300 50  0001 C CNN
	1    2850 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 6200 1850 6200
Connection ~ 1850 6200
Wire Wire Line
	2350 6200 2850 6200
Connection ~ 2350 6200
Wire Wire Line
	2850 6400 2350 6400
Wire Wire Line
	2350 6400 1850 6400
Connection ~ 2350 6400
Connection ~ 1850 6400
$Comp
L power:+3V3 #PWR0101
U 1 1 5CCE2621
P 1500 6200
F 0 "#PWR0101" H 1500 6050 50  0001 C CNN
F 1 "+3V3" H 1515 6373 50  0000 C CNN
F 2 "" H 1500 6200 50  0001 C CNN
F 3 "" H 1500 6200 50  0001 C CNN
	1    1500 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5CCE276B
P 1500 6400
F 0 "#PWR0102" H 1500 6150 50  0001 C CNN
F 1 "GND" H 1505 6227 50  0000 C CNN
F 2 "" H 1500 6400 50  0001 C CNN
F 3 "" H 1500 6400 50  0001 C CNN
	1    1500 6400
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:AMS1117-3.3 U1
U 1 1 5CCE33CF
P 1900 4600
F 0 "U1" H 1900 4842 50  0000 C CNN
F 1 "AMS1117-3.3" H 1900 4751 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 1900 4800 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 2000 4350 50  0001 C CNN
	1    1900 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 6200 1850 6200
Wire Wire Line
	1500 6400 1850 6400
$Comp
L power:+3V3 #PWR0103
U 1 1 5CCE5CA3
P 2750 4500
F 0 "#PWR0103" H 2750 4350 50  0001 C CNN
F 1 "+3V3" H 2765 4673 50  0000 C CNN
F 2 "" H 2750 4500 50  0001 C CNN
F 3 "" H 2750 4500 50  0001 C CNN
	1    2750 4500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 5CCE6332
P 1350 4500
F 0 "#PWR0104" H 1350 4350 50  0001 C CNN
F 1 "+5V" H 1365 4673 50  0000 C CNN
F 2 "" H 1350 4500 50  0001 C CNN
F 3 "" H 1350 4500 50  0001 C CNN
	1    1350 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 4600 1600 4600
$Comp
L stm_rtc:program_connector J1
U 1 1 5CCF6EC1
P 5850 1800
F 0 "J1" H 6419 1861 50  0000 L CNN
F 1 "program_connector" H 6419 1770 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 6050 1850 50  0001 C CNN
F 3 "~" H 6050 1850 50  0001 C CNN
	1    5850 1800
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0105
U 1 1 5CCF8741
P 5400 1550
F 0 "#PWR0105" H 5400 1400 50  0001 C CNN
F 1 "+3V3" H 5415 1723 50  0000 C CNN
F 2 "" H 5400 1550 50  0001 C CNN
F 3 "" H 5400 1550 50  0001 C CNN
	1    5400 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 1550 5400 1550
Wire Wire Line
	5850 1650 5400 1650
$Comp
L power:GND #PWR0106
U 1 1 5CCF949B
P 5400 1650
F 0 "#PWR0106" H 5400 1400 50  0001 C CNN
F 1 "GND" H 5405 1477 50  0000 C CNN
F 2 "" H 5400 1650 50  0001 C CNN
F 3 "" H 5400 1650 50  0001 C CNN
	1    5400 1650
	1    0    0    -1  
$EndComp
Text GLabel 5850 1750 0    39   Output ~ 0
TX
Text GLabel 5850 1850 0    39   Input ~ 0
RX
Text GLabel 5850 1950 0    39   Input ~ 0
NRES
Text GLabel 5850 2050 0    39   Input ~ 0
BOOT
Text GLabel 850  1750 0    39   Output ~ 0
BOOT
Text GLabel 900  1550 0    39   Output ~ 0
NRES
Text GLabel 3100 3050 2    39   Output ~ 0
RX
Wire Wire Line
	3100 3050 2950 3050
Wire Wire Line
	900  1550 950  1550
Wire Wire Line
	850  1750 950  1750
Text GLabel 3100 2950 2    39   Input ~ 0
TX
Wire Wire Line
	2850 2950 3100 2950
$Comp
L power:+3V3 #PWR0107
U 1 1 5CCFBEE2
P 2350 1200
F 0 "#PWR0107" H 2350 1050 50  0001 C CNN
F 1 "+3V3" H 2365 1373 50  0000 C CNN
F 2 "" H 2350 1200 50  0001 C CNN
F 3 "" H 2350 1200 50  0001 C CNN
	1    2350 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 1350 2250 1250
Wire Wire Line
	2250 1250 2350 1250
Wire Wire Line
	2350 1350 2350 1250
Connection ~ 2350 1250
Wire Wire Line
	2450 1350 2450 1250
Wire Wire Line
	2450 1250 2350 1250
$Comp
L power:GND #PWR0108
U 1 1 5CCFE308
P 2350 3350
F 0 "#PWR0108" H 2350 3100 50  0001 C CNN
F 1 "GND" H 2355 3177 50  0000 C CNN
F 2 "" H 2350 3350 50  0001 C CNN
F 3 "" H 2350 3350 50  0001 C CNN
	1    2350 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 3250 2350 3350
Entry Wire Line
	1650 2950 1550 2850
Entry Wire Line
	1550 2750 1650 2850
Entry Wire Line
	1550 2650 1650 2750
Entry Wire Line
	1550 2550 1650 2650
Wire Wire Line
	1650 2950 1750 2950
Wire Wire Line
	1650 2850 1750 2850
Wire Wire Line
	1650 2750 1750 2750
Wire Wire Line
	1650 2650 1750 2650
Text GLabel 1500 2550 0    39   BiDi ~ 0
RTC_DAT
Wire Bus Line
	1550 2550 1500 2550
Entry Wire Line
	2950 2350 3050 2250
Entry Wire Line
	2950 2450 3050 2350
Entry Wire Line
	2950 2550 3050 2450
Entry Wire Line
	2950 2650 3050 2550
Wire Wire Line
	2850 2350 2950 2350
Wire Wire Line
	2850 2450 2950 2450
Wire Wire Line
	2850 2550 2950 2550
Wire Wire Line
	2850 2650 2950 2650
Wire Bus Line
	3050 2250 3100 2250
Text GLabel 3100 2250 2    39   Input ~ 0
RTC_ADDR
NoConn ~ 2850 1650
NoConn ~ 2850 1750
NoConn ~ 2850 1850
NoConn ~ 2850 1950
NoConn ~ 2850 2050
NoConn ~ 2850 2150
NoConn ~ 2850 2250
NoConn ~ 1750 2250
NoConn ~ 1750 2350
NoConn ~ 1750 2450
NoConn ~ 1750 2550
Text Notes 550  800  0    50   ~ 0
PB0-1, PA0-7 are not 5V tolerant\nthus useless for communicating\nwith Amiga
Text GLabel 3100 3150 2    39   Output ~ 0
NCS
Wire Wire Line
	3100 3150 2950 3150
Wire Wire Line
	2950 3150 2950 3050
Connection ~ 2950 3050
Wire Wire Line
	2950 3050 2850 3050
Text GLabel 3100 2850 2    39   Output ~ 0
NWR
Text GLabel 3100 2750 2    39   Output ~ 0
NRD
Wire Wire Line
	3100 2750 2850 2750
Wire Wire Line
	2850 2850 3100 2850
Entry Wire Line
	6600 3350 6700 3250
Entry Wire Line
	6700 3150 6600 3250
Entry Wire Line
	6700 3050 6600 3150
Entry Wire Line
	6700 2950 6600 3050
Text GLabel 6750 2950 2    39   BiDi ~ 0
RTC_DAT
Wire Bus Line
	6700 2950 6750 2950
Wire Wire Line
	6500 3050 6600 3050
Wire Wire Line
	6500 3150 6600 3150
Wire Wire Line
	6500 3250 6600 3250
Wire Wire Line
	6500 3350 6600 3350
Entry Wire Line
	5650 2950 5550 2850
Entry Wire Line
	5650 3050 5550 2950
Entry Wire Line
	5650 3150 5550 3050
Entry Wire Line
	5650 3250 5550 3150
Wire Wire Line
	5700 2950 5650 2950
Wire Wire Line
	5700 3050 5650 3050
Wire Wire Line
	5700 3150 5650 3150
Wire Wire Line
	5700 3250 5650 3250
Wire Bus Line
	5550 2850 5450 2850
Text GLabel 5450 2850 0    39   Output ~ 0
RTC_ADDR
Text Label 2850 2350 0    39   ~ 0
A0
Text Label 2850 2450 0    39   ~ 0
A1
Text Label 2850 2550 0    39   ~ 0
A2
Text Label 2850 2650 0    39   ~ 0
A3
Text GLabel 6750 3450 2    39   Output ~ 0
NWR
Text GLabel 5550 3350 0    39   Output ~ 0
NRD
Wire Wire Line
	5550 3350 5700 3350
Wire Wire Line
	6500 3450 6750 3450
Text GLabel 5550 2750 0    39   Output ~ 0
NCS
Wire Wire Line
	5550 2750 5700 2750
Text Label 1650 2650 0    39   ~ 0
D0
Text Label 1650 2750 0    39   ~ 0
D1
Text Label 1650 2850 0    39   ~ 0
D2
Text Label 1650 2950 0    39   ~ 0
D3
$Comp
L MCU_ST_STM32F0:STM32F031K6Ux U2
U 1 1 5CCDE5F5
P 2350 2250
F 0 "U2" H 2700 3100 50  0000 C CNN
F 1 "STM32F031K6Ux" H 2700 1300 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.45x3.45mm" H 1850 1350 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00104043.pdf" H 2350 2250 50  0001 C CNN
	1    2350 2250
	1    0    0    -1  
$EndComp
NoConn ~ 1750 3050
NoConn ~ 5700 2650
Text GLabel 1500 1950 0    39   Output ~ 0
OSC_P
Wire Wire Line
	1500 1950 1750 1950
Wire Wire Line
	1500 2050 1750 2050
Text GLabel 1500 2050 0    39   Input ~ 0
OSC_N
Text GLabel 6750 2850 2    39   Input ~ 0
OSC_P
Text GLabel 6750 2750 2    39   Output ~ 0
OSC_N
Wire Wire Line
	6750 2750 6500 2750
Wire Wire Line
	6750 2850 6500 2850
$Comp
L power:GND #PWR0109
U 1 1 5CD41539
P 1900 5300
F 0 "#PWR0109" H 1900 5050 50  0001 C CNN
F 1 "GND" H 1905 5127 50  0000 C CNN
F 2 "" H 1900 5300 50  0001 C CNN
F 3 "" H 1900 5300 50  0001 C CNN
	1    1900 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 4850 2350 4900
Wire Wire Line
	2350 4900 1900 4900
Connection ~ 1900 4900
$Comp
L power:GND #PWR0110
U 1 1 5CD45A23
P 5700 3450
F 0 "#PWR0110" H 5700 3200 50  0001 C CNN
F 1 "GND" H 5705 3277 50  0000 C CNN
F 2 "" H 5700 3450 50  0001 C CNN
F 3 "" H 5700 3450 50  0001 C CNN
	1    5700 3450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 5CD460BA
P 6600 2650
F 0 "#PWR0111" H 6600 2500 50  0001 C CNN
F 1 "+5V" H 6615 2823 50  0000 C CNN
F 2 "" H 6600 2650 50  0001 C CNN
F 3 "" H 6600 2650 50  0001 C CNN
	1    6600 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2650 6500 2650
Wire Wire Line
	2350 1200 2350 1250
NoConn ~ 6500 2950
$Comp
L Device:R_Small R3
U 1 1 5CD5BF2C
P 3100 1350
F 0 "R3" H 3159 1396 50  0000 L CNN
F 1 "10k" H 3159 1305 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3100 1350 50  0001 C CNN
F 3 "~" H 3100 1350 50  0001 C CNN
	1    3100 1350
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R4
U 1 1 5CD5C3CC
P 3100 1750
F 0 "R4" H 3159 1796 50  0000 L CNN
F 1 "10k" H 3159 1705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3100 1750 50  0001 C CNN
F 3 "~" H 3100 1750 50  0001 C CNN
	1    3100 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1550 3100 1550
Wire Wire Line
	3100 1550 3100 1650
Wire Wire Line
	3100 1550 3100 1450
Connection ~ 3100 1550
$Comp
L power:GND #PWR0112
U 1 1 5CD641B2
P 3100 1850
F 0 "#PWR0112" H 3100 1600 50  0001 C CNN
F 1 "GND" H 3105 1677 50  0000 C CNN
F 2 "" H 3100 1850 50  0001 C CNN
F 3 "" H 3100 1850 50  0001 C CNN
	1    3100 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0113
U 1 1 5CD64A85
P 3100 1200
F 0 "#PWR0113" H 3100 1050 50  0001 C CNN
F 1 "+5V" H 3115 1373 50  0000 C CNN
F 2 "" H 3100 1200 50  0001 C CNN
F 3 "" H 3100 1200 50  0001 C CNN
	1    3100 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 5CD65583
P 950 1350
F 0 "R1" H 1009 1396 50  0000 L CNN
F 1 "10k" H 1009 1305 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 950 1350 50  0001 C CNN
F 3 "~" H 950 1350 50  0001 C CNN
	1    950  1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1450 950  1550
Connection ~ 950  1550
Wire Wire Line
	950  1550 1750 1550
$Comp
L power:+3V3 #PWR0114
U 1 1 5CD6729C
P 950 1200
F 0 "#PWR0114" H 950 1050 50  0001 C CNN
F 1 "+3V3" H 965 1373 50  0000 C CNN
F 2 "" H 950 1200 50  0001 C CNN
F 3 "" H 950 1200 50  0001 C CNN
	1    950  1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1200 950  1250
Wire Wire Line
	3100 1250 3100 1200
$Comp
L Device:R_Small R2
U 1 1 5CD73AEA
P 950 1950
F 0 "R2" H 1009 1996 50  0000 L CNN
F 1 "10k" H 1009 1905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 950 1950 50  0001 C CNN
F 3 "~" H 950 1950 50  0001 C CNN
	1    950  1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1750 950  1850
Connection ~ 950  1750
Wire Wire Line
	950  1750 1750 1750
$Comp
L power:GND #PWR0115
U 1 1 5CD7C565
P 950 2100
F 0 "#PWR0115" H 950 1850 50  0001 C CNN
F 1 "GND" H 955 1927 50  0000 C CNN
F 2 "" H 950 2100 50  0001 C CNN
F 3 "" H 950 2100 50  0001 C CNN
	1    950  2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  2050 950  2100
$Comp
L Diode:BAR42FILM D1
U 1 1 5CDA5E7D
P 2750 4750
F 0 "D1" V 2704 4893 50  0000 L CNN
F 1 "BAR42FILM" V 2795 4893 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2750 4575 50  0001 C CNN
F 3 "www.st.com/resource/en/datasheet/bar42.pdf" H 2750 4750 50  0001 C CNN
	1    2750 4750
	0    1    1    0   
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 5CDB73A4
P 2750 5150
F 0 "BT1" H 2868 5246 50  0000 L CNN
F 1 "Battery_Cell" H 2868 5155 50  0000 L CNN
F 2 "stm_rtc:BatteryHolder_Keystone_106_1x20mm" V 2750 5210 50  0001 C CNN
F 3 "~" V 2750 5210 50  0001 C CNN
	1    2750 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 4900 2750 4950
Wire Wire Line
	1900 4900 1900 5300
Wire Wire Line
	1900 5300 2750 5300
Wire Wire Line
	2750 5300 2750 5250
Connection ~ 1900 5300
Wire Wire Line
	2750 4500 2750 4600
Wire Wire Line
	1350 4500 1350 4600
Text Notes 1750 4150 0    79   ~ 0
Power supply
Text Notes 5350 1250 0    79   ~ 0
uC programming
Text Notes 5300 2400 0    79   ~ 0
Connecting instead of RTC
Entry Wire Line
	6600 4950 6700 4850
Entry Wire Line
	6700 4750 6600 4850
Entry Wire Line
	6700 4650 6600 4750
Entry Wire Line
	6700 4550 6600 4650
Text GLabel 6750 4550 2    39   BiDi ~ 0
RTC_DAT
Wire Bus Line
	6700 4550 6750 4550
Wire Wire Line
	6500 4650 6600 4650
Wire Wire Line
	6500 4750 6600 4750
Wire Wire Line
	6500 4850 6600 4850
Wire Wire Line
	6500 4950 6600 4950
Entry Wire Line
	5650 4550 5550 4450
Entry Wire Line
	5650 4650 5550 4550
Entry Wire Line
	5650 4750 5550 4650
Entry Wire Line
	5650 4850 5550 4750
Wire Wire Line
	5700 4550 5650 4550
Wire Wire Line
	5700 4650 5650 4650
Wire Wire Line
	5700 4750 5650 4750
Wire Wire Line
	5700 4850 5650 4850
Wire Bus Line
	5550 4450 5450 4450
Text GLabel 5450 4450 0    39   Output ~ 0
RTC_ADDR
Text GLabel 6750 5050 2    39   Output ~ 0
NWR
Text GLabel 5550 4950 0    39   Output ~ 0
NRD
Wire Wire Line
	5550 4950 5700 4950
Wire Wire Line
	6500 5050 6750 5050
Text GLabel 5550 4350 0    39   Output ~ 0
NCS
Wire Wire Line
	5550 4350 5700 4350
NoConn ~ 5700 4250
Text GLabel 6750 4450 2    39   Input ~ 0
OSC_P
Text GLabel 6750 4350 2    39   Output ~ 0
OSC_N
Wire Wire Line
	6750 4350 6500 4350
Wire Wire Line
	6750 4450 6500 4450
$Comp
L power:GND #PWR01
U 1 1 5CDE33FE
P 5700 5050
F 0 "#PWR01" H 5700 4800 50  0001 C CNN
F 1 "GND" H 5705 4877 50  0000 C CNN
F 2 "" H 5700 5050 50  0001 C CNN
F 3 "" H 5700 5050 50  0001 C CNN
	1    5700 5050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR02
U 1 1 5CDE3404
P 6600 4250
F 0 "#PWR02" H 6600 4100 50  0001 C CNN
F 1 "+5V" H 6615 4423 50  0000 C CNN
F 2 "" H 6600 4250 50  0001 C CNN
F 3 "" H 6600 4250 50  0001 C CNN
	1    6600 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 4250 6500 4250
NoConn ~ 6500 4550
Text Notes 5000 4000 0    79   ~ 0
Copy for second direction of fitting
$Comp
L stm_rtc:RTC_CONN U3
U 1 1 5CD143F2
P 6100 3000
F 0 "U3" H 6100 3450 39  0000 C CNN
F 1 "RTC_CONN" H 6200 2450 39  0000 C CNN
F 2 "Package_DIP:DIP-18_W7.62mm" H 6100 3000 39  0001 C CNN
F 3 "" H 6100 3000 39  0001 C CNN
	1    6100 3000
	1    0    0    -1  
$EndComp
$Comp
L stm_rtc:RTC_CONN U4
U 1 1 5CDE33D9
P 6100 4600
F 0 "U4" H 6100 5050 39  0000 C CNN
F 1 "RTC_CONN" H 6200 4050 39  0000 C CNN
F 2 "Package_DIP:DIP-18_W7.62mm" H 6100 4600 39  0001 C CNN
F 3 "" H 6100 4600 39  0001 C CNN
	1    6100 4600
	1    0    0    -1  
$EndComp
NoConn ~ 5700 2850
NoConn ~ 5700 4450
$Comp
L Device:CP_Small C2
U 1 1 5CCE1104
P 2350 4750
F 0 "C2" H 2438 4796 50  0000 L CNN
F 1 "4.7uF" H 2438 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2350 4750 50  0001 C CNN
F 3 "~" H 2350 4750 50  0001 C CNN
	1    2350 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 4600 2350 4600
Wire Wire Line
	2350 4600 2350 4650
Wire Wire Line
	2350 4600 2750 4600
Connection ~ 2350 4600
Connection ~ 2750 4600
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5CCEEBB2
P 6900 2650
F 0 "#FLG0101" H 6900 2725 50  0001 C CNN
F 1 "PWR_FLAG" H 6900 2823 50  0000 C CNN
F 2 "" H 6900 2650 50  0001 C CNN
F 3 "~" H 6900 2650 50  0001 C CNN
	1    6900 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2650 6900 2650
Connection ~ 6600 2650
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5CCF1DCC
P 5200 3450
F 0 "#FLG0102" H 5200 3525 50  0001 C CNN
F 1 "PWR_FLAG" H 5200 3623 50  0000 C CNN
F 2 "" H 5200 3450 50  0001 C CNN
F 3 "~" H 5200 3450 50  0001 C CNN
	1    5200 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3450 5700 3450
Connection ~ 5700 3450
Text Label 5650 2950 0    39   ~ 0
A0
Text Label 5650 3050 0    39   ~ 0
A1
Text Label 5650 3150 0    39   ~ 0
A2
Text Label 5650 3250 0    39   ~ 0
A3
Text Label 6500 3050 0    39   ~ 0
D0
Text Label 6500 3150 0    39   ~ 0
D1
Text Label 6500 3250 0    39   ~ 0
D2
Text Label 6500 3350 0    39   ~ 0
D3
Text Label 6500 4650 0    39   ~ 0
D0
Text Label 6500 4750 0    39   ~ 0
D1
Text Label 6500 4850 0    39   ~ 0
D2
Text Label 6500 4950 0    39   ~ 0
D3
Text Label 5650 4550 0    39   ~ 0
A0
Text Label 5650 4650 0    39   ~ 0
A1
Text Label 5650 4750 0    39   ~ 0
A2
Text Label 5650 4850 0    39   ~ 0
A3
Wire Bus Line
	1550 2550 1550 2850
Wire Bus Line
	3050 2250 3050 2550
Wire Bus Line
	6700 2950 6700 3250
Wire Bus Line
	5550 2850 5550 3150
Wire Bus Line
	6700 4550 6700 4850
Wire Bus Line
	5550 4450 5550 4750
$EndSCHEMATC

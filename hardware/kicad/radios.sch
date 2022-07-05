EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:TART
LIBS:clk_module
LIBS:texas_lvds
LIBS:radio_hub-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
Title ""
Date "3 dec 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 4350 2350 2    60   Input ~ 0
CKIN
Text GLabel 2800 1800 1    60   Input ~ 0
2V8_A
Text GLabel 2600 1800 1    60   Input ~ 0
2V8_B
$Comp
L GNDA #PWR031
U 1 1 545C4714
P 2900 5600
F 0 "#PWR031" H 2900 5600 40  0001 C CNN
F 1 "GNDA" H 2900 5530 40  0000 C CNN
F 2 "" H 2900 5600 60  0000 C CNN
F 3 "" H 2900 5600 60  0000 C CNN
	1    2900 5600
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA1
U 1 1 545C4FF2
P 7150 1850
F 0 "ICA1" H 7150 1800 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 2430 50  0001 C CNN
F 2 "MODULE" H 7140 2270 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 2350 50  0001 C CNN
F 4 "LTC_2851" H 7150 1900 50  0000 C CNN "NAME"
	1    7150 1850
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA2
U 1 1 545C5028
P 7150 2650
F 0 "ICA2" H 7150 2600 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 3230 50  0001 C CNN
F 2 "MODULE" H 7140 3070 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 3150 50  0001 C CNN
F 4 "LTC_2851" H 7150 2700 50  0000 C CNN "NAME"
	1    7150 2650
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA3
U 1 1 545C502F
P 7150 3450
F 0 "ICA3" H 7150 3400 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 4030 50  0001 C CNN
F 2 "MODULE" H 7140 3870 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 3950 50  0001 C CNN
F 4 "LTC_2851" H 7150 3500 50  0000 C CNN "NAME"
	1    7150 3450
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA4
U 1 1 545C5055
P 7150 4250
F 0 "ICA4" H 7150 4200 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 4830 50  0001 C CNN
F 2 "MODULE" H 7140 4670 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 4750 50  0001 C CNN
F 4 "LTC_2851" H 7150 4300 50  0000 C CNN "NAME"
	1    7150 4250
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA5
U 1 1 545C5074
P 7150 5050
F 0 "ICA5" H 7150 5000 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 5630 50  0001 C CNN
F 2 "MODULE" H 7140 5470 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 5550 50  0001 C CNN
F 4 "LTC_2851" H 7150 5100 50  0000 C CNN "NAME"
	1    7150 5050
	1    0    0    -1  
$EndComp
$Comp
L LTC2851_TART ICA6
U 1 1 545C507B
P 7150 5850
F 0 "ICA6" H 7150 5800 50  0000 C CNN
F 1 "LTC2851_TART" H 7140 6430 50  0001 C CNN
F 2 "MODULE" H 7140 6270 50  0001 C CNN
F 3 "DOCUMENTATION" H 7140 6350 50  0001 C CNN
F 4 "LTC_2851" H 7150 5900 50  0000 C CNN "NAME"
	1    7150 5850
	1    0    0    -1  
$EndComp
NoConn ~ 6400 1800
NoConn ~ 6400 2600
NoConn ~ 6400 4200
NoConn ~ 6400 5000
$Comp
L GND #PWR032
U 1 1 545C54FF
P 6200 6600
F 0 "#PWR032" H 6200 6600 30  0001 C CNN
F 1 "GND" H 6200 6530 30  0001 C CNN
F 2 "" H 6200 6600 60  0000 C CNN
F 3 "" H 6200 6600 60  0000 C CNN
	1    6200 6600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR033
U 1 1 545C550E
P 8100 6600
F 0 "#PWR033" H 8100 6600 30  0001 C CNN
F 1 "GND" H 8100 6530 30  0001 C CNN
F 2 "" H 8100 6600 60  0000 C CNN
F 3 "" H 8100 6600 60  0000 C CNN
	1    8100 6600
	1    0    0    -1  
$EndComp
Text Label 5500 1900 2    60   ~ 0
DT_1
Text Label 5500 3500 2    60   ~ 0
DT_3
Text Label 5500 4300 2    60   ~ 0
DT_4
Text Label 5500 5900 2    60   ~ 0
DT_6
Text Label 5500 5100 2    60   ~ 0
DT_5
Text Label 5500 2700 2    60   ~ 0
DT_2
Text Label 4350 2150 0    60   ~ 0
DT_1
Text Label 4350 2700 0    60   ~ 0
DT_2
Text Label 4350 3250 0    60   ~ 0
DT_3
Text Label 4350 3800 0    60   ~ 0
DT_4
Text Label 4350 4350 0    60   ~ 0
DT_5
Text Label 4350 4900 0    60   ~ 0
DT_6
Text GLabel 9100 1900 2    60   Input ~ 0
DT_1_INV
Text GLabel 9100 2700 2    60   Input ~ 0
DT_2_INV
Text GLabel 9100 3500 2    60   Input ~ 0
DT_3_INV
Text GLabel 9100 4300 2    60   Input ~ 0
DT_4_INV
Text GLabel 9100 5900 2    60   Input ~ 0
DT_6_INV
Text GLabel 9100 5100 2    60   Input ~ 0
DT_5_INV
Text GLabel 9600 2000 2    60   Input ~ 0
DT_1_NINV
Text GLabel 9600 2800 2    60   Input ~ 0
DT_2_NINV
Text GLabel 9600 3600 2    60   Input ~ 0
DT_3_NINV
Text GLabel 9600 4400 2    60   Input ~ 0
DT_4_NINV
Text GLabel 9600 5200 2    60   Input ~ 0
DT_5_NINV
Text GLabel 9600 6000 2    60   Input ~ 0
DT_6_NINV
NoConn ~ 6400 5800
Text GLabel 5800 1450 1    60   Input ~ 0
+3V3
$Comp
L GPS_RADIO_MODULE_TART MOD_1
U 1 1 545FFEE5
P 3500 2250
F 0 "MOD_1" H 3500 2500 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 1950 60  0001 C CNN
F 2 "~" H 3500 2250 60  0000 C CNN
F 3 "~" H 3500 2250 60  0000 C CNN
	1    3500 2250
	1    0    0    -1  
$EndComp
$Comp
L GPS_RADIO_MODULE_TART MOD_2
U 1 1 545FFEF2
P 3500 2800
F 0 "MOD_2" H 3500 3050 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 2500 60  0001 C CNN
F 2 "~" H 3500 2800 60  0000 C CNN
F 3 "~" H 3500 2800 60  0000 C CNN
	1    3500 2800
	1    0    0    -1  
$EndComp
$Comp
L GPS_RADIO_MODULE_TART MOD_3
U 1 1 545FFEF8
P 3500 3350
F 0 "MOD_3" H 3500 3600 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 3050 60  0001 C CNN
F 2 "~" H 3500 3350 60  0000 C CNN
F 3 "~" H 3500 3350 60  0000 C CNN
	1    3500 3350
	1    0    0    -1  
$EndComp
$Comp
L GPS_RADIO_MODULE_TART MOD_4
U 1 1 545FFEFE
P 3500 3900
F 0 "MOD_4" H 3500 4150 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 3600 60  0001 C CNN
F 2 "~" H 3500 3900 60  0000 C CNN
F 3 "~" H 3500 3900 60  0000 C CNN
	1    3500 3900
	1    0    0    -1  
$EndComp
$Comp
L GPS_RADIO_MODULE_TART MOD_5
U 1 1 545FFF04
P 3500 4450
F 0 "MOD_5" H 3500 4700 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 4150 60  0001 C CNN
F 2 "~" H 3500 4450 60  0000 C CNN
F 3 "~" H 3500 4450 60  0000 C CNN
	1    3500 4450
	1    0    0    -1  
$EndComp
$Comp
L GPS_RADIO_MODULE_TART MOD_6
U 1 1 545FFF0A
P 3500 5000
F 0 "MOD_6" H 3500 5250 60  0000 C CNN
F 1 "GPS_RADIO_MODULE_TART" H 3450 4700 60  0001 C CNN
F 2 "~" H 3500 5000 60  0000 C CNN
F 3 "~" H 3500 5000 60  0000 C CNN
	1    3500 5000
	1    0    0    -1  
$EndComp
NoConn ~ 6400 3400
$Comp
L R RA1
U 1 1 54600433
P 8600 1700
F 0 "RA1" V 8680 1700 40  0000 C CNN
F 1 "100" V 8607 1701 40  0000 C CNN
F 2 "~" V 8530 1700 30  0000 C CNN
F 3 "~" H 8600 1700 30  0000 C CNN
	1    8600 1700
	0    -1   -1   0   
$EndComp
$Comp
L R RA3
U 1 1 5460076A
P 8600 3300
F 0 "RA3" V 8680 3300 40  0000 C CNN
F 1 "100" V 8607 3301 40  0000 C CNN
F 2 "~" V 8530 3300 30  0000 C CNN
F 3 "~" H 8600 3300 30  0000 C CNN
	1    8600 3300
	0    -1   -1   0   
$EndComp
$Comp
L R RA4
U 1 1 54600779
P 8600 4100
F 0 "RA4" V 8680 4100 40  0000 C CNN
F 1 "100" V 8607 4101 40  0000 C CNN
F 2 "~" V 8530 4100 30  0000 C CNN
F 3 "~" H 8600 4100 30  0000 C CNN
	1    8600 4100
	0    -1   -1   0   
$EndComp
$Comp
L R RA5
U 1 1 54600788
P 8600 4900
F 0 "RA5" V 8680 4900 40  0000 C CNN
F 1 "100" V 8607 4901 40  0000 C CNN
F 2 "~" V 8530 4900 30  0000 C CNN
F 3 "~" H 8600 4900 30  0000 C CNN
	1    8600 4900
	0    -1   -1   0   
$EndComp
$Comp
L R RA6
U 1 1 54600797
P 8600 5700
F 0 "RA6" V 8680 5700 40  0000 C CNN
F 1 "100" V 8607 5701 40  0000 C CNN
F 2 "~" V 8530 5700 30  0000 C CNN
F 3 "~" H 8600 5700 30  0000 C CNN
	1    8600 5700
	0    -1   -1   0   
$EndComp
$Comp
L R RA2
U 1 1 54600CB4
P 8600 2500
F 0 "RA2" V 8680 2500 40  0000 C CNN
F 1 "100" V 8607 2501 40  0000 C CNN
F 2 "~" V 8530 2500 30  0000 C CNN
F 3 "~" H 8600 2500 30  0000 C CNN
	1    8600 2500
	0    -1   -1   0   
$EndComp
$Comp
L C CA1
U 1 1 54600DD6
P 6000 2150
F 0 "CA1" H 6000 2250 40  0000 L CNN
F 1 "0.1uF" H 6006 2065 40  0000 L CNN
F 2 "~" H 6038 2000 30  0000 C CNN
F 3 "~" H 6000 2150 60  0000 C CNN
	1    6000 2150
	1    0    0    -1  
$EndComp
$Comp
L C CA2
U 1 1 54600F85
P 6000 2950
F 0 "CA2" H 6000 3050 40  0000 L CNN
F 1 "0.1uF" H 6006 2865 40  0000 L CNN
F 2 "~" H 6038 2800 30  0000 C CNN
F 3 "~" H 6000 2950 60  0000 C CNN
	1    6000 2950
	1    0    0    -1  
$EndComp
$Comp
L C CA3
U 1 1 54600F8B
P 6000 3750
F 0 "CA3" H 6000 3850 40  0000 L CNN
F 1 "0.1uF" H 6006 3665 40  0000 L CNN
F 2 "~" H 6038 3600 30  0000 C CNN
F 3 "~" H 6000 3750 60  0000 C CNN
	1    6000 3750
	1    0    0    -1  
$EndComp
$Comp
L C CA4
U 1 1 54600F91
P 6000 4550
F 0 "CA4" H 6000 4650 40  0000 L CNN
F 1 "0.1uF" H 6006 4465 40  0000 L CNN
F 2 "~" H 6038 4400 30  0000 C CNN
F 3 "~" H 6000 4550 60  0000 C CNN
	1    6000 4550
	1    0    0    -1  
$EndComp
$Comp
L C CA5
U 1 1 54600F97
P 6000 5350
F 0 "CA5" H 6000 5450 40  0000 L CNN
F 1 "0.1uF" H 6006 5265 40  0000 L CNN
F 2 "~" H 6038 5200 30  0000 C CNN
F 3 "~" H 6000 5350 60  0000 C CNN
	1    6000 5350
	1    0    0    -1  
$EndComp
$Comp
L C CA6
U 1 1 54600F9D
P 6000 6150
F 0 "CA6" H 6000 6250 40  0000 L CNN
F 1 "0.1uF" H 6006 6065 40  0000 L CNN
F 2 "~" H 6038 6000 30  0000 C CNN
F 3 "~" H 6000 6150 60  0000 C CNN
	1    6000 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 4900 8950 4900
Wire Wire Line
	8250 4900 8350 4900
Wire Wire Line
	2900 2350 2900 5600
Connection ~ 2900 2900
Wire Wire Line
	3000 2900 2900 2900
Connection ~ 6200 6350
Wire Wire Line
	6200 6350 6000 6350
Connection ~ 6000 5700
Wire Wire Line
	6000 5950 6000 5700
Connection ~ 6200 5550
Wire Wire Line
	6200 5550 6000 5550
Connection ~ 6000 4900
Wire Wire Line
	6000 5150 6000 4900
Connection ~ 6200 4750
Wire Wire Line
	6200 4750 6000 4750
Connection ~ 6000 4100
Wire Wire Line
	6000 4350 6000 4100
Connection ~ 6200 3950
Wire Wire Line
	6200 3950 6000 3950
Connection ~ 6200 3150
Wire Wire Line
	6200 3150 6000 3150
Connection ~ 6000 3300
Wire Wire Line
	6000 3550 6000 3300
Connection ~ 6000 2500
Wire Wire Line
	6000 2750 6000 2500
Connection ~ 6200 2350
Wire Wire Line
	6000 2350 6200 2350
Connection ~ 6000 1700
Wire Wire Line
	6000 1950 6000 1700
Connection ~ 8950 2700
Wire Wire Line
	8950 2500 8950 2700
Wire Wire Line
	8850 2500 8950 2500
Connection ~ 8250 2800
Wire Wire Line
	8250 2500 8250 2800
Wire Wire Line
	8350 2500 8250 2500
Connection ~ 8250 6000
Wire Wire Line
	8250 5700 8250 6000
Wire Wire Line
	8350 5700 8250 5700
Connection ~ 8950 5900
Wire Wire Line
	8950 5700 8950 5900
Wire Wire Line
	8850 5700 8950 5700
Connection ~ 8250 4400
Wire Wire Line
	8250 4900 8250 5200
Connection ~ 8950 4300
Wire Wire Line
	8950 4900 8950 5100
Connection ~ 8950 3500
Wire Wire Line
	8950 4100 8950 4300
Wire Wire Line
	8850 4100 8950 4100
Connection ~ 8250 3600
Wire Wire Line
	8250 4100 8250 4400
Wire Wire Line
	8350 4100 8250 4100
Wire Wire Line
	8950 3300 8950 3500
Wire Wire Line
	8850 3300 8950 3300
Wire Wire Line
	8250 3300 8250 3600
Wire Wire Line
	8350 3300 8250 3300
Connection ~ 8950 1900
Wire Wire Line
	8950 1700 8950 1900
Wire Wire Line
	8850 1700 8950 1700
Connection ~ 8250 2000
Wire Wire Line
	8250 1700 8250 2000
Wire Wire Line
	8350 1700 8250 1700
Connection ~ 2900 3450
Wire Wire Line
	2900 3450 3000 3450
Connection ~ 2900 4000
Wire Wire Line
	2900 4000 3000 4000
Connection ~ 2900 4550
Wire Wire Line
	2900 4550 3000 4550
Connection ~ 2900 5100
Wire Wire Line
	2900 5100 3000 5100
Wire Wire Line
	3000 2350 2900 2350
Connection ~ 2600 3800
Wire Wire Line
	3000 3800 2600 3800
Connection ~ 2600 4350
Wire Wire Line
	2600 4350 3000 4350
Wire Wire Line
	2600 4900 3000 4900
Wire Wire Line
	2600 1800 2600 4900
Connection ~ 2800 2700
Wire Wire Line
	2800 2700 3000 2700
Connection ~ 2800 2150
Wire Wire Line
	3000 2150 2800 2150
Wire Wire Line
	2800 3250 3000 3250
Wire Wire Line
	2800 1800 2800 3250
Connection ~ 4200 4550
Wire Wire Line
	4200 4550 4000 4550
Connection ~ 4200 4000
Wire Wire Line
	4200 4000 4000 4000
Connection ~ 4200 3450
Wire Wire Line
	4200 3450 4000 3450
Connection ~ 4200 2900
Wire Wire Line
	4000 2900 4200 2900
Connection ~ 4200 2350
Wire Wire Line
	4200 5100 4000 5100
Wire Wire Line
	4200 2350 4200 5100
Wire Wire Line
	4000 2350 4350 2350
Connection ~ 5800 4100
Wire Wire Line
	5800 4100 6400 4100
Wire Wire Line
	7900 5200 9600 5200
Wire Wire Line
	7900 6000 9600 6000
Wire Wire Line
	7900 5100 9100 5100
Wire Wire Line
	7900 5900 9100 5900
Wire Wire Line
	7900 4400 9600 4400
Wire Wire Line
	7900 4300 9100 4300
Wire Wire Line
	7900 3600 9600 3600
Wire Wire Line
	7900 3500 9100 3500
Wire Wire Line
	7900 2800 9600 2800
Wire Wire Line
	7900 2700 9100 2700
Wire Wire Line
	7900 2000 9600 2000
Wire Wire Line
	7900 1900 9100 1900
Wire Wire Line
	6400 2700 5500 2700
Wire Wire Line
	6400 5100 5500 5100
Wire Wire Line
	6400 5900 5500 5900
Wire Wire Line
	6400 4300 5500 4300
Wire Wire Line
	6400 3500 5500 3500
Wire Wire Line
	6400 1900 5500 1900
Connection ~ 5800 4900
Wire Wire Line
	5800 5700 6400 5700
Connection ~ 5800 3300
Wire Wire Line
	5800 4900 6400 4900
Connection ~ 5800 2500
Wire Wire Line
	5800 3300 6400 3300
Connection ~ 5800 1700
Wire Wire Line
	5800 2500 6400 2500
Connection ~ 8100 5800
Wire Wire Line
	8100 5800 7900 5800
Connection ~ 8100 5700
Wire Wire Line
	8100 5700 7900 5700
Connection ~ 8100 5000
Wire Wire Line
	8100 5000 7900 5000
Connection ~ 8100 4900
Wire Wire Line
	8100 4900 7900 4900
Connection ~ 8100 4200
Wire Wire Line
	8100 4200 7900 4200
Connection ~ 8100 4100
Wire Wire Line
	8100 4100 7900 4100
Connection ~ 8100 3400
Wire Wire Line
	8100 3400 7900 3400
Connection ~ 8100 3300
Wire Wire Line
	8100 3300 7900 3300
Connection ~ 8100 2600
Wire Wire Line
	8100 2600 7900 2600
Connection ~ 8100 2500
Wire Wire Line
	8100 2500 7900 2500
Connection ~ 8100 1800
Wire Wire Line
	7900 1800 8100 1800
Wire Wire Line
	8100 1700 8100 6600
Wire Wire Line
	7900 1700 8100 1700
Wire Wire Line
	5800 1450 5800 5700
Wire Wire Line
	5800 1700 6400 1700
Connection ~ 6200 6000
Wire Wire Line
	6200 6000 6400 6000
Connection ~ 6200 5200
Wire Wire Line
	6200 5200 6400 5200
Connection ~ 6200 4400
Wire Wire Line
	6200 4400 6400 4400
Connection ~ 6200 3600
Wire Wire Line
	6200 3600 6400 3600
Connection ~ 6200 2800
Wire Wire Line
	6200 2800 6400 2800
Wire Wire Line
	6200 2000 6200 6600
Wire Wire Line
	6400 2000 6200 2000
Wire Wire Line
	4000 4350 4350 4350
Wire Wire Line
	4000 2150 4350 2150
Wire Wire Line
	4000 4900 4350 4900
Wire Wire Line
	4000 3800 4350 3800
Wire Wire Line
	4000 3250 4350 3250
Wire Wire Line
	4000 2700 4350 2700
Connection ~ 8250 5200
Connection ~ 8950 5100
$EndSCHEMATC

# STM32 emulator of msm6264b RTC for Amiga computers

This project aims to implement RTC replacement for classic Amiga computers.
Target uC was chosen to be as cheap as possible, easily available & RoHS-friendly.
This project may work on other computers, but it's not guaranteed.

If you made it work for other machine with some fix or without it,
tell me so by creating an issue!

## Build and flash

To build firmware, you'll need STM32CubeMX installed to generate required HAL stuff.
This way you can also easily port this project to other chips.

- open stm_rtc.ioc in STM32CubeMX, then click `GENERATE CODE` button.
- After that, simply use generated makefile by writing:

``` sh
make OPT="-Ofast -std=c11 -Wpedantic -frename-registers" DEBUG=0
```

If you're on Windows and have MinGW installed, you may use `mingw32-make` instead.
This should generate firmware in `./build/stm_rtc.bin`.
I've used following GCC version:

``` plain
> arm-none-eabi-gcc --version
arm-none-eabi-gcc (GNU Tools for ARM Embedded Processors) 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]
```

To flash firmware into your STM you'll need `stm32flash` tool installed.
Required pinout is as follows:

``` plain
PA14 (TX) - USB-UART RX
PA15 (RX) - USB-UART TX
BOOT0     - 3v3 during programming, GND when run
RES       - 3v3 via 10k or any other resistor
```

You may need to drive RES for a short time to GND to reset device before programming.

Connect UART-USB dongle to your PC and type:

``` sh
stm32flash -R -w ./build/stm_rtc_stm32f031k4u.bin COM5
# or
stm32flash -R -w ./build/stm_rtc_stm32f030c6t.bin COM5
```

Of course replace COM5 with name of correct serial port.
You may use Realterm, Cutecom or whatever serial monitor you prefer to list them.

## How it works

TBD

## License

See each file for details.

- All ST code is under STMicroelectronics's license.
- MSM RTC emulation code found in `msm_rtc.c` and `msm_rtc.h` is licensed under [Mozilla Public License 2.0](LICENSE).

## TODO

- write
- add pinout compatibility with smaller stm32f0 packages
- port to  STM32F031C6T6
- PCB
- switch to LL generation for less footprint?
- compat with latest arm gcc?
- stm32f030 power saving code for even cheaper device?

## This worked on QFP48

``` asm
 147              	.L5:
 148 001c 0B69     		ldr	r3, [r1, #16]
 149 001e 1340     		ands	r3, r2
 150 0020 FCD1     		bne	.L5
 151 0022 3869     		ldr	r0, [r7, #16]
 152 0024 050A     		lsrs	r5, r0, #8
 153 0026 3540     		ands	r5, r6
 154 0028 A800     		lsls	r0, r5, #2
 155 002a 6546     		mov	r5, ip
 156 002c 2858     		ldr	r0, [r5, r0]
 157 002e 4546     		mov	r5, r8
 158 0030 6061     		str	r0, [r4, #20]
 159 0032 2560     		str	r5, [r4]
 160 0034 2360     		str	r3, [r4]
 161 0036 F1E7     		b	.L5
```

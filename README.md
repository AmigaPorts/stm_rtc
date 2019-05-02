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
stm32flash -R -w ./build/stm_rtc.bin COM5
```

Of course replace COM5 with name of correct serial port.
You may use Realterm, Cutecom or whatever serial monitor you prefer to list them.

## How it works

TBD

## License

See each file for details.

- All ST code is under STMicroelectronics's license.
- MSM RTC emulation code found in `msm_rtc.c` and `msm_rtc.h` is licensed under [Mozilla Public License 2.0](LICENSE).

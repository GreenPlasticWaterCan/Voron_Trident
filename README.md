# Steps to updating Trident

-`sudo service klipper stop` (stop klipper)

## Update MCU:

-`make menuconfig KCONFIG_CONFIG=config.mcu` (make menuconfig using the main controller presets, only need to be done the first time)

-`make clean`

-`make KCONFIG_CONFIG=config.mcu`(make firmware using config.mcu presets)

-`python3 ~/katapult/scripts/flashtool.py -i can0 -u bec70ad5756c -r` (Put main controller into bootloader/katapult)

-`ls /dev/serial/by-id` (query USB-id)

-`python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb_katapult_stm32h723xx_1A0008001751313338343730-if00` (flash over USB)

alternative:
-`make flash KCONFIG_CONFIG=config.mcu FLASH_DEVICE=/dev/serial/by-id/usb_katapult_stm32h723xx_1A0008001751313338343730-if00`

## Update toolhead:

-`make menuconfig KCONFIG_CONFIG=config.toolhead` (make menuconfig using the toolhead presets)

-`make clean`

-`make KCONFIG_CONFIG=config.toolhead` (make config using config.toolhead presets)

-`python3 ~/katapult/scripts/flashtool.py -i can0 -u 0b4fcaff12d7 -r` (Put Toolhead into bootloader/katapult)

-`python3 ~/katapult/scripts/flashtool.py -q` (query CANbus UUID)

-`python3 ~/katapult/scripts/flashtool.py -i can0 -u 0b4fcaff12d7 -f ~/klipper/out/klipper.bin` (flash firmware over CANbus)

-`Sudo service klipper start` (start klipper)

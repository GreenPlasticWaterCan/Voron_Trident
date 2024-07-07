Update MCU:

`make menuconfig KCONFIG_CONFIG=config.mcu`
`make clean`
`make KCONFIG_CONFIG=config.mcu`
`python3 ~/katapult/scripts/flashtool.py -i can0 -u bec70ad5756c -r`
`python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb_katapult_stm32h723xx_1A0008001751313338343730-if00`



Update toolhead:
make menuconfig KCONFIG_CONFIG=config.toolhead
make clean
make KCONFIG_CONFIG=config.toolhead
python3 ~/katapult/scripts/flashtool.py -i can0 -u 0b4fcaff12d7 -r

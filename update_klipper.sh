#!/bin/bash
set -euo pipefail
#This is a bash script to automatically update all MCU's. This needs to be changed to each specific printer. It also uses KCONFIG_CONFIG tha>

#Stop klipper services
echo 'Shutting down Klipper'
sudo service klipper stop
sleep 1

#Updating the main controller board
#Clean previous firmware  files
echo 'cleaning old firmware config'
make clean KCONFIG_CONFIG=config.mcu
sleep 1

#Make new firmware  file
echo 'Building firmware'
make KCONFIG_CONFIG=config.mcu
sleep 1

#Put the contoller board in Katapult-USB mode\
echo 'Putting controller board into Katapult'
python3 ~/katapult/scripts/flashtool.py -i can0 -u bec70ad5756c -r
sleep 1

#Flash new firmware over USB
echo 'Flashing controller board'
make flash KCONFIG_CONFIG=config.mcu FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h723xx_1A0008001751313338343730-if00
sleep 1

#Updating the toolhead board
#Clean previous config files
echo 'cleaning old firmware config'
make clean KCONFIG_CONFIG=config.toolhead
sleep 1

#Make new firmware files
echo 'Building firmware'
make KCONFIG_CONFIG=config.toolhead
sleep 1

#Put toolhead into Katapult-bootloader to be able to flash over CANBus
echo 'Putting toolhead into bootloader'
python3 ~/katapult/scripts/flashtool.py -i can0 -u 0b4fcaff12d7 -r
sleep 1

#Flash the new firmware over CANBus to the toolhead
echo 'Flashing firwmare'
python3 ~/katapult/scripts/flashtool.py -i can0 -u 0b4fcaff12d7 -f ~/klipper/out/klipper.bin
sleep 1

#Restart klipper services
sudo service klipper start
echo 'Starting Klipper'
sleep 1

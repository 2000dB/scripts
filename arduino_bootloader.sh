#! /bin/bash

################################################################
# Make sure all the variables are what you need for the specific
# board/clock/whatever
# 
# 2000dB - 2012
################################################################

CHIP=atmega168
PROG=stk500v2
PORT=/dev/tty.usbserial-FTE270YJ

ARDUINO_DIR=/Applications/Arduino.app/Contents/Resources/Java
BOOTLOADER=${ARDUINO_DIR}/hardware/arduino/bootloaders/optiboot/optiboot_atmega168.hex
AVR_DIR=${ARDUINO_DIR}/hardware/tools/avr
AVR_CONF=${AVR_DIR}/etc/avrdude.conf
AVRDUDE=${AVR_DIR}/bin/avrdude

# erase
$AVRDUDE -C $AVR_CONF -e -p $CHIP -P $PORT -c $PROG -B 2

# set fuses
$AVRDUDE -C $AVR_CONF -p $CHIP -P $PORT -c $PROG -U lfuse:w:0xff:m -U hfuse:w:0xde:m -U efuse:w:0x05:m

# flash bootloader
$AVRDUDE -C $AVR_CONF -p $CHIP -P $PORT -c $PROG -U flash:w:$BOOTLOADER:i

# lock bootloader segment
$AVRDUDE -C $AVR_CONF -V -p $CHIP -P $PORT -c $PROG -U lock:w:0x0f:m

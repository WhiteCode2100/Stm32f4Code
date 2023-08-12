#define tool path
TOOLS_PATH=/home/xing/my_disk/software/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux/bin
CC=${TOOLS_PATH}/arm-none-eabi-gcc
AS=${TOOLS_PATH}/arm-none-eabi-as
LD=${TOOLS_PATH}/arm-none-eabi-ld
OBJCOPY=${TOOLS_PATH}/arm-none-eabi-objcopy

.PHONY: all

all:
	$(AS) -mcpu=cortex-m4 start.s -c -o start.o
	$(LD) -T stm32f4.ld start.o -o start.elf
	$(OBJCOPY) -O binary start.elf start.bin
clean:
	rm -rf start.o start.elf start.bin

flash: ${PRJ_NAME}
	st-flash write start.bin 0x8000000
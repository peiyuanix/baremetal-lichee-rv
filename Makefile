HOST_CC := gcc
CROSS_COMPILE := riscv64-linux-gnu-
AS := ${CROSS_COMPILE}as
CC := ${CROSS_COMPILE}gcc
LD := ${CROSS_COMPILE}ld
OBJCOPY := ${CROSS_COMPILE}objcopy
SDCARD := "replace_device_in_burn_of_makefile_with_your_sdcard"

bin/BOOT0.bin: bin/yuan_spl.bin tools/mksunxiboot
	./tools/mksunxiboot bin/yuan_spl.bin bin/BOOT0.bin

bin/yuan_spl.bin: yuan_spl_init.s yuan_spl.c yuan_spl.ld
	${AS} yuan_spl_init.s -o bin/yuan_spl_init.asmo
	${CC} --freestanding -c -O0 yuan_spl.c -o bin/yuan_spl.co
	${LD} --no-relax -T yuan_spl.ld bin/yuan_spl_init.asmo bin/yuan_spl.co -o bin/yuan_spl.elf
	${OBJCOPY} -O binary -S bin/yuan_spl.elf bin/yuan_spl.bin

dis: bin/yuan_spl_bootable.bin
	riscv64-linux-gnu-objdump -b binary -m riscv:rv64 -D bin/BOOT0.bin

tools/mksunxiboot:
	${HOST_CC} -o tools/mksunxiboot mksunxiboot.c

burn: bin/BOOT0.bin
	sudo dd if=bin/BOOT0.bin of=${SDCARD} bs=512 seek=16 conv=sync

clean:
	rm -rf bin/
	rm -rf tools/

$(shell mkdir -p bin)
$(shell mkdir -p tools)
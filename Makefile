HOST_CC := gcc
CROSS_COMPILE := riscv64-linux-gnu-
AS := ${CROSS_COMPILE}as
LD := ${CROSS_COMPILE}ld
OBJCOPY := ${CROSS_COMPILE}objcopy
SDCARD := "replace_device_in_burn_of_makefile_with_your_sdcard"

bin/BOOT0.bin: bin/yuan_spl.bin tools/mksunxiboot
	./tools/mksunxiboot bin/yuan_spl.bin bin/BOOT0.bin

bin/yuan_spl.bin: yuan_spl.s yuan_spl.ld
	${AS} yuan_spl.s -o bin/yuan_spl.o
	${LD} -T yuan_spl.ld bin/yuan_spl.o -o bin/yuan_spl.elf
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
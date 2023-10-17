.global _yuan_spl_init

.text
_yuan_spl_init:
	li sp, 0x27fff    # set the top of SRAM to the stack pointer
	j _yuan_spl_main

_infi:
	j _infi

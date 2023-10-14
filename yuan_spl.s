.global _yuan_spl_start

.text
_yuan_spl_start:
	li gp, 0x02000000 # GPIO base addr

	li t0, 0xfffffff1
	sw t0, 0x30(gp)   # set PB_0  to OUTPUT mode

	li t0, 0x00000001
	sw t0, 0x40(gp)   # set PB_0 state to 1
_infi:
	j _yuan_spl_start

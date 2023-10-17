#include "riscv_asm.h"

#define GPIO_BASE (0x02000000)
#define GPIO_OFF_PB_CFG (GPIO_BASE + 0x30)
#define GPIO_OFF_PB_DAT (GPIO_BASE + 0x40)

void _yuan_spl_main()
{
	writeu32(GPIO_OFF_PB_CFG, 0xFFFFFFF1); // set PB_0  to OUTPUT mode
	writeu32(GPIO_OFF_PB_DAT, 0x00000001); // set PB_0 state to 1
	for (;;)
		;
}
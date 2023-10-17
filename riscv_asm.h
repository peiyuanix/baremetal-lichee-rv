#ifndef _RISCV_ASM_H
#define _RISCV_ASM_H

#include "riscv_arch.h"

#define readu8(addr) (*(const u8 *)(addr))
#define readu16(addr) (*(const u16 *)(addr))
#define readu32(addr) (*(const u32 *)(addr))
#define readu64(addr) (*(const u64 *)(addr))

#define writeu8(addr, val) (*(u8 *)(addr) = (val))
#define writeu16(addr, val) (*(u16 *)(addr) = (val))
#define writeu32(addr, val) (*(u32 *)(addr) = (val))
#define writeu64(addr, val) (*(u64 *)(addr) = (val))

static inline void csrw_mtvec(const volatile u64 val)
{
  asm volatile("csrw mtvec, %0"
               :
               : "r"(val));
}

static inline void csrw_mie(const volatile u64 val)
{
  asm volatile("csrw mie, %0"
               :
               : "r"(val));
}

static inline u64 csrr_mstatus()
{
  volatile u64 val;
  asm volatile("csrr %0, mstatus"
               : "=r"(val)
               :);
  return val;
}

static inline void csrw_mstatus(const volatile u64 val)
{
  asm volatile("csrw mstatus, %0"
               :
               : "r"(val));
}

static inline void csrs_mstatus(const volatile u64 val)
{
  asm volatile("csrs mstatus, %0"
               :
               : "r"(val));
}

static inline void csrc_mstatus(const volatile u64 val)
{
  asm volatile("csrc mstatus, %0"
               :
               : "r"(val));
}

static inline u64 csrr_mcause()
{
  volatile u64 val;
  asm volatile("csrr %0, mcause"
               : "=r"(val)
               :);
  return val;
}

static inline u64 csrr_mepc()
{
  volatile u64 val;
  asm volatile("csrr %0, mepc"
               : "=r"(val)
               :);
  return val;
}

static inline void ecall()
{
  asm volatile("ecall"
               :
               :);
}

#endif
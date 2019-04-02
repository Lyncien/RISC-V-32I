# 1 "1testAll.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "1testAll.S"
# See LICENSE for license details.

#*****************************************************************************
# xor.S
#-----------------------------------------------------------------------------

# Test xor instruction.


# 1 "./riscv_test.h" 1





# 1 "././encoding.h" 1
# 7 "./riscv_test.h" 2
# 11 "1testAll.S" 2
# 1 "./test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 20 "./test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 36 "./test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 92 "./test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 120 "./test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 214 "./test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 340 "./test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 369 "./test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
# 631 "./test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in gp)
#-----------------------------------------------------------------------
# 643 "./test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "1testAll.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0


 #add.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_2: li x1, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x30, x29, fail;;
  test_3: li x1, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x00000002) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x30, x29, fail;;
  test_4: li x1, ((0x00000003) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x00000007) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x0000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x30, x29, fail;;

  test_5: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x30, x29, fail;;
  test_6: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x30, x29, fail;;
  test_7: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xffffffff7fff8000) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne x30, x29, fail;;

  test_8: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 8; bne x30, x29, fail;;
  test_9: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 9; bne x30, x29, fail;;
  test_10: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x0000000080007ffe) & ((1 << (32 - 1) << 1) - 1)); li gp, 10; bne x30, x29, fail;;

  test_11: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xffffffff80007fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 11; bne x30, x29, fail;;
  test_12: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x000000007fff7fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 12; bne x30, x29, fail;;

  test_13: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 13; bne x30, x29, fail;;
  test_14: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 14; bne x30, x29, fail;;
  test_15: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0xfffffffffffffffe) & ((1 << (32 - 1) << 1) - 1)); li gp, 15; bne x30, x29, fail;;

  test_16: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2;; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 16; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_17: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x1, x1, x2;; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 17; bne x1, x29, fail;;
  test_18: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x2, x1, x2;; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 18; bne x2, x29, fail;;
  test_19: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); add x1, x1, x1;; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 19; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_20: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 20; bne x6, x29, fail;;
  test_21: li x4, 0; 1: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 21; bne x6, x29, fail;;
  test_22: li x4, 0; 1: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 22; bne x6, x29, fail;;

  test_23: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 23; bne x30, x29, fail;;
  test_24: li x4, 0; 1: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 24; bne x30, x29, fail;;
  test_25: li x4, 0; 1: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 25; bne x30, x29, fail;;
  test_26: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 26; bne x30, x29, fail;;
  test_27: li x4, 0; 1: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 27; bne x30, x29, fail;;
  test_28: li x4, 0; 1: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 28; bne x30, x29, fail;;

  test_29: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 29; bne x30, x29, fail;;
  test_30: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 30; bne x30, x29, fail;;
  test_31: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); nop; nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 31; bne x30, x29, fail;;
  test_32: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 32; bne x30, x29, fail;;
  test_33: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((25) & ((1 << (32 - 1) << 1) - 1)); li gp, 33; bne x30, x29, fail;;
  test_34: li x4, 0; 1: li x2, ((11) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); add x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((26) & ((1 << (32 - 1) << 1) - 1)); li gp, 34; bne x30, x29, fail;;

  test_35: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); add x2, x0, x1;; li x29, ((15) & ((1 << (32 - 1) << 1) - 1)); li gp, 35; bne x2, x29, fail;;
  test_36: li x1, ((32) & ((1 << (32 - 1) << 1) - 1)); add x2, x1, x0;; li x29, ((32) & ((1 << (32 - 1) << 1) - 1)); li gp, 36; bne x2, x29, fail;;
  test_37: add x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 37; bne x1, x29, fail;;
  test_38: li x1, ((16) & ((1 << (32 - 1) << 1) - 1)); li x2, ((30) & ((1 << (32 - 1) << 1) - 1)); add x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 38; bne x0, x29, fail;;

#addi.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_39: li x1, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x000) | (-(((0x000) >> 11) & 1) << 11));; li x29, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 39; bne x30, x29, fail;;
  test_40: li x1, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x001) | (-(((0x001) >> 11) & 1) << 11));; li x29, ((0x00000002) & ((1 << (32 - 1) << 1) - 1)); li gp, 40; bne x30, x29, fail;;
  test_41: li x1, ((0x00000003) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x007) | (-(((0x007) >> 11) & 1) << 11));; li x29, ((0x0000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 41; bne x30, x29, fail;;

  test_42: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x800) | (-(((0x800) >> 11) & 1) << 11));; li x29, ((0xfffffffffffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 42; bne x30, x29, fail;;
  test_43: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x000) | (-(((0x000) >> 11) & 1) << 11));; li x29, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 43; bne x30, x29, fail;;
  test_44: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x800) | (-(((0x800) >> 11) & 1) << 11));; li x29, ((0xffffffff7ffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 44; bne x30, x29, fail;;

  test_45: li x1, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x7ff) | (-(((0x7ff) >> 11) & 1) << 11));; li x29, ((0x00000000000007ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 45; bne x30, x29, fail;;
  test_46: li x1, ((0x7fffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x000) | (-(((0x000) >> 11) & 1) << 11));; li x29, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 46; bne x30, x29, fail;;
  test_47: li x1, ((0x7fffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x7ff) | (-(((0x7ff) >> 11) & 1) << 11));; li x29, ((0x00000000800007fe) & ((1 << (32 - 1) << 1) - 1)); li gp, 47; bne x30, x29, fail;;

  test_48: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x7ff) | (-(((0x7ff) >> 11) & 1) << 11));; li x29, ((0xffffffff800007ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 48; bne x30, x29, fail;;
  test_49: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x800) | (-(((0x800) >> 11) & 1) << 11));; li x29, ((0x000000007ffff7ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 49; bne x30, x29, fail;;

  test_50: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0xfff) | (-(((0xfff) >> 11) & 1) << 11));; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 50; bne x30, x29, fail;;
  test_51: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x001) | (-(((0x001) >> 11) & 1) << 11));; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 51; bne x30, x29, fail;;
  test_52: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0xfff) | (-(((0xfff) >> 11) & 1) << 11));; li x29, ((0xfffffffffffffffe) & ((1 << (32 - 1) << 1) - 1)); li gp, 52; bne x30, x29, fail;;

  test_53: li x1, ((0x7fffffff) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((0x001) | (-(((0x001) >> 11) & 1) << 11));; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 53; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_54: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); addi x1, x1, ((11) | (-(((11) >> 11) & 1) << 11));; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 54; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_55: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((11) | (-(((11) >> 11) & 1) << 11)); addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 55; bne x6, x29, fail;;
  test_56: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((10) | (-(((10) >> 11) & 1) << 11)); nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((23) & ((1 << (32 - 1) << 1) - 1)); li gp, 56; bne x6, x29, fail;;
  test_57: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((9) | (-(((9) >> 11) & 1) << 11)); nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((22) & ((1 << (32 - 1) << 1) - 1)); li gp, 57; bne x6, x29, fail;;

  test_58: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); addi x30, x1, ((11) | (-(((11) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 58; bne x30, x29, fail;;
  test_59: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; addi x30, x1, ((10) | (-(((10) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((23) & ((1 << (32 - 1) << 1) - 1)); li gp, 59; bne x30, x29, fail;;
  test_60: li x4, 0; 1: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; nop; addi x30, x1, ((9) | (-(((9) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((22) & ((1 << (32 - 1) << 1) - 1)); li gp, 60; bne x30, x29, fail;;

  test_61: addi x1, x0, ((32) | (-(((32) >> 11) & 1) << 11));; li x29, ((32) & ((1 << (32 - 1) << 1) - 1)); li gp, 61; bne x1, x29, fail;;
  test_62: li x1, ((33) & ((1 << (32 - 1) << 1) - 1)); addi x0, x1, ((50) | (-(((50) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 62; bne x0, x29, fail;;

#and.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_63: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 63; bne x30, x29, fail;;
  test_64: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 64; bne x30, x29, fail;;
  test_65: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 65; bne x30, x29, fail;;
  test_66: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0xf000f000) & ((1 << (32 - 1) << 1) - 1)); li gp, 66; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_67: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x1, x1, x2;; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 67; bne x1, x29, fail;;
  test_68: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x2, x1, x2;; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 68; bne x2, x29, fail;;
  test_69: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x1, x1, x1;; li x29, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 69; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_70: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 70; bne x6, x29, fail;;
  test_71: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 71; bne x6, x29, fail;;
  test_72: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 72; bne x6, x29, fail;;

  test_73: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 73; bne x30, x29, fail;;
  test_74: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 74; bne x30, x29, fail;;
  test_75: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 75; bne x30, x29, fail;;
  test_76: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 76; bne x30, x29, fail;;
  test_77: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 77; bne x30, x29, fail;;
  test_78: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 78; bne x30, x29, fail;;

  test_79: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 79; bne x30, x29, fail;;
  test_80: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 80; bne x30, x29, fail;;
  test_81: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 81; bne x30, x29, fail;;
  test_82: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 82; bne x30, x29, fail;;
  test_83: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 83; bne x30, x29, fail;;
  test_84: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 84; bne x30, x29, fail;;

  test_85: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x2, x0, x1;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 85; bne x2, x29, fail;;
  test_86: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); and x2, x1, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 86; bne x2, x29, fail;;
  test_87: and x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 87; bne x1, x29, fail;;
  test_88: li x1, ((0x11111111) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x22222222) & ((1 << (32 - 1) << 1) - 1)); and x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 88; bne x0, x29, fail;;

#andi.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_89: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11));; li x29, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 89; bne x30, x29, fail;;
  test_90: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0x000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 90; bne x30, x29, fail;;
  test_91: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x29, ((0x0000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 91; bne x30, x29, fail;;
  test_92: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 92; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_93: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); andi x1, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0x00000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 93; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_94: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11)); addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00000700) & ((1 << (32 - 1) << 1) - 1)); li gp, 94; bne x6, x29, fail;;
  test_95: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 95; bne x6, x29, fail;;
  test_96: li x4, 0; 1: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11)); nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 96; bne x6, x29, fail;;

  test_97: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); andi x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00000700) & ((1 << (32 - 1) << 1) - 1)); li gp, 97; bne x30, x29, fail;;
  test_98: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; andi x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 98; bne x30, x29, fail;;
  test_99: li x4, 0; 1: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; andi x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 99; bne x30, x29, fail;;

  test_100: andi x1, x0, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 100; bne x1, x29, fail;;
  test_101: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); andi x0, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 101; bne x0, x29, fail;;

#auipc.S
  test_102: .align 3; lla a0, 1f + 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x29, ((10000) & ((1 << (32 - 1) << 1) - 1)); li gp, 102; bne a0, x29, fail;






  test_103: .align 3; lla a0, 1f - 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x29, ((-10000) & ((1 << (32 - 1) << 1) - 1)); li gp, 103; bne a0, x29, fail;






 #beq.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_104: li gp, 104; li x1, 0; li x2, 0; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;
  test_105: li gp, 105; li x1, 1; li x2, 1; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;
  test_106: li gp, 106; li x1, -1; li x2, -1; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;

  test_107: li gp, 107; li x1, 0; li x2, 1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_108: li gp, 108; li x1, 1; li x2, 0; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_109: li gp, 109; li x1, -1; li x2, 1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_110: li gp, 110; li x1, 1; li x2, -1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_111: li gp, 111; li x4, 0; 1: li x1, 0; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_112: li gp, 112; li x4, 0; 1: li x1, 0; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_113: li gp, 113; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_114: li gp, 114; li x4, 0; 1: li x1, 0; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_115: li gp, 115; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_116: li gp, 116; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_117: li gp, 117; li x4, 0; 1: li x1, 0; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_118: li gp, 118; li x4, 0; 1: li x1, 0; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_119: li gp, 119; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_120: li gp, 120; li x4, 0; 1: li x1, 0; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_121: li gp, 121; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_122: li gp, 122; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_123: li x1, 1; beq x0, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 123; bne x1, x29, fail;
# 265 "1testAll.S"
 #bge.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_124: li gp, 124; li x1, 0; li x2, 0; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;
  test_125: li gp, 125; li x1, 1; li x2, 1; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;
  test_126: li gp, 126; li x1, -1; li x2, -1; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;
  test_127: li gp, 127; li x1, 1; li x2, 0; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;
  test_128: li gp, 128; li x1, 1; li x2, -1; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;
  test_129: li gp, 129; li x1, -1; li x2, -2; bge x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bge x1, x2, 1b; bne x0, gp, fail; 3:;

  test_130: li gp, 130; li x1, 0; li x2, 1; bge x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bge x1, x2, 1b; 3:;
  test_131: li gp, 131; li x1, -1; li x2, 1; bge x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bge x1, x2, 1b; 3:;
  test_132: li gp, 132; li x1, -2; li x2, -1; bge x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bge x1, x2, 1b; 3:;
  test_133: li gp, 133; li x1, -2; li x2, 1; bge x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bge x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_134: li gp, 134; li x4, 0; 1: li x1, -1; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_135: li gp, 135; li x4, 0; 1: li x1, -1; li x2, 0; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_136: li gp, 136; li x4, 0; 1: li x1, -1; li x2, 0; nop; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_137: li gp, 137; li x4, 0; 1: li x1, -1; nop; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_138: li gp, 138; li x4, 0; 1: li x1, -1; nop; li x2, 0; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_139: li gp, 139; li x4, 0; 1: li x1, -1; nop; nop; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_140: li gp, 140; li x4, 0; 1: li x1, -1; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_141: li gp, 141; li x4, 0; 1: li x1, -1; li x2, 0; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_142: li gp, 142; li x4, 0; 1: li x1, -1; li x2, 0; nop; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_143: li gp, 143; li x4, 0; 1: li x1, -1; nop; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_144: li gp, 144; li x4, 0; 1: li x1, -1; nop; li x2, 0; nop; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_145: li gp, 145; li x4, 0; 1: li x1, -1; nop; nop; li x2, 0; bge x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_146: li x1, 1; bge x1, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 146; bne x1, x29, fail;
# 317 "1testAll.S"
 #bgeu.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_147: li gp, 147; li x1, 0x00000000; li x2, 0x00000000; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_148: li gp, 148; li x1, 0x00000001; li x2, 0x00000001; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_149: li gp, 149; li x1, 0xffffffff; li x2, 0xffffffff; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_150: li gp, 150; li x1, 0x00000001; li x2, 0x00000000; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_151: li gp, 151; li x1, 0xffffffff; li x2, 0xfffffffe; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_152: li gp, 152; li x1, 0xffffffff; li x2, 0x00000000; bgeu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bgeu x1, x2, 1b; bne x0, gp, fail; 3:;

  test_153: li gp, 153; li x1, 0x00000000; li x2, 0x00000001; bgeu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bgeu x1, x2, 1b; 3:;
  test_154: li gp, 154; li x1, 0xfffffffe; li x2, 0xffffffff; bgeu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bgeu x1, x2, 1b; 3:;
  test_155: li gp, 155; li x1, 0x00000000; li x2, 0xffffffff; bgeu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bgeu x1, x2, 1b; 3:;
  test_156: li gp, 156; li x1, 0x7fffffff; li x2, 0x80000000; bgeu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bgeu x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_157: li gp, 157; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_158: li gp, 158; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_159: li gp, 159; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; nop; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_160: li gp, 160; li x4, 0; 1: li x1, 0xefffffff; nop; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_161: li gp, 161; li x4, 0; 1: li x1, 0xefffffff; nop; li x2, 0xf0000000; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_162: li gp, 162; li x4, 0; 1: li x1, 0xefffffff; nop; nop; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_163: li gp, 163; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_164: li gp, 164; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_165: li gp, 165; li x4, 0; 1: li x1, 0xefffffff; li x2, 0xf0000000; nop; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_166: li gp, 166; li x4, 0; 1: li x1, 0xefffffff; nop; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_167: li gp, 167; li x4, 0; 1: li x1, 0xefffffff; nop; li x2, 0xf0000000; nop; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_168: li gp, 168; li x4, 0; 1: li x1, 0xefffffff; nop; nop; li x2, 0xf0000000; bgeu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_169: li x1, 1; bgeu x1, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 169; bne x1, x29, fail;
# 369 "1testAll.S"
 #blt.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_170: li gp, 170; li x1, 0; li x2, 1; blt x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: blt x1, x2, 1b; bne x0, gp, fail; 3:;
  test_171: li gp, 171; li x1, -1; li x2, 1; blt x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: blt x1, x2, 1b; bne x0, gp, fail; 3:;
  test_172: li gp, 172; li x1, -2; li x2, -1; blt x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: blt x1, x2, 1b; bne x0, gp, fail; 3:;

  test_173: li gp, 173; li x1, 1; li x2, 0; blt x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: blt x1, x2, 1b; 3:;
  test_174: li gp, 174; li x1, 1; li x2, -1; blt x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: blt x1, x2, 1b; 3:;
  test_175: li gp, 175; li x1, -1; li x2, -2; blt x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: blt x1, x2, 1b; 3:;
  test_176: li gp, 176; li x1, 1; li x2, -2; blt x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: blt x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_177: li gp, 177; li x4, 0; 1: li x1, 0; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_178: li gp, 178; li x4, 0; 1: li x1, 0; li x2, -1; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_179: li gp, 179; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_180: li gp, 180; li x4, 0; 1: li x1, 0; nop; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_181: li gp, 181; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_182: li gp, 182; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_183: li gp, 183; li x4, 0; 1: li x1, 0; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_184: li gp, 184; li x4, 0; 1: li x1, 0; li x2, -1; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_185: li gp, 185; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_186: li gp, 186; li x4, 0; 1: li x1, 0; nop; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_187: li gp, 187; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_188: li gp, 188; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; blt x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_189: li x1, 1; blt x0, x1, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 189; bne x1, x29, fail;
# 418 "1testAll.S"
 #bltu.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_190: li gp, 190; li x1, 0x00000000; li x2, 0x00000001; bltu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bltu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_191: li gp, 191; li x1, 0xfffffffe; li x2, 0xffffffff; bltu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bltu x1, x2, 1b; bne x0, gp, fail; 3:;
  test_192: li gp, 192; li x1, 0x00000000; li x2, 0xffffffff; bltu x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bltu x1, x2, 1b; bne x0, gp, fail; 3:;

  test_193: li gp, 193; li x1, 0x00000001; li x2, 0x00000000; bltu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bltu x1, x2, 1b; 3:;
  test_194: li gp, 194; li x1, 0xffffffff; li x2, 0xfffffffe; bltu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bltu x1, x2, 1b; 3:;
  test_195: li gp, 195; li x1, 0xffffffff; li x2, 0x00000000; bltu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bltu x1, x2, 1b; 3:;
  test_196: li gp, 196; li x1, 0x80000000; li x2, 0x7fffffff; bltu x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bltu x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_197: li gp, 197; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_198: li gp, 198; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_199: li gp, 199; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; nop; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_200: li gp, 200; li x4, 0; 1: li x1, 0xf0000000; nop; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_201: li gp, 201; li x4, 0; 1: li x1, 0xf0000000; nop; li x2, 0xefffffff; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_202: li gp, 202; li x4, 0; 1: li x1, 0xf0000000; nop; nop; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_203: li gp, 203; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_204: li gp, 204; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_205: li gp, 205; li x4, 0; 1: li x1, 0xf0000000; li x2, 0xefffffff; nop; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_206: li gp, 206; li x4, 0; 1: li x1, 0xf0000000; nop; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_207: li gp, 207; li x4, 0; 1: li x1, 0xf0000000; nop; li x2, 0xefffffff; nop; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_208: li gp, 208; li x4, 0; 1: li x1, 0xf0000000; nop; nop; li x2, 0xefffffff; bltu x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_209: li x1, 1; bltu x0, x1, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 209; bne x1, x29, fail;
# 467 "1testAll.S"
 #bne.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_210: li gp, 210; li x1, 0; li x2, 1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_211: li gp, 211; li x1, 1; li x2, 0; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_212: li gp, 212; li x1, -1; li x2, 1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;
  test_213: li gp, 213; li x1, 1; li x2, -1; bne x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: bne x1, x2, 1b; bne x0, gp, fail; 3:;

  test_214: li gp, 214; li x1, 0; li x2, 0; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;
  test_215: li gp, 215; li x1, 1; li x2, 1; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;
  test_216: li gp, 216; li x1, -1; li x2, -1; bne x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: bne x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_217: li gp, 217; li x4, 0; 1: li x1, 0; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_218: li gp, 218; li x4, 0; 1: li x1, 0; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_219: li gp, 219; li x4, 0; 1: li x1, 0; li x2, 0; nop; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_220: li gp, 220; li x4, 0; 1: li x1, 0; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_221: li gp, 221; li x4, 0; 1: li x1, 0; nop; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_222: li gp, 222; li x4, 0; 1: li x1, 0; nop; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_223: li gp, 223; li x4, 0; 1: li x1, 0; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_224: li gp, 224; li x4, 0; 1: li x1, 0; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_225: li gp, 225; li x4, 0; 1: li x1, 0; li x2, 0; nop; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_226: li gp, 226; li x4, 0; 1: li x1, 0; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_227: li gp, 227; li x4, 0; 1: li x1, 0; nop; li x2, 0; nop; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_228: li gp, 228; li x4, 0; 1: li x1, 0; nop; nop; li x2, 0; bne x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_229: li x1, 1; bne x1, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 229; bne x1, x29, fail;
# 516 "1testAll.S"
 #fence_i.S
# li a3, 111
# lh a0, insn
# lh a1, insn+2

# # test I$ hit
# .align 6
# sh a0, 1f, t0
# sh a1, 1f+2, t0
# fence.i

# 1: addi a3, a3, 222
# test_230: nop; li x29, ((444) & ((1 << (32 - 1) << 1) - 1)); li gp, 230; bne a3, x29, fail;

 # # test prefetcher hit
# li a4, 100
# 1: addi a4, a4, -1
# bnez a4, 1b

# sh a0, 1f, t0
# sh a1, 1f+2, t0
# fence.i

# .align 6
# 1: addi a3, a3, 555
# test_231: nop; li x29, ((777) & ((1 << (32 - 1) << 1) - 1)); li gp, 231; bne a3, x29, fail;

 #jal.S
  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

jal_test_2:
  li gp, 2
  li ra, 0

  jal x4, jal_target_2
jal_linkaddr_2:
  nop
  nop

  j fail

jal_target_2:
  la x6, jal_linkaddr_2
  bne x6, x4, fail

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_232: li ra, 1; jal x0, 1f; addi ra, ra, 1; addi ra, ra, 1; addi ra, ra, 1; addi ra, ra, 1; 1: addi ra, ra, 1; addi ra, ra, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 232; bne ra, x29, fail;
# 578 "1testAll.S"
 #jalr.S
  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

jalr_test_2:
  li gp, 2
  li t0, 0
  la t1, jalr_target_2

  jalr t0, t1, 0
jalr_linkaddr_2:
  j fail

jalr_target_2:
  la t1, jalr_linkaddr_2
  bne t0, t1, fail

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_233: li gp, 233; li x4, 0; 1: la x6, 2f; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_234: li gp, 234; li x4, 0; 1: la x6, 2f; nop; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_235: li gp, 235; li x4, 0; 1: la x6, 2f; nop; nop; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  .option push
  .align 2
  .option norvc
  test_236: li t0, 1; la t1, 1f; jr t1, -4; addi t0, t0, 1; addi t0, t0, 1; addi t0, t0, 1; addi t0, t0, 1; 1: addi t0, t0, 1; addi t0, t0, 1;; li x29, ((4) & ((1 << (32 - 1) << 1) - 1)); li gp, 236; bne t0, x29, fail;
# 622 "1testAll.S"
  .option pop



  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 
.align 1
#lb.S lbu.S
  tdat:
  tdat1: .byte 0xff
  tdat2: .byte 0x00
  tdat3: .byte 0xf0
  tdat4: .byte 0x0f
#sb.S
  sb_tdat:
  sb_tdat1: .byte 0xef
  sb_tdat2: .byte 0xef
  sb_tdat3: .byte 0xef
  sb_tdat4: .byte 0xef
  sb_tdat5: .byte 0xef
  sb_tdat6: .byte 0xef
  sb_tdat7: .byte 0xef
  sb_tdat8: .byte 0xef
  sb_tdat9: .byte 0xef
  sb_tdat10: .byte 0xef
.align 2
#lh.S lhu.S
  lh_tdat:
  lh_tdat1: .half 0x00ff
  lh_tdat2: .half 0xff00
  lh_tdat3: .half 0x0ff0
  lh_tdat4: .half 0xf00f
#sh.S
  sh_tdat:
  sh_tdat1: .half 0xbeef
  sh_tdat2: .half 0xbeef
  sh_tdat3: .half 0xbeef
  sh_tdat4: .half 0xbeef
  sh_tdat5: .half 0xbeef
  sh_tdat6: .half 0xbeef
  sh_tdat7: .half 0xbeef
  sh_tdat8: .half 0xbeef
  sh_tdat9: .half 0xbeef
  sh_tdat10: .half 0xbeef
.align 4
#lw.S
  lw_tdat:
  lw_tdat1: .word 0x00ff00ff
  lw_tdat2: .word 0xff00ff00
  lw_tdat3: .word 0x0ff00ff0
  lw_tdat4: .word 0xf00ff00f
#sw.S
  sw_tdat:
  sw_tdat1: .word 0xdeadbeef
  sw_tdat2: .word 0xdeadbeef
  sw_tdat3: .word 0xdeadbeef
  sw_tdat4: .word 0xdeadbeef
  sw_tdat5: .word 0xdeadbeef
  sw_tdat6: .word 0xdeadbeef
  sw_tdat7: .word 0xdeadbeef
  sw_tdat8: .word 0xdeadbeef
  sw_tdat9: .word 0xdeadbeef
  sw_tdat10: .word 0xdeadbeef
.align 4
#fence_i.S
insn:
  addi a3, a3, 333

.align 4; .global end_signature; end_signature:

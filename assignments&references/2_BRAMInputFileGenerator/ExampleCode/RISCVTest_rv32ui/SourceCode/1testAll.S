# See LICENSE for license details.

#*****************************************************************************
# xor.S
#-----------------------------------------------------------------------------
#
# Test xor instruction.
#

#include "./riscv_test.h"
#include "./test_macros.h"


RVTEST_CODE_BEGIN


#add.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  add, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  add, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RR_OP( 4,  add, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_RR_OP( 5,  add, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_RR_OP( 6,  add, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_RR_OP( 7,  add, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_RR_OP( 8,  add, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_RR_OP( 9,  add, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_RR_OP( 10, add, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_RR_OP( 11, add, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_RR_OP( 12, add, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_RR_OP( 13, add, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_RR_OP( 14, add, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_RR_OP( 15, add, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_RR_OP( 16, add, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 17, add, 24, 13, 11 );
  TEST_RR_SRC2_EQ_DEST( 18, add, 25, 14, 11 );
  TEST_RR_SRC12_EQ_DEST( 19, add, 26, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 20, 0, add, 24, 13, 11 );
  TEST_RR_DEST_BYPASS( 21, 1, add, 25, 14, 11 );
  TEST_RR_DEST_BYPASS( 22, 2, add, 26, 15, 11 );

  TEST_RR_SRC12_BYPASS( 23, 0, 0, add, 24, 13, 11 );
  TEST_RR_SRC12_BYPASS( 24, 0, 1, add, 25, 14, 11 );
  TEST_RR_SRC12_BYPASS( 25, 0, 2, add, 26, 15, 11 );
  TEST_RR_SRC12_BYPASS( 26, 1, 0, add, 24, 13, 11 );
  TEST_RR_SRC12_BYPASS( 27, 1, 1, add, 25, 14, 11 );
  TEST_RR_SRC12_BYPASS( 28, 2, 0, add, 26, 15, 11 );

  TEST_RR_SRC21_BYPASS( 29, 0, 0, add, 24, 13, 11 );
  TEST_RR_SRC21_BYPASS( 30, 0, 1, add, 25, 14, 11 );
  TEST_RR_SRC21_BYPASS( 31, 0, 2, add, 26, 15, 11 );
  TEST_RR_SRC21_BYPASS( 32, 1, 0, add, 24, 13, 11 );
  TEST_RR_SRC21_BYPASS( 33, 1, 1, add, 25, 14, 11 );
  TEST_RR_SRC21_BYPASS( 34, 2, 0, add, 26, 15, 11 );

  TEST_RR_ZEROSRC1( 35, add, 15, 15 );
  TEST_RR_ZEROSRC2( 36, add, 32, 32 );
  TEST_RR_ZEROSRC12( 37, add, 0 );
  TEST_RR_ZERODEST( 38, add, 16, 30 );

#addi.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 39,  addi, 0x00000000, 0x00000000, 0x000 );
  TEST_IMM_OP( 40,  addi, 0x00000002, 0x00000001, 0x001 );
  TEST_IMM_OP( 41,  addi, 0x0000000a, 0x00000003, 0x007 );

  TEST_IMM_OP( 42,  addi, 0xfffffffffffff800, 0x0000000000000000, 0x800 );
  TEST_IMM_OP( 43,  addi, 0xffffffff80000000, 0xffffffff80000000, 0x000 );
  TEST_IMM_OP( 44,  addi, 0xffffffff7ffff800, 0xffffffff80000000, 0x800 );

  TEST_IMM_OP( 45,  addi, 0x00000000000007ff, 0x00000000, 0x7ff );
  TEST_IMM_OP( 46,  addi, 0x000000007fffffff, 0x7fffffff, 0x000 );
  TEST_IMM_OP( 47, addi, 0x00000000800007fe, 0x7fffffff, 0x7ff );

  TEST_IMM_OP( 48, addi, 0xffffffff800007ff, 0xffffffff80000000, 0x7ff );
  TEST_IMM_OP( 49, addi, 0x000000007ffff7ff, 0x000000007fffffff, 0x800 );

  TEST_IMM_OP( 50, addi, 0xffffffffffffffff, 0x0000000000000000, 0xfff );
  TEST_IMM_OP( 51, addi, 0x0000000000000000, 0xffffffffffffffff, 0x001 );
  TEST_IMM_OP( 52, addi, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfff );

  TEST_IMM_OP( 53, addi, 0x0000000080000000, 0x7fffffff, 0x001 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 54, addi, 24, 13, 11 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 55, 0, addi, 24, 13, 11 );
  TEST_IMM_DEST_BYPASS( 56, 1, addi, 23, 13, 10 );
  TEST_IMM_DEST_BYPASS( 57, 2, addi, 22, 13,  9 );

  TEST_IMM_SRC1_BYPASS( 58, 0, addi, 24, 13, 11 );
  TEST_IMM_SRC1_BYPASS( 59, 1, addi, 23, 13, 10 );
  TEST_IMM_SRC1_BYPASS( 60, 2, addi, 22, 13,  9 );

  TEST_IMM_ZEROSRC1( 61, addi, 32, 32 );
  TEST_IMM_ZERODEST( 62, addi, 33, 50 );

#and.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RR_OP( 63, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_OP( 64, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_OP( 65, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_OP( 66, and, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 67, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC2_EQ_DEST( 68, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_EQ_DEST( 69, and, 0xff00ff00, 0xff00ff00 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 70,  0, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_DEST_BYPASS( 71, 1, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_DEST_BYPASS( 72, 2, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC12_BYPASS( 73, 0, 0, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 74, 0, 1, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 75, 0, 2, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 76, 1, 0, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 77, 1, 1, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 78, 2, 0, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC21_BYPASS( 79, 0, 0, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 80, 0, 1, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 81, 0, 2, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 82, 1, 0, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 83, 1, 1, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 84, 2, 0, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_ZEROSRC1( 85, and, 0, 0xff00ff00 );
  TEST_RR_ZEROSRC2( 86, and, 0, 0x00ff00ff );
  TEST_RR_ZEROSRC12( 87, and, 0 );
  TEST_RR_ZERODEST( 88, and, 0x11111111, 0x22222222 );

#andi.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 89, andi, 0xff00ff00, 0xff00ff00, 0xf0f );
  TEST_IMM_OP( 90, andi, 0x000000f0, 0x0ff00ff0, 0x0f0 );
  TEST_IMM_OP( 91, andi, 0x0000000f, 0x00ff00ff, 0x70f );
  TEST_IMM_OP( 92, andi, 0x00000000, 0xf00ff00f, 0x0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 93, andi, 0x00000000, 0xff00ff00, 0x0f0 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 94,  0, andi, 0x00000700, 0x0ff00ff0, 0x70f );
  TEST_IMM_DEST_BYPASS( 95,  1, andi, 0x000000f0, 0x00ff00ff, 0x0f0 );
  TEST_IMM_DEST_BYPASS( 96,  2, andi, 0xf00ff00f, 0xf00ff00f, 0xf0f );

  TEST_IMM_SRC1_BYPASS( 97, 0, andi, 0x00000700, 0x0ff00ff0, 0x70f );
  TEST_IMM_SRC1_BYPASS( 98, 1, andi, 0x000000f0, 0x00ff00ff, 0x0f0 );
  TEST_IMM_SRC1_BYPASS( 99, 2, andi, 0x0000000f, 0xf00ff00f, 0x70f );

  TEST_IMM_ZEROSRC1( 100, andi, 0, 0x0f0 );
  TEST_IMM_ZERODEST( 101, andi, 0x00ff00ff, 0x70f );

#auipc.S
  TEST_CASE(102, a0, 10000, \
    .align 3; \
    lla a0, 1f + 10000; \
    jal a1, 1f; \
    1: sub a0, a0, a1; \
  )

  TEST_CASE(103, a0, -10000, \
    .align 3; \
    lla a0, 1f - 10000; \
    jal a1, 1f; \
    1: sub a0, a0, a1; \
  )

#beq.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 104, beq,  0,  0 );
  TEST_BR2_OP_TAKEN( 105, beq,  1,  1 );
  TEST_BR2_OP_TAKEN( 106, beq, -1, -1 );

  TEST_BR2_OP_NOTTAKEN( 107, beq,  0,  1 );
  TEST_BR2_OP_NOTTAKEN( 108, beq,  1,  0 );
  TEST_BR2_OP_NOTTAKEN( 109, beq, -1,  1 );
  TEST_BR2_OP_NOTTAKEN( 110, beq,  1, -1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 111,  0, 0, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 112, 0, 1, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 113, 0, 2, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 114, 1, 0, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 115, 1, 1, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 116, 2, 0, beq, 0, -1 );

  TEST_BR2_SRC12_BYPASS( 117, 0, 0, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 118, 0, 1, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 119, 0, 2, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 120, 1, 0, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 121, 1, 1, beq, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 122, 2, 0, beq, 0, -1 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 123, x1, 3, \
    li  x1, 1; \
    beq x0, x0, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#bge.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 124, bge,  0,  0 );
  TEST_BR2_OP_TAKEN( 125, bge,  1,  1 );
  TEST_BR2_OP_TAKEN( 126, bge, -1, -1 );
  TEST_BR2_OP_TAKEN( 127, bge,  1,  0 );
  TEST_BR2_OP_TAKEN( 128, bge,  1, -1 );
  TEST_BR2_OP_TAKEN( 129, bge, -1, -2 );

  TEST_BR2_OP_NOTTAKEN(  130, bge,  0,  1 );
  TEST_BR2_OP_NOTTAKEN(  131, bge, -1,  1 );
  TEST_BR2_OP_NOTTAKEN( 132, bge, -2, -1 );
  TEST_BR2_OP_NOTTAKEN( 133, bge, -2,  1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 134, 0, 0, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 135, 0, 1, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 136, 0, 2, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 137, 1, 0, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 138, 1, 1, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 139, 2, 0, bge, -1, 0 );

  TEST_BR2_SRC12_BYPASS( 140, 0, 0, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 141, 0, 1, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 142, 0, 2, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 143, 1, 0, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 144, 1, 1, bge, -1, 0 );
  TEST_BR2_SRC12_BYPASS( 145, 2, 0, bge, -1, 0 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 146, x1, 3, \
    li  x1, 1; \
    bge x1, x0, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#bgeu.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 147, bgeu, 0x00000000, 0x00000000 );
  TEST_BR2_OP_TAKEN( 148, bgeu, 0x00000001, 0x00000001 );
  TEST_BR2_OP_TAKEN( 149, bgeu, 0xffffffff, 0xffffffff );
  TEST_BR2_OP_TAKEN( 150, bgeu, 0x00000001, 0x00000000 );
  TEST_BR2_OP_TAKEN( 151, bgeu, 0xffffffff, 0xfffffffe );
  TEST_BR2_OP_TAKEN( 152, bgeu, 0xffffffff, 0x00000000 );

  TEST_BR2_OP_NOTTAKEN(  153, bgeu, 0x00000000, 0x00000001 );
  TEST_BR2_OP_NOTTAKEN(  154, bgeu, 0xfffffffe, 0xffffffff );
  TEST_BR2_OP_NOTTAKEN( 155, bgeu, 0x00000000, 0xffffffff );
  TEST_BR2_OP_NOTTAKEN( 156, bgeu, 0x7fffffff, 0x80000000 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 157, 0, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 158, 0, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 159, 0, 2, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 160, 1, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 161, 1, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 162, 2, 0, bgeu, 0xefffffff, 0xf0000000 );

  TEST_BR2_SRC12_BYPASS( 163, 0, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 164, 0, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 165, 0, 2, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 166, 1, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 167, 1, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 168, 2, 0, bgeu, 0xefffffff, 0xf0000000 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 169, x1, 3, \
    li  x1, 1; \
    bgeu x1, x0, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#blt.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 170, blt,  0,  1 );
  TEST_BR2_OP_TAKEN( 171, blt, -1,  1 );
  TEST_BR2_OP_TAKEN( 172, blt, -2, -1 );

  TEST_BR2_OP_NOTTAKEN( 173, blt,  1,  0 );
  TEST_BR2_OP_NOTTAKEN( 174, blt,  1, -1 );
  TEST_BR2_OP_NOTTAKEN( 175, blt, -1, -2 );
  TEST_BR2_OP_NOTTAKEN( 176, blt,  1, -2 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 177,  0, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 178, 0, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 179, 0, 2, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 180, 1, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 181, 1, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 182, 2, 0, blt, 0, -1 );

  TEST_BR2_SRC12_BYPASS( 183, 0, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 184, 0, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 185, 0, 2, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 186, 1, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 187, 1, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 188, 2, 0, blt, 0, -1 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 189, x1, 3, \
    li  x1, 1; \
    blt x0, x1, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#bltu.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 190, bltu, 0x00000000, 0x00000001 );
  TEST_BR2_OP_TAKEN( 191, bltu, 0xfffffffe, 0xffffffff );
  TEST_BR2_OP_TAKEN( 192, bltu, 0x00000000, 0xffffffff );

  TEST_BR2_OP_NOTTAKEN( 193, bltu, 0x00000001, 0x00000000 );
  TEST_BR2_OP_NOTTAKEN( 194, bltu, 0xffffffff, 0xfffffffe );
  TEST_BR2_OP_NOTTAKEN( 195, bltu, 0xffffffff, 0x00000000 );
  TEST_BR2_OP_NOTTAKEN( 196, bltu, 0x80000000, 0x7fffffff );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 197,  0, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 198, 0, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 199, 0, 2, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 200, 1, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 201, 1, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 202, 2, 0, bltu, 0xf0000000, 0xefffffff );

  TEST_BR2_SRC12_BYPASS( 203, 0, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 204, 0, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 205, 0, 2, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 206, 1, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 207, 1, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 208, 2, 0, bltu, 0xf0000000, 0xefffffff );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 209, x1, 3, \
    li  x1, 1; \
    bltu x0, x1, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#bne.S
  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 210, bne,  0,  1 );
  TEST_BR2_OP_TAKEN( 211, bne,  1,  0 );
  TEST_BR2_OP_TAKEN( 212, bne, -1,  1 );
  TEST_BR2_OP_TAKEN( 213, bne,  1, -1 );

  TEST_BR2_OP_NOTTAKEN( 214, bne,  0,  0 );
  TEST_BR2_OP_NOTTAKEN( 215, bne,  1,  1 );
  TEST_BR2_OP_NOTTAKEN( 216, bne, -1, -1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 217,  0, 0, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 218, 0, 1, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 219, 0, 2, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 220, 1, 0, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 221, 1, 1, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 222, 2, 0, bne, 0, 0 );

  TEST_BR2_SRC12_BYPASS( 223, 0, 0, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 224, 0, 1, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 225, 0, 2, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 226, 1, 0, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 227, 1, 1, bne, 0, 0 );
  TEST_BR2_SRC12_BYPASS( 228, 2, 0, bne, 0, 0 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 229, x1, 3, \
    li  x1, 1; \
    bne x1, x0, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

#fence_i.S
#   li a3, 111
#   lh a0, insn
#   lh a1, insn+2
#   
#   # test I$ hit
#   .align 6
#   sh a0, 1f, t0
#   sh a1, 1f+2, t0
#   fence.i
#   
#   1: addi a3, a3, 222
#   TEST_CASE( 230, a3, 444, nop )
#   
#   # test prefetcher hit
#   li a4, 100
#   1: addi a4, a4, -1
#   bnez a4, 1b
#   
#   sh a0, 1f, t0
#   sh a1, 1f+2, t0
#   fence.i
#   
#   .align 6
#   1: addi a3, a3, 555
#   TEST_CASE( 231, a3, 777, nop )

#jal.S
  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

jal_test_2:
  li  TESTNUM, 2
  li  ra, 0

  jal x4, jal_target_2
jal_linkaddr_2:
  nop
  nop

  j fail

jal_target_2:
  la  x6, jal_linkaddr_2
  bne x6, x4, fail

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 232, ra, 3, \
    li  ra, 1; \
    jal x0, 1f; \
    addi ra, ra, 1; \
    addi ra, ra, 1; \
    addi ra, ra, 1; \
    addi ra, ra, 1; \
1:  addi ra, ra, 1; \
    addi ra, ra, 1; \
  )

#jalr.S
  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

jalr_test_2:
  li  TESTNUM, 2
  li  t0, 0
  la  t1, jalr_target_2

  jalr t0, t1, 0
jalr_linkaddr_2:
  j fail

jalr_target_2:
  la  t1, jalr_linkaddr_2
  bne t0, t1, fail

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_JALR_SRC1_BYPASS( 233, 0, jalr );
  TEST_JALR_SRC1_BYPASS( 234, 1, jalr );
  TEST_JALR_SRC1_BYPASS( 235, 2, jalr );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  .option push
  .align 2
  .option norvc
  TEST_CASE( 236, t0, 4, \
    li  t0, 1; \
    la  t1, 1f; \
    jr  t1, -4; \
    addi t0, t0, 1; \
    addi t0, t0, 1; \
    addi t0, t0, 1; \
    addi t0, t0, 1; \
1:  addi t0, t0, 1; \
    addi t0, t0, 1; \
  )
  .option pop



  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
.align 1  
#lb.S lbu.S
  tdat:
  tdat1:  .byte 0xff
  tdat2:  .byte 0x00
  tdat3:  .byte 0xf0
  tdat4:  .byte 0x0f
#sb.S
  sb_tdat:
  sb_tdat1:  .byte 0xef
  sb_tdat2:  .byte 0xef
  sb_tdat3:  .byte 0xef
  sb_tdat4:  .byte 0xef
  sb_tdat5:  .byte 0xef
  sb_tdat6:  .byte 0xef
  sb_tdat7:  .byte 0xef
  sb_tdat8:  .byte 0xef
  sb_tdat9:  .byte 0xef
  sb_tdat10: .byte 0xef
.align 2
#lh.S lhu.S
  lh_tdat:
  lh_tdat1:  .half 0x00ff
  lh_tdat2:  .half 0xff00
  lh_tdat3:  .half 0x0ff0
  lh_tdat4:  .half 0xf00f
#sh.S
  sh_tdat:
  sh_tdat1:  .half 0xbeef
  sh_tdat2:  .half 0xbeef
  sh_tdat3:  .half 0xbeef
  sh_tdat4:  .half 0xbeef
  sh_tdat5:  .half 0xbeef
  sh_tdat6:  .half 0xbeef
  sh_tdat7:  .half 0xbeef
  sh_tdat8:  .half 0xbeef
  sh_tdat9:  .half 0xbeef
  sh_tdat10: .half 0xbeef
.align 4
#lw.S
  lw_tdat:
  lw_tdat1:  .word 0x00ff00ff
  lw_tdat2:  .word 0xff00ff00
  lw_tdat3:  .word 0x0ff00ff0
  lw_tdat4:  .word 0xf00ff00f
#sw.S
  sw_tdat:
  sw_tdat1:  .word 0xdeadbeef
  sw_tdat2:  .word 0xdeadbeef
  sw_tdat3:  .word 0xdeadbeef
  sw_tdat4:  .word 0xdeadbeef
  sw_tdat5:  .word 0xdeadbeef
  sw_tdat6:  .word 0xdeadbeef
  sw_tdat7:  .word 0xdeadbeef
  sw_tdat8:  .word 0xdeadbeef
  sw_tdat9:  .word 0xdeadbeef
  sw_tdat10: .word 0xdeadbeef
.align 4  
#fence_i.S
insn:
  addi a3, a3, 333
  
RVTEST_DATA_END

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

#lb.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_LD_OP( 237, lb, 0xffffffffffffffff, 0,  tdat );
  TEST_LD_OP( 238, lb, 0x0000000000000000, 1,  tdat );
  TEST_LD_OP( 239, lb, 0xfffffffffffffff0, 2,  tdat );
  TEST_LD_OP( 240, lb, 0x000000000000000f, 3, tdat );

  # Test with negative offset

  TEST_LD_OP( 241, lb, 0xffffffffffffffff, -3, tdat4 );
  TEST_LD_OP( 242, lb, 0x0000000000000000, -2,  tdat4 );
  TEST_LD_OP( 243, lb, 0xfffffffffffffff0, -1,  tdat4 );
  TEST_LD_OP( 244, lb, 0x000000000000000f, 0,   tdat4 );

  # Test with a negative base

  TEST_CASE( 245, x5, 0xffffffffffffffff, \
    la  x1, tdat; \
    addi x1, x1, -32; \
    lb x5, 32(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 246, x5, 0x0000000000000000, \
    la  x1, tdat; \
    addi x1, x1, -6; \
    lb x5, 7(x1); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_LD_DEST_BYPASS( 247, 0, lb, 0xfffffffffffffff0, 1, tdat2 );
  TEST_LD_DEST_BYPASS( 248, 1, lb, 0x000000000000000f, 1, tdat3 );
  TEST_LD_DEST_BYPASS( 249, 2, lb, 0x0000000000000000, 1, tdat1 );

  TEST_LD_SRC1_BYPASS( 250, 0, lb, 0xfffffffffffffff0, 1, tdat2 );
  TEST_LD_SRC1_BYPASS( 251, 1, lb, 0x000000000000000f, 1, tdat3 );
  TEST_LD_SRC1_BYPASS( 252, 2, lb, 0x0000000000000000, 1, tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 253, x2, 2, \
    la  x5, tdat; \
    lb  x2, 0(x5); \
    li  x2, 2; \
  )

  TEST_CASE( 254, x2, 2, \
    la  x5, tdat; \
    lb  x2, 0(x5); \
    nop; \
    li  x2, 2; \
  )

#lbu.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_LD_OP( 255, lbu, 0x00000000000000ff, 0,  tdat );
  TEST_LD_OP( 256, lbu, 0x0000000000000000, 1,  tdat );
  TEST_LD_OP( 257, lbu, 0x00000000000000f0, 2,  tdat );
  TEST_LD_OP( 258, lbu, 0x000000000000000f, 3, tdat );

  # Test with negative offset

  TEST_LD_OP( 259, lbu, 0x00000000000000ff, -3, tdat4 );
  TEST_LD_OP( 260, lbu, 0x0000000000000000, -2,  tdat4 );
  TEST_LD_OP( 261, lbu, 0x00000000000000f0, -1,  tdat4 );
  TEST_LD_OP( 262, lbu, 0x000000000000000f, 0,   tdat4 );

  # Test with a negative base

  TEST_CASE( 263, x5, 0x00000000000000ff, \
    la  x1, tdat; \
    addi x1, x1, -32; \
    lbu x5, 32(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 264, x5, 0x0000000000000000, \
    la  x1, tdat; \
    addi x1, x1, -6; \
    lbu x5, 7(x1); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_LD_DEST_BYPASS( 265, 0, lbu, 0x00000000000000f0, 1, tdat2 );
  TEST_LD_DEST_BYPASS( 266, 1, lbu, 0x000000000000000f, 1, tdat3 );
  TEST_LD_DEST_BYPASS( 267, 2, lbu, 0x0000000000000000, 1, tdat1 );

  TEST_LD_SRC1_BYPASS( 268, 0, lbu, 0x00000000000000f0, 1, tdat2 );
  TEST_LD_SRC1_BYPASS( 269, 1, lbu, 0x000000000000000f, 1, tdat3 );
  TEST_LD_SRC1_BYPASS( 270, 2, lbu, 0x0000000000000000, 1, tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 271, x2, 2, \
    la  x5, tdat; \
    lbu  x2, 0(x5); \
    li  x2, 2; \
  )

  TEST_CASE( 272, x2, 2, \
    la  x5, tdat; \
    lbu  x2, 0(x5); \
    nop; \
    li  x2, 2; \
  )

#lh.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_LD_OP( 273, lh, 0x00000000000000ff, 0,  lh_tdat );
  TEST_LD_OP( 274, lh, 0xffffffffffffff00, 2,  lh_tdat );
  TEST_LD_OP( 275, lh, 0x0000000000000ff0, 4,  lh_tdat );
  TEST_LD_OP( 276, lh, 0xfffffffffffff00f, 6,  lh_tdat );

  # Test with negative offset

  TEST_LD_OP( 277, lh, 0x00000000000000ff, -6,  lh_tdat4 );
  TEST_LD_OP( 278, lh, 0xffffffffffffff00, -4,  lh_tdat4 );
  TEST_LD_OP( 279, lh, 0x0000000000000ff0, -2,  lh_tdat4 );
  TEST_LD_OP( 280, lh, 0xfffffffffffff00f,  0,  lh_tdat4 );

  # Test with a negative base

  TEST_CASE( 281, x5, 0x00000000000000ff, \
    la  x1, lh_tdat; \
    addi x1, x1, -32; \
    lh x5, 32(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 282, x5, 0xffffffffffffff00, \
    la  x1, lh_tdat; \
    addi x1, x1, -5; \
    lh x5, 7(x1); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_LD_DEST_BYPASS( 283, 0, lh, 0x0000000000000ff0, 2, lh_tdat2 );
  TEST_LD_DEST_BYPASS( 284, 1, lh, 0xfffffffffffff00f, 2, lh_tdat3 );
  TEST_LD_DEST_BYPASS( 285, 2, lh, 0xffffffffffffff00, 2, lh_tdat1 );

  TEST_LD_SRC1_BYPASS( 286, 0, lh, 0x0000000000000ff0, 2, lh_tdat2 );
  TEST_LD_SRC1_BYPASS( 287, 1, lh, 0xfffffffffffff00f, 2, lh_tdat3 );
  TEST_LD_SRC1_BYPASS( 288, 2, lh, 0xffffffffffffff00, 2, lh_tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 289, x2, 2, \
    la  x5, lh_tdat; \
    lh  x2, 0(x5); \
    li  x2, 2; \
  )

  TEST_CASE( 290, x2, 2, \
    la  x5, lh_tdat; \
    lh  x2, 0(x5); \
    nop; \
    li  x2, 2; \
  )

#lhu.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_LD_OP( 291, lhu, 0x00000000000000ff, 0,  lh_tdat );
  TEST_LD_OP( 292, lhu, 0x000000000000ff00, 2,  lh_tdat );
  TEST_LD_OP( 293, lhu, 0x0000000000000ff0, 4,  lh_tdat );
  TEST_LD_OP( 294, lhu, 0x000000000000f00f, 6,  lh_tdat );

  # Test with negative offset

  TEST_LD_OP( 295, lhu, 0x00000000000000ff, -6,  lh_tdat4 );
  TEST_LD_OP( 296, lhu, 0x000000000000ff00, -4,  lh_tdat4 );
  TEST_LD_OP( 297, lhu, 0x0000000000000ff0, -2,  lh_tdat4 );
  TEST_LD_OP( 298, lhu, 0x000000000000f00f,  0,  lh_tdat4 );

  # Test with a negative base

  TEST_CASE( 299, x5, 0x00000000000000ff, \
    la  x1, lh_tdat; \
    addi x1, x1, -32; \
    lhu x5, 32(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 300, x5, 0x000000000000ff00, \
    la  x1, lh_tdat; \
    addi x1, x1, -5; \
    lhu x5, 7(x1); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_LD_DEST_BYPASS( 301, 0, lhu, 0x0000000000000ff0, 2, lh_tdat2 );
  TEST_LD_DEST_BYPASS( 302, 1, lhu, 0x000000000000f00f, 2, lh_tdat3 );
  TEST_LD_DEST_BYPASS( 303, 2, lhu, 0x000000000000ff00, 2, lh_tdat1 );

  TEST_LD_SRC1_BYPASS( 304, 0, lhu, 0x0000000000000ff0, 2, lh_tdat2 );
  TEST_LD_SRC1_BYPASS( 305, 1, lhu, 0x000000000000f00f, 2, lh_tdat3 );
  TEST_LD_SRC1_BYPASS( 306, 2, lhu, 0x000000000000ff00, 2, lh_tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 307, x2, 2, \
    la  x5, lh_tdat; \
    lhu  x2, 0(x5); \
    li  x2, 2; \
  )

  TEST_CASE( 308, x2, 2, \
    la  x5, lh_tdat; \
    lhu  x2, 0(x5); \
    nop; \
    li  x2, 2; \
  )

#lui.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_CASE( 309, x1, 0x0000000000000000, lui x1, 0x00000 );
  TEST_CASE( 310, x1, 0xfffffffffffff800, lui x1, 0xfffff;sra x1,x1,1);
  TEST_CASE( 311, x1, 0x00000000000007ff, lui x1, 0x7ffff;sra x1,x1,20);
  TEST_CASE( 312, x1, 0xfffffffffffff800, lui x1, 0x80000;sra x1,x1,20);

  TEST_CASE( 313, x0, 0, lui x0, 0x80000 );

#lw.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_LD_OP( 314, lw, 0x0000000000ff00ff, 0,  lw_tdat );
  TEST_LD_OP( 315, lw, 0xffffffffff00ff00, 4,  lw_tdat );
  TEST_LD_OP( 316, lw, 0x000000000ff00ff0, 8,  lw_tdat );
  TEST_LD_OP( 317, lw, 0xfffffffff00ff00f, 12, lw_tdat );

  # Test with negative offset

  TEST_LD_OP( 318, lw, 0x0000000000ff00ff, -12, lw_tdat4 );
  TEST_LD_OP( 319, lw, 0xffffffffff00ff00, -8,  lw_tdat4 );
  TEST_LD_OP( 320, lw, 0x000000000ff00ff0, -4,  lw_tdat4 );
  TEST_LD_OP( 321, lw, 0xfffffffff00ff00f, 0,   lw_tdat4 );

  # Test with a negative base

  TEST_CASE( 322, x5, 0x0000000000ff00ff, \
    la  x1, lw_tdat; \
    addi x1, x1, -32; \
    lw x5, 32(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 323, x5, 0xffffffffff00ff00, \
    la  x1, lw_tdat; \
    addi x1, x1, -3; \
    lw x5, 7(x1); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_LD_DEST_BYPASS( 324, 0, lw, 0x000000000ff00ff0, 4, lw_tdat2 );
  TEST_LD_DEST_BYPASS( 325, 1, lw, 0xfffffffff00ff00f, 4, lw_tdat3 );
  TEST_LD_DEST_BYPASS( 326, 2, lw, 0xffffffffff00ff00, 4, lw_tdat1 );

  TEST_LD_SRC1_BYPASS( 327, 0, lw, 0x000000000ff00ff0, 4, lw_tdat2 );
  TEST_LD_SRC1_BYPASS( 328, 1, lw, 0xfffffffff00ff00f, 4, lw_tdat3 );
  TEST_LD_SRC1_BYPASS( 329, 2, lw, 0xffffffffff00ff00, 4, lw_tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 330, x2, 2, \
    la  x5, lw_tdat; \
    lw  x2, 0(x5); \
    li  x2, 2; \
  )

  TEST_CASE( 331, x2, 2, \
    la  x5, lw_tdat; \
    lw  x2, 0(x5); \
    nop; \
    li  x2, 2; \
  )

#or.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RR_OP( 332, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_OP( 333, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_OP( 334, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_OP( 335, or, 0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 336, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC2_EQ_DEST( 337, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_EQ_DEST( 338, or, 0xff00ff00, 0xff00ff00 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 339,  0, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_DEST_BYPASS( 340, 1, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_DEST_BYPASS( 341, 2, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC12_BYPASS( 342, 0, 0, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 343, 0, 1, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 344, 0, 2, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 345, 1, 0, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 346, 1, 1, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 347, 2, 0, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC21_BYPASS( 348, 0, 0, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 349, 0, 1, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 350, 0, 2, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 351, 1, 0, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 352, 1, 1, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 353, 2, 0, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_ZEROSRC1( 354, or, 0xff00ff00, 0xff00ff00 );
  TEST_RR_ZEROSRC2( 355, or, 0x00ff00ff, 0x00ff00ff );
  TEST_RR_ZEROSRC12( 356, or, 0 );
  TEST_RR_ZERODEST( 357, or, 0x11111111, 0x22222222 );

#ori.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 358, ori, 0xffffffffffffff0f, 0xffffffffff00ff00, 0xf0f );
  TEST_IMM_OP( 359, ori, 0x000000000ff00ff0, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_OP( 360, ori, 0x0000000000ff07ff, 0x0000000000ff00ff, 0x70f );
  TEST_IMM_OP( 361, ori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 362, ori, 0xff00fff0, 0xff00ff00, 0x0f0 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 363,  0, ori, 0x000000000ff00ff0, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_DEST_BYPASS( 364,  1, ori, 0x0000000000ff07ff, 0x0000000000ff00ff, 0x70f );
  TEST_IMM_DEST_BYPASS( 365,  2, ori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  TEST_IMM_SRC1_BYPASS( 366, 0, ori, 0x000000000ff00ff0, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_SRC1_BYPASS( 367, 1, ori, 0xffffffffffffffff, 0x0000000000ff00ff, 0xf0f );
  TEST_IMM_SRC1_BYPASS( 368, 2, ori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  TEST_IMM_ZEROSRC1( 369, ori, 0x0f0, 0x0f0 );
  TEST_IMM_ZERODEST( 370, ori, 0x00ff00ff, 0x70f );

#sb.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_ST_OP( 371, lb, sb, 0xffffffffffffffaa, 0, sb_tdat );
  TEST_ST_OP( 372, lb, sb, 0x0000000000000000, 1, sb_tdat );
  TEST_ST_OP( 373, lh, sb, 0xffffffffffffefa0, 2, sb_tdat );
  TEST_ST_OP( 374, lb, sb, 0x000000000000000a, 3, sb_tdat );

  # Test with negative offset

  TEST_ST_OP( 375, lb, sb, 0xffffffffffffffaa, -3, sb_tdat8 );
  TEST_ST_OP( 376, lb, sb, 0x0000000000000000, -2, sb_tdat8 );
  TEST_ST_OP( 377, lb, sb, 0xffffffffffffffa0, -1, sb_tdat8 );
  TEST_ST_OP( 378, lb, sb, 0x000000000000000a, 0,  sb_tdat8 );

  # Test with a negative base

  TEST_CASE( 379, x5, 0x78, \
    la  x1, sb_tdat9; \
    li  x2, 0x12345678; \
    addi x4, x1, -32; \
    sb x2, 32(x4); \
    lb x5, 0(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 380, x5, 0xffffffffffffff98, \
    la  x1, sb_tdat9; \
    li  x2, 0x00003098; \
    addi x1, x1, -6; \
    sb x2, 7(x1); \
    la  x4, sb_tdat10; \
    lb x5, 0(x4); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_ST_SRC12_BYPASS( 381, 0, 0, lb, sb, 0xffffffffffffffdd, 0, sb_tdat );
  TEST_ST_SRC12_BYPASS( 382, 0, 1, lb, sb, 0xffffffffffffffcd, 1, sb_tdat );
  TEST_ST_SRC12_BYPASS( 383, 0, 2, lb, sb, 0xffffffffffffffcc, 2, sb_tdat );
  TEST_ST_SRC12_BYPASS( 384, 1, 0, lb, sb, 0xffffffffffffffbc, 3, sb_tdat );
  TEST_ST_SRC12_BYPASS( 385, 1, 1, lb, sb, 0xffffffffffffffbb, 4, sb_tdat );
  TEST_ST_SRC12_BYPASS( 386, 2, 0, lb, sb, 0xffffffffffffffab, 5, sb_tdat );

  TEST_ST_SRC21_BYPASS( 387, 0, 0, lb, sb, 0x33, 0, sb_tdat );
  TEST_ST_SRC21_BYPASS( 388, 0, 1, lb, sb, 0x23, 1, sb_tdat );
  TEST_ST_SRC21_BYPASS( 389, 0, 2, lb, sb, 0x22, 2, sb_tdat );
  TEST_ST_SRC21_BYPASS( 390, 1, 0, lb, sb, 0x12, 3, sb_tdat );
  TEST_ST_SRC21_BYPASS( 391, 1, 1, lb, sb, 0x11, 4, sb_tdat );
  TEST_ST_SRC21_BYPASS( 392, 2, 0, lb, sb, 0x01, 5, sb_tdat );

  li a0, 0xef
  la a1, sb_tdat
  sb a0, 3(a1)

#sh.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_ST_OP( 393, lh, sh, 0x00000000000000aa, 0, sh_tdat );
  TEST_ST_OP( 394, lh, sh, 0xffffffffffffaa00, 2, sh_tdat );
  TEST_ST_OP( 395, lw, sh, 0xffffffffbeef0aa0, 4, sh_tdat );
  TEST_ST_OP( 396, lh, sh, 0xffffffffffffa00a, 6, sh_tdat );

  # Test with negative offset

  TEST_ST_OP( 397, lh, sh, 0x00000000000000aa, -6, sh_tdat8 );
  TEST_ST_OP( 398, lh, sh, 0xffffffffffffaa00, -4, sh_tdat8 );
  TEST_ST_OP( 399, lh, sh, 0x0000000000000aa0, -2, sh_tdat8 );
  TEST_ST_OP( 400, lh, sh, 0xffffffffffffa00a, 0,  sh_tdat8 );

  # Test with a negative base

  TEST_CASE( 401, x5, 0x5678, \
    la  x1, sh_tdat9; \
    li  x2, 0x12345678; \
    addi x4, x1, -32; \
    sh x2, 32(x4); \
    lh x5, 0(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 402, x5, 0x3098, \
    la  x1, sh_tdat9; \
    li  x2, 0x00003098; \
    addi x1, x1, -5; \
    sh x2, 7(x1); \
    la  x4, sh_tdat10; \
    lh x5, 0(x4); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_ST_SRC12_BYPASS( 403, 0, 0, lh, sh, 0xffffffffffffccdd, 0,  sh_tdat );
  TEST_ST_SRC12_BYPASS( 404, 0, 1, lh, sh, 0xffffffffffffbccd, 2,  sh_tdat );
  TEST_ST_SRC12_BYPASS( 405, 0, 2, lh, sh, 0xffffffffffffbbcc, 4,  sh_tdat );
  TEST_ST_SRC12_BYPASS( 406, 1, 0, lh, sh, 0xffffffffffffabbc, 6,  sh_tdat );
  TEST_ST_SRC12_BYPASS( 407, 1, 1, lh, sh, 0xffffffffffffaabb, 8,  sh_tdat );
  TEST_ST_SRC12_BYPASS( 408, 2, 0, lh, sh, 0xffffffffffffdaab, 10, sh_tdat );

  TEST_ST_SRC21_BYPASS( 409, 0, 0, lh, sh, 0x2233, 0,  sh_tdat );
  TEST_ST_SRC21_BYPASS( 410, 0, 1, lh, sh, 0x1223, 2,  sh_tdat );
  TEST_ST_SRC21_BYPASS( 411, 0, 2, lh, sh, 0x1122, 4,  sh_tdat );
  TEST_ST_SRC21_BYPASS( 412, 1, 0, lh, sh, 0x0112, 6,  sh_tdat );
  TEST_ST_SRC21_BYPASS( 413, 1, 1, lh, sh, 0x0011, 8,  sh_tdat );
  TEST_ST_SRC21_BYPASS( 414, 2, 0, lh, sh, 0x3001, 10, sh_tdat );

  li a0, 0xbeef
  la a1, sh_tdat
  sh a0, 6(a1)

#sll.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 415,  sll, 0x0000000000000001, 0x0000000000000001, 0  );
  TEST_RR_OP( 416,  sll, 0x0000000000000002, 0x0000000000000001, 1  );
  TEST_RR_OP( 417,  sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_OP( 418,  sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_OP( 419,  sll, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_RR_OP( 420,  sll, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_RR_OP( 421,  sll, 0xfffffffffffffffe, 0xffffffffffffffff, 1  );
  TEST_RR_OP( 422,  sll, 0xffffffffffffff80, 0xffffffffffffffff, 7  );
  TEST_RR_OP( 423, sll, 0xffffffffffffc000, 0xffffffffffffffff, 14 );
  TEST_RR_OP( 424, sll, 0xffffffff80000000, 0xffffffffffffffff, 31 );

  TEST_RR_OP( 425, sll, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_RR_OP( 426, sll, 0x0000000042424242, 0x0000000021212121, 1  );
  TEST_RR_OP( 427, sll, 0x0000001090909080, 0x0000000021212121, 7  );
  TEST_RR_OP( 428, sll, 0x0000084848484000, 0x0000000021212121, 14 );
  TEST_RR_OP( 429, sll, 0x1090909080000000, 0x0000000021212121, 31 );

  # Verify that shifts only use bottom six bits

  TEST_RR_OP( 430, sll, 0x0000000021212121, 0x0000000021212121, 0xffffffffffffffc0 );
  TEST_RR_OP( 431, sll, 0x0000000042424242, 0x0000000021212121, 0xffffffffffffffc1 );
  TEST_RR_OP( 432, sll, 0x0000001090909080, 0x0000000021212121, 0xffffffffffffffc7 );
  TEST_RR_OP( 433, sll, 0x0000084848484000, 0x0000000021212121, 0xffffffffffffffce );

#if __riscv_xlen == 64
  TEST_RR_OP( 434, sll, 0x8000000000000000, 0x0000000021212121, 0xffffffffffffffff );
  TEST_RR_OP( 435, sll, 0x8000000000000000, 0x0000000000000001, 63 );
  TEST_RR_OP( 436, sll, 0xffffff8000000000, 0xffffffffffffffff, 39 );
  TEST_RR_OP( 437, sll, 0x0909080000000000, 0x0000000021212121, 43 );
#endif

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 438, sll, 0x00000080, 0x00000001, 7  );
  TEST_RR_SRC2_EQ_DEST( 439, sll, 0x00004000, 0x00000001, 14 );
  TEST_RR_SRC12_EQ_DEST( 440, sll, 24, 3 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 441, 0, sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_DEST_BYPASS( 442, 1, sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_DEST_BYPASS( 443, 2, sll, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_RR_SRC12_BYPASS( 444, 0, 0, sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_SRC12_BYPASS( 445, 0, 1, sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_SRC12_BYPASS( 446, 0, 2, sll, 0x0000000080000000, 0x0000000000000001, 31 );
  TEST_RR_SRC12_BYPASS( 447, 1, 0, sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_SRC12_BYPASS( 448, 1, 1, sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_SRC12_BYPASS( 449, 2, 0, sll, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_RR_SRC21_BYPASS( 450, 0, 0, sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_SRC21_BYPASS( 451, 0, 1, sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_SRC21_BYPASS( 452, 0, 2, sll, 0x0000000080000000, 0x0000000000000001, 31 );
  TEST_RR_SRC21_BYPASS( 453, 1, 0, sll, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_RR_SRC21_BYPASS( 454, 1, 1, sll, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_RR_SRC21_BYPASS( 455, 2, 0, sll, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_RR_ZEROSRC1( 456, sll, 0, 15 );
  TEST_RR_ZEROSRC2( 457, sll, 32, 32 );
  TEST_RR_ZEROSRC12( 458, sll, 0 );
  TEST_RR_ZERODEST( 459, sll, 1024, 2048 );

#slli.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 460,  slli, 0x0000000000000001, 0x0000000000000001, 0  );
  TEST_IMM_OP( 461,  slli, 0x0000000000000002, 0x0000000000000001, 1  );
  TEST_IMM_OP( 462,  slli, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_IMM_OP( 463,  slli, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_IMM_OP( 464,  slli, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_IMM_OP( 465,  slli, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_IMM_OP( 466,  slli, 0xfffffffffffffffe, 0xffffffffffffffff, 1  );
  TEST_IMM_OP( 467,  slli, 0xffffffffffffff80, 0xffffffffffffffff, 7  );
  TEST_IMM_OP( 468, slli, 0xffffffffffffc000, 0xffffffffffffffff, 14 );
  TEST_IMM_OP( 469, slli, 0xffffffff80000000, 0xffffffffffffffff, 31 );

  TEST_IMM_OP( 470, slli, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_IMM_OP( 471, slli, 0x0000000042424242, 0x0000000021212121, 1  );
  TEST_IMM_OP( 472, slli, 0x0000001090909080, 0x0000000021212121, 7  );
  TEST_IMM_OP( 473, slli, 0x0000084848484000, 0x0000000021212121, 14 );
  TEST_IMM_OP( 474, slli, 0x1090909080000000, 0x0000000021212121, 31 );

#if __riscv_xlen == 64
  TEST_IMM_OP( 475, slli, 0x8000000000000000, 0x0000000000000001, 63 );
  TEST_IMM_OP( 476, slli, 0xffffff8000000000, 0xffffffffffffffff, 39 );
  TEST_IMM_OP( 477, slli, 0x0909080000000000, 0x0000000021212121, 43 );
#endif

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 478, slli, 0x00000080, 0x00000001, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 479, 0, slli, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_IMM_DEST_BYPASS( 480, 1, slli, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_IMM_DEST_BYPASS( 481, 2, slli, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_IMM_SRC1_BYPASS( 482, 0, slli, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_IMM_SRC1_BYPASS( 483, 1, slli, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_IMM_SRC1_BYPASS( 484, 2, slli, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_IMM_ZEROSRC1( 485, slli, 0, 31 );
  TEST_IMM_ZERODEST( 486, slli, 33, 20 );

#slt.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 487,  slt, 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_RR_OP( 488,  slt, 0, 0x0000000000000001, 0x0000000000000001 );
  TEST_RR_OP( 489,  slt, 1, 0x0000000000000003, 0x0000000000000007 );
  TEST_RR_OP( 490,  slt, 0, 0x0000000000000007, 0x0000000000000003 );

  TEST_RR_OP( 491,  slt, 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_RR_OP( 492,  slt, 1, 0xffffffff80000000, 0x0000000000000000 );
  TEST_RR_OP( 493,  slt, 1, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_RR_OP( 494,  slt, 1, 0x0000000000000000, 0x0000000000007fff );
  TEST_RR_OP( 495, slt, 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_RR_OP( 496, slt, 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_RR_OP( 497, slt, 1, 0xffffffff80000000, 0x0000000000007fff );
  TEST_RR_OP( 498, slt, 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_RR_OP( 499, slt, 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_RR_OP( 500, slt, 1, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_RR_OP( 501, slt, 0, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 502, slt, 0, 14, 13 );
  TEST_RR_SRC2_EQ_DEST( 503, slt, 1, 11, 13 );
  TEST_RR_SRC12_EQ_DEST( 504, slt, 0, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 505, 0, slt, 1, 11, 13 );
  TEST_RR_DEST_BYPASS( 506, 1, slt, 0, 14, 13 );
  TEST_RR_DEST_BYPASS( 507, 2, slt, 1, 12, 13 );

  TEST_RR_SRC12_BYPASS( 508, 0, 0, slt, 0, 14, 13 );
  TEST_RR_SRC12_BYPASS( 509, 0, 1, slt, 1, 11, 13 );
  TEST_RR_SRC12_BYPASS( 510, 0, 2, slt, 0, 15, 13 );
  TEST_RR_SRC12_BYPASS( 511, 1, 0, slt, 1, 10, 13 );
  TEST_RR_SRC12_BYPASS( 512, 1, 1, slt, 0, 16, 13 );
  TEST_RR_SRC12_BYPASS( 513, 2, 0, slt, 1,  9, 13 );

  TEST_RR_SRC21_BYPASS( 514, 0, 0, slt, 0, 17, 13 );
  TEST_RR_SRC21_BYPASS( 515, 0, 1, slt, 1,  8, 13 );
  TEST_RR_SRC21_BYPASS( 516, 0, 2, slt, 0, 18, 13 );
  TEST_RR_SRC21_BYPASS( 517, 1, 0, slt, 1,  7, 13 );
  TEST_RR_SRC21_BYPASS( 518, 1, 1, slt, 0, 19, 13 );
  TEST_RR_SRC21_BYPASS( 519, 2, 0, slt, 1,  6, 13 );

  TEST_RR_ZEROSRC1( 520, slt, 0, -1 );
  TEST_RR_ZEROSRC2( 521, slt, 1, -1 );
  TEST_RR_ZEROSRC12( 522, slt, 0 );
  TEST_RR_ZERODEST( 523, slt, 16, 30 );

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

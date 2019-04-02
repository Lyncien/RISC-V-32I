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


#slti.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 524,  slti, 0, 0x0000000000000000, 0x000 );
  TEST_IMM_OP( 525,  slti, 0, 0x0000000000000001, 0x001 );
  TEST_IMM_OP( 526,  slti, 1, 0x0000000000000003, 0x007 );
  TEST_IMM_OP( 527,  slti, 0, 0x0000000000000007, 0x003 );

  TEST_IMM_OP( 528,  slti, 0, 0x0000000000000000, 0x800 );
  TEST_IMM_OP( 529,  slti, 1, 0xffffffff80000000, 0x000 );
  TEST_IMM_OP( 530,  slti, 1, 0xffffffff80000000, 0x800 );

  TEST_IMM_OP( 531,  slti, 1, 0x0000000000000000, 0x7ff );
  TEST_IMM_OP( 532, slti, 0, 0x000000007fffffff, 0x000 );
  TEST_IMM_OP( 533, slti, 0, 0x000000007fffffff, 0x7ff );

  TEST_IMM_OP( 534, slti, 1, 0xffffffff80000000, 0x7ff );
  TEST_IMM_OP( 535, slti, 0, 0x000000007fffffff, 0x800 );

  TEST_IMM_OP( 536, slti, 0, 0x0000000000000000, 0xfff );
  TEST_IMM_OP( 537, slti, 1, 0xffffffffffffffff, 0x001 );
  TEST_IMM_OP( 538, slti, 0, 0xffffffffffffffff, 0xfff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 539, slti, 1, 11, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 540, 0, slti, 0, 15, 10 );
  TEST_IMM_DEST_BYPASS( 541, 1, slti, 1, 10, 16 );
  TEST_IMM_DEST_BYPASS( 542, 2, slti, 0, 16,  9 );

  TEST_IMM_SRC1_BYPASS( 543, 0, slti, 1, 11, 15 );
  TEST_IMM_SRC1_BYPASS( 544, 1, slti, 0, 17,  8 );
  TEST_IMM_SRC1_BYPASS( 545, 2, slti, 1, 12, 14 );

  TEST_IMM_ZEROSRC1( 546, slti, 0, 0xfff );
  TEST_IMM_ZERODEST( 547, slti, 0x00ff00ff, 0xfff );

#sltiu.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 548,  sltiu, 0, 0x0000000000000000, 0x000 );
  TEST_IMM_OP( 549,  sltiu, 0, 0x0000000000000001, 0x001 );
  TEST_IMM_OP( 550,  sltiu, 1, 0x0000000000000003, 0x007 );
  TEST_IMM_OP( 551,  sltiu, 0, 0x0000000000000007, 0x003 );

  TEST_IMM_OP( 552,  sltiu, 1, 0x0000000000000000, 0x800 );
  TEST_IMM_OP( 553,  sltiu, 0, 0xffffffff80000000, 0x000 );
  TEST_IMM_OP( 554,  sltiu, 1, 0xffffffff80000000, 0x800 );

  TEST_IMM_OP( 555,  sltiu, 1, 0x0000000000000000, 0x7ff );
  TEST_IMM_OP( 556, sltiu, 0, 0x000000007fffffff, 0x000 );
  TEST_IMM_OP( 557, sltiu, 0, 0x000000007fffffff, 0x7ff );

  TEST_IMM_OP( 558, sltiu, 0, 0xffffffff80000000, 0x7ff );
  TEST_IMM_OP( 559, sltiu, 1, 0x000000007fffffff, 0x800 );

  TEST_IMM_OP( 560, sltiu, 1, 0x0000000000000000, 0xfff );
  TEST_IMM_OP( 561, sltiu, 0, 0xffffffffffffffff, 0x001 );
  TEST_IMM_OP( 562, sltiu, 0, 0xffffffffffffffff, 0xfff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 563, sltiu, 1, 11, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 564, 0, sltiu, 0, 15, 10 );
  TEST_IMM_DEST_BYPASS( 565, 1, sltiu, 1, 10, 16 );
  TEST_IMM_DEST_BYPASS( 567, 2, sltiu, 0, 16,  9 );

  TEST_IMM_SRC1_BYPASS( 568, 0, sltiu, 1, 11, 15 );
  TEST_IMM_SRC1_BYPASS( 569, 1, sltiu, 0, 17,  8 );
  TEST_IMM_SRC1_BYPASS( 570, 2, sltiu, 1, 12, 14 );

  TEST_IMM_ZEROSRC1( 571, sltiu, 1, 0xfff );
  TEST_IMM_ZERODEST( 572, sltiu, 0x00ff00ff, 0xfff );

#sltu.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 573,  sltu, 0, 0x00000000, 0x00000000 );
  TEST_RR_OP( 574,  sltu, 0, 0x00000001, 0x00000001 );
  TEST_RR_OP( 575,  sltu, 1, 0x00000003, 0x00000007 );
  TEST_RR_OP( 576,  sltu, 0, 0x00000007, 0x00000003 );

  TEST_RR_OP( 577,  sltu, 1, 0x00000000, 0xffff8000 );
  TEST_RR_OP( 578,  sltu, 0, 0x80000000, 0x00000000 );
  TEST_RR_OP( 579,  sltu, 1, 0x80000000, 0xffff8000 );

  TEST_RR_OP( 580,  sltu, 1, 0x00000000, 0x00007fff );
  TEST_RR_OP( 581, sltu, 0, 0x7fffffff, 0x00000000 );
  TEST_RR_OP( 582, sltu, 0, 0x7fffffff, 0x00007fff );

  TEST_RR_OP( 583, sltu, 0, 0x80000000, 0x00007fff );
  TEST_RR_OP( 584, sltu, 1, 0x7fffffff, 0xffff8000 );

  TEST_RR_OP( 585, sltu, 1, 0x00000000, 0xffffffff );
  TEST_RR_OP( 586, sltu, 0, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 587, sltu, 0, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 588, sltu, 0, 14, 13 );
  TEST_RR_SRC2_EQ_DEST( 589, sltu, 1, 11, 13 );
  TEST_RR_SRC12_EQ_DEST( 590, sltu, 0, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 591, 0, sltu, 1, 11, 13 );
  TEST_RR_DEST_BYPASS( 592, 1, sltu, 0, 14, 13 );
  TEST_RR_DEST_BYPASS( 593, 2, sltu, 1, 12, 13 );

  TEST_RR_SRC12_BYPASS( 594, 0, 0, sltu, 0, 14, 13 );
  TEST_RR_SRC12_BYPASS( 595, 0, 1, sltu, 1, 11, 13 );
  TEST_RR_SRC12_BYPASS( 596, 0, 2, sltu, 0, 15, 13 );
  TEST_RR_SRC12_BYPASS( 597, 1, 0, sltu, 1, 10, 13 );
  TEST_RR_SRC12_BYPASS( 598, 1, 1, sltu, 0, 16, 13 );
  TEST_RR_SRC12_BYPASS( 599, 2, 0, sltu, 1,  9, 13 );

  TEST_RR_SRC21_BYPASS( 601, 0, 0, sltu, 0, 17, 13 );
  TEST_RR_SRC21_BYPASS( 602, 0, 1, sltu, 1,  8, 13 );
  TEST_RR_SRC21_BYPASS( 603, 0, 2, sltu, 0, 18, 13 );
  TEST_RR_SRC21_BYPASS( 604, 1, 0, sltu, 1,  7, 13 );
  TEST_RR_SRC21_BYPASS( 605, 1, 1, sltu, 0, 19, 13 );
  TEST_RR_SRC21_BYPASS( 606, 2, 0, sltu, 1,  6, 13 );

  TEST_RR_ZEROSRC1( 607, sltu, 1, -1 );
  TEST_RR_ZEROSRC2( 608, sltu, 0, -1 );
  TEST_RR_ZEROSRC12( 609, sltu, 0 );
  TEST_RR_ZERODEST( 610, sltu, 16, 30 );

#sra.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 611,  sra, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_RR_OP( 612,  sra, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_RR_OP( 613,  sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_OP( 614,  sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_OP( 615,  sra, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  TEST_RR_OP( 616,  sra, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_RR_OP( 617,  sra, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_RR_OP( 618,  sra, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_RR_OP( 619, sra, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_RR_OP( 620, sra, 0x0000000000000000, 0x000000007fffffff, 31 );

  TEST_RR_OP( 621, sra, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_RR_OP( 622, sra, 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  );
  TEST_RR_OP( 623, sra, 0xffffffffff030303, 0xffffffff81818181, 7  );
  TEST_RR_OP( 624, sra, 0xfffffffffffe0606, 0xffffffff81818181, 14 );
  TEST_RR_OP( 625, sra, 0xffffffffffffffff, 0xffffffff81818181, 31 );

  # Verify that shifts only use bottom five bits

  TEST_RR_OP( 626, sra, 0xffffffff81818181, 0xffffffff81818181, 0xffffffffffffffc0 );
  TEST_RR_OP( 627, sra, 0xffffffffc0c0c0c0, 0xffffffff81818181, 0xffffffffffffffc1 );
  TEST_RR_OP( 628, sra, 0xffffffffff030303, 0xffffffff81818181, 0xffffffffffffffc7 );
  TEST_RR_OP( 629, sra, 0xfffffffffffe0606, 0xffffffff81818181, 0xffffffffffffffce );
  TEST_RR_OP( 630, sra, 0xffffffffffffffff, 0xffffffff81818181, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 631, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_SRC2_EQ_DEST( 632, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_SRC12_EQ_DEST( 633, sra, 0, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 634, 0, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_DEST_BYPASS( 635, 1, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_DEST_BYPASS( 636, 2, sra, 0xffffffffffffffff, 0xffffffff80000000, 31 );

  TEST_RR_SRC12_BYPASS( 637, 0, 0, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_SRC12_BYPASS( 638, 0, 1, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_SRC12_BYPASS( 639, 0, 2, sra, 0xffffffffffffffff, 0xffffffff80000000, 31 );
  TEST_RR_SRC12_BYPASS( 640, 1, 0, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_SRC12_BYPASS( 641, 1, 1, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_SRC12_BYPASS( 642, 2, 0, sra, 0xffffffffffffffff, 0xffffffff80000000, 31 );

  TEST_RR_SRC21_BYPASS( 643, 0, 0, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_SRC21_BYPASS( 644, 0, 1, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_SRC21_BYPASS( 645, 0, 2, sra, 0xffffffffffffffff, 0xffffffff80000000, 31 );
  TEST_RR_SRC21_BYPASS( 646, 1, 0, sra, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_RR_SRC21_BYPASS( 647, 1, 1, sra, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_RR_SRC21_BYPASS( 648, 2, 0, sra, 0xffffffffffffffff, 0xffffffff80000000, 31 );

  TEST_RR_ZEROSRC1( 649, sra, 0, 15 );
  TEST_RR_ZEROSRC2( 650, sra, 32, 32 );
  TEST_RR_ZEROSRC12( 651, sra, 0 );
  TEST_RR_ZERODEST( 652, sra, 1024, 2048 );

#srai
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 653,  srai, 0xffffff8000000000, 0xffffff8000000000, 0  );
  TEST_IMM_OP( 654,  srai, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_IMM_OP( 655,  srai, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_IMM_OP( 656,  srai, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_IMM_OP( 657,  srai, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  #TEST_IMM_OP( 657,  srai, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_IMM_OP( 658,  srai, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_IMM_OP( 659,  srai, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_IMM_OP( 660, srai, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_IMM_OP( 661, srai, 0x0000000000000000, 0x000000007fffffff, 31 );

  TEST_IMM_OP( 662, srai, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_IMM_OP( 663, srai, 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  );
  TEST_IMM_OP( 664, srai, 0xffffffffff030303, 0xffffffff81818181, 7  );
  TEST_IMM_OP( 665, srai, 0xfffffffffffe0606, 0xffffffff81818181, 14 );
  TEST_IMM_OP( 666, srai, 0xffffffffffffffff, 0xffffffff81818181, 31 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 667, srai, 0xffffffffff000000, 0xffffffff80000000, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 668, 0, srai, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_IMM_DEST_BYPASS( 669, 1, srai, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_IMM_DEST_BYPASS( 670, 2, srai, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  TEST_IMM_SRC1_BYPASS( 671, 0, srai, 0xffffffffff000000, 0xffffffff80000000, 7 );
  TEST_IMM_SRC1_BYPASS( 672, 1, srai, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_IMM_SRC1_BYPASS( 673, 2, srai, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  TEST_IMM_ZEROSRC1( 674, srai, 0, 4 );
  TEST_IMM_ZERODEST( 675, srai, 33, 10 );

#srl.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

#define TEST_SRL(n, v, a) \
  TEST_RR_OP(n, srl, ((v) & ((1 << (__riscv_xlen-1) << 1) - 1)) >> (a), v, a)

  TEST_SRL( 676,  0xffffffff80000000, 0  );
  TEST_SRL( 677,  0xffffffff80000000, 1  );
  TEST_SRL( 678,  0xffffffff80000000, 7  );
  TEST_SRL( 679,  0xffffffff80000000, 14 );
  TEST_SRL( 680,  0xffffffff80000001, 31 );

  TEST_SRL( 681,  0xffffffffffffffff, 0  );
  TEST_SRL( 682,  0xffffffffffffffff, 1  );
  TEST_SRL( 683,  0xffffffffffffffff, 7  );
  TEST_SRL( 684, 0xffffffffffffffff, 14 );
  TEST_SRL( 685, 0xffffffffffffffff, 31 );

  TEST_SRL( 686, 0x0000000021212121, 0  );
  TEST_SRL( 687, 0x0000000021212121, 1  );
  TEST_SRL( 688, 0x0000000021212121, 7  );
  TEST_SRL( 689, 0x0000000021212121, 14 );
  TEST_SRL( 690, 0x0000000021212121, 31 );

  # Verify that shifts only use bottom five bits

  TEST_RR_OP( 691, srl, 0x0000000021212121, 0x0000000021212121, 0xffffffffffffffc0 );
  TEST_RR_OP( 692, srl, 0x0000000010909090, 0x0000000021212121, 0xffffffffffffffc1 );
  TEST_RR_OP( 693, srl, 0x0000000000424242, 0x0000000021212121, 0xffffffffffffffc7 );
  TEST_RR_OP( 694, srl, 0x0000000000008484, 0x0000000021212121, 0xffffffffffffffce );
  TEST_RR_OP( 695, srl, 0x0000000000000000, 0x0000000021212121, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 696, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_SRC2_EQ_DEST( 697, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_SRC12_EQ_DEST( 698, srl, 0, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 699, 0, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_DEST_BYPASS( 700, 1, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_DEST_BYPASS( 701, 2, srl, 0x00000001, 0x80000000, 31 );

  TEST_RR_SRC12_BYPASS( 702, 0, 0, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_SRC12_BYPASS( 703, 0, 1, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_SRC12_BYPASS( 704, 0, 2, srl, 0x00000001, 0x80000000, 31 );
  TEST_RR_SRC12_BYPASS( 705, 1, 0, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_SRC12_BYPASS( 706, 1, 1, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_SRC12_BYPASS( 707, 2, 0, srl, 0x00000001, 0x80000000, 31 );

  TEST_RR_SRC21_BYPASS( 708, 0, 0, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_SRC21_BYPASS( 709, 0, 1, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_SRC21_BYPASS( 710, 0, 2, srl, 0x00000001, 0x80000000, 31 );
  TEST_RR_SRC21_BYPASS( 711, 1, 0, srl, 0x01000000, 0x80000000, 7  );
  TEST_RR_SRC21_BYPASS( 712, 1, 1, srl, 0x00020000, 0x80000000, 14 );
  TEST_RR_SRC21_BYPASS( 713, 2, 0, srl, 0x00000001, 0x80000000, 31 );

  TEST_RR_ZEROSRC1( 714, srl, 0, 15 );
  TEST_RR_ZEROSRC2( 715, srl, 32, 32 );
  TEST_RR_ZEROSRC12( 716, srl, 0 );
  TEST_RR_ZERODEST( 717, srl, 1024, 2048 );

#srli.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_SRL( 718,  0xffffffff80000000, 0  );
  TEST_SRL( 719,  0xffffffff80000000, 1  );
  TEST_SRL( 720,  0xffffffff80000000, 7  );
  TEST_SRL( 721,  0xffffffff80000000, 14 );
  TEST_SRL( 722,  0xffffffff80000001, 31 );

  TEST_SRL( 723,  0xffffffffffffffff, 0  );
  TEST_SRL( 724,  0xffffffffffffffff, 1  );
  TEST_SRL( 725,  0xffffffffffffffff, 7  );
  TEST_SRL( 726, 0xffffffffffffffff, 14 );
  TEST_SRL( 727, 0xffffffffffffffff, 31 );

  TEST_SRL( 728, 0x0000000021212121, 0  );
  TEST_SRL( 729, 0x0000000021212121, 1  );
  TEST_SRL( 730, 0x0000000021212121, 7  );
  TEST_SRL( 731, 0x0000000021212121, 14 );
  TEST_SRL( 732, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 733, srli, 0x01000000, 0x80000000, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 734, 0, srli, 0x01000000, 0x80000000, 7  );
  TEST_IMM_DEST_BYPASS( 735, 1, srli, 0x00020000, 0x80000000, 14 );
  TEST_IMM_DEST_BYPASS( 736, 2, srli, 0x00000001, 0x80000001, 31 );

  TEST_IMM_SRC1_BYPASS( 737, 0, srli, 0x01000000, 0x80000000, 7  );
  TEST_IMM_SRC1_BYPASS( 738, 1, srli, 0x00020000, 0x80000000, 14 );
  TEST_IMM_SRC1_BYPASS( 739, 2, srli, 0x00000001, 0x80000001, 31 );

  TEST_IMM_ZEROSRC1( 740, srli, 0, 4 );
  TEST_IMM_ZERODEST( 741, srli, 33, 10 );

#sub.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 742,  sub, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_RR_OP( 743,  sub, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_RR_OP( 744,  sub, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_RR_OP( 745,  sub, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_RR_OP( 746,  sub, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_RR_OP( 747,  sub, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_RR_OP( 748,  sub, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_RR_OP( 749,  sub, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_RR_OP( 750, sub, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_RR_OP( 751, sub, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_RR_OP( 752, sub, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_RR_OP( 753, sub, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_RR_OP( 754, sub, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_RR_OP( 755, sub, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 756, sub, 2, 13, 11 );
  TEST_RR_SRC2_EQ_DEST( 757, sub, 3, 14, 11 );
  TEST_RR_SRC12_EQ_DEST( 758, sub, 0, 13 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 759, 0, sub, 2, 13, 11 );
  TEST_RR_DEST_BYPASS( 760, 1, sub, 3, 14, 11 );
  TEST_RR_DEST_BYPASS( 761, 2, sub, 4, 15, 11 );

  TEST_RR_SRC12_BYPASS( 762, 0, 0, sub, 2, 13, 11 );
  TEST_RR_SRC12_BYPASS( 763, 0, 1, sub, 3, 14, 11 );
  TEST_RR_SRC12_BYPASS( 764, 0, 2, sub, 4, 15, 11 );
  TEST_RR_SRC12_BYPASS( 765, 1, 0, sub, 2, 13, 11 );
  TEST_RR_SRC12_BYPASS( 766, 1, 1, sub, 3, 14, 11 );
  TEST_RR_SRC12_BYPASS( 767, 2, 0, sub, 4, 15, 11 );

  TEST_RR_SRC21_BYPASS( 768, 0, 0, sub, 2, 13, 11 );
  TEST_RR_SRC21_BYPASS( 769, 0, 1, sub, 3, 14, 11 );
  TEST_RR_SRC21_BYPASS( 770, 0, 2, sub, 4, 15, 11 );
  TEST_RR_SRC21_BYPASS( 771, 1, 0, sub, 2, 13, 11 );
  TEST_RR_SRC21_BYPASS( 772, 1, 1, sub, 3, 14, 11 );
  TEST_RR_SRC21_BYPASS( 773, 2, 0, sub, 4, 15, 11 );

  TEST_RR_ZEROSRC1( 774, sub, 15, -15 );
  TEST_RR_ZEROSRC2( 775, sub, 32, 32 );
  TEST_RR_ZEROSRC12( 776, sub, 0 );
  TEST_RR_ZERODEST( 777, sub, 16, 30 );

#sw.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_ST_OP( 778, lw, sw, 0x0000000000aa00aa, 0,  sw_tdat );
  TEST_ST_OP( 779, lw, sw, 0xffffffffaa00aa00, 4,  sw_tdat );
  TEST_ST_OP( 780, lw, sw, 0x000000000aa00aa0, 8,  sw_tdat );
  TEST_ST_OP( 781, lw, sw, 0xffffffffa00aa00a, 12, sw_tdat );

  # Test with negative offset

  TEST_ST_OP( 782, lw, sw, 0x0000000000aa00aa, -12, sw_tdat8 );
  TEST_ST_OP( 783, lw, sw, 0xffffffffaa00aa00, -8,  sw_tdat8 );
  TEST_ST_OP( 784, lw, sw, 0x000000000aa00aa0, -4,  sw_tdat8 );
  TEST_ST_OP( 785, lw, sw, 0xffffffffa00aa00a, 0,   sw_tdat8 );

  # Test with a negative base

  TEST_CASE( 786, x5, 0x12345678, \
    la  x1, sw_tdat9; \
    li  x2, 0x12345678; \
    addi x4, x1, -32; \
    sw x2, 32(x4); \
    lw x5, 0(x1); \
  )

  # Test with unaligned base

  TEST_CASE( 787, x5, 0x58213098, \
    la  x1, sw_tdat9; \
    li  x2, 0x58213098; \
    addi x1, x1, -3; \
    sw x2, 7(x1); \
    la  x4, sw_tdat10; \
    lw x5, 0(x4); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_ST_SRC12_BYPASS( 788, 0, 0, lw, sw, 0xffffffffaabbccdd, 0,  sw_tdat );
  TEST_ST_SRC12_BYPASS( 789, 0, 1, lw, sw, 0xffffffffdaabbccd, 4,  sw_tdat );
  TEST_ST_SRC12_BYPASS( 790, 0, 2, lw, sw, 0xffffffffddaabbcc, 8,  sw_tdat );
  TEST_ST_SRC12_BYPASS( 791, 1, 0, lw, sw, 0xffffffffcddaabbc, 12, sw_tdat );
  TEST_ST_SRC12_BYPASS( 792, 1, 1, lw, sw, 0xffffffffccddaabb, 16, sw_tdat );
  TEST_ST_SRC12_BYPASS( 793, 2, 0, lw, sw, 0xffffffffbccddaab, 20, sw_tdat );

  TEST_ST_SRC21_BYPASS( 794, 0, 0, lw, sw, 0x00112233, 0,  sw_tdat );
  TEST_ST_SRC21_BYPASS( 795, 0, 1, lw, sw, 0x30011223, 4,  sw_tdat );
  TEST_ST_SRC21_BYPASS( 796, 0, 2, lw, sw, 0x33001122, 8,  sw_tdat );
  TEST_ST_SRC21_BYPASS( 797, 1, 0, lw, sw, 0x23300112, 12, sw_tdat );
  TEST_ST_SRC21_BYPASS( 798, 1, 1, lw, sw, 0x22330011, 16, sw_tdat );
  TEST_ST_SRC21_BYPASS( 799, 2, 0, lw, sw, 0x12233001, 20, sw_tdat );

#xor.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RR_OP( 800, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_OP( 801, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_OP( 802, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_OP( 803, xor, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 804, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC2_EQ_DEST( 805, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_EQ_DEST( 806, xor, 0x00000000, 0xff00ff00 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 807,  0, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_DEST_BYPASS( 808, 1, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_DEST_BYPASS( 809, 2, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC12_BYPASS( 810, 0, 0, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 811, 0, 1, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 812, 0, 2, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 813, 1, 0, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC12_BYPASS( 814, 1, 1, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC12_BYPASS( 815, 2, 0, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_SRC21_BYPASS( 816, 0, 0, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 817, 0, 1, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 818, 0, 2, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 819, 1, 0, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RR_SRC21_BYPASS( 820, 1, 1, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RR_SRC21_BYPASS( 821, 2, 0, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RR_ZEROSRC1( 822, xor, 0xff00ff00, 0xff00ff00 );
  TEST_RR_ZEROSRC2( 823, xor, 0x00ff00ff, 0x00ff00ff );
  TEST_RR_ZEROSRC12( 824, xor, 0 );
  TEST_RR_ZERODEST( 825, xor, 0x11111111, 0x22222222 );

#xori.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_IMM_OP( 826, xori, 0xffffffffff00f00f, 0x0000000000ff0f00, 0xf0f );
  TEST_IMM_OP( 827, xori, 0x000000000ff00f00, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_OP( 828, xori, 0x0000000000ff0ff0, 0x0000000000ff08ff, 0x70f );
  TEST_IMM_OP( 829, xori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_IMM_SRC1_EQ_DEST( 830, xori, 0xffffffffff00f00f, 0xffffffffff00f700, 0x70f );

   #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_IMM_DEST_BYPASS( 831,  0, xori, 0x000000000ff00f00, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_DEST_BYPASS( 832,  1, xori, 0x0000000000ff0ff0, 0x0000000000ff08ff, 0x70f );
  TEST_IMM_DEST_BYPASS( 833,  2, xori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  TEST_IMM_SRC1_BYPASS( 834, 0, xori, 0x000000000ff00f00, 0x000000000ff00ff0, 0x0f0 );
  TEST_IMM_SRC1_BYPASS( 835, 1, xori, 0x0000000000ff0ff0, 0x0000000000ff0fff, 0x00f );
  TEST_IMM_SRC1_BYPASS( 836, 2, xori, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );

  TEST_IMM_ZEROSRC1( 837, xori, 0x0f0, 0x0f0 );
  TEST_IMM_ZERODEST( 838, xori, 0x00ff00ff, 0x70f );

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

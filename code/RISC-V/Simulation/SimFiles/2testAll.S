# 1 "2testAll.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "2testAll.S"
# See LICENSE for license details.

#*****************************************************************************
# xor.S
#-----------------------------------------------------------------------------

# Test xor instruction.


# 1 "./riscv_test.h" 1





# 1 "././encoding.h" 1
# 7 "./riscv_test.h" 2
# 11 "2testAll.S" 2
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
# 12 "2testAll.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

 #lb.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_237: la x1, tdat; lb x30, 0(x1);; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 237; bne x30, x29, fail;;
  test_238: la x1, tdat; lb x30, 1(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 238; bne x30, x29, fail;;
  test_239: la x1, tdat; lb x30, 2(x1);; li x29, ((0xfffffffffffffff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 239; bne x30, x29, fail;;
  test_240: la x1, tdat; lb x30, 3(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 240; bne x30, x29, fail;;

  # Test with negative offset

  test_241: la x1, tdat4; lb x30, -3(x1);; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 241; bne x30, x29, fail;;
  test_242: la x1, tdat4; lb x30, -2(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 242; bne x30, x29, fail;;
  test_243: la x1, tdat4; lb x30, -1(x1);; li x29, ((0xfffffffffffffff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 243; bne x30, x29, fail;;
  test_244: la x1, tdat4; lb x30, 0(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 244; bne x30, x29, fail;;

  # Test with a negative base

  test_245: la x1, tdat; addi x1, x1, -32; lb x5, 32(x1);; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 245; bne x5, x29, fail;





  # Test with unaligned base

  test_246: la x1, tdat; addi x1, x1, -6; lb x5, 7(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 246; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_247: li gp, 247; li x4, 0; 1: la x1, tdat2; lb x30, 1(x1); addi x6, x30, 0; li x29, 0xfffffffffffffff0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_248: li gp, 248; li x4, 0; 1: la x1, tdat3; lb x30, 1(x1); nop; addi x6, x30, 0; li x29, 0x000000000000000f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_249: li gp, 249; li x4, 0; 1: la x1, tdat1; lb x30, 1(x1); nop; nop; addi x6, x30, 0; li x29, 0x0000000000000000; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_250: li gp, 250; li x4, 0; 1: la x1, tdat2; lb x30, 1(x1); li x29, 0xfffffffffffffff0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_251: li gp, 251; li x4, 0; 1: la x1, tdat3; nop; lb x30, 1(x1); li x29, 0x000000000000000f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_252: li gp, 252; li x4, 0; 1: la x1, tdat1; nop; nop; lb x30, 1(x1); li x29, 0x0000000000000000; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_253: la x5, tdat; lb x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 253; bne x2, x29, fail;





  test_254: la x5, tdat; lb x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 254; bne x2, x29, fail;






 #lbu.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_255: la x1, tdat; lbu x30, 0(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 255; bne x30, x29, fail;;
  test_256: la x1, tdat; lbu x30, 1(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 256; bne x30, x29, fail;;
  test_257: la x1, tdat; lbu x30, 2(x1);; li x29, ((0x00000000000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 257; bne x30, x29, fail;;
  test_258: la x1, tdat; lbu x30, 3(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 258; bne x30, x29, fail;;

  # Test with negative offset

  test_259: la x1, tdat4; lbu x30, -3(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 259; bne x30, x29, fail;;
  test_260: la x1, tdat4; lbu x30, -2(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 260; bne x30, x29, fail;;
  test_261: la x1, tdat4; lbu x30, -1(x1);; li x29, ((0x00000000000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 261; bne x30, x29, fail;;
  test_262: la x1, tdat4; lbu x30, 0(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 262; bne x30, x29, fail;;

  # Test with a negative base

  test_263: la x1, tdat; addi x1, x1, -32; lbu x5, 32(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 263; bne x5, x29, fail;





  # Test with unaligned base

  test_264: la x1, tdat; addi x1, x1, -6; lbu x5, 7(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 264; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_265: li gp, 265; li x4, 0; 1: la x1, tdat2; lbu x30, 1(x1); addi x6, x30, 0; li x29, 0x00000000000000f0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_266: li gp, 266; li x4, 0; 1: la x1, tdat3; lbu x30, 1(x1); nop; addi x6, x30, 0; li x29, 0x000000000000000f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_267: li gp, 267; li x4, 0; 1: la x1, tdat1; lbu x30, 1(x1); nop; nop; addi x6, x30, 0; li x29, 0x0000000000000000; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_268: li gp, 268; li x4, 0; 1: la x1, tdat2; lbu x30, 1(x1); li x29, 0x00000000000000f0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_269: li gp, 269; li x4, 0; 1: la x1, tdat3; nop; lbu x30, 1(x1); li x29, 0x000000000000000f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_270: li gp, 270; li x4, 0; 1: la x1, tdat1; nop; nop; lbu x30, 1(x1); li x29, 0x0000000000000000; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_271: la x5, tdat; lbu x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 271; bne x2, x29, fail;





  test_272: la x5, tdat; lbu x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 272; bne x2, x29, fail;






 #lh.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_273: la x1, lh_tdat; lh x30, 0(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 273; bne x30, x29, fail;;
  test_274: la x1, lh_tdat; lh x30, 2(x1);; li x29, ((0xffffffffffffff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 274; bne x30, x29, fail;;
  test_275: la x1, lh_tdat; lh x30, 4(x1);; li x29, ((0x0000000000000ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 275; bne x30, x29, fail;;
  test_276: la x1, lh_tdat; lh x30, 6(x1);; li x29, ((0xfffffffffffff00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 276; bne x30, x29, fail;;

  # Test with negative offset

  test_277: la x1, lh_tdat4; lh x30, -6(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 277; bne x30, x29, fail;;
  test_278: la x1, lh_tdat4; lh x30, -4(x1);; li x29, ((0xffffffffffffff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 278; bne x30, x29, fail;;
  test_279: la x1, lh_tdat4; lh x30, -2(x1);; li x29, ((0x0000000000000ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 279; bne x30, x29, fail;;
  test_280: la x1, lh_tdat4; lh x30, 0(x1);; li x29, ((0xfffffffffffff00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 280; bne x30, x29, fail;;

  # Test with a negative base

  test_281: la x1, lh_tdat; addi x1, x1, -32; lh x5, 32(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 281; bne x5, x29, fail;





  # Test with unaligned base

  test_282: la x1, lh_tdat; addi x1, x1, -5; lh x5, 7(x1);; li x29, ((0xffffffffffffff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 282; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_283: li gp, 283; li x4, 0; 1: la x1, lh_tdat2; lh x30, 2(x1); addi x6, x30, 0; li x29, 0x0000000000000ff0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_284: li gp, 284; li x4, 0; 1: la x1, lh_tdat3; lh x30, 2(x1); nop; addi x6, x30, 0; li x29, 0xfffffffffffff00f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_285: li gp, 285; li x4, 0; 1: la x1, lh_tdat1; lh x30, 2(x1); nop; nop; addi x6, x30, 0; li x29, 0xffffffffffffff00; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_286: li gp, 286; li x4, 0; 1: la x1, lh_tdat2; lh x30, 2(x1); li x29, 0x0000000000000ff0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_287: li gp, 287; li x4, 0; 1: la x1, lh_tdat3; nop; lh x30, 2(x1); li x29, 0xfffffffffffff00f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_288: li gp, 288; li x4, 0; 1: la x1, lh_tdat1; nop; nop; lh x30, 2(x1); li x29, 0xffffffffffffff00; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_289: la x5, lh_tdat; lh x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 289; bne x2, x29, fail;





  test_290: la x5, lh_tdat; lh x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 290; bne x2, x29, fail;






 #lhu.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_291: la x1, lh_tdat; lhu x30, 0(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 291; bne x30, x29, fail;;
  test_292: la x1, lh_tdat; lhu x30, 2(x1);; li x29, ((0x000000000000ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 292; bne x30, x29, fail;;
  test_293: la x1, lh_tdat; lhu x30, 4(x1);; li x29, ((0x0000000000000ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 293; bne x30, x29, fail;;
  test_294: la x1, lh_tdat; lhu x30, 6(x1);; li x29, ((0x000000000000f00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 294; bne x30, x29, fail;;

  # Test with negative offset

  test_295: la x1, lh_tdat4; lhu x30, -6(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 295; bne x30, x29, fail;;
  test_296: la x1, lh_tdat4; lhu x30, -4(x1);; li x29, ((0x000000000000ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 296; bne x30, x29, fail;;
  test_297: la x1, lh_tdat4; lhu x30, -2(x1);; li x29, ((0x0000000000000ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 297; bne x30, x29, fail;;
  test_298: la x1, lh_tdat4; lhu x30, 0(x1);; li x29, ((0x000000000000f00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 298; bne x30, x29, fail;;

  # Test with a negative base

  test_299: la x1, lh_tdat; addi x1, x1, -32; lhu x5, 32(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 299; bne x5, x29, fail;





  # Test with unaligned base

  test_300: la x1, lh_tdat; addi x1, x1, -5; lhu x5, 7(x1);; li x29, ((0x000000000000ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 300; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_301: li gp, 301; li x4, 0; 1: la x1, lh_tdat2; lhu x30, 2(x1); addi x6, x30, 0; li x29, 0x0000000000000ff0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_302: li gp, 302; li x4, 0; 1: la x1, lh_tdat3; lhu x30, 2(x1); nop; addi x6, x30, 0; li x29, 0x000000000000f00f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_303: li gp, 303; li x4, 0; 1: la x1, lh_tdat1; lhu x30, 2(x1); nop; nop; addi x6, x30, 0; li x29, 0x000000000000ff00; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_304: li gp, 304; li x4, 0; 1: la x1, lh_tdat2; lhu x30, 2(x1); li x29, 0x0000000000000ff0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_305: li gp, 305; li x4, 0; 1: la x1, lh_tdat3; nop; lhu x30, 2(x1); li x29, 0x000000000000f00f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_306: li gp, 306; li x4, 0; 1: la x1, lh_tdat1; nop; nop; lhu x30, 2(x1); li x29, 0x000000000000ff00; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_307: la x5, lh_tdat; lhu x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 307; bne x2, x29, fail;





  test_308: la x5, lh_tdat; lhu x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 308; bne x2, x29, fail;






 #lui.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_309: lui x1, 0x00000; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 309; bne x1, x29, fail;;
  test_310: lui x1, 0xfffff;sra x1,x1,1; li x29, ((0xfffffffffffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 310; bne x1, x29, fail;;
  test_311: lui x1, 0x7ffff;sra x1,x1,20; li x29, ((0x00000000000007ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 311; bne x1, x29, fail;;
  test_312: lui x1, 0x80000;sra x1,x1,20; li x29, ((0xfffffffffffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 312; bne x1, x29, fail;;

  test_313: lui x0, 0x80000; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 313; bne x0, x29, fail;;

#lw.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_314: la x1, lw_tdat; lw x30, 0(x1);; li x29, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 314; bne x30, x29, fail;;
  test_315: la x1, lw_tdat; lw x30, 4(x1);; li x29, ((0xffffffffff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 315; bne x30, x29, fail;;
  test_316: la x1, lw_tdat; lw x30, 8(x1);; li x29, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 316; bne x30, x29, fail;;
  test_317: la x1, lw_tdat; lw x30, 12(x1);; li x29, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 317; bne x30, x29, fail;;

  # Test with negative offset

  test_318: la x1, lw_tdat4; lw x30, -12(x1);; li x29, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 318; bne x30, x29, fail;;
  test_319: la x1, lw_tdat4; lw x30, -8(x1);; li x29, ((0xffffffffff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 319; bne x30, x29, fail;;
  test_320: la x1, lw_tdat4; lw x30, -4(x1);; li x29, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 320; bne x30, x29, fail;;
  test_321: la x1, lw_tdat4; lw x30, 0(x1);; li x29, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); li gp, 321; bne x30, x29, fail;;

  # Test with a negative base

  test_322: la x1, lw_tdat; addi x1, x1, -32; lw x5, 32(x1);; li x29, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 322; bne x5, x29, fail;





  # Test with unaligned base

  test_323: la x1, lw_tdat; addi x1, x1, -3; lw x5, 7(x1);; li x29, ((0xffffffffff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 323; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_324: li gp, 324; li x4, 0; 1: la x1, lw_tdat2; lw x30, 4(x1); addi x6, x30, 0; li x29, 0x000000000ff00ff0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_325: li gp, 325; li x4, 0; 1: la x1, lw_tdat3; lw x30, 4(x1); nop; addi x6, x30, 0; li x29, 0xfffffffff00ff00f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_326: li gp, 326; li x4, 0; 1: la x1, lw_tdat1; lw x30, 4(x1); nop; nop; addi x6, x30, 0; li x29, 0xffffffffff00ff00; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_327: li gp, 327; li x4, 0; 1: la x1, lw_tdat2; lw x30, 4(x1); li x29, 0x000000000ff00ff0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_328: li gp, 328; li x4, 0; 1: la x1, lw_tdat3; nop; lw x30, 4(x1); li x29, 0xfffffffff00ff00f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_329: li gp, 329; li x4, 0; 1: la x1, lw_tdat1; nop; nop; lw x30, 4(x1); li x29, 0xffffffffff00ff00; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_330: la x5, lw_tdat; lw x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 330; bne x2, x29, fail;





  test_331: la x5, lw_tdat; lw x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 331; bne x2, x29, fail;






 #or.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_332: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2;; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 332; bne x30, x29, fail;;
  test_333: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2;; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 333; bne x30, x29, fail;;
  test_334: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2;; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 334; bne x30, x29, fail;;
  test_335: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2;; li x29, ((0xf0fff0ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 335; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_336: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x1, x1, x2;; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 336; bne x1, x29, fail;;
  test_337: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x2, x1, x2;; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 337; bne x2, x29, fail;;
  test_338: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); or x1, x1, x1;; li x29, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 338; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_339: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 339; bne x6, x29, fail;;
  test_340: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 340; bne x6, x29, fail;;
  test_341: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 341; bne x6, x29, fail;;

  test_342: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 342; bne x30, x29, fail;;
  test_343: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 343; bne x30, x29, fail;;
  test_344: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 344; bne x30, x29, fail;;
  test_345: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 345; bne x30, x29, fail;;
  test_346: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 346; bne x30, x29, fail;;
  test_347: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 347; bne x30, x29, fail;;

  test_348: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 348; bne x30, x29, fail;;
  test_349: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 349; bne x30, x29, fail;;
  test_350: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 350; bne x30, x29, fail;;
  test_351: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xff0fff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 351; bne x30, x29, fail;;
  test_352: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfff0fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 352; bne x30, x29, fail;;
  test_353: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); or x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0fff0fff) & ((1 << (32 - 1) << 1) - 1)); li gp, 353; bne x30, x29, fail;;

  test_354: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); or x2, x0, x1;; li x29, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 354; bne x2, x29, fail;;
  test_355: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); or x2, x1, x0;; li x29, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 355; bne x2, x29, fail;;
  test_356: or x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 356; bne x1, x29, fail;;
  test_357: li x1, ((0x11111111) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x22222222) & ((1 << (32 - 1) << 1) - 1)); or x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 357; bne x0, x29, fail;;

#ori.S
  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_358: li x1, ((0xffffffffff00ff00) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11));; li x29, ((0xffffffffffffff0f) & ((1 << (32 - 1) << 1) - 1)); li gp, 358; bne x30, x29, fail;;
  test_359: li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 359; bne x30, x29, fail;;
  test_360: li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x29, ((0x0000000000ff07ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 360; bne x30, x29, fail;;
  test_361: li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 361; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_362: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); ori x1, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0xff00fff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 362; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_363: li x4, 0; 1: li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 363; bne x6, x29, fail;;
  test_364: li x4, 0; 1: li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11)); nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000ff07ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 364; bne x6, x29, fail;;
  test_365: li x4, 0; 1: li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 365; bne x6, x29, fail;;

  test_366: li x4, 0; 1: li x1, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000000000ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li gp, 366; bne x30, x29, fail;;
  test_367: li x4, 0; 1: li x1, ((0x0000000000ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; ori x30, x1, ((0xf0f) | (-(((0xf0f) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 367; bne x30, x29, fail;;
  test_368: li x4, 0; 1: li x1, ((0xfffffffff00ff00f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; ori x30, x1, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0xfffffffff00ff0ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 368; bne x30, x29, fail;;

  test_369: ori x1, x0, ((0x0f0) | (-(((0x0f0) >> 11) & 1) << 11));; li x29, ((0x0f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 369; bne x1, x29, fail;;
  test_370: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); ori x0, x1, ((0x70f) | (-(((0x70f) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 370; bne x0, x29, fail;;

#sb.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_371: la x1, sb_tdat; li x2, 0xffffffffffffffaa; sb x2, 0(x1); lb x30, 0(x1);; li x29, ((0xffffffffffffffaa) & ((1 << (32 - 1) << 1) - 1)); li gp, 371; bne x30, x29, fail;;
  test_372: la x1, sb_tdat; li x2, 0x0000000000000000; sb x2, 1(x1); lb x30, 1(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 372; bne x30, x29, fail;;
  test_373: la x1, sb_tdat; li x2, 0xffffffffffffefa0; sb x2, 2(x1); lh x30, 2(x1);; li x29, ((0xffffffffffffefa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 373; bne x30, x29, fail;;
  test_374: la x1, sb_tdat; li x2, 0x000000000000000a; sb x2, 3(x1); lb x30, 3(x1);; li x29, ((0x000000000000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 374; bne x30, x29, fail;;

  # Test with negative offset

  test_375: la x1, sb_tdat8; li x2, 0xffffffffffffffaa; sb x2, -3(x1); lb x30, -3(x1);; li x29, ((0xffffffffffffffaa) & ((1 << (32 - 1) << 1) - 1)); li gp, 375; bne x30, x29, fail;;
  test_376: la x1, sb_tdat8; li x2, 0x0000000000000000; sb x2, -2(x1); lb x30, -2(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 376; bne x30, x29, fail;;
  test_377: la x1, sb_tdat8; li x2, 0xffffffffffffffa0; sb x2, -1(x1); lb x30, -1(x1);; li x29, ((0xffffffffffffffa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 377; bne x30, x29, fail;;
  test_378: la x1, sb_tdat8; li x2, 0x000000000000000a; sb x2, 0(x1); lb x30, 0(x1);; li x29, ((0x000000000000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 378; bne x30, x29, fail;;

  # Test with a negative base

  test_379: la x1, sb_tdat9; li x2, 0x12345678; addi x4, x1, -32; sb x2, 32(x4); lb x5, 0(x1);; li x29, ((0x78) & ((1 << (32 - 1) << 1) - 1)); li gp, 379; bne x5, x29, fail;







  # Test with unaligned base

  test_380: la x1, sb_tdat9; li x2, 0x00003098; addi x1, x1, -6; sb x2, 7(x1); la x4, sb_tdat10; lb x5, 0(x4);; li x29, ((0xffffffffffffff98) & ((1 << (32 - 1) << 1) - 1)); li gp, 380; bne x5, x29, fail;
# 452 "2testAll.S"
  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_381: li gp, 381; li x4, 0; 1: li x1, 0xffffffffffffffdd; la x2, sb_tdat; sb x1, 0(x2); lb x30, 0(x2); li x29, 0xffffffffffffffdd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_382: li gp, 382; li x4, 0; 1: li x1, 0xffffffffffffffcd; la x2, sb_tdat; nop; sb x1, 1(x2); lb x30, 1(x2); li x29, 0xffffffffffffffcd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_383: li gp, 383; li x4, 0; 1: li x1, 0xffffffffffffffcc; la x2, sb_tdat; nop; nop; sb x1, 2(x2); lb x30, 2(x2); li x29, 0xffffffffffffffcc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_384: li gp, 384; li x4, 0; 1: li x1, 0xffffffffffffffbc; nop; la x2, sb_tdat; sb x1, 3(x2); lb x30, 3(x2); li x29, 0xffffffffffffffbc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_385: li gp, 385; li x4, 0; 1: li x1, 0xffffffffffffffbb; nop; la x2, sb_tdat; nop; sb x1, 4(x2); lb x30, 4(x2); li x29, 0xffffffffffffffbb; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_386: li gp, 386; li x4, 0; 1: li x1, 0xffffffffffffffab; nop; nop; la x2, sb_tdat; sb x1, 5(x2); lb x30, 5(x2); li x29, 0xffffffffffffffab; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_387: li gp, 387; li x4, 0; 1: la x2, sb_tdat; li x1, 0x33; sb x1, 0(x2); lb x30, 0(x2); li x29, 0x33; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_388: li gp, 388; li x4, 0; 1: la x2, sb_tdat; li x1, 0x23; nop; sb x1, 1(x2); lb x30, 1(x2); li x29, 0x23; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_389: li gp, 389; li x4, 0; 1: la x2, sb_tdat; li x1, 0x22; nop; nop; sb x1, 2(x2); lb x30, 2(x2); li x29, 0x22; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_390: li gp, 390; li x4, 0; 1: la x2, sb_tdat; nop; li x1, 0x12; sb x1, 3(x2); lb x30, 3(x2); li x29, 0x12; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_391: li gp, 391; li x4, 0; 1: la x2, sb_tdat; nop; li x1, 0x11; nop; sb x1, 4(x2); lb x30, 4(x2); li x29, 0x11; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_392: li gp, 392; li x4, 0; 1: la x2, sb_tdat; nop; nop; li x1, 0x01; sb x1, 5(x2); lb x30, 5(x2); li x29, 0x01; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  li a0, 0xef
  la a1, sb_tdat
  sb a0, 3(a1)

#sh.S
  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_393: la x1, sh_tdat; li x2, 0x00000000000000aa; sh x2, 0(x1); lh x30, 0(x1);; li x29, ((0x00000000000000aa) & ((1 << (32 - 1) << 1) - 1)); li gp, 393; bne x30, x29, fail;;
  test_394: la x1, sh_tdat; li x2, 0xffffffffffffaa00; sh x2, 2(x1); lh x30, 2(x1);; li x29, ((0xffffffffffffaa00) & ((1 << (32 - 1) << 1) - 1)); li gp, 394; bne x30, x29, fail;;
  test_395: la x1, sh_tdat; li x2, 0xffffffffbeef0aa0; sh x2, 4(x1); lw x30, 4(x1);; li x29, ((0xffffffffbeef0aa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 395; bne x30, x29, fail;;
  test_396: la x1, sh_tdat; li x2, 0xffffffffffffa00a; sh x2, 6(x1); lh x30, 6(x1);; li x29, ((0xffffffffffffa00a) & ((1 << (32 - 1) << 1) - 1)); li gp, 396; bne x30, x29, fail;;

  # Test with negative offset

  test_397: la x1, sh_tdat8; li x2, 0x00000000000000aa; sh x2, -6(x1); lh x30, -6(x1);; li x29, ((0x00000000000000aa) & ((1 << (32 - 1) << 1) - 1)); li gp, 397; bne x30, x29, fail;;
  test_398: la x1, sh_tdat8; li x2, 0xffffffffffffaa00; sh x2, -4(x1); lh x30, -4(x1);; li x29, ((0xffffffffffffaa00) & ((1 << (32 - 1) << 1) - 1)); li gp, 398; bne x30, x29, fail;;
  test_399: la x1, sh_tdat8; li x2, 0x0000000000000aa0; sh x2, -2(x1); lh x30, -2(x1);; li x29, ((0x0000000000000aa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 399; bne x30, x29, fail;;
  test_400: la x1, sh_tdat8; li x2, 0xffffffffffffa00a; sh x2, 0(x1); lh x30, 0(x1);; li x29, ((0xffffffffffffa00a) & ((1 << (32 - 1) << 1) - 1)); li gp, 400; bne x30, x29, fail;;

  # Test with a negative base

  test_401: la x1, sh_tdat9; li x2, 0x12345678; addi x4, x1, -32; sh x2, 32(x4); lh x5, 0(x1);; li x29, ((0x5678) & ((1 << (32 - 1) << 1) - 1)); li gp, 401; bne x5, x29, fail;







  # Test with unaligned base

  test_402: la x1, sh_tdat9; li x2, 0x00003098; addi x1, x1, -5; sh x2, 7(x1); la x4, sh_tdat10; lh x5, 0(x4);; li x29, ((0x3098) & ((1 << (32 - 1) << 1) - 1)); li gp, 402; bne x5, x29, fail;
# 512 "2testAll.S"
  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_403: li gp, 403; li x4, 0; 1: li x1, 0xffffffffffffccdd; la x2, sh_tdat; sh x1, 0(x2); lh x30, 0(x2); li x29, 0xffffffffffffccdd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_404: li gp, 404; li x4, 0; 1: li x1, 0xffffffffffffbccd; la x2, sh_tdat; nop; sh x1, 2(x2); lh x30, 2(x2); li x29, 0xffffffffffffbccd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_405: li gp, 405; li x4, 0; 1: li x1, 0xffffffffffffbbcc; la x2, sh_tdat; nop; nop; sh x1, 4(x2); lh x30, 4(x2); li x29, 0xffffffffffffbbcc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_406: li gp, 406; li x4, 0; 1: li x1, 0xffffffffffffabbc; nop; la x2, sh_tdat; sh x1, 6(x2); lh x30, 6(x2); li x29, 0xffffffffffffabbc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_407: li gp, 407; li x4, 0; 1: li x1, 0xffffffffffffaabb; nop; la x2, sh_tdat; nop; sh x1, 8(x2); lh x30, 8(x2); li x29, 0xffffffffffffaabb; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_408: li gp, 408; li x4, 0; 1: li x1, 0xffffffffffffdaab; nop; nop; la x2, sh_tdat; sh x1, 10(x2); lh x30, 10(x2); li x29, 0xffffffffffffdaab; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_409: li gp, 409; li x4, 0; 1: la x2, sh_tdat; li x1, 0x2233; sh x1, 0(x2); lh x30, 0(x2); li x29, 0x2233; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_410: li gp, 410; li x4, 0; 1: la x2, sh_tdat; li x1, 0x1223; nop; sh x1, 2(x2); lh x30, 2(x2); li x29, 0x1223; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_411: li gp, 411; li x4, 0; 1: la x2, sh_tdat; li x1, 0x1122; nop; nop; sh x1, 4(x2); lh x30, 4(x2); li x29, 0x1122; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_412: li gp, 412; li x4, 0; 1: la x2, sh_tdat; nop; li x1, 0x0112; sh x1, 6(x2); lh x30, 6(x2); li x29, 0x0112; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_413: li gp, 413; li x4, 0; 1: la x2, sh_tdat; nop; li x1, 0x0011; nop; sh x1, 8(x2); lh x30, 8(x2); li x29, 0x0011; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_414: li gp, 414; li x4, 0; 1: la x2, sh_tdat; nop; nop; li x1, 0x3001; sh x1, 10(x2); lh x30, 10(x2); li x29, 0x3001; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  li a0, 0xbeef
  la a1, sh_tdat
  sh a0, 6(a1)

#sll.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_415: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li gp, 415; bne x30, x29, fail;;
  test_416: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((1) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000000000002) & ((1 << (32 - 1) << 1) - 1)); li gp, 416; bne x30, x29, fail;;
  test_417: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 417; bne x30, x29, fail;;
  test_418: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 418; bne x30, x29, fail;;
  test_419: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 419; bne x30, x29, fail;;

  test_420: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 420; bne x30, x29, fail;;
  test_421: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((1) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0xfffffffffffffffe) & ((1 << (32 - 1) << 1) - 1)); li gp, 421; bne x30, x29, fail;;
  test_422: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0xffffffffffffff80) & ((1 << (32 - 1) << 1) - 1)); li gp, 422; bne x30, x29, fail;;
  test_423: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0xffffffffffffc000) & ((1 << (32 - 1) << 1) - 1)); li gp, 423; bne x30, x29, fail;;
  test_424: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 424; bne x30, x29, fail;;

  test_425: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li gp, 425; bne x30, x29, fail;;
  test_426: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((1) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000042424242) & ((1 << (32 - 1) << 1) - 1)); li gp, 426; bne x30, x29, fail;;
  test_427: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000001090909080) & ((1 << (32 - 1) << 1) - 1)); li gp, 427; bne x30, x29, fail;;
  test_428: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000084848484000) & ((1 << (32 - 1) << 1) - 1)); li gp, 428; bne x30, x29, fail;;
  test_429: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x1090909080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 429; bne x30, x29, fail;;

  # Verify that shifts only use bottom six bits

  test_430: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffc0) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li gp, 430; bne x30, x29, fail;;
  test_431: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffc1) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000000042424242) & ((1 << (32 - 1) << 1) - 1)); li gp, 431; bne x30, x29, fail;;
  test_432: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffc7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000001090909080) & ((1 << (32 - 1) << 1) - 1)); li gp, 432; bne x30, x29, fail;;
  test_433: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffce) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2;; li x29, ((0x0000084848484000) & ((1 << (32 - 1) << 1) - 1)); li gp, 433; bne x30, x29, fail;;
# 571 "2testAll.S"
  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_438: li x1, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x1, x1, x2;; li x29, ((0x00000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 438; bne x1, x29, fail;;
  test_439: li x1, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); sll x2, x1, x2;; li x29, ((0x00004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 439; bne x2, x29, fail;;
  test_440: li x1, ((3) & ((1 << (32 - 1) << 1) - 1)); sll x1, x1, x1;; li x29, ((24) & ((1 << (32 - 1) << 1) - 1)); li gp, 440; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_441: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 441; bne x6, x29, fail;;
  test_442: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 442; bne x6, x29, fail;;
  test_443: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 443; bne x6, x29, fail;;

  test_444: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 444; bne x30, x29, fail;;
  test_445: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 445; bne x30, x29, fail;;
  test_446: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); nop; nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 446; bne x30, x29, fail;;
  test_447: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 447; bne x30, x29, fail;;
  test_448: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 448; bne x30, x29, fail;;
  test_449: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 449; bne x30, x29, fail;;

  test_450: li x4, 0; 1: li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 450; bne x30, x29, fail;;
  test_451: li x4, 0; 1: li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 451; bne x30, x29, fail;;
  test_452: li x4, 0; 1: li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 452; bne x30, x29, fail;;
  test_453: li x4, 0; 1: li x2, ((7) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 453; bne x30, x29, fail;;
  test_454: li x4, 0; 1: li x2, ((14) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 454; bne x30, x29, fail;;
  test_455: li x4, 0; 1: li x2, ((31) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); sll x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 455; bne x30, x29, fail;;

  test_456: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); sll x2, x0, x1;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 456; bne x2, x29, fail;;
  test_457: li x1, ((32) & ((1 << (32 - 1) << 1) - 1)); sll x2, x1, x0;; li x29, ((32) & ((1 << (32 - 1) << 1) - 1)); li gp, 457; bne x2, x29, fail;;
  test_458: sll x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 458; bne x1, x29, fail;;
  test_459: li x1, ((1024) & ((1 << (32 - 1) << 1) - 1)); li x2, ((2048) & ((1 << (32 - 1) << 1) - 1)); sll x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 459; bne x0, x29, fail;;

#slli.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_460: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((0) | (-(((0) >> 11) & 1) << 11));; li x29, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li gp, 460; bne x30, x29, fail;;
  test_461: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((1) | (-(((1) >> 11) & 1) << 11));; li x29, ((0x0000000000000002) & ((1 << (32 - 1) << 1) - 1)); li gp, 461; bne x30, x29, fail;;
  test_462: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((7) | (-(((7) >> 11) & 1) << 11));; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 462; bne x30, x29, fail;;
  test_463: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((14) | (-(((14) >> 11) & 1) << 11));; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 463; bne x30, x29, fail;;
  test_464: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((31) | (-(((31) >> 11) & 1) << 11));; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 464; bne x30, x29, fail;;

  test_465: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((0) | (-(((0) >> 11) & 1) << 11));; li x29, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li gp, 465; bne x30, x29, fail;;
  test_466: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((1) | (-(((1) >> 11) & 1) << 11));; li x29, ((0xfffffffffffffffe) & ((1 << (32 - 1) << 1) - 1)); li gp, 466; bne x30, x29, fail;;
  test_467: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((7) | (-(((7) >> 11) & 1) << 11));; li x29, ((0xffffffffffffff80) & ((1 << (32 - 1) << 1) - 1)); li gp, 467; bne x30, x29, fail;;
  test_468: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((14) | (-(((14) >> 11) & 1) << 11));; li x29, ((0xffffffffffffc000) & ((1 << (32 - 1) << 1) - 1)); li gp, 468; bne x30, x29, fail;;
  test_469: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((31) | (-(((31) >> 11) & 1) << 11));; li x29, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 469; bne x30, x29, fail;;

  test_470: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((0) | (-(((0) >> 11) & 1) << 11));; li x29, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); li gp, 470; bne x30, x29, fail;;
  test_471: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((1) | (-(((1) >> 11) & 1) << 11));; li x29, ((0x0000000042424242) & ((1 << (32 - 1) << 1) - 1)); li gp, 471; bne x30, x29, fail;;
  test_472: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((7) | (-(((7) >> 11) & 1) << 11));; li x29, ((0x0000001090909080) & ((1 << (32 - 1) << 1) - 1)); li gp, 472; bne x30, x29, fail;;
  test_473: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((14) | (-(((14) >> 11) & 1) << 11));; li x29, ((0x0000084848484000) & ((1 << (32 - 1) << 1) - 1)); li gp, 473; bne x30, x29, fail;;
  test_474: li x1, ((0x0000000021212121) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((31) | (-(((31) >> 11) & 1) << 11));; li x29, ((0x1090909080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 474; bne x30, x29, fail;;







  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_478: li x1, ((0x00000001) & ((1 << (32 - 1) << 1) - 1)); slli x1, x1, ((7) | (-(((7) >> 11) & 1) << 11));; li x29, ((0x00000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 478; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_479: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((7) | (-(((7) >> 11) & 1) << 11)); addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 479; bne x6, x29, fail;;
  test_480: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((14) | (-(((14) >> 11) & 1) << 11)); nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 480; bne x6, x29, fail;;
  test_481: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((31) | (-(((31) >> 11) & 1) << 11)); nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 481; bne x6, x29, fail;;

  test_482: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slli x30, x1, ((7) | (-(((7) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000000080) & ((1 << (32 - 1) << 1) - 1)); li gp, 482; bne x30, x29, fail;;
  test_483: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; slli x30, x1, ((14) | (-(((14) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000000004000) & ((1 << (32 - 1) << 1) - 1)); li gp, 483; bne x30, x29, fail;;
  test_484: li x4, 0; 1: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); nop; nop; slli x30, x1, ((31) | (-(((31) >> 11) & 1) << 11)); addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0000000080000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 484; bne x30, x29, fail;;

  test_485: slli x1, x0, ((31) | (-(((31) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 485; bne x1, x29, fail;;
  test_486: li x1, ((33) & ((1 << (32 - 1) << 1) - 1)); slli x0, x1, ((20) | (-(((20) >> 11) & 1) << 11));; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 486; bne x0, x29, fail;;

#slt.S
  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_487: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 487; bne x30, x29, fail;;
  test_488: li x1, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 488; bne x30, x29, fail;;
  test_489: li x1, ((0x0000000000000003) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000007) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 489; bne x30, x29, fail;;
  test_490: li x1, ((0x0000000000000007) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000003) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 490; bne x30, x29, fail;;

  test_491: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 491; bne x30, x29, fail;;
  test_492: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 492; bne x30, x29, fail;;
  test_493: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 493; bne x30, x29, fail;;

  test_494: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 494; bne x30, x29, fail;;
  test_495: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 495; bne x30, x29, fail;;
  test_496: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 496; bne x30, x29, fail;;

  test_497: li x1, ((0xffffffff80000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000007fff) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 497; bne x30, x29, fail;;
  test_498: li x1, ((0x000000007fffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffff8000) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 498; bne x30, x29, fail;;

  test_499: li x1, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 499; bne x30, x29, fail;;
  test_500: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0000000000000001) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 500; bne x30, x29, fail;;
  test_501: li x1, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xffffffffffffffff) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 501; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_502: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x1, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 502; bne x1, x29, fail;;
  test_503: li x1, ((11) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x2, x1, x2;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 503; bne x2, x29, fail;;
  test_504: li x1, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x1, x1, x1;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 504; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_505: li x4, 0; 1: li x1, ((11) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 505; bne x6, x29, fail;;
  test_506: li x4, 0; 1: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 506; bne x6, x29, fail;;
  test_507: li x4, 0; 1: li x1, ((12) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 507; bne x6, x29, fail;;

  test_508: li x4, 0; 1: li x1, ((14) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 508; bne x30, x29, fail;;
  test_509: li x4, 0; 1: li x1, ((11) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 509; bne x30, x29, fail;;
  test_510: li x4, 0; 1: li x1, ((15) & ((1 << (32 - 1) << 1) - 1)); li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 510; bne x30, x29, fail;;
  test_511: li x4, 0; 1: li x1, ((10) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 511; bne x30, x29, fail;;
  test_512: li x4, 0; 1: li x1, ((16) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 512; bne x30, x29, fail;;
  test_513: li x4, 0; 1: li x1, ((9) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 513; bne x30, x29, fail;;

  test_514: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); li x1, ((17) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 514; bne x30, x29, fail;;
  test_515: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); li x1, ((8) & ((1 << (32 - 1) << 1) - 1)); nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 515; bne x30, x29, fail;;
  test_516: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); li x1, ((18) & ((1 << (32 - 1) << 1) - 1)); nop; nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 516; bne x30, x29, fail;;
  test_517: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((7) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 517; bne x30, x29, fail;;
  test_518: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((19) & ((1 << (32 - 1) << 1) - 1)); nop; slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 518; bne x30, x29, fail;;
  test_519: li x4, 0; 1: li x2, ((13) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((6) & ((1 << (32 - 1) << 1) - 1)); slt x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 519; bne x30, x29, fail;;

  test_520: li x1, ((-1) & ((1 << (32 - 1) << 1) - 1)); slt x2, x0, x1;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 520; bne x2, x29, fail;;
  test_521: li x1, ((-1) & ((1 << (32 - 1) << 1) - 1)); slt x2, x1, x0;; li x29, ((1) & ((1 << (32 - 1) << 1) - 1)); li gp, 521; bne x2, x29, fail;;
  test_522: slt x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 522; bne x1, x29, fail;;
  test_523: li x1, ((16) & ((1 << (32 - 1) << 1) - 1)); li x2, ((30) & ((1 << (32 - 1) << 1) - 1)); slt x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 523; bne x0, x29, fail;;

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

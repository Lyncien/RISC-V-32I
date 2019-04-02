// See LICENSE for license details.

#ifndef _ENV_PHYSICAL_SINGLE_CORE_H
#define _ENV_PHYSICAL_SINGLE_CORE_H

#include "./encoding.h"

//-----------------------------------------------------------------------
// Begin Macro
//-----------------------------------------------------------------------
#define RVTEST_CODE_BEGIN                                               \
        .section .text;	                                                \
        .align  6;                                                      \
        .globl _start;                                                  \
_start:                                                                 \
	addi zero,zero, 0

//-----------------------------------------------------------------------
// End Macro
//-----------------------------------------------------------------------

#define RVTEST_CODE_END                                                 \
        unimp

//-----------------------------------------------------------------------
// Pass/Fail Macro
//-----------------------------------------------------------------------
#define TESTNUM gp

#define TEST_PASSFAIL \
        bne x0, TESTNUM, pass; \
fail: \
        RVTEST_FAIL; \
pass: \
        RVTEST_PASS \

#define RVTEST_PASS  \
                li TESTNUM,1;\
finish1:        jal x20,finish1
        
#define RVTEST_FAIL \
finish2:        jal x20,finish2

//-----------------------------------------------------------------------
// Data Section Macro
//-----------------------------------------------------------------------

#define EXTRA_DATA

#define RVTEST_DATA_BEGIN                                               \
        EXTRA_DATA                                                      \
        .pushsection .tohost,"aw",@progbits;                            \
        .align 6; .global tohost; tohost: .dword 0;                     \
        .align 6; .global fromhost; fromhost: .dword 0;                 \
        .popsection;                                                    \
        .align 4; .global begin_signature; begin_signature:

#define RVTEST_DATA_END .align 4; .global end_signature; end_signature:

#endif

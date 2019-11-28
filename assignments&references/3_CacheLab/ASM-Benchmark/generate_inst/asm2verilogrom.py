# -*- coding:utf-8 -*-
# Python2 or Python3
# Author : WangXuan
# 
# 功能： 使用 Windows 版的 RISCV 工具链将汇编编译成 指令 RAM 的 Verilog 文件
# 


import os, sys, binascii

verilog_head = '''// asm file name: %s
module InstructionRam(
    input  clk, rst,
    input  [ 3:0] wea,
    input  [11:0] addra,
    input  [31:0] dina ,
    output reg [31:0] douta
);
initial begin douta=0;end

reg [31:0] ram_cell [1024];

initial begin
'''

verilog_tail = '''
end

always @ (posedge clk or posedge rst)
    if(rst)
        douta <= 0;
    else
        douta <= ram_cell[addra];

always @ (posedge clk)
    if(wea[0]) 
        ram_cell[addra][ 7: 0] <= dina[ 7: 0];
        
always @ (posedge clk)
    if(wea[1]) 
        ram_cell[addra][15: 8] <= dina[15: 8];
        
always @ (posedge clk)
    if(wea[2]) 
        ram_cell[addra][23:16] <= dina[23:16];
        
always @ (posedge clk)
    if(wea[3]) 
        ram_cell[addra][31:24] <= dina[31:24];

endmodule
'''

RISCV_TOOLCHAIN_PATH = '.\\riscv32-gnu-toolchain-windows\\'

if len(sys.argv) != 3:
    print('    Usage:\n        python asm2verilog.py [INPUT ASM file] [OUTPUT Verilog file]')
    print('    Example:\n        python asm2verilog.py QuickSort.S InstructionRam.v')
else:
    INPUT  = sys.argv[1]
    OUTPUT = sys.argv[2]

    res = os.system( '%sriscv32-elf-as %s            -o compile_tmp.o   -march=rv32i' % (RISCV_TOOLCHAIN_PATH, INPUT) )
    if res != 0:
        print('\n    Assembling Error!')
        sys.exit()
    os.system( '%sriscv32-elf-ld compile_tmp.o -o compile_tmp.om'               % (RISCV_TOOLCHAIN_PATH       ) )
    os.system( 'del compile_tmp.o'   )
    os.system( '%sriscv32-elf-objcopy -O binary compile_tmp.om compile_tmp.bin' % (RISCV_TOOLCHAIN_PATH,      ) )
    os.system( 'del compile_tmp.om'  )
    s = binascii.b2a_hex( open('compile_tmp.bin', 'rb').read() )
    os.system( 'del compile_tmp.bin' )

    def byte_wise_reverse(b):
        return b[6:8] + b[4:6] + b[2:4] + b[0:2]
        return b[6:8] + b[4:6] + b[2:4] + b[0:2]

    with open(OUTPUT, 'w') as f:
        f.write(verilog_head % (INPUT,))
        for i in range(0, len(s), 8):
            instr_string = str(byte_wise_reverse(s[i:i+8]))
            if instr_string[1] == "'":
                instr_string = instr_string[2:]
            instr_string = instr_string.strip("'")
            f.write('    ram_cell[%8d] = 32\'h%s;\n' % (i//8, instr_string, ))
        f.write(verilog_tail)
    
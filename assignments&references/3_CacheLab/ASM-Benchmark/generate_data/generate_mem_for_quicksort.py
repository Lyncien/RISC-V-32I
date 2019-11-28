# -*- coding:utf-8 -*-
# Python2 or Python3
# Author : WangXuan
# 
# 功能： 生成针对于快速排序(matmul)的 mem.sv ，里面存放即将被排序的数据
# 

verilog_head = '''
module mem #(                   // 
    parameter  ADDR_LEN  = 11   // 
) (
    input  clk, rst,
    input  [ADDR_LEN-1:0] addr, // memory address
    output reg [31:0] rd_data,  // data read out
    input  wr_req,
    input  [31:0] wr_data       // data write in
);
localparam MEM_SIZE = 1<<ADDR_LEN;
reg [31:0] ram_cell [MEM_SIZE];

always @ (posedge clk or posedge rst)
    if(rst)
        rd_data <= 0;
    else
        rd_data <= ram_cell[addr];

always @ (posedge clk)
    if(wr_req) 
        ram_cell[addr] <= wr_data;

initial begin'''

verilog_tail = '''end

endmodule
'''

import sys
from random import shuffle

if len(sys.argv) != 2:
    print('    Usage:\n        python generate_mem_for_quicksort.py [matrix size]')
    print('    Example:\n        python generate_mem_for_quicksort.py 16')
    print('    Tip: use this command to write to file:\n        python generate_mem_for_quicksort.py 16 > mem.sv')
else:
    try:
        N = int( sys.argv[1] )
    except:
        print('    *** Error: parameter must be integer, not %s' % (sys.argv[1], ) )
        sys.exit(-1)
    if N<=2:
        print('    *** Error: parameter must be larger than 2, not %d' % (N, ) )
        sys.exit(-1)

    print(verilog_head)
    
    lst = list(range(N))
    shuffle(lst)
    for i in range(N):
        print("    ram_cell[%8d] = 32'h%08x;" % ( i, lst[i], ) )
    
    print(verilog_tail)


# -*- coding:utf-8 -*-
# Python2 or Python3
# Author : WangXuan
# 
# 功能： 生成针对于矩阵乘法(matmul)的 mem.v ，里面存放两个要进行相乘的初始矩阵
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
from random import randint

if len(sys.argv) != 2:
    print('    Usage:\n        python generate_mem_for_matmul.py [matrix size]')
    print('    Example:\n        python generate_mem_for_matmul.py 16')
    print('    Tip: use this command to write to file:\n        python generate_mem_for_matmul.py 16 > mem.sv')
else:
    try:
        N = int( sys.argv[1] )
    except:
        print('    *** Error: parameter must be integer, not %s' % (sys.argv[1], ) )
        sys.exit(-1)
    if N<=1:
        print('    *** Error: parameter must be larger than 1, not %d' % (N, ) )
        sys.exit(-1)

    print(verilog_head)
    
    A, B, C = [], [], []
    for i in range(N):
        Aline, Bline, Cline = [], [], []
        for j in range(N):
            Aline.append( randint(0,0xffffffff) )
            Bline.append( randint(0,0xffffffff) )
            Cline.append( 0 )
        A.append(Aline)
        B.append(Bline)
        C.append(Cline)
    
    for i in range(N):
        for j in range(N):
            for k in range(N):
                C[i][j] += A[i][k] & B[k][j]
    
    print('    // dst matrix C')
    for i in range(N):
        for j in range(N):
            print("    ram_cell[%8d] = 32'h0;  // 32'h%08x;" % ( N*i+j, C[i][j] & 0xffffffff, ) )
    print('    // src matrix A')
    for i in range(N):
        for j in range(N):
            print("    ram_cell[%8d] = 32'h%08x;" % (   N*N+N*i+j, A[i][j], ) )
    print('    // src matrix B')
    for i in range(N):
        for j in range(N):
            print("    ram_cell[%8d] = 32'h%08x;" % ( 2*N*N+N*i+j, B[i][j], ) )
    
    print(verilog_tail)


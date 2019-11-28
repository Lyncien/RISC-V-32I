# -*- coding:utf-8 -*-
# Python2 or Python3
# Author : WangXuan
# 
# 功能： 生成 cache_tb.v ， 即针对cache的testbench
# 

verilog_head = '''
module cache_tb();

`define DATA_COUNT (%d)
`define RDWR_COUNT (6*`DATA_COUNT)

reg wr_cycle           [`RDWR_COUNT];
reg rd_cycle           [`RDWR_COUNT];
reg [31:0] addr_rom    [`RDWR_COUNT];
reg [31:0] wr_data_rom [`RDWR_COUNT];
reg [31:0] validation_data [`DATA_COUNT];

initial begin
'''

verilog_tail = '''
end


reg clk = 1'b1, rst = 1'b1;
initial #4 rst = 1'b0;
always  #1 clk = ~clk;

wire  miss;
wire [31:0] rd_data;
reg  [31:0] index = 0, wr_data = 0, addr = 0;
reg  rd_req = 1'b0, wr_req = 1'b0;
reg rd_req_ff = 1'b0, miss_ff = 1'b0;
reg [31:0] validation_count = 0;

always @ (posedge clk or posedge rst)
    if(rst) begin
        rd_req_ff <= 1'b0;
        miss_ff   <= 1'b0;
    end else begin
        rd_req_ff <= rd_req;
        miss_ff   <= miss;
    end

always @ (posedge clk or posedge rst)
    if(rst) begin
        validation_count <= 0;
    end else begin
        if(validation_count>=`DATA_COUNT) begin
            validation_count <= 'hffffffff;
        end else if(rd_req_ff && (index>(4*`DATA_COUNT))) begin
            if(~miss_ff) begin
                if(validation_data[validation_count]==rd_data)
                    validation_count <= validation_count+1;
                else
                    validation_count <= 0;
            end
        end else begin
            validation_count <= 0;
        end
    end

always @ (posedge clk or posedge rst)
    if(rst) begin
        index   <= 0;
        wr_data <= 0;
        addr    <= 0;
        rd_req  <= 1'b0;
        wr_req  <= 1'b0;
    end else begin
        if(~miss) begin
            if(index<`RDWR_COUNT) begin
                if(wr_cycle[index]) begin
                    rd_req  <= 1'b0;
                    wr_req  <= 1'b1;
                end else if(rd_cycle[index]) begin
                    wr_data <= 0;
                    rd_req  <= 1'b1;
                    wr_req  <= 1'b0;
                end else begin
                    wr_data <= 0;
                    rd_req  <= 1'b0;
                    wr_req  <= 1'b0;
                end
                wr_data <= wr_data_rom[index];
                addr    <= addr_rom[index];
                index <= index + 1;
            end else begin
                wr_data <= 0;
                addr    <= 0;
                rd_req  <= 1'b0;
                wr_req  <= 1'b0;
            end
        end
    end

cache #(
    .LINE_ADDR_LEN  ( 3             ),
    .SET_ADDR_LEN   ( 2             ),
    .TAG_ADDR_LEN   ( 12            ),
    .WAY_CNT        ( 3             )
) cache_test_instance (
    .clk            ( clk           ),
    .rst            ( rst           ),
    .miss           ( miss          ),
    .addr           ( addr          ),
    .rd_req         ( rd_req        ),
    .rd_data        ( rd_data       ),
    .wr_req         ( wr_req        ),
    .wr_data        ( wr_data       )
);

endmodule
'''


import sys
from random import randint

if len(sys.argv) != 2:
    print('    Usage:\n        python generate_cache_tb.py [write words]')
    print('    Example:\n        python generate_cache_tb.py 16')
    print('    Tip: use this command to write to file:\n        python generate_cache_tb.py 16 > cache_tb.v')
else:
    try:
        N = int( sys.argv[1] )
    except:
        print('    *** Error: parameter must be integer, not %s' % (sys.argv[1], ) )
        sys.exit(-1)
    
    result = []
    verilog = verilog_head % (N,)
    
    verilog += "    // %d sequence write cycles\n" % (N,)
    for i in range( N ):
        writeval = randint(0, 4*N)
        result.append( writeval )
        verilog += "    rd_cycle[%5d] = 1'b0;  wr_cycle[%5d] = 1'b1;  addr_rom[%5d]='h%08x;  wr_data_rom[%5d]='h%08x;\n" % (i, i, i, i*4, i, writeval)
    
    verilog += "    // %d random read and write cycles\n" % (3*N,)
    for i in range( N, 4*N ):
        rd_wr_addr = randint(0, N-1)
        if randint(0,1)==0:
            writeval = randint(0, 4*N)
            result[rd_wr_addr] = writeval
            verilog += "    rd_cycle[%5d] = 1'b0;  wr_cycle[%5d] = 1'b1;  addr_rom[%5d]='h%08x;  wr_data_rom[%5d]='h%08x;\n" % (i, i, i, rd_wr_addr*4, i, writeval)
        else:
            verilog += "    rd_cycle[%5d] = 1'b1;  wr_cycle[%5d] = 1'b0;  addr_rom[%5d]='h%08x;  wr_data_rom[%5d]='h%08x;\n" % (i, i, i, rd_wr_addr*4, i, 0)
    
    verilog += "    // %d silence cycles\n" % (N,)
    for i in range( 4*N, 5*N ):
        verilog += "    rd_cycle[%5d] = 1'b0;  wr_cycle[%5d] = 1'b0;  addr_rom[%5d]='h%08x;  wr_data_rom[%5d]='h%08x;\n" % (i, i, i, 0, i, 0)

    verilog += "    // %d sequence read cycles\n" % (N,)
    for i in range( 5*N, 6*N ):
        verilog += "    rd_cycle[%5d] = 1'b1;  wr_cycle[%5d] = 1'b0;  addr_rom[%5d]='h%08x;  wr_data_rom[%5d]='h%08x;\n" % (i, i, i, (i-5*N)*4, i, 0)
        
    verilog += 'end\n\ninitial begin\n' 
    for i,res in enumerate(result):
        verilog += "    validation_data[%5d] = 'h%08x; \n" % (i, res)
    verilog += verilog_tail
    
    res_str = '`timescale 1ns/100ps\n//correct read result:\n//'
    for res in result:
        res_str += ' %08x' % (res, )
    print(res_str)
    print(verilog)
    
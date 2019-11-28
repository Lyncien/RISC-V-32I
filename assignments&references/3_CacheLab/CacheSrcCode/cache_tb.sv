`timescale 1ns/100ps
//correct read result:
// 0000000c 00000011 0000000c 00000005 0000000b 00000000 00000008 00000005

module cache_tb();

`define DATA_COUNT (8)
`define RDWR_COUNT (6*`DATA_COUNT)

reg wr_cycle           [`RDWR_COUNT];
reg rd_cycle           [`RDWR_COUNT];
reg [31:0] addr_rom    [`RDWR_COUNT];
reg [31:0] wr_data_rom [`RDWR_COUNT];
reg [31:0] validation_data [`DATA_COUNT];

initial begin
    // 8 sequence write cycles
    rd_cycle[    0] = 1'b0;  wr_cycle[    0] = 1'b1;  addr_rom[    0]='h00000000;  wr_data_rom[    0]='h0000001b;
    rd_cycle[    1] = 1'b0;  wr_cycle[    1] = 1'b1;  addr_rom[    1]='h00000004;  wr_data_rom[    1]='h0000001c;
    rd_cycle[    2] = 1'b0;  wr_cycle[    2] = 1'b1;  addr_rom[    2]='h00000008;  wr_data_rom[    2]='h00000014;
    rd_cycle[    3] = 1'b0;  wr_cycle[    3] = 1'b1;  addr_rom[    3]='h0000000c;  wr_data_rom[    3]='h00000005;
    rd_cycle[    4] = 1'b0;  wr_cycle[    4] = 1'b1;  addr_rom[    4]='h00000010;  wr_data_rom[    4]='h00000016;
    rd_cycle[    5] = 1'b0;  wr_cycle[    5] = 1'b1;  addr_rom[    5]='h00000014;  wr_data_rom[    5]='h00000002;
    rd_cycle[    6] = 1'b0;  wr_cycle[    6] = 1'b1;  addr_rom[    6]='h00000018;  wr_data_rom[    6]='h00000008;
    rd_cycle[    7] = 1'b0;  wr_cycle[    7] = 1'b1;  addr_rom[    7]='h0000001c;  wr_data_rom[    7]='h00000003;
    // 24 random read and write cycles
    rd_cycle[    8] = 1'b0;  wr_cycle[    8] = 1'b1;  addr_rom[    8]='h00000008;  wr_data_rom[    8]='h0000000f;
    rd_cycle[    9] = 1'b0;  wr_cycle[    9] = 1'b1;  addr_rom[    9]='h00000008;  wr_data_rom[    9]='h0000000c;
    rd_cycle[   10] = 1'b0;  wr_cycle[   10] = 1'b1;  addr_rom[   10]='h0000001c;  wr_data_rom[   10]='h00000013;
    rd_cycle[   11] = 1'b1;  wr_cycle[   11] = 1'b0;  addr_rom[   11]='h0000001c;  wr_data_rom[   11]='h00000000;
    rd_cycle[   12] = 1'b1;  wr_cycle[   12] = 1'b0;  addr_rom[   12]='h0000001c;  wr_data_rom[   12]='h00000000;
    rd_cycle[   13] = 1'b1;  wr_cycle[   13] = 1'b0;  addr_rom[   13]='h00000008;  wr_data_rom[   13]='h00000000;
    rd_cycle[   14] = 1'b1;  wr_cycle[   14] = 1'b0;  addr_rom[   14]='h00000008;  wr_data_rom[   14]='h00000000;
    rd_cycle[   15] = 1'b1;  wr_cycle[   15] = 1'b0;  addr_rom[   15]='h00000000;  wr_data_rom[   15]='h00000000;
    rd_cycle[   16] = 1'b0;  wr_cycle[   16] = 1'b1;  addr_rom[   16]='h00000018;  wr_data_rom[   16]='h00000008;
    rd_cycle[   17] = 1'b1;  wr_cycle[   17] = 1'b0;  addr_rom[   17]='h00000010;  wr_data_rom[   17]='h00000000;
    rd_cycle[   18] = 1'b0;  wr_cycle[   18] = 1'b1;  addr_rom[   18]='h00000000;  wr_data_rom[   18]='h0000001e;
    rd_cycle[   19] = 1'b1;  wr_cycle[   19] = 1'b0;  addr_rom[   19]='h00000014;  wr_data_rom[   19]='h00000000;
    rd_cycle[   20] = 1'b1;  wr_cycle[   20] = 1'b0;  addr_rom[   20]='h00000000;  wr_data_rom[   20]='h00000000;
    rd_cycle[   21] = 1'b1;  wr_cycle[   21] = 1'b0;  addr_rom[   21]='h00000000;  wr_data_rom[   21]='h00000000;
    rd_cycle[   22] = 1'b0;  wr_cycle[   22] = 1'b1;  addr_rom[   22]='h0000001c;  wr_data_rom[   22]='h00000005;
    rd_cycle[   23] = 1'b1;  wr_cycle[   23] = 1'b0;  addr_rom[   23]='h00000008;  wr_data_rom[   23]='h00000000;
    rd_cycle[   24] = 1'b0;  wr_cycle[   24] = 1'b1;  addr_rom[   24]='h00000014;  wr_data_rom[   24]='h00000000;
    rd_cycle[   25] = 1'b1;  wr_cycle[   25] = 1'b0;  addr_rom[   25]='h00000008;  wr_data_rom[   25]='h00000000;
    rd_cycle[   26] = 1'b0;  wr_cycle[   26] = 1'b1;  addr_rom[   26]='h00000000;  wr_data_rom[   26]='h0000000c;
    rd_cycle[   27] = 1'b1;  wr_cycle[   27] = 1'b0;  addr_rom[   27]='h00000010;  wr_data_rom[   27]='h00000000;
    rd_cycle[   28] = 1'b0;  wr_cycle[   28] = 1'b1;  addr_rom[   28]='h00000010;  wr_data_rom[   28]='h0000000b;
    rd_cycle[   29] = 1'b1;  wr_cycle[   29] = 1'b0;  addr_rom[   29]='h0000000c;  wr_data_rom[   29]='h00000000;
    rd_cycle[   30] = 1'b0;  wr_cycle[   30] = 1'b1;  addr_rom[   30]='h00000004;  wr_data_rom[   30]='h00000011;
    rd_cycle[   31] = 1'b1;  wr_cycle[   31] = 1'b0;  addr_rom[   31]='h0000001c;  wr_data_rom[   31]='h00000000;
    // 8 silence cycles
    rd_cycle[   32] = 1'b0;  wr_cycle[   32] = 1'b0;  addr_rom[   32]='h00000000;  wr_data_rom[   32]='h00000000;
    rd_cycle[   33] = 1'b0;  wr_cycle[   33] = 1'b0;  addr_rom[   33]='h00000000;  wr_data_rom[   33]='h00000000;
    rd_cycle[   34] = 1'b0;  wr_cycle[   34] = 1'b0;  addr_rom[   34]='h00000000;  wr_data_rom[   34]='h00000000;
    rd_cycle[   35] = 1'b0;  wr_cycle[   35] = 1'b0;  addr_rom[   35]='h00000000;  wr_data_rom[   35]='h00000000;
    rd_cycle[   36] = 1'b0;  wr_cycle[   36] = 1'b0;  addr_rom[   36]='h00000000;  wr_data_rom[   36]='h00000000;
    rd_cycle[   37] = 1'b0;  wr_cycle[   37] = 1'b0;  addr_rom[   37]='h00000000;  wr_data_rom[   37]='h00000000;
    rd_cycle[   38] = 1'b0;  wr_cycle[   38] = 1'b0;  addr_rom[   38]='h00000000;  wr_data_rom[   38]='h00000000;
    rd_cycle[   39] = 1'b0;  wr_cycle[   39] = 1'b0;  addr_rom[   39]='h00000000;  wr_data_rom[   39]='h00000000;
    // 8 sequence read cycles
    rd_cycle[   40] = 1'b1;  wr_cycle[   40] = 1'b0;  addr_rom[   40]='h00000000;  wr_data_rom[   40]='h00000000;
    rd_cycle[   41] = 1'b1;  wr_cycle[   41] = 1'b0;  addr_rom[   41]='h00000004;  wr_data_rom[   41]='h00000000;
    rd_cycle[   42] = 1'b1;  wr_cycle[   42] = 1'b0;  addr_rom[   42]='h00000008;  wr_data_rom[   42]='h00000000;
    rd_cycle[   43] = 1'b1;  wr_cycle[   43] = 1'b0;  addr_rom[   43]='h0000000c;  wr_data_rom[   43]='h00000000;
    rd_cycle[   44] = 1'b1;  wr_cycle[   44] = 1'b0;  addr_rom[   44]='h00000010;  wr_data_rom[   44]='h00000000;
    rd_cycle[   45] = 1'b1;  wr_cycle[   45] = 1'b0;  addr_rom[   45]='h00000014;  wr_data_rom[   45]='h00000000;
    rd_cycle[   46] = 1'b1;  wr_cycle[   46] = 1'b0;  addr_rom[   46]='h00000018;  wr_data_rom[   46]='h00000000;
    rd_cycle[   47] = 1'b1;  wr_cycle[   47] = 1'b0;  addr_rom[   47]='h0000001c;  wr_data_rom[   47]='h00000000;
end

initial begin
    validation_data[    0] = 'h0000000c; 
    validation_data[    1] = 'h00000011; 
    validation_data[    2] = 'h0000000c; 
    validation_data[    3] = 'h00000005; 
    validation_data[    4] = 'h0000000b; 
    validation_data[    5] = 'h00000000; 
    validation_data[    6] = 'h00000008; 
    validation_data[    7] = 'h00000005; 

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


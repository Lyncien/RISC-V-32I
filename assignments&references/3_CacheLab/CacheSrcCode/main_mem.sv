
module main_mem #(                  // 主存，每次读写以line 为单位
    parameter  LINE_ADDR_LEN =  3,  // line内地址长度，决定了每个line具有 2^LINE_ADDR_LEN 个 word
    parameter  ADDR_LEN  = 8        // 主存地址长度，决定了主存具有 2^ADDR_LEN 个 line
)(
    input  clk, rst,
    output gnt,                     // read or write grant
    input  [ADDR_LEN-1:0] addr,     // line地址
    input  rd_req,
    output reg [31:0] rd_line [1<<LINE_ADDR_LEN],
    input  wr_req,
    input  [31:0] wr_line [1<<LINE_ADDR_LEN]
);

localparam  RD_CYCLE = 50;
localparam  WR_CYCLE = 50;
localparam LINE_SIZE = 1<<LINE_ADDR_LEN;

reg  mem_wr_req = 1'b0;
reg  [(ADDR_LEN+LINE_ADDR_LEN)-1:0] mem_addr = 0;
reg  [31:0] mem_wr_data = 0;
wire [31:0] mem_rd_data;

mem #(
    .ADDR_LEN  ( ADDR_LEN + LINE_ADDR_LEN    )
) mem_inst (
    .clk       (  clk           ),
    .rst       (  rst           ),
    .addr      (  mem_addr      ),
    .rd_data   (  mem_rd_data   ),
    .wr_req    (  mem_wr_req    ),
    .wr_data   (  mem_wr_data   )
);

reg  [31:0] rd_delay = 0, wr_delay = 0;
wire rd_ok = (rd_delay >= RD_CYCLE);
wire wr_ok = (wr_delay >= WR_CYCLE);
reg  rd_cycle, wr_cycle;
reg  [ADDR_LEN-1:0] addr_last = 0;
reg [31:0] rd_line_latch [LINE_SIZE];
wire [LINE_ADDR_LEN-1:0] wr_line_addr = wr_delay-(WR_CYCLE-LINE_SIZE);
wire [LINE_ADDR_LEN-1:0] rd_line_addr = rd_delay-1;
wire [LINE_ADDR_LEN-1:0] rd_out_line_addr = rd_delay-3;

assign gnt = (rd_cycle & rd_ok) | (wr_cycle & wr_ok);

always @ (posedge clk or posedge rst)
    if(rst)
        addr_last <= 0;
    else
        addr_last <= addr;

always @ (*) begin
    rd_cycle = 1'b0;
    wr_cycle = 1'b0;
    if(addr_last == addr)
        if(rd_req)
            rd_cycle = 1'b1;
        else if(wr_req)
            wr_cycle = 1'b1;
end

always @ (posedge clk or posedge rst)    // ?????
    if(rst) begin
        mem_wr_req = 1'b0;
        mem_addr   = 0;
        mem_wr_data= 0;
    end else begin
        mem_wr_req = 1'b0;
        mem_addr   = 0;
        mem_wr_data= 0;
        if (wr_cycle) begin
            rd_delay <= 0;
            if(wr_ok) begin
                wr_delay <= 0;
            end else begin
                if(wr_delay>=(WR_CYCLE-LINE_SIZE)) begin
                    mem_wr_req  = 1'b1;
                    mem_addr    = {addr, wr_line_addr};
                    mem_wr_data = wr_line[wr_line_addr];
                end
                wr_delay <= wr_delay + 1;
            end
        end else if(rd_cycle) begin
            wr_delay <= 0;
            if(rd_ok) begin
                rd_line <= rd_line_latch;
            end else begin
                if(rd_delay>=1 && rd_delay<1+LINE_SIZE) begin
                    mem_addr    = {addr, rd_line_addr};
                end
                if(rd_delay>=3 && rd_delay<3+LINE_SIZE) begin
                    rd_line_latch[rd_out_line_addr] <= mem_rd_data;
                end
                rd_delay <= rd_delay + 1;
            end
        end else begin
            rd_delay <= 0;
            wr_delay <= 0;
        end
    end
    
endmodule
// asm file name: MatMul.S
module InstructionRam(
    input  clk, rst,
    input  [ 3:0] wea,
    input  [11:0] addra,
    input  [31:0] dina ,
    output reg [31:0] douta
);
initial begin douta=0;end

reg [31:0] ram_cell[1024];

initial begin
    ram_cell[       0] = 32'h00404713;
    ram_cell[       1] = 32'h00404693;
    ram_cell[       2] = 32'h00e696b3;
    ram_cell[       3] = 32'h00004633;
    ram_cell[       4] = 32'h00e69533;
    ram_cell[       5] = 32'h00a505b3;
    ram_cell[       6] = 32'h000042b3;
    ram_cell[       7] = 32'h00004333;
    ram_cell[       8] = 32'h00004e33;
    ram_cell[       9] = 32'h000043b3;
    ram_cell[      10] = 32'h00e29eb3;
    ram_cell[      11] = 32'h007e8eb3;
    ram_cell[      12] = 32'h00ae8eb3;
    ram_cell[      13] = 32'h000eae83;
    ram_cell[      14] = 32'h00e39f33;
    ram_cell[      15] = 32'h006f0f33;
    ram_cell[      16] = 32'h00bf0f33;
    ram_cell[      17] = 32'h000f2f03;
    ram_cell[      18] = 32'h01eefeb3;
    ram_cell[      19] = 32'h01de0e33;
    ram_cell[      20] = 32'h00438393;
    ram_cell[      21] = 32'hfcd3cae3;
    ram_cell[      22] = 32'h00e29eb3;
    ram_cell[      23] = 32'h006e8eb3;
    ram_cell[      24] = 32'h00ce8eb3;
    ram_cell[      25] = 32'h01cea023;
    ram_cell[      26] = 32'h00430313;
    ram_cell[      27] = 32'hfad34ae3;
    ram_cell[      28] = 32'h00428293;
    ram_cell[      29] = 32'hfad2c4e3;
    ram_cell[      30] = 32'h0000006f;

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

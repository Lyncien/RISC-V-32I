
`define LRU 1 //注释掉就是FIFO策略
module cache #(
    parameter  LINE_ADDR_LEN = 3, // line(块/行)内地址长度，决定了每个line具有2^3个word
    parameter  SET_ADDR_LEN  = 3, // set(组)地址长度，决定了一共有2^3=8组
    parameter  TAG_ADDR_LEN  = 7, // tag长度
    parameter  WAY_CNT       = 3  // 组相连度，决定了每组中有多少路line
)(
    input  clk, rst,
    output miss,               // 对CPU发出的miss信号
    input  [31:0] addr,        // 读写请求地址
    input  rd_req,             // 读请求信号
    output reg [31:0] rd_data, // 读出的数据，一次读一个word
    input  wr_req,             // 写请求信号
    input  [31:0] wr_data      // 要写入的数据，一次写一个word
);
localparam WORD_ADDR_LEN   = 2;
localparam MEM_ADDR_LEN    = TAG_ADDR_LEN + SET_ADDR_LEN ;      // 计算主存地址长度 MEM_ADDR_LEN，主存大小=2^MEM_ADDR_LEN个line
localparam UNUSED_ADDR_LEN = 32 - MEM_ADDR_LEN - LINE_ADDR_LEN - WORD_ADDR_LEN; // 计算未使用的地址的长度

localparam LINE_SIZE       = 1 << LINE_ADDR_LEN  ;         // 计算 line 中 word 的数量，即 2^LINE_ADDR_LEN 个word 每 line
localparam SET_SIZE        = 1 << SET_ADDR_LEN   ;         // 计算一共有多少组，即 2^SET_ADDR_LEN 个组

reg [              31 : 0] cache    [SET_SIZE][WAY_CNT][LINE_SIZE]; // SET_SIZE个组，每组WAY_CNT个line，每个line有LINE_SIZE个word
reg [TAG_ADDR_LEN - 1 : 0] tag      [SET_SIZE][WAY_CNT];            // SET_SIZE个组，每组WAY_CNT个TAG
reg                        valid    [SET_SIZE][WAY_CNT];            // SET_SIZE个组，每组WAY_CNT个valid(有效位)
reg                        dirty    [SET_SIZE][WAY_CNT];            // SET_SIZE个组，每组WAY_CNT个dirty(脏位)

wire [  WORD_ADDR_LEN - 1 : 0]   word_addr;
wire [  LINE_ADDR_LEN - 1 : 0]   line_addr;
wire [   SET_ADDR_LEN - 1 : 0]    set_addr;
wire [   TAG_ADDR_LEN - 1 : 0]    tag_addr;
wire [UNUSED_ADDR_LEN - 1 : 0] unused_addr;
assign {unused_addr, tag_addr, set_addr, line_addr, word_addr} = addr;  // 拆分 32bit 输入地址ADDR 拆分成这5个部分

enum  {IDLE, SWAP_OUT, SWAP_IN, SWAP_IN_OK} cache_stat;    // cache 状态机的状态定义
                                                           // IDLE代表就绪，SWAP_OUT代表正在换出，SWAP_IN代表正在换入，SWAP_IN_OK代表换入后进行一周期的写入cache操作。

reg  [   SET_ADDR_LEN - 1 : 0] mem_rd_set_addr = 0;
reg  [   TAG_ADDR_LEN - 1 : 0] mem_rd_tag_addr = 0;
wire [   MEM_ADDR_LEN - 1 : 0] mem_rd_addr = {mem_rd_tag_addr, mem_rd_set_addr};
reg  [   MEM_ADDR_LEN - 1 :0 ] mem_wr_addr = 0;
reg  [31 : 0] mem_wr_line [LINE_SIZE];
wire [31 : 0] mem_rd_line [LINE_SIZE];
wire mem_rd_req = (cache_stat == SWAP_IN );
wire mem_wr_req = (cache_stat == SWAP_OUT);
wire [   MEM_ADDR_LEN - 1 : 0] mem_addr = mem_rd_req ? mem_rd_addr : ( mem_wr_req ? mem_wr_addr : 0);
wire mem_gnt;      // 主存响应读写的握手信号


reg hit = 0; //是否命中
integer hit_way = -1; //命中的路
always @ (*) begin      // 判断 输入的address 是否在 cache 中命中
	for(integer way = 0; way < WAY_CNT; way++)
		if(valid[set_addr][way] && tag[set_addr][way] == tag_addr) begin //如果 cache line有效，并且tag与输入地址中的tag相等，则命中
			hit = 1'b1;
			hit_way = way;
			break; //之前忘记break了，导致hit几乎总是0
		end else begin
			hit = 1'b0;
			hit_way = -1;
		end
end

assign miss = (rd_req | wr_req) & ~(hit && cache_stat == IDLE) ; 
// 当有读写请求时，如果cache不处于就绪(IDLE)状态，或者未命中，则miss=1

integer swap_way[SET_SIZE]; //(每个组)(下一次)进行换入/换出的路
`ifdef LRU
integer way_age[SET_SIZE][WAY_CNT];
//int queue[$];
integer max_age_way;
integer max_age;
`endif
always @ (posedge clk or posedge rst) begin // ?? cache ???
	if(rst) begin
		cache_stat <= IDLE;
		for(integer i = 0; i < SET_SIZE; i++) begin
			swap_way[i] <= 0;
			for(integer j = 0; j < WAY_CNT; j++) begin
				dirty[i][j] <= 1'b0;
				valid[i][j] <= 1'b0;
`ifdef LRU
				way_age[i][j] <= 0;
`endif
				end
		end
		for(integer k = 0; k < LINE_SIZE; k++)
			mem_wr_line[k] <= 0;
		mem_wr_addr <= 0;
		{mem_rd_tag_addr, mem_rd_set_addr} <= 0;
		rd_data <= 0;
`ifdef LRU
		max_age <= 0;
		max_age_way <= 0;
`endif
		end else begin
		case(cache_stat)
			IDLE: //就绪状态
				begin
					if(hit) begin //如果cache命中
						if(rd_req) begin    //是读请求
							rd_data <= cache[set_addr][hit_way][line_addr];   //则直接从cache中取出要读的数据
						end else if(wr_req) begin //是写请求
							cache[set_addr][hit_way][line_addr] <= wr_data;   // 则直接向cache中写入数据
							dirty[set_addr][hit_way] <= 1'b1;                 // 写数据的同时置脏位
						end 
`ifdef LRU
						if(rd_req | wr_req) begin//更新各way年龄，更新下一次替换应该选择的way
							for(integer way = 0; way < WAY_CNT; way++)
								if(way == hit_way)
									way_age[set_addr][way] <= 0;
								else
									way_age[set_addr][way] <= way_age[set_addr][way] + 1;
							//queue = way_age[set_addr].find_first_index(age) with (age == way_age[set_addr].max);
							for(integer way = 0; way < WAY_CNT; way++)
								if(way_age[set_addr][way] > max_age) begin
									max_age = way_age[set_addr][way];
									max_age_way = way;
								end
							swap_way[set_addr] <= max_age_way;
							max_age_way <= 0;
						end
`endif
					end else begin //如果cache未命中
						if(wr_req | rd_req) begin   //有读写请求，则需要进行换入
							if( valid[set_addr][swap_way[set_addr]] & dirty[set_addr][swap_way[set_addr]] ) begin // 如果要换入的cache line本来有效，且脏，则需要先将它换出
								cache_stat  <= SWAP_OUT;
								mem_wr_addr <= { tag[set_addr][swap_way[set_addr]], set_addr };
								mem_wr_line <= cache[set_addr][swap_way[set_addr]];
							end else begin          // 反之，不需要换出，直接换入
								cache_stat  <= SWAP_IN;
							end
							{mem_rd_tag_addr, mem_rd_set_addr} <= {tag_addr, set_addr};
						end
					end
				end
			SWAP_OUT: //换出状态，脏数据将写回主存
				begin
					if(mem_gnt) begin           // 如果主存握手信号有效，说明换出成功，跳到下一状态
						cache_stat <= SWAP_IN;
					end
				end
			SWAP_IN: //换入状态，从主存读取数据
				begin
					if(mem_gnt) begin           // 如果主存握手信号有效，说明换入成功，跳到下一状态
						cache_stat <= SWAP_IN_OK;
					end
				end
			SWAP_IN_OK: //换入完成状态
				begin   //这周期将主存读出的line写入cache，并更新tag，置高valid，置低dirty
					for(integer i = 0; i < LINE_SIZE; i++)
						cache[mem_rd_set_addr][swap_way[mem_rd_set_addr]][i] <= mem_rd_line[i];
					tag  [mem_rd_set_addr][swap_way[mem_rd_set_addr]] <= mem_rd_tag_addr;
					valid[mem_rd_set_addr][swap_way[mem_rd_set_addr]] <= 1'b1;
					dirty[mem_rd_set_addr][swap_way[mem_rd_set_addr]] <= 1'b0;
					cache_stat                             <= IDLE;    // 回到就绪状态
`ifdef LRU
					for(integer way = 0; way < WAY_CNT; way++)//更新各way年龄，更新下一次替换应该选择的way
						if(way == hit_way)
							way_age[mem_rd_set_addr][way] <= 0;
						else
							way_age[mem_rd_set_addr][way] <= way_age[mem_rd_set_addr][way] + 1;
					//queue = way_age[mem_rd_set_addr].find_first_index(age) with (age == way_age[mem_rd_set_addr].max);
					for(integer way = 0; way < WAY_CNT; way++)
						if(way_age[mem_rd_set_addr][way] > max_age) begin
							max_age = way_age[mem_rd_set_addr][way];
							max_age_way = way;
						end
					swap_way[mem_rd_set_addr] <= max_age_way;
					max_age_way <= 0;
`else
					if(swap_way[mem_rd_set_addr] == WAY_CNT - 1)
						swap_way[mem_rd_set_addr] <= 0;
					else
						swap_way[mem_rd_set_addr] <= swap_way[mem_rd_set_addr] + 1;
`endif
				end
		endcase
	end
end

main_mem #(     // slow main memory
    .LINE_ADDR_LEN  ( LINE_ADDR_LEN          ),
    .ADDR_LEN       ( MEM_ADDR_LEN           )
) main_mem_instance (
    .clk            ( clk                    ),
    .rst            ( rst                    ),
    .gnt            ( mem_gnt                ),
    .addr           ( mem_addr               ),
    .rd_req         ( mem_rd_req             ),
    .rd_line        ( mem_rd_line            ),
    .wr_req         ( mem_wr_req             ),
    .wr_line        ( mem_wr_line            )
);

endmodule






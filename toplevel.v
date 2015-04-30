`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*Big To-Do:
	
	1.) Finish instantiating modules
	2.) Create pipelines
	3.) 


*/
//
//////////////////////////////////////////////////////////////////////////////////
module toplevel(clk, input_bus, output_bus, valid_input, valid_output, reset, Y1out, Y2out, Y3out, ALU_out
    );
	 
	parameter n = 32;

	input clk, reset;
	input [n-1:0] input_bus;
	input valid_input;
	output [n-1:0] output_bus;
	output reg valid_output;
	
	output [4:0] Y1out;
	output [6:0] Y2out;
	output [1:0] Y3out;
	
	output [0:31] ALU_out;
	

	

	//wire busses

	wire [0:235] r; //235 ram communication line
	wire [0:16] s; //17 select linse
	wire [0:191] u; //192 wires for registry output
	wire [0:188] w; //157 wires: STAGE 1 Communication
	wire [0:400] x; //337 wires: STAGE 2 Communication  (needs to be broken up for stage 3)
	control CONTROL(clk,reset,IDV,x[290],x[256:287],x[289],w[111],x[295],w[117:148],
						w[0],w[1],w[112:115],w[4],w[110],w[2],
						s[0],s[1],s[2],s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11],s[12],s[13],s[14],s[15],s[16],
						x[294],x[293],x[296],x[297],x[298],x[299],x[300],x[301],x[302],x[303],ODV,x[292],w[5],
						w[54],w[55],w[56],w[57],w[3],w[116],LPSR2,ISEL,LSEL, Y1out, Y2out, Y3out);
	//STAGE 1 MODULES: INSTRUCTION FETCH
	//========================================================================================
	//MHVPIS
	//TO DO: Check that MHVPIS inputs/outputs are lines up correctly across
	//			the different instantiations
	MHVPIS mhvpis  (w[112:115], w[106:109], clk, w[4], w[0], w[1], w[5], w[14:21]);
	//MUX1: input to PC
	Mux4to1_8Bit MUX1 (s[0:1], {w[14:21], w[6:13], w[22:29], w[30:37] }, w[38:45]);
	//MUX2: input to MAR1
	Mux2to1_8Bit MUX2 (s[16], {w[46:53],w[22:29]}, w[149:156]);
	//mux3: input to R6 load line
	Mux2to1_8Bit MUX3 (s[2], {w[46:53],w[6:13]}, w[58:65]);

	LdStrRegParam #( 8 ) R6 (w[149:156], w[30:37], w[54], rst, 0, clk); 
	LdStrRegParam #( 8 ) R7 (w[46:53], w[22:29], w[55], rst, 0, clk); 
	//PC
	PrgmCntr PC (clk, 1'b0, w[38:45], w[46:53], w[56], w[57]);
	//MAR1
	LdStrRegParam #( 8 ) MAR1 (w[58:65], w[66:73], w[3], rst, 0, clk); 
	//IR
	PosNegLdStrReg # ( 32 ) IR1 (w[74:105],w[117:148], w[2], rst, 0, clk);
	//instruction cache
	Cache Instr_Cache (w[66:73], w[74:105], 8'b0000000, w[110], 1'b0, w[111], clk, r[0:7], r[8:39], r[86:118], r[41], r[40],  r[42]);
	//instruction delay
	DataDelay mem_delay_1 (r[0:7], r[8:39], r[41], r[40], r[42], r[43:50], r[51:82], r[84], r[83], r[85], clk);
	//instruction ram
	//TODO: Ian they had this removed, but it needs to be in. We'll have to look at this
	RAM Instr_RAM (r[51:82], r[86:117], clk, r[85], r[84], r[83], r[43:50]);
	//========================================================================================
	//FIRST PIPELINE
	HW6_load_store_reg_n_bit PIPELINE_STAGE_1(clk, w[117:148],  ,  , w[116], x[0:15]);
	//HW6_load_store_reg_n_bit PIPELINE_STAGE_1(clk, w[117:148],  ,  , w[116], PSR_out);
//	//========================================================================================
//	//STAGE 2 MODULES: INSTRUCTION DECODE
//	//========================================================================================
		//mux4: MDR2 Input
	Mux4to1_8Bit # ( 32 ) MUX4 (s[3:4], {x[192:223], x[128:159], input_bus, 0}, x[305:336]);
	//mux5: MAR2 Input
	Mux4to1_8Bit MUX5 (s[5:6], {x[0:7], x[8:15], x[88:95], x[152:159] }, x[16:23]);
	//mux6: ALU line A (plus input to other MUXes)
	Mux8to1_32Bit MUX6 (s[7:9], {u[0:191],0}, x[128:159]);
	
	//mux7: ALU line B to select indirect/immediate
	Mux8to1_32Bit MUX7 ({0,0, ISEL}, {x[64:95], w[134:148], 0}, x[337:368]);
	
	//mux8: load vs ALU on PSR2 line
	Mux8to1_32Bit MUX8 ({0,0, LSEL}, {x[64:95], x[192:223], 0}, x[369:400]);
	
	//R0 thru R5
	LdStrRegParam #( 32 ) R0 (x[192:223], u[0:31], x[298], rst, 0, clk); 
	LdStrRegParam #( 32 ) R1 (x[192:223], u[32:63], x[299], rst, 0, clk); 
	LdStrRegParam #( 32 ) R2 (x[192:223], u[64:95], x[300], rst, 0, clk); 
	LdStrRegParam #( 32 ) R3 (x[192:223], u[96:127], x[301], rst, 0, clk); 
	LdStrRegParam #( 32 ) R4 (x[192:223], u[128:159], x[302], rst, 0, clk); 
	LdStrRegParam #( 32 ) R5 (x[192:223], u[160:191], x[303], rst, 0, clk); 
	
	//Memory Address Register 2
	LdStrRegParam #( 8 ) MAR2 (x[16:23], x[24:31], x[297], rst, 0, clk);
	
	//combinational logic to prevent LMDR from overriding cache data on negedge loads
	and (x[304], ~x[295], x[296]);
	
	//Memory Data Register 2
	MemDataReg_32Bit # ( 32 ) MDR2 (x[305:336],x[32:63], x[64:95], x[304], rst, clk);
	
	//data cache
	Cache Data_Cache (x[64:95], x[32:63], x[24:31],x[293],x[294], x[295], clk, r[118:125], r[126:157], r[203:234], r[159], r[158],  r[235]);
	
	//data delay
	DataDelay mem_delay_2 (r[118:125], r[126:157], r[159], r[158], r[159], r[160:167], r[168:199], r[201], r[200], r[202], clk);
	//data ram
	//TODO: remove this comment and the one below it!!! See line 58
	RAM Data_RAM (r[168:199], r[203:234], clk, r[202], r[201], r[200], r[160:167]);
	
	//ALU  c,Cin,Ain,Bin,Cout,Fout,V,Z,carry_outs
	n_bit_ALU_generate ALU({s10,s11,s12},1'b0,x[128:159],x[64:95],x[160:191],x[290],x[288],x[256:287]);
	//n_bit_ALU_generate ALU({s10,s11,s12},1'b0,x[128:159],x[64:95],x[160:191],x[290],x[288],ALU_out);
	
//
//	//Shifter c,f,f_s
	nbit_mult_div SHIFTER({s13,s14,s15},x[256:287],x[192:223]);
//	
//	always @ (posedge(clk)) begin
//		
//		test_out <= x[192:223];
//		
//	end;
//	
//	//	//STAGE 3 MODULES
HW6_load_store_reg_n_bit PIPELINE_STAGE_2(clk, x[369:400], 0,0 , w[116], ALU_out);

//

assign output_bus = x[64:95];
endmodule

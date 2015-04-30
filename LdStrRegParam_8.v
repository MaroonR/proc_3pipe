`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:11 04/30/2015 
// Design Name: 
// Module Name:    LdStrRegParam_8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LdStrRegParam_8(ld_str_in, ld_str_out, ld_str, clr, set, clk);

	parameter n = 8;
	
	input [n-1:0] ld_str_in;
	input clr, set, clk, ld_str;
	output [n-1:0] ld_str_out;
	
//	//create LSB of ALU
//	alu_bit_slice ALU_BIT_0(c,Ain[0],Bin[0],carry[0],carry[1],Fout[0]);
//	
//	//generate other bits
//	generate for (i=1; i<=n-1; i=i+1) begin: remaining_bits
//		alu_bit_slice ALU_BITS(c,Ain[i],Bin[i],carry[i],carry[i+1],Fout[i]);
//	end
//	endgenerate
	
	
	genvar i;
	
	//create LSB of of reg
	RegBitSlice REG_BIT0 (clr, set, clk, ld_str, ld_str_in[0], ld_str_out[0]);
	
	generate
		for (i = 1; i <= n-1; i = i + 1)	begin: BiteSliceGen
			RegBitSlice REG_BITS (clr, set, clk, ld_str, ld_str_in[i], ld_str_out[i]);
		end
	endgenerate


endmodule
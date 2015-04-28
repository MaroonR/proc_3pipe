`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:39 04/28/2015 
// Design Name: 
// Module Name:    LdStrRegParam 
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
module LdStrRegParam(ld_str_in, ld_str_out, ld_str, clr, set, clk);

	parameter n = 4;
	
	input [n-1:0] ld_str_in;
	input clr, set, clk, ld_str;
	output [n-1:0] ld_str_out;
	
	genvar i;
	
	generate
		for (i = 0; i < n; i = i + 1)	begin: BiteSliceGen
			RegBitSlice U (clr, set, clk, ld_str, ld_str_in[i], ld_str_out[i]);
		end
	endgenerate


endmodule
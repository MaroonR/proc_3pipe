`timescale 1ns / 1ps

module PosNegLdStrReg(ld_str_in, ld_str_out, ld_str, clr, set, clk);

	parameter n = 32;
	
	input [n-1:0] ld_str_in;
	input clr, set, clk, ld_str;
	output [n-1:0] ld_str_out;
	
	genvar i;
	
	generate
		for (i = 0; i < n; i = i + 1)	begin: BiteSliceGen
			PosNegRegBitSlice U (clr, set, clk, ld_str, ld_str_in[i], ld_str_out[i]);
		end
	endgenerate


endmodule

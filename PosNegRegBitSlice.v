`timescale 1ns / 1ps
module PosNegRegBitSlice(clr, set, clk, ld_str, sl_in, sl_out);
	input clr, set, clk, sl_in, ld_str;
	output sl_out;
	
	wire [1:0] x;
	
	assign sl_out = x[1];
	
	hw1_2x1_MUX_behav MUX (ld_str, {sl_in,x[1]}, x[0]);
	PosNegDFlipFlop DFF (clk, x[0], set, clr, x[1]);
	

endmodule 
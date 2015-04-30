`timescale 1ns / 1ps
module MemDataReg_32Bit(cpu_in, cache_in, ld_str_out, ld_str, clr, clk);

	parameter n = 32;
	
	input [n-1:0] cpu_in;
	input [n-1:0] cache_in;
	input clr, clk, ld_str;
	output [n-1:0] ld_str_out;
	reg [n-1:0] bit_slice_input;
	
	genvar i;
	
	generate
		for (i = 0; i < n; i = i + 1)	begin: BiteSliceGen
			PosNegRegBitSlice U (clr, set, clk, 1'b1, bit_slice_input[i], ld_str_out[i]);
		end
	endgenerate
	
	always @ (clk) begin
		if (ld_str == 1)
			bit_slice_input = cpu_in;
		else
			bit_slice_input = cache_in;
	end
	

endmodule

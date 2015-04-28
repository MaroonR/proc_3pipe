`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:40 04/27/2015 
// Design Name: 
// Module Name:    HW6_load_store_reg_n_bit 
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
module HW6_load_store_reg_n_bit(clk, reg_in, clear, set, ld_st, reg_out);
	parameter n = 32;
	
	input 			clk, clear, set, ld_st;
	input	[n-1:0]	reg_in;
	
	output	[n-1:0]	reg_out;
	
	genvar i;
	
	//create LSB of register
	HW6_load_store_reg_bit_slice REG_BIT_0(
		.clk		(clk), 	
		.slice_in	(reg_in[0]), 
		.clear		(clear), 
		.set		(set), 
		.ld_st		(ld_st), 
		.slice_out	(reg_out[0])
	);
	
	//generate other bits
	generate for (i = 1; i < n; i = i + 1) begin: remaining_bits
		HW6_load_store_reg_bit_slice REG_BITS(
			.clk		(clk), 
			.slice_in	(reg_in[i]), 
			.clear		(clear), 
			.set		(set), 
			.ld_st		(ld_st), 
			.slice_out	(reg_out[i])
		);		
	end
	endgenerate
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:40 04/27/2015 
// Design Name: 
// Module Name:    HW6_load_store_reg_bit_slice 
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
module HW6_load_store_reg_bit_slice(clk, slice_in, clear, set, ld_st, slice_out);
	input	clk, slice_in, clear, set, ld_st;
	output	slice_out;
	
	wire	[1:0]	w;
	//w[0] - connection from mux_out to d
	//w[1] - connection from q to mux_i0/slice_out
	
	hw1_2x1_MUX_behav MUX(
		.s	(ld_st),
		.i1	(slice_in),
		.i0	(w[1]),
		.o	(w[0])
	);
	
	HW5_DFF_syn_high_clear_set DFF(
		.clk	(clk),
		.d		(w[0]),
		.set	(set),
		.clear	(clear), 
		.q		(w[1]), 
		.q_cmp	(    )	//this port is unused
	);
	
	assign slice_out = w[1];
	
endmodule

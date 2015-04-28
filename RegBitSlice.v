
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:24:14 04/28/2015 
// Design Name: 
// Module Name:    RegBitSlice 
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
`timescale 1ns / 1ps

module RegBitSlice(clr, set, clk, ld_str, sl_in, sl_out);
	input clr, set, clk, sl_in, ld_str;
	output sl_out;
	
	wire [1:0] x;
	
	assign sl_out = x[1];
	
	hw1_2x1_MUX_behav MUX (ld_str, {sl_in,x[1]}, x[0]);
	HW5_DFF_syn_high_clear_set DFF (clk, x[0], set, clr, x[1]);
	

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:20 04/27/2015 
// Design Name: 
// Module Name:    HW5_DFF_syn_high_clear_set 
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
module HW5_DFF_syn_high_clear_set(clk, d, set, clear, q, q_cmp);
	input clk, d, set, clear;
	output q, q_cmp;
	reg q;
	
	always@(posedge(clk))
	begin
		if (clear == 1) q = 0;
		else if (set == 1) q = 1;
		else q = d;
	end
	
	assign q_cmp = ~q;

endmodule

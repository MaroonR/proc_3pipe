`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:15 04/28/2015 
// Design Name: 
// Module Name:    MHVPIS 
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
module MHVPIS(i, mask, clk, set, set_ien, clr_ien, i_pend, data_out);
	parameter n = 8;	 	//determines width of RAM
	input [3:0] i; 		//interupt lines in
	input [3:0] mask; 	//masking lines in
	input clk, set, set_ien, clr_ien;
	output [(n-1):0] data_out; //address to pass to PC
	output i_pend;
	wire [3:0] i_out, mask_out, and_out;
	reg [1:0] mem_addr; // register between logic and RAM
	wire ff_out, or_out;
	
	and (and_out[0], i_out[0], mask_out[0]);
  and (and_out[1], i_out[1], mask_out[1]);
  and (and_out[2], i_out[2], mask_out[2]);
	and (and_out[3], i_out[3], mask_out[3]);
	
	or (or_out, and_out[3], and_out[2], and_out[1], and_out[0]);
	and (i_pend, or_out, ff_out);
	
	LdStrRegParam IR (i, i_out, ~or_out, clr_ien, set, clk);
	LdStrRegParam MR (mask, mask_out, ~or_out, clr_ien, set, clk);

	always @ (and_out)
	begin: code_conversion
		casex (and_out)
			4'b1xxx: mem_addr = 2'b00;
			4'b01xx: mem_addr = 2'b01;
			4'b001x: mem_addr = 2'b10;
			4'b0001: mem_addr = 2'b11;
			default: mem_addr = 2'bzz;
		endcase
	end
	
	// logic block
	
	RAM_MHVPIS RAM1 (8'b00000000, data_out, clk, 1'b1, 1'b1, 1'b1, mem_addr);
	
	//DFF for interrupt enable
	
	HW5_DFF_syn_high_clear_set DFF (clk, ff_out, clr_ien, set_ien, ff_out);  //set and clr reversed to get inverse output from flipflop
	


endmodule

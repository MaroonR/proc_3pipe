`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:00 04/27/2015 
// Design Name: 
// Module Name:    HW8_n_bit_PC 
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
module HW8_n_bit_PC(clk, clear, c, reg_in, inc_int, reg_out);
	parameter n = 32;
	
	input			clk, 
					clear;
	input	[1:0]	c;
	input	[n-1:0]	reg_in;
	input	[n-1:0]	inc_int;
	
	output	[n-1:0]	reg_out;
	reg		[n-1:0]	reg_out;

	
	always @ (posedge clk) begin
		if (clear == 0)
			reg_out = 'b0;
		else //normal operation
			case (c)
			2'b00	:	reg_out = reg_out;	//Hold Count
			
			2'b01	:	reg_out = reg_in;	//Parallel load
			
			2'b10	:	begin				//Increment by 4, since our instructions are 4 bytes
							reg_out = reg_out + 4;
							if (reg_out == 0) begin
								//handle overflow
							end
						end
						
			2'b11	:	begin				//Increment by positive int
							reg_out = reg_out + inc_int;
							if (reg_out - inc_int > reg_out) begin
								//handle overflow
							end
							else
						end
						
			default	:	reg_out = 'bZ;
			endcase
	end
endmodule
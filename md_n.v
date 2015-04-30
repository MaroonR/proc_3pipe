`timescale 1ns / 1ps

// Create Date:    17:50:06 03/02/2010 
// Design Name: 
// Module Name:    nbit_mult_div 
// Project Name: 

module nbit_mult_div(c,f,f_s);
	parameter n = 32;
	input [2:0]c;
	input signed [(n-1):0]f;
	output signed [(n-1):0]f_s;
	reg signed [(n-1):0]f_s;
	
	always @ (c,f)
	begin
		case (c)
			0 : f_s = f >>> 3;
			1 : f_s = f >>> 2;
			2 : f_s = f >>> 1;
			3 : f_s = f;
			4 : f_s = f <<< 1;
			5 : f_s = f <<< 2;
			6 : f_s = f <<< 3;
			7 : f_s = 0;
			default : f_s = 0;
		endcase
	end

endmodule
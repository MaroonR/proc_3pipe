`timescale 1ns / 1ps



//this mux was created especially for our
//MUX6, which selects between the immediate
//value and the indirect value to be placed
//on the ALU
module mux_2x1_16SE_32( sel, i0, i1, out );
    
	 input sel;
	 input [15:0] i0;
	 input [31:0] i1;
	 output [31:0] out;
	 
	 assign out = 
		
		sel == 1 ? i1 :
		sel == 0 ? i0 :
		0;
		
		
	 


endmodule

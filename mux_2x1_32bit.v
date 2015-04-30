`timescale 1ns / 1ps
module mux_2x1_32Bit(SEL, IN, OUT); 
    input SEL;
	 input [63:0] IN;
	 output [31:0]OUT;
	 
	 assign OUT = (~SEL&IN[63:32])|(SEL&IN[31:0]);
	 
endmodule 
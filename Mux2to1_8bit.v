`timescale 1ns / 1ps
module Mux2to1_8Bit(SEL, IN, OUT); 
    input SEL;
	 input [15:0] IN;
	 output [7:0]OUT;
	 
	 assign OUT = (~SEL&IN[15:8])|(SEL&IN[7:0]);
	 
endmodule 
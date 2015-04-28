`timescale 1ns / 1ps
module Mux4to1_8Bit(SEL, IN, OUT);

	parameter n = 8;
    input [1:0] SEL;
	 input [(n*4-1):0] IN;
	 output [n-1:0]OUT;
	 
	 assign OUT = (~SEL[0]&~SEL[1]&IN[(n*4-1):n*3])|(SEL[0]&~SEL[1]&IN[(n*3-1):(n*2)])|(~SEL[0]&SEL[1]&IN[(n*2-1):n])|(SEL[0]&SEL[1]&IN[n-1:0]);
	 
endmodule 
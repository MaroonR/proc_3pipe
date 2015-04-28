
`timescale 1ns / 1ps

module Mux8to1_32Bit(SEL, IN, OUT);

	parameter n = 32;
    input [2:0] SEL;
	 input [(n*8-1):0] IN;
	 output [n-1:0]OUT;
	 
	 assign OUT = (~SEL[0]&~SEL[1]&~SEL[2]&IN[(n*8-1):n*7])
	 |(~SEL[0]&~SEL[1]&SEL[2]&IN[(n*7-1):n*6])
	 |(~SEL[0]&SEL[1]&~SEL[2]&IN[(n*6-1):n*5])
	 |(~SEL[0]&SEL[1]&SEL[2]&IN[(n*5-1):n*4])
	 |(SEL[0]&~SEL[1]&~SEL[2]&IN[(n*4-1):n*3])
	 |(SEL[0]&~SEL[1]&SEL[2]&IN[(n*3-1):n*2])
	 |(SEL[0]&SEL[1]&~SEL[2]&IN[(n*2-1):n])
	 |(SEL[0]&SEL[1]&SEL[2]&IN[(n-1):0]);
endmodule 
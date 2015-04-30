
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:23 04/27/2015 
// Design Name: 
// Module Name:    ALU 
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
`timescale 1 ns / 1ns

module n_bit_ALU_generate(c,Cin,Ain,Bin,Cout,Fout,V,Z,carry_outs);
	parameter n=32;
	
	input	[n-1:0]	Ain,Bin;
	input	[2:0]	c;
	input			Cin;
	output	[n-1:0]	Fout;
	output	[n:0]	carry_outs;
	output			V,Z,Cout;
	
	wire	[n:0]	carry;
	wire	[n-1:0]	w;

	
	genvar i;
	
	assign carry[0] = Cin;
	assign carry_outs = carry;
	assign Cout = carry[n];
	
	//gates here
	
	//create LSB of ALU
	ALUslice ALU_BIT_0(c,Ain[0],Bin[0],carry[0],carry[1],Fout[0]);
	
	//generate other bits
	generate for (i=1; i<=n-1; i=i+1) begin: remaining_bits
		ALUslice ALU_BITS(c,Ain[i],Bin[i],carry[i],carry[i+1],Fout[i]);
	end
	endgenerate
	
	assign V=(carry[n] ^ carry[n-1]);
	assign Z=~(|Fout);
	
endmodule

module nbit_mult_div(c,f,f_s);
	parameter n = 4;
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

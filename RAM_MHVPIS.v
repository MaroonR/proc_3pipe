`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:22:36 04/28/2015 
// Design Name: 
// Module Name:    RAM_MHVPIS 
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
module RAM_MHVPIS(dataIn, dataOut, clk, clr, ce, rw, mar);
	parameter n = 2, m = 8;
	input clk, rw, ce, clr;
	input [m-1:0] dataIn;
	output reg [m-1:0] dataOut;
	input [n-1:0] mar;
	reg [m-1:0] ram[(2**n)-1:0];
	wire rd_rw;
	
	and A0 (rd_rw, rw, ce);
	
	integer k;
	
	initial
	begin:load_constants
		ram [0] = 8'b00000000;
		ram [1] = 8'b00000001;
		ram [2] = 8'b00000010;
		ram [3] = 8'b00000011;
	end

	
	always @ (posedge clk)
	
	if (ce == 1'b0)
		for (k=0; k<m; k=k+1) begin dataOut[k]=1'bz; end
	else
	begin
		if (clr == 1'b0)
		begin
			for (k=0; k<(2**n); k=k+1) begin ram[k] <= 0; end
		end
		if (rd_rw == 1'b1)//read
		begin
			dataOut = ram[mar];
		end
		
		if (rd_rw == 1'b0) // write
		begin
			ram[mar] <= dataIn;
		end
	end


endmodule

`timescale 1ns / 1ps

module RAM(dataIn, dataOut, clk, clr, ce, rw, mar);
	parameter n = 8, m = 32;
	input clk, rw, ce, clr;
	input [m-1:0] dataIn;
	output reg [m-1:0] dataOut;
	input [n-1:0] mar;
	reg [m-1:0] ram[(2**n)-1:0];
	
	integer k;
	
	always @ (negedge clk)
	
	if (ce == 1'b0)
		for (k=0; k<m; k=k+1) begin dataOut[k]=1'bz; end
	else
	begin
		if (clr == 1'b0)
		begin
			for (k=0; k<(2**n); k=k+1) begin ram[k] <= 0; end
		end
		else if (rw == 1'b1)//read
		begin
			dataOut = ram[mar];
		end
		
		else if (rw == 1'b0) // write
		begin
			ram[mar] <= dataIn;
		end
	end


endmodule
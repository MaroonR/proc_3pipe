`timescale 1ns / 1ps
module PosNegDFlipFlop(clock,D,Set,Clear,Q);
	input clock;				//clock input
	input D, Set, Clear;		//three inputs
	output reg Q;				//output from flip flop		
	
	always @ (negedge(clock) or posedge(clock))
		begin
			if (Clear == 1'b0) 
				Q = 1'b0;
			else if (Set == 1'b0) 
				Q = 1'b1;
			else
				Q = D;
		end

endmodule 
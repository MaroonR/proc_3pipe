`timescale 1ns / 1ps
module PosNegDFlipFlop(Clock,D,Set,Clear,Q);
	input Clock;				//clock input
	input D, Set, Clear;		//three inputs
	output reg Q;				//output from flip flop		
	
	always @ (Clock)
		begin
			if (Clear == 1'b0) 
				Q = 1'b0;
			else if (Set == 1'b0) 
				Q = 1'b1;
			else
				Q = D;
		end

endmodule 
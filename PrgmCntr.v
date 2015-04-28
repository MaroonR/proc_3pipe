`timescale 1ns / 1ps

module PrgmCntr(clk, clear, pc_input, pc_output, IPC, LPC);
       parameter n = 4;                        //bit count of the counter

       input clk, clear;
       input [n-1:0] pc_input;
       input IPC, LPC;
       output reg [n-1:0] pc_output;

       integer i;
		 initial
			for (i = 0; i < n; i = i + 1)
				pc_output[i]=1'b0;

       always @ (posedge clk)
       begin
               if (clear == 1)
               begin
                       for (i=0; i < n; i = i+1)
                       begin
                               pc_output[i] = 0;
                       end
               end

               else if (LPC != IPC)
               begin
						if (LPC == 1)
							pc_output = pc_input;
						else
							pc_output = pc_output + 1'b1;
               end
					else
						pc_output = pc_output;
       end


endmodule 
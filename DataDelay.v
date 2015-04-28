`timescale 1ns / 1ps

//takes 5 data lines and delays their throughput by x num of clk cycles
// 1 - n bit line (address)
// 2 - m bit line (data)
// 3 - one bit (chip enable)
// 4 - one bit (read/write)
// 5 - one bit (clear)
module DataDelay(marI, dataI, ceI, rwI, clrI, marO, dataO, ceO, rwO, clrO, clk);
parameter n = 8;
parameter m = 32;

parameter delay = 4;

input ceI, rwI, clrI, clk;
input [n-1:0] marI;
input [m-1:0] dataI;

output reg ceO, rwO, clrO;
output reg [n-1:0] marO;
output reg [m-1:0] dataO;

reg [n+m+2:0] bank[delay:0];

integer i, j, k;

initial		//fills bank with 0s
begin:init 
	for (i = 0; i < delay+1; i=i+1)
	begin: outer_loop1
		for (j = 0; j< n+m+3; j=j+1)
		begin: inner_loop1
			bank[i][j]=1'b0;
		end
	end
end

always @ (negedge clk)
begin:alwys
	k=delay-1;
	while (k>=0)
	begin:loop
		bank [k+1] = bank [k];
		k=k-1;
	end
	//latching inputs into register
	bank[0] = {marI, dataI, ceI, rwI, clrI} ;
	
	//latching outputs from registers to output
	marO = bank [delay][n+m+3-1:m+3];
	dataO = bank [delay][m+3-1:3];
	ceO = bank [delay][2];
	rwO = bank [delay][1];
	clrO = bank [delay][0];
end	


endmodule

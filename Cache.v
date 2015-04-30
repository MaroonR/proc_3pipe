`timescale 1ns / 1ps
//four word cache with LRU selection

module Cache(MDRI, MDRO, MARI, read, write, ready, clk, Address_to_RAM, Data_to_RAM, Data_from_RAM, ceO, rwO,  clrO); 
	parameter n = 8;
	parameter m = 32;
	
	//IO to Processor
	input clk, read, write;
	output reg ready;
	input [m-1:0] MDRI;
	input [n-1:0] MARI;
	output reg[m-1:0] MDRO;
	
	//IO to RAM
	output reg [n-1:0] Address_to_RAM;
	output reg [m-1:0] Data_to_RAM;
	input [m-1:0] Data_from_RAM;
	output reg ceO, rwO, clrO;
	
	//each reg contains the address, data, and a count for LRU algorithm
	reg [n+m+1:0] bank[3:0];
	
	integer i, j, k, q;
	integer waiting;
	
	initial	//setting all banks to zero
	begin:init
		for (i = 0; i < 4; i = i + 1)
		begin:outer_loop
			for (j = 0;j < m+n+2; j = j + 1)
			begin
				bank[i][j]=1'b0;
				bank[i][1:0]=i;	//sets LRU counters to 0-3
			end
		end
		waiting = 0;
		q=0;
	end
	
	always @ (negedge clk)
	begin :alwys_block
	//RAM output arrived, there was no cache hit
		if (Data_from_RAM [0] != 1'b1 || Data_from_RAM [0] != 1'b0)	
		begin:RAM_returns_data
			//store data in cache			
			//finding location by using LRU count
			for (i = 0; i < 4; i = i + 1)
			begin: LRU_loop
				if (bank[i][1:0] == 0)	//one count must always be zero
					j = i;
				bank[i][1:0] = bank[i][1:0] - 1'b1;
			end
			//overwriting the value 
			bank[j] = {MARI, Data_from_RAM, 2'b11};
			MDRO = Data_from_RAM;
			ready = 1'b1;
			waiting = 0;
		end
		else if (write == 1'b1)	//processor writes MDR to MAR
		begin: processor_write
			j=-1;
			//check if data is in cache
			for (i = 0; i < 4; i = i + 1)
				if (bank[i][m+n+1:m+2]==MARI)	//MAR is equal to an address in the block
					j = i;							//then j becomes that block's index
			if (j!=-1)				//a block was found containing that address
			begin: update_block
				for (i = 0; i < 4; i = i + 1) begin	//decrementing LRU counters
					if (bank[i][1:0]>bank[j][1:0])	//
						bank[i][1:0] = bank[i][1:0] - 1'b1;
					if (bank[i][m+n+1:m+2]==MARI)		//MAR is equal to an address in the block
						j = i;
				end
				bank[j] = {MARI, MDRI, 2'b11};
			end
			else				//this block is not in the cache
			begin: overwrite_LRU_block
				for (i = 0; i < 4; i = i + 1)
				begin:search_loop
					if (bank[i][1:0]==0)
						j = i;
					bank[i][1:0] = bank[i][1:0] - 1'b1;
				end
				//all counts decremented, found 0 block
				bank[j]={MARI, MDRI, 2'b11};	//writing block to cache
			end
			//send write to RAM
			Data_to_RAM = MDRI;
			ceO =1'b1;
			rwO = 1'b0;
			clrO = 1'b1;
			Address_to_RAM = MARI;
		end
		else if (read == 1'b1 && waiting==0)	//processor reads address at MDR 
		begin: processor_read
			//check if block is in cache
			j=-1;
			for (i = 0; i < 4; i = i + 1)
				if (bank[i][m+n+1:m+2]==MARI)	//MAR is equal to an address in the block
					j = i;							//then j becomes that block's index
			if (j!=-1)				//a block was found containing that address
			begin:return_cached_block //return cached block
				MDRO = bank[j][m+1:2];
				ready = 1'b1;
			end
			
			//fetch block from memory
			else
			begin:fetch_memory_block
				Address_to_RAM = MARI;
				ceO = 1'b1;
				rwO = 1'b1;
				clrO = 1'b1;
				Data_to_RAM = 0;
				waiting = 1;
			end
		end
		else
		begin: take_no_action
			ready = 1'b0;
			for(k = 0; k < m; k = k + 1)
				MDRO[k] = 1'b0;
			for(k = 0; k < n; k = k + 1)
				Address_to_RAM[k] = 1'b0;
			for(k = 0; k < m; k = k + 1)
				Data_to_RAM[k] = 1'b0;
			ceO = 0;
			rwO = 0;
			clrO = 1;			
		end
	end
endmodule 
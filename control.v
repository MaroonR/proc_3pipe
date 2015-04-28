`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:57 04/27/2015 
// Design Name: 
// Module Name:    control 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:22 04/27/2015 
// Design Name: 
// Module Name:    controller 
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

/* instruction format:
	
	DIRECT ADDRESING            !!!!!!!!!!!!!! We need to talk about this
	===========================================
	[    4    ] [    5    ] [    5    ] [    5   ] [   9    ] [   4  ]
	
	
		opcode		  rs			  rt			  rd		 sh-amt		 alu
	===========================================
	
	IMMEDIATE ADDRESSING
	===========================================
	[   4   ] [   5   ] [   5   ] [           18               ]
	  
	  opcode      rs        rt             immediate
	===========================================
	
	INDIRECT ADDRESSING 
	===========================================
	[   4   ] [                      28                       ]
	
	 opcode                       target address
	===========================================
	
				OP						FUNCT				
//ADD   : 	0000					0000          	ADD Unsigned
//ADDS  : 	0000					0001				ADD signed
//SUB   : 	0000					0010				SUB Unsigned
//SUBS  : 	0000					0011				...
//OR    : 	0000					0100
//ORS   : 	0000					0101
//AND   : 	0000					0110
//ANDS  : 	0000					0111
//NOT   : 	0000					1000	
//SLT/XOR   : 	0000					1001				Set to 1 if less than? Or do we want dependent on ALU status like ARM?
//MULT  : 	0000					1010				MULT Signed
//DIV   : 	0000					1011				DIV Signed
//SLL   : 	0000					1100				Shift Left Logical
//SRL   : 	0000					1101				Shift Right Logical
//SRA   : 	0000					1111				Shift Right Arithmetic


//J	  : 	0001					0000				Jump
//JL    : 	0010					0000				Jump and Link
//JR	  : 	0011					0000				Jump and return? what?
//SLTI  : 	0100										Set to 1 if less than 1 immed.
//BNE   : 	0101										Branch on Not Equals
//BGT   :   0110										Branch on Greather Than
//BLT   :	0111										Branch on Less Than
//LDR   : 	1000
//STR   : 	1001
//LMR   : 	1010
//NOP   :	1011
				1100
				1101
				1111


module controller(intr, start, clr, clk, yp, Y, ctrl, alu_ctrl
    );
	 
	 input clk, start, clear;
	 input [3:0] intr;
	 output reg [7:0] ctrl;
	 output alu_ctrl;
	 /*
	 0:  regdst
	 1:  jump
	 2:  branch
	 3:  memread  
	 4:  memtoreg  (I assume this is where we indirect addressing)
	 5:  memwrite
	 6:  alusrc (selects if Imm value is used or the read_data is used for ALU work
						this lets us differentiate between immediate and direct addressing)
	 7:  regwrite
	 */
	 output reg [3:0] intr_passthrough;
	 output reg [9:0] yp, Y;
	 
	parameter 
		a=10'b1000000000, //start, NOP?
		b=10'b0100000000, //flag for alu control
		c=10'b0010000000, //LDR
		d=10'b0001000000, //ST 
		e=10'b0000100000, //MOV
		f=10'b0000010000, //BEQ
		g=10'b0000001000, //BX LR
		h=10'b0000000100, //IN
		i=10'b0000000010, //OUT
		j=10'b0000000001; //LMR or XOR
	
	 always @ (intr or yp) begin //determine next state
	 case (yp)
		a : if (intr == 0) Y = a;
			 else if (intr > 0 and intr < 9) Y = b;
			 else if (intr == 9) Y = c;
			 else if (intr == 10) Y = d;
			 else if (intr == 11) Y = e;
			 else if (intr == 12) Y = f;
			 else if (intr == 13) Y = g;
			 else if (intr == 14) Y = h;
			 else if (intr == 15) Y = i;
			 else Y = a; //default case 
		b : Y = a;
		c : Y = a;
		d : Y = a;
		e : Y = a;
		f : Y = a;
		g : Y = a;
		h : Y = a;
		i : Y = a;
		default : Y = a;
		endcase
	end
	
	
	always @ (posedge clk)
	begin
		if (clr == 1'b0) yp=10'b0000000000;
		else if (start == 1) yp = a;
		else yp = Y;
	end
	
	always @ (yp)
	begin
	/*
	 0:  regdst
	 1:  jump
	 2:  branch
	 3:  memread  
	 4:  memtoreg  (I assume this is where we indirect addressing)
	 5:  memwrite
	 6:  alusrc (selects if Imm value is used or the read_data is used for ALU work
						this lets us differentiate between immediate and direct addressing)
	 7:  regwrite
	 */
	case (yp)
		a : begin //this is the start case, determines proper case based on instruction
			ctrl = 0;
			intr_passthrough = intr; 
			end
		b : begin //trusty ALU case. passes the instruction through, enables ALU_Control unit
			ctrl = 0;
			intr_passthrough = insr; //this line really only needed here
			alu_ctrl = 1; //alu_enable
		c: begin //regdst, lets us choose the register destination (not really needed, just fun)
			ctrl = 8'b00000001; //set regdst control bit
			insr_passthrough = 
			
			
			
			


endmodule
`timescale 1ns / 1ps


module control(clk,reset,IDV,V,S,Z,I_Cache_Ready,D_Cache_Ready,IR,
						set_en,ctrl_en,ir_in,lmr_ir,I_Cache_R,LIR,
						s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,
						D_Cache_W,D_Cache_R,LMDR2,LMAR2,LR0,LR1,LR2,LR3,LR4,LR5,ODV,LSR,i_pend,
						LR6,LR7,IPC,LPC,LMAR1,LPSR);
						
	input clk,reset,IDV,V,Z,i_pend;
	input I_Cache_Ready,D_Cache_Ready;
	input [31:0] IR,S;
	output reg set_en,ctrl_en,ir_in,lmr_ir;
	output reg I_Cache_R,LIR;
	output reg s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16;
	output reg D_Cache_W,D_Cache_R;
	output reg LMDR2,LMAR2,LR0,LR1,LR2,LR3,LR4,LR5;
	output reg ODV,LSR,LR6,LR7,IPC,LPC,LMAR1,LPSR;
	reg sm1_ready,sm2_ready;
	reg [4:0] y1,next_y1;
	reg [6:0] y2,next_y2;
	parameter t1_0=5'b00000,t1_1=5'b00001,t1_2=5'b00010,t1_3=5'b00011,t1_4=5'b00100,
				 t1_5=5'b00101,t1_6=5'b00110,t1_7=5'b00111,t1_8=5'b01000,t1_9=5'b01001,
				 t1_10=5'b01010,t1_11=5'b01011,t1_12=5'b01100,t1_13=5'b01101,t1_14=5'b01110,
				 t1_15=5'b01111,t1_16=5'b10000,t1_17=5'b10001,
				 t2_0=7'b0000000,t2_1=7'b0000001,t2_2=7'b0000010,t2_3=7'b0000011,t2_4=7'b0000100,
				 t2_5=7'b0000101,t2_6=7'b0000110,t2_7=7'b0000111,t2_8=7'b0001000,t2_9=7'b0001001,
				 t2_10=7'b0001010,t2_11=7'b0001011,t2_12=7'b0001100,t2_13=7'b0001101,t2_14=7'b0001110,
				 t2_15=7'b0001111,t2_16=7'b0010000,t2_17=7'b0010001,t2_18=7'b0010010,t2_19=7'b0010011,
				 t2_20=7'b0010100,t2_21=7'b0010101,t2_22=7'b0010110,t2_23=7'b0010111,t2_24=7'b0011000,
				 t2_25=7'b0011001,t2_26=7'b0011010,t2_27=7'b0011011,t2_28=7'b0011100,t2_29=7'b0011101,
				 t2_30=7'b0011110,t2_31=7'b0011111,t2_32=7'b0100000,t2_33=7'b0100001,t2_34=7'b0100010,
				 t2_35=7'b0100011,t2_36=7'b0100100,t2_37=7'b0100101,t2_38=7'b0100110,t2_39=7'b0100111,
				 t2_40=7'b0101000,t2_41=7'b0101001,t2_42=7'b0101010,t2_43=7'b0101011,t2_44=7'b0101100,
				 t2_45=7'b0101101,t2_46=7'b0101110,t2_47=7'b0101111,t2_48=7'b0110000,t2_49=7'b0110001,
				 t2_50=7'b0110010,t2_51=7'b0110011,t2_52=7'b0110100,t2_53=7'b0110101,t2_54=7'b0110110,
				 t2_55=7'b0110111,t2_56=7'b0111000,t2_57=7'b0111001,t2_58=7'b0111010,t2_59=7'b0111011,
				 t2_60=7'b0111100,t2_61=7'b0111101,t2_62=7'b0111110,t2_63=7'b0111111,t2_64=7'b1000000,
				 t2_65=7'b1000001,t2_66=7'b1000010,t2_67=7'b1000011,t2_68=7'b1000100,t2_69=7'b1000101,
				 t2_70=7'b1000110,t2_71=7'b1000111,t2_72=7'b1001000,t2_73=7'b1001001,t2_74=7'b1001010,
				 t2_75=7'b1001011,t2_76=7'b1001100,t2_77=7'b1001101,t2_78=7'b1001101,t2_79=7'b1001110,
				 t2_80=7'b1010000,t2_81=7'b1010001;
				 
	always @ (y1)
	begin
		case (y1)
		t1_0	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;		//START
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0; sm1_ready=1;	//Interrupt?
					if (sm2_ready == 0) next_y1 = t1_0;
					else if (i_pend == 1'b1) next_y1 = t1_1;
					else next_y1 = t1_3; end
		
		t1_1	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;		
					LR6=0; LR7=1; lmr_ir=0; ir_in=0; ctrl_en=1; set_en=0; s16=0; sm1_ready=0;
					next_y1 = t1_0; end
					
		t1_2	:	begin s0=1; s1=1; s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_3; end
					
		t1_3	:	begin s0=0; s1=0; s2=0; I_Cache_R=1; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=1;		//MAR<=PC
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0; sm1_ready=0;
					if (I_Cache_Ready == 1'b1) next_y1 = t1_4;
					else next_y1 = t1_3; end
		
		t1_4	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=1; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					if (IR[31:27] == "00111") next_y1 = t1_6;		 //CONBR
					else if (IR[31:27] == "01000") next_y1 = t1_9;  //JUMP
					else if (IR[31:27] == "01001") next_y1 = t1_12; //JSR
					else if (IR[31:27] == "01010") next_y1 = t1_14; //ISR
					else if (IR[31:27] == "10000") next_y1 = t1_16; //LDMSK
					else next_y1 = t1_5; end
		
		t1_5	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=1;	LIR=0; LPSR=1; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_0; end
		
		t1_6	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=0; LPSR=1; LMAR1=0;		//CONBR
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					if (LSR == 1'b0) next_y1 = t1_6;
					else if (S[31] == 1'b0) next_y1 = t1_7;
					else next_y1 = t1_8; end
		
		t1_7	:	begin s0=0; s1=1; s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_0; end
		
		t1_8	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=1;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_0; end
		
		t1_9	:	begin s0=0; s1=0; s2=1; I_Cache_R=1; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;		//JUMP
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					if (IR[8] == 1) next_y1 = t1_11; //Source Immediate
					else next_y1 = t1_10; end			 //Source Register
		
		t1_10	:	begin s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					if (IR[2:0] == "110") begin s0=1; s1=1; end
					else if (IR[2:0] == "111") begin s0=1; s1=0; end
					next_y1 = t1_0; end
		
		t1_11	:	begin s0=0; s1=1; s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_0; end
		
		t1_12	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=1;	LIR=0; LPSR=0; LMAR1=0;		//JSR
					LR6=1; LR7=1; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=1;
					if (IR[8] == 1) next_y1 = t1_11; //Source Immediate
					else next_y1 = t1_10; end			 //Source Register
		
//		t1_13	:	begin s0=1; s1=1; s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
//					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
//					next_y1 = t1_0; end
		
		t1_14	:	begin s0=1; s1=1; s2=0; I_Cache_R=0; LPC=1; IPC=0;	LIR=0; LPSR=0; LMAR1=0;		//ISR
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_15; end
		
		t1_15	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=1; set_en=0; s16=0;
					next_y1 = t1_0; end
		
//		t1_16	:	begin s0=0; s1=0; s2=1; I_Cache_R=1; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;		//LDMSK
//					LR6=0; LR7=0; lmr_ir=0; ir_in=0; ctrl_en=0; set_en=0; s16=0;
//					next_y1 = t1_17; end
		
		t1_17	:	begin s0=0; s1=0; s2=0; I_Cache_R=0; LPC=0; IPC=0;	LIR=0; LPSR=0; LMAR1=0;
					LR6=0; LR7=0; lmr_ir=1; ir_in=0; ctrl_en=0; set_en=0; s16=0;
					next_y1 = t1_0; end
		endcase
	end
	
	always @ (y2)
	begin
		case (y2)
		t2_0	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=1;
					if (sm1_ready == 0) next_y2 = t2_0;
					else if (IR[31:27] == "01000") next_y2 = t2_0;  		//JUMP
					else if (IR[31:27] == "01001") next_y2 = t2_0; //JSR
					else if (IR[31:27] == "01010") next_y2 = t2_0; //ISR
					else if (IR[31:27] == "01110") next_y2 = t2_1; //INPUT
					else if (IR[31:27] == "00000") begin		//ADD
						if (IR[12] == 1) next_y2 = t2_5;
						else next_y2 = t2_7; end
					else if (IR[31:27] == "00001") begin	   //SUB
						if (IR[12] == 1) next_y2 = t2_12;
						else next_y2 = t2_14; end
					else if (IR[31:27] == "00010") begin	   //OR
						if (IR[12] == 1) next_y2 = t2_19;
						else next_y2 = t2_21; end
					else if (IR[31:27] == "00011") begin	   //AND
						if (IR[12] == 1) next_y2 = t2_26;
						else next_y2 = t2_28; end
					else if (IR[31:27] == "00111") begin	   //CONBR
						if (IR[12] == 1) next_y2 = t2_33;
						else next_y2 = t2_35; end
					else if (IR[31:27] == "00100") next_y2 = t2_38;	//COMPL
					else if (IR[31:27] == "00101") next_y2 = t2_48;	//MULT_DIV
					else if (IR[31:27] == "00110") next_y2 = t2_58;	//SHIFT
					else if (IR[31:27] == "01011") next_y2 = t2_68;	//MVR
					else if (IR[31:27] == "01100") next_y2 = t2_73;	//LOAD
					else if (IR[31:27] == "01101") next_y2 = t2_76;	//STORE
					else if (IR[31:27] == "01111") next_y2 = t2_79;	//OUTPUT
					else next_y2 = t2_0;
					end
		
		t2_1	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[8] == 1) next_y2 = t2_2;
					else if (IDV == 1) next_y2 = t2_3;
					else next_y2 = t2_1; end		//CHECK THIS!!
		
		t2_2	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if ((D_Cache_Ready == 1'b1) && (IDV == 1)) next_y2 = t2_3;
					else if ((D_Cache_Ready == 1'b1) && (IDV == 0)) next_y2 = t2_2;  //CHECK THIS!!
					else next_y2 = t2_2; end
					
		t2_3	:	begin s3=1; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=1; LSR=0;
					next_y2 = t2_4; end
					
		t2_4	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_5	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_6;
					else next_y2 = t2_5; end
					
		t2_6	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_7; end
					
		t2_7	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_7;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_8;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_9;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_11; end
					
		t2_8	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_8;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_9;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_11; end
					
		t2_9	:	begin s3=0; s4=0; s5=0; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b0) next_y2 = t2_9;
					else if ((D_Cache_Ready == 1'b1)) next_y2 = t2_10; end
					
		t2_10	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_11	:	begin s3=0; s4=0; s5=0; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_0; end
					
		t2_12	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_13;
					else next_y2 = t2_12; end
					
		t2_13	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_14; end
					
		t2_14	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_14;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_15;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_16;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_18; end
					
		t2_15	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_15;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_16;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_18; end
					
		t2_16	:	begin s3=0; s4=0; s5=0; s6=1; s10=0; s11=0; s12=1; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b0) next_y2 = t2_16;
					else if ((D_Cache_Ready == 1'b1)) next_y2 = t2_17; end
					
		t2_17	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_18	:	begin s3=0; s4=0; s5=0; s6=0; s10=0; s11=0; s12=1; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_0; end
		
		t2_19	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_20;
					else next_y2 = t2_19; end
					
		t2_20	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_21; end
					
		t2_21	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_21;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_22;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_23;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_25; end
					
		t2_22	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_22;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_23;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_25; end
					
		t2_23	:	begin s3=0; s4=0; s5=0; s6=1; s10=1; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b0) next_y2 = t2_23;
					else if ((D_Cache_Ready == 1'b1)) next_y2 = t2_24; end
					
		t2_24	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_25	:	begin s3=0; s4=0; s5=0; s6=0; s10=1; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Source R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_0; end
					
		t2_26	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_27;
					else next_y2 = t2_26; end
					
		t2_27	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_28; end
					
		t2_28	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_28;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_29;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_30;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_32; end
					
		t2_29	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_29;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_30;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_32; end
					
		t2_30	:	begin s3=0; s4=0; s5=0; s6=1; s10=0; s11=1; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b0) next_y2 = t2_30;
					else if ((D_Cache_Ready == 1'b1)) next_y2 = t2_31; end
					
		t2_31	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_32	:	begin s3=0; s4=0; s5=0; s6=0; s10=0; s11=1; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_33	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_34;
					else next_y2 = t2_33; end
					
		t2_34	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_35; end
					
		t2_35	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_35;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_36;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_37;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_39; end
					
		t2_36	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b0) next_y2 = t2_36;
					else if (D_Cache_Ready == 1'b1) next_y2 = t2_37; end
					
		t2_37	:	begin s3=0; s4=0; s5=0; s6=0; s10=0; s11=0; s12=1; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					next_y2 = t2_0; end
					
		t2_38	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_39;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_40;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_42;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b0)) next_y2 = t2_38;
					else if ((IR[9] == 0) && (IR[8] == 1)) next_y2 = t2_43;
					else if ((IR[9] == 0) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_45;
					else if ((IR[9] == 0) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_47; end
					
		t2_39	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_40;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_42;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_39; end
					
		t2_40	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=1; s11=1; s12=1; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=1;
					next_y2 = t2_41; end
					
		t2_41	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_42	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=1; s11=1; s12=1; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_43	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_44;
					else next_y2 = t2_43; end
					
		t2_44	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[2:0] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[2:0] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[2:0] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[2:0] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[2:0] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[2:0] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					if (IR[21] == 1) next_y2 = t2_45;
					else if (IR[21] == 0) next_y2 = t2_47; end

		t2_45	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=1; s11=1; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; ODV=0; LSR=1;
					if (IR[2:0] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end				//Source R0
					else if (IR[2:0] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[2:0] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[2:0] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[2:0] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[2:0] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					next_y2 = t2_46; end
					
		t2_46	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_47	:	begin s3=0; s4=0; s5=0; s6=0; s10=1; s11=1; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_48	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_49;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_50;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_52;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b0)) next_y2 = t2_48;
					else if ((IR[9] == 0) && (IR[8] == 1)) next_y2 = t2_53;
					else if ((IR[9] == 0) && (IR[8] == 0)) next_y2 = t2_54; end
					
		t2_49	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_50;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_52;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_49; end
					
		t2_50	:	begin s3=0; s4=0; s5=0; s6=1; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0; s13=IR[12]; s14=IR[11]; s15=IR[10];
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_51; end
					
		t2_51	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_52	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0; s13=IR[12]; s14=IR[11]; s15=IR[10];
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_53	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_55;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_57;
					else next_y2 = t2_53; end
					
		t2_54	:	begin s3=0; s4=1; s5=0; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=1; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[21] == 1) next_y2 = t2_55;
					else if (IR[21] == 0) next_y2 = t2_57; end

		t2_55	:	begin s3=0; s4=0; s5=0; s6=1; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0; s13=IR[12]; s14=IR[11]; s15=IR[10];
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; ODV=0; LSR=0;
					next_y2 = t2_56; end
					
		t2_56	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_57	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=1; s11=1; s12=0; s13=IR[12]; s14=IR[11]; s15=IR[10];
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
		
		t2_58	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_59;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 1)) next_y2 = t2_60;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b1) && (IR[8] == 0) && (IR[21] == 0)) next_y2 = t2_62;
					else if ((IR[9] == 1) && (D_Cache_Ready == 1'b0)) next_y2 = t2_58;
					else if ((IR[9] == 0) && (IR[8] == 1)) next_y2 = t2_63;
					else if ((IR[9] == 0) && (IR[8] == 0)) next_y2 = t2_64; end
					
		t2_59	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_60;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_62;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_59; end
					
		t2_60	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=1; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (IR[22] == 1) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=1; s14=0; s15=0; end
						else if (IR[11:10] == "10") begin s13=1; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=1; s14=1; s15=0; end
						end
					else if (IR[22] == 0) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=0; s14=1; s15=0; end
						else if (IR[11:10] == "10") begin s13=0; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=0; s14=0; s15=0; end
					end
					next_y2 = t2_61; end
					
		t2_61	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_62	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[22] == 1) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=1; s14=0; s15=0; end
						else if (IR[11:10] == "10") begin s13=1; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=1; s14=1; s15=0; end
						end
					else if (IR[22] == 0) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=0; s14=1; s15=0; end
						else if (IR[11:10] == "10") begin s13=0; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=0; s14=0; s15=0; end
					end
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end 
					
		t2_63	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if ((D_Cache_Ready == 1'b1) && (IR[21] == 1)) next_y2 = t2_65;
					else if ((D_Cache_Ready == 1'b1) && (IR[21] == 0)) next_y2 = t2_67;
					else next_y2 = t2_63; end
					
		t2_64	:	begin s3=0; s4=1; s5=0; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=1; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[21] == 1) next_y2 = t2_65;
					else if (IR[21] == 0) next_y2 = t2_67; end

		t2_65	:	begin s3=0; s4=0; s5=0; s6=1; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=1; ODV=0; LSR=0;
					if (IR[22] == 1) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=1; s14=0; s15=0; end
						else if (IR[11:10] == "10") begin s13=1; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=1; s14=1; s15=0; end
						end
					else if (IR[22] == 0) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=0; s14=1; s15=0; end
						else if (IR[11:10] == "10") begin s13=0; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=0; s14=0; s15=0; end
					end
					next_y2 = t2_66; end
					
		t2_66	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_67	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=1; s11=1; s12=0;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[22] == 1) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=1; s14=0; s15=0; end
						else if (IR[11:10] == "10") begin s13=1; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=1; s14=1; s15=0; end
						end
					else if (IR[22] == 0) begin
						if (IR[11:10] == "00") begin s13=0; s14=1; s15=1; end
						else if (IR[11:10] == "01") begin s13=0; s14=1; s15=0; end
						else if (IR[11:10] == "10") begin s13=0; s14=0; s15=1; end
						else if (IR[11:10] == "11") begin s13=0; s14=0; s15=0; end
					end
					if (IR[15:13] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[15:13] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[15:13] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[15:13] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[15:13] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[15:13] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_68	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; sm2_ready=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if ((IR[3] == 1) && (D_Cache_Ready == 1'b1)) next_y2 = t2_69;
					else if ((IR[3] == 1) && (D_Cache_Ready == 1'b0)) next_y2 = t2_68;
					else if ((IR[3] == 0) && (IR[7] == 1)) next_y2 = t2_70;
					else if ((IR[3] == 0) && (IR[7] == 0)) next_y2 = t2_72; end
					
		t2_69	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=1;
					if (IR[2:0] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Source R0
					else if (IR[2:0] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Source R1
					else if (IR[2:0] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Source R2
					else if (IR[2:0] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Source R3
					else if (IR[2:0] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Source R4
					else if (IR[2:0] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Source R5
					if (IR[7] == 1) next_y2 = t2_70;
					else if (IR[7] == 0) next_y2 = t2_72; end
					
		t2_70	:	begin s3=0; s4=0; s5=1; s6=1; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=0; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0;
					if (IR[6:4] == "000") begin s7=0; s8=0; s9=0; end				//Dest R0
					else if (IR[6:4] == "001") begin s7=0; s8=0; s9=1; end		//Dest R1
					else if (IR[6:4] == "010") begin s7=0; s8=1; s9=0; end		//Dest R2
					else if (IR[6:4] == "011") begin s7=0; s8=1; s9=1; end		//Dest R3
					else if (IR[6:4] == "100") begin s7=1; s8=0; s9=0; end		//Dest R4
					else if (IR[6:4] == "101") begin s7=1; s8=0; s9=1; end		//Dest R5
					if (D_Cache_Ready == 1'b1) next_y2 = t2_71;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_70; end
					
		t2_71	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					next_y2 = t2_0; end
					
		t2_72	:	begin s3=0; s4=0; s5=0; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; ODV=0; LSR=0;
					if (IR[2:0] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[2:0] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[2:0] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[2:0] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[2:0] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[2:0] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					if (IR[6:4] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[6:4] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[6:4] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[6:4] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[6:4] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[6:4] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_73	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if (IR[8] == 1) next_y2 = t2_74;
					else if (IR[8] == 0) next_y2 = t2_75; end
					
		t2_74	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b1) next_y2 = t2_75;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_74; end
					
		t2_75	:	begin s3=0; s4=0; s5=0; s6=0; s7=1; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (IR[11:9] == "000") begin LR0=1; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; end			//Dest R0
					else if (IR[11:9] == "001") begin LR0=0; LR1=1; LR2=0; LR3=0; LR4=0; LR5=0; end		//Dest R1
					else if (IR[11:9] == "010") begin LR0=0; LR1=0; LR2=1; LR3=0; LR4=0; LR5=0; end		//Dest R2
					else if (IR[11:9] == "011") begin LR0=0; LR1=0; LR2=0; LR3=1; LR4=0; LR5=0; end		//Dest R3
					else if (IR[11:9] == "100") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=1; LR5=0; end		//Dest R4
					else if (IR[11:9] == "101") begin LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=1; end		//Dest R5
					next_y2 = t2_0; end
					
		t2_76	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if ((IR[11] == 1) && D_Cache_Ready == 1'b1) next_y2 = t2_77;
					else if ((IR[11] == 1) && D_Cache_Ready == 1'b0) next_y2 = t2_76;
					else if (IR[11] == 0) next_y2 = t2_78; end
					
		t2_77	:	begin s3=0; s4=1; s5=1; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=1; LMDR2=1; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					next_y2 = t2_0; end
					
		t2_78	:	begin s3=0; s4=1; s5=0; s6=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=1; LMAR2=0; LMDR2=1; ODV=0; LSR=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0;
					if (IR[11:9] == "000") begin s7=0; s8=0; s9=0; end				//Source R0
					else if (IR[11:9] == "001") begin s7=0; s8=0; s9=1; end		//Source R1
					else if (IR[11:9] == "010") begin s7=0; s8=1; s9=0; end		//Source R2
					else if (IR[11:9] == "011") begin s7=0; s8=1; s9=1; end		//Source R3
					else if (IR[11:9] == "100") begin s7=1; s8=0; s9=0; end		//Source R4
					else if (IR[11:9] == "101") begin s7=1; s8=0; s9=1; end		//Source R5
					next_y2 = t2_0; end
					
		t2_79	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0; sm2_ready=0;
					if ((D_Cache_Ready == 1'b1) && (IR[8] == 1)) next_y2 = t2_80;
					else if ((D_Cache_Ready == 1'b1) && (IR[8] == 0)) next_y2 = t2_81;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_79; end
					
		t2_80	:	begin s3=0; s4=0; s5=0; s6=1; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=1; D_Cache_W=0; LMAR2=1; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=0; LSR=0;
					if (D_Cache_Ready == 1'b1) next_y2 = t2_81;
					else if (D_Cache_Ready == 1'b0) next_y2 = t2_80; end
					
		t2_81	:	begin s3=0; s4=0; s5=0; s6=0; s7=0; s8=0; s9=0; s10=0; s11=0; s12=0; s13=0; s14=1; s15=1;
					D_Cache_R=0; D_Cache_W=0; LMAR2=0; LMDR2=0; LR0=0; LR1=0; LR2=0; LR3=0; LR4=0; LR5=0; ODV=1; LSR=0;
					if (IDV == 1) next_y2 = t2_0; 
					else next_y2 = t2_81; end
		endcase
	end

	always @ (reset or clk)
	begin
		if (reset==1'b0) begin
			y1 <= t1_0;
			y2 <= t2_0;
		end
		else if (clk == 1'b1) begin
			y1 <= next_y1;
			y2 <= next_y2;
		end
	end

endmodule

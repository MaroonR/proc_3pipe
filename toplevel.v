`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:27 04/27/2015 
// Design Name: 
// Module Name:    toplevel 
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
module toplevel(clk
    );

input clk;

instruction_fetch IF();
HW6_load_store_reg_n_bit PIPELINE_STAGE_1();
instruction_decode ID();
HW6_load_store_reg_n_bit PIPELINE_STAGE_2();
execute EX();
//I'm adding this in for demo purposes, but it is not part of our design
//we may or may not want it.
//HW6_load_store_reg_n_bit PIPELINE_STAGE_3

endmodule

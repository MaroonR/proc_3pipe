`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:11 04/27/2015 
// Design Name: 
// Module Name:    hw1_4x1_MUX_RTL 
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
module hw1_4x1_MUX_RTL(i, s, o);

  input [3:0]i;
  input [1:0]s;
  output o;
  
  assign o = i[s];

endmodule

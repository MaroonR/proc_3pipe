`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:37 04/27/2015 
// Design Name: 
// Module Name:    hw1_2x1_MUX_behav 
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
module hw1_2x1_MUX_behav(s,i1,i0,o);

  input s, i1, i0;
  output o;
  reg o;

  always @(*)
  begin
    o = s ? i1 : i0;
  end

endmodule

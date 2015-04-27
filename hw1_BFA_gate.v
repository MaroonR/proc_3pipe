`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:04 04/27/2015 
// Design Name: 
// Module Name:    hw1_BFA_gate 
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
module hw1_BFA_gate(a, b, cin, s, cout);

  input a, b, cin;
  output s, cout;
  wire wx0, wa0, wa1, wa2;

  //Calculate sum
  xor (wx0, a, b);
  xor (s, wx0, cin);
  
  //Caluclate carry
  and (wa0, a, b);
  and (wa1, a, cin);
  and (wa2, b, cin);

  or (cout, wa0, wa1, wa2);

endmodule

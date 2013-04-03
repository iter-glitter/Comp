`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren
// 
// Create Date:    18:17:17 02/05/2013 
// Design Name: 
// Module Name:    or_gate 
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
module or_gate(a,b,out);
	input a, b;
	output out;
	
	or OR1(out,a,b);

endmodule

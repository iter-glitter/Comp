`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren
// 
// Create Date:    21:10:34 01/24/2013 
// Design Name: 
// Module Name:    mux_2-1_rtl 
// Project Name: DVHW1 
// Target Devices: 
// Tool versions: 
// Description: 
//	2 to 1 MUX @ Register-Transfer-Level (RTL)
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2_1_rtl(i1, i2, sel, out);
	input i1, i2, sel; //i1: input 1, i2: input 2, sel: select
	output out;
	
	//2:1 Multiplexer function
	assign out = (~sel & i1)|(sel & i2); 


endmodule

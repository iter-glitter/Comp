`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// mux_2-1_rtl 
//	2 to 1 MUX @ Register-Transfer-Level (RTL)
// 
//	Select | OUTPUT
//   00    |   i0
//   01    |   i1
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2_1(i0, i1, sel, out);
	input i0, i1, sel; //i0: input 1, i1: input 2, sel: select
	output out;
	
	//2:1 Multiplexer function
	assign out = (~sel & i0)|(sel & i1); 


endmodule

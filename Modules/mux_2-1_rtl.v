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
//////////////////////////////////////////////////////////////////////////////////
module mux_2_1_rtl(i1, i2, sel, out);
	input i1, i2, sel; //i1: input 1, i2: input 2, sel: select
	output out;
	
	//2:1 Multiplexer function
	assign out = (~sel & i1)|(sel & i2); 


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:    bfa_gate 
//		Binary full adder with gate description
//
//////////////////////////////////////////////////////////////////////////////////
module bfa_gate(i0, i1, ci, sout, cout);

	input i0, i1, ci;
	output sout, cout;
	wire wxor, wand0, wand1;
	
	// Output, input, input
	xor Xor0(wxor, i0, i1);
	xor Xor1(sout, wxor, ci);
	and And0(wand0, wxor, ci);
	and And1(wand1, i0, i1);
	or  Or0(cout, wand0, wand1);

endmodule

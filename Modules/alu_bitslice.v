`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:  alu_bitslice 
//
// Data inputs: a, b, c_in (carry in)
// control inputs: c
// Output: f_out, c_out (carry out)
//
// Structural style - (Gate Level)
//
//////////////////////////////////////////////////////////////////////////////////
module alu_bitslice(a,b,c,c_in,c_out,f_out);

	input a;
	input b;
	input [2:0] c;
	input c_in;
	
	output f_out;
	output c_out;
	
	wire wire_bfa_out, w_or_out, w_and_out, w_not_out, w_b, w_not_b_out, w_not_a_out;
	wire w_fout;
	
	//Negate a and b (wires out)
	not b_not(w_not_b_out,b);
	not a_not(w_not_a_out,a);
	
	//B is negated when C[0] is 1, use 2x1 mux to make selection
	//module mux_2_1_rtl(i1, i2, sel, out);
	mux_2_1_rtl MUX_2x1_1(b,w_not_b_out,c[0],w_b);
	
	//Setup Binary Full Adder
	//module bfa_gate(i0, i1, ci, sout, cout);
	bfa_gate BFA(a,w_b,c_in,w_bfa_out,c_out);
	
	//OR Gate
	or OR_Gate(w_or_out, a, w_b);
	
	//AND Gate
	and AND_Gate(w_and_out, a, w_b);

	//The selection of ~a or ~b is made on c[0], use a 2x1 mux to make selection
	//module mux_2_1_rtl(i1, i2, sel, out);
	mux_2_1_rtl MUX_2x1_2(w_not_a_out, w_not_b_out, c[0], w_not_out);
	
	//f_out is determined on the selection of c[2] and c[1], use 4x1 mux
	//module mux_4_1_behavioral(i1, i2, i3, i4, sel, out);
	mux_4_1_behavioral MUX_4x1(w_bfa_out, w_or_out, w_and_out, w_not_out, c[2:1], w_fout);
	assign f_out = w_fout;


	
endmodule

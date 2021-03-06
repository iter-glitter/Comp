`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath - Spring 2013
// Accumulator Based Processor
//
// 2x1 MUX operation -
// Select | OUTPUT
//    0   |   i0
//    1   |   i1
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2_1(i0, i1, sel, out);
	input [7:0] i0, i1;
	input sel;
	output reg [7:0] out;
	
	always @(i0 or i1 or sel)
	begin
		case( sel )
			1'b0:	out = i0;
			1'b1:	out = i1;
			default: out = 8'b00000000;
		endcase
	end

endmodule


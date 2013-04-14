`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath - Spring 2013
// Accumulator Based Processor
//
// 4x1 MUX operation -
// Select | OUTPUT
//   00   |   i0
//   01   |   i1
//   10   |   i2
//   11   |   i3
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4_1(i0, i1, i2, i3, sel, out);
	input [7:0] i0, i1, i2, i3;
	input [1:0] sel;
	output reg [7:0] out;
	
	always @(i0 or i1 or i2 or i3 or sel)
	begin
		case( sel )
			2'b00:	out = i0;
			2'b01:	out = i1;
			2'b10:	out = i2;
			2'b11:	out = i3;
			default: out = 8'b00000000;
		endcase
	end

endmodule

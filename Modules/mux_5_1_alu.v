`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath - Spring 2013
// Accumulator Based Processor
//
// 5x1 MUX operation -
//
//	SELECT | OUTPUT
//   000   |   i0
//   001   |   i1
//   010   |   i2
//   011   |   i3
//   100   |   i4
//
//////////////////////////////////////////////////////////////////////////////////
module mux_ALU(i0, i1, i2, i3, i4, sel, out);
	input [7:0] i0, i1, i2, i3, i4;
	input [2:0] sel;
	output reg [7:0] out;
	
	always @(i0 or i1 or i2 or i3 or i4 or sel)
	begin
		case( sel )
			3'b000:	out = i0;
			3'b001:	out = i1;
			3'b010:	out = i2;
			3'b011:	out = i3;
			3'b100: out = 8'b00000000;
			default: out = 8'b00000000;
		endcase
	end

endmodule

//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath - Spring 2013
// Accumulator Based Processor
//
// 3x1 MUX operation -
// Select | OUTPUT
//   00   |   i0
//   01   |   i1
//   10   |   i2
//
//////////////////////////////////////////////////////////////////////////////////
module mux_3_1(i0, i1, i2, sel, out);
	input [7:0] i0, i1, i2;
	input [1:0] sel;
	output reg [7:0] out;
	
	always @(i0 or i1 or i2 or sel)
	begin
		case( sel )
			2'b00:	out = i0;
			2'b01:	out = i1;
			2'b10:	out = i2;
			default: out = 8'b00000000;
		endcase
	end

endmodule

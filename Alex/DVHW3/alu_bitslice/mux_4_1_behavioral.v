`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:15 01/24/2013 
// Design Name: 	
// Module Name:    mux_4_1_behavioral 
// Project Name:   DVHW1
// Target Devices: 
// Tool versions: 
// Description: 
//	4 to 1 multiplexer
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// 4x1 MUX operation -
// A high when i1 and i2 low
// B high when i2 low i1 high
// C high when i2 high i1 low
// D high when i2 high i1 high
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4_1_behavioral(i1, i2, i3, i4, sel, out);
	input i1, i2, i3, i4;
	input [1:0] sel;
	output out;
	reg out;
	
	always @(i1 or i2 or i3 or i4 or sel)
	begin
		case( sel )
			2'b00:	out = i1;
			2'b01:	out = i2;
			2'b10:	out = i3;
			2'b11:	out = i4;
			default:	out = 0;
		endcase
	end

endmodule

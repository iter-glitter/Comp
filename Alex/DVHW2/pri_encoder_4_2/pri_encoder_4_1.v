`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:55 02/01/2013 
// Design Name: 
// Module Name:    pri_encoder_4_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pri_encoder_4_1(i, out, dis);
	input [3:0] i;
	output [1:0] out;
	output dis;
	
	reg [1:0] out;
	reg dis;
	
	always @ (i) begin
		
		//How do you do "dont cares"? - 'x' did not work
		case(i)
			4'b0000: begin out = 2'bxx; dis=1; end
			4'b0001: begin out = 2'b00; dis=0; end
			4'b0010: begin out = 2'b01; dis=0; end
			4'b0011: begin out = 2'b01; dis=0; end
			4'b0100: begin out = 2'b10; dis=0; end
			4'b0101: begin out = 2'b10; dis=0; end
			4'b0110: begin out = 2'b10; dis=0; end
			4'b0111: begin out = 2'b10; dis=0; end
			4'b1000: begin out = 2'b11; dis=0; end
			4'b1001: begin out = 2'b11; dis=0; end
			4'b1010: begin out = 2'b11; dis=0; end
			4'b1011: begin out = 2'b11; dis=0; end
			4'b1100: begin out = 2'b11; dis=0; end
			4'b1101: begin out = 2'b11; dis=0; end
			4'b1110: begin out = 2'b11; dis=0; end
			4'b1111: begin out = 2'b11; dis=0; end
			default: out=2'bZZ;
		endcase
	end

endmodule

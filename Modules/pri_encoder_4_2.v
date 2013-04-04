`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Priority Encoder 4 x 2 
//
//////////////////////////////////////////////////////////////////////////////////
module pri_encoder_4_2(in, enab, out, valid);
	input [3:0] in;
	input enab;
	output reg [1:0] out;
	output reg valid;
	
	always @ (in or enab) begin
		if(enab==1'b0) begin
			out = 2'bZZ;
			valid = 1'b0;
		end
		else begin
			if(in[3]==1'b1) begin out=2'b11; valid=1'b1; end
			else if(in[2]==1'b1) begin out=2'b10; valid=1'b1; end
			else if(in[1]==1'b1) begin out=2'b01; valid=1'b1; end
			else if(in[0]==1'b1) begin out=2'b00; valid=1'b1; end
			else begin out=2'bZZ; valid=1'b0; end
		end
	end

endmodule

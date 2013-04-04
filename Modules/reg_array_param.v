`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Parameterized Register Array 
// reg_array_param.v
// 
// + Module uses a (2^m x n) array of registers. There are 2^m registers, each 4 bits wide. 
// + Read continuously (out continuously assigned to read address (radd)).
// + Write only when write enable is high (wrt_enab)
// + Write on negedge of clock
// + Read on posedge of clock 
// + Active Low synchronous clear takes precedence
// 
////////////////////////////////////////////////////////////////////////////////////////////
module reg_array_param(clk, clr, wrt_enab, d_in, radd, wadd, d_out);
	parameter m=2;
	parameter n=4;
	input clk, wrt_enab, clr;
	input [n-1:0] d_in;
	input [m-1:0] radd, wadd;
	output reg [n-1:0] d_out;
	
	reg [n-1:0] reg_arr[((2**m)-1):0];
	
	always @(posedge clk) begin
		d_out <= reg_arr[radd];
	end
	
	always @(negedge clk) begin
		if(clr==1'b0) 
		begin:clearBlock
			integer i;
			for(i=0; i<(2**m); i=i+1) begin:clearLoop
				reg_arr[i] <= 0; 
			end
		end
		else if(wrt_enab == 1'b1)
		begin
			reg_arr[wadd]<=d_in;
		end
	end

endmodule

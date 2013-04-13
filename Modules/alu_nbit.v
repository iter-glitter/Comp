`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:  alu_bitslice 
//
// Data inputs: in0, in1, c_in (carry in)
// control inputs: ctrl
// Output: alu_out, c_out (carry out), V (overflow)
//
//	ctrl2 ctrl1 ctrl0 | ALU Operation
//	  0     0    0    | in0 + in1 + c_in (ADD)
//	  0     0    1    | in0 + ~in1 + 1	 (SUB)
//	  0     1    0    | in0 | in1		 (OR)
//	  0     1    1    | in0 | ~in1		 (OR)
//	  1     0    0    | in0 & in1		 (AND)
//	  1     0    1    | in0 & ~in1		 (AND)
//	  1     1    0    | ~in0			 (COMPLEMENT)
//	  1     1    1    | ~in1			 (COMPLEMENT)
//
//
//////////////////////////////////////////////////////////////////////////////////
module alu_nbit(in0,in1,c_in,ctrl,c_out,alu_out,V);
	parameter n=8;
	input [n-1:0] in0,in1; 	//Input data1 and Input data2
	input c_in;				//Carry In
	input [2:0] ctrl; 		//ALU Control Lines
	output c_out;			//Carry out
	output [n-1:0] alu_out;	//ALU data Output
	output V;				//Overflow output
	
	wire [n:0] w_c;
	
	
	//Instantiate module alu_bitslice(a,b,c,c_in,c_out,alu_out);
	genvar i;
	assign w_c[0]=c_in;
	assign c_out = w_c[n];
	
	generate
		for(i=0;i<n;i=i+1) 
		begin:submit
			alu_bitslice ALU_slice(in0[i],in1[i],ctrl,w_c[i],w_c[i+1],alu_out[i]);
		end
	endgenerate
	xor overflow_detect(V,w_c[n],w_c[n-1]);
endmodule

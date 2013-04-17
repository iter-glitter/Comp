`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:58 02/12/2013 
// Design Name: 
// Module Name:    n_bit_alu_generate 
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
module n_bit_alu_generate(a,b,c_in,c,c_out,f_out,V);
	parameter n=4;
	input [n-1:0] a,b;
	input c_in;
	input [2:0] c; //control
	wire [n:0] w_c;
	
	output c_out;
	output [n-1:0] f_out;
	output V;
	
	//Instantiate module alu_bitslice(a,b,c,c_in,c_out,f_out);
	genvar i;
	assign w_c[0]=c_in;
	assign c_out = w_c[n];
	
	generate
		for(i=0;i<n;i=i+1) 
		begin:submit
			alu_bitslice ALU_slice(a[i],b[i],c,w_c[i],w_c[i+1],f_out[i]);
		end
	endgenerate
	xor overflow_detect(V,w_c[n],w_c[n-1]);
endmodule

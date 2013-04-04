`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:    ld_st_rg_struct_generate 
//
//////////////////////////////////////////////////////////////////////////////////
module ld_st_rg_struct_generate(set,clk,clr,sl_in,l_s,sl_out);
	parameter n=4;
	input clk, clr, set, l_s;
	input [n-1:0] sl_in;
	
	output [n-1:0] sl_out;
	
	genvar i;
	generate
		for(i=0;i<=n-1;i=i+1) 
		begin:submit
			//Format: ld_st_rg_sl_struct(set,clk,clr,sl_in,l_s,sl_out)
			ld_st_rg_sl_struct ld_st_sl(set,clk,clr,sl_in[i],l_s,sl_out[i]);
		end
	endgenerate
endmodule

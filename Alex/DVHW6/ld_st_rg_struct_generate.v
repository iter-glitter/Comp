`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren 
// 
// Create Date:    01:16:08 02/15/2013 
// Design Name: 
// Module Name:    ld_st_rg_struct_generate 
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
module ld_st_rg_struct_generate(set,clk,clr,sl_in,l_s,sl_out);
	parameter n=4;
	input clk, clr, set, l_s;
	input [n-1:0] sl_in;
	
	output [n-1:0] sl_out;
	
	genvar i;
	generate
		for(i=0;i<=n-1;i=i+1) 
		begin:submit
			//ld_st_rg_sl_struct(set,clk,clr,sl_in,l_s,sl_out)
			ld_st_rg_sl_struct ld_st_sl(set,clk,clr,sl_in[i],l_s,sl_out[i]);
		end
	endgenerate
endmodule

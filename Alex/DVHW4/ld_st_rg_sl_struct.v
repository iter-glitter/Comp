`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:55 02/14/2013 
// Design Name: 
// Module Name:    ld_st_rg_sl_struct 
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
module ld_st_rg_sl_struct(set,clk,clr,sl_in,l_s,sl_out);
	input set,clk,clr,sl_in,l_s;
	output sl_out;
	wire [1:0]w;

	assign sl_out = w[1];
	
	dff_syn_low_clr_set DFF0 (clk,w[0],set,clr,w[1]); //dff_syn_low_clr_set(clk,d,set,clr,q,q_cmp);
	mux_2_1_rtl	MUX0 (w[1],sl_in,l_s,w[0]);//mux_2_1_rtl(i1, i2, sel, out)

endmodule

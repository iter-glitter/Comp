`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath
// Accumulator Based Processor
//
// Module Name:    ld_st_rg_sl_struct 
//
//////////////////////////////////////////////////////////////////////////////////
module ld_st_rg_sl_struct(set,clk,clr,sl_in,l_s,sl_out);
	input set,clk,clr,sl_in,l_s;
	output sl_out;
	wire [1:0]w;

	assign sl_out = w[1];
	
	//Format: dff_syn_low_clr_set(clk,d,set,clr,q,q_cmp);
	dff_syn_low_clr_set DFF0 (clk,w[0],set,clr,w[1]); 
	//Format: mux_2_1_rtl(i1, i2, sel, out)
	mux_2_1_rtl	MUX0 (w[1],sl_in,l_s,w[0]);

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:    dff_syn_low_clr_set 
//
//
// CLR and SET are Active Low. CLR -> Highest Priority
//
//////////////////////////////////////////////////////////////////////////////////
module dff_syn_low_clr_set(clk,d,set,clr,q,q_cmp);
	input clr, set, d, clk;
	output reg q;
	output q_cmp;
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin q=1'b0; end
		else if(set==1'b0) begin q=1'b1; end
		else begin q=d; end
	end
	
	assign q_cmp=~q;

endmodule

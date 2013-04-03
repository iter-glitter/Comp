`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Heath - Spring 2013
//
// D Flip Flop
//
// CLR and SET are Active Low. CLR -> Highest Priority
//
//
//////////////////////////////////////////////////////////////////////////////////
//module dff_syn_low_clr_set(clk,d,set,clr,q,q_cmp); //Use for q complement
module dff_syn_low_clr_set(clk,d,set,clr,q);
	input clr, set, clk;
	input [1:0] d;
	output reg [1:0]q;
	//output q_cmp;
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin q<=2'bZZ; end //Clear
		else if(set==1'b0) begin q<=2'bZZ; end //Active Low Set
		else begin q<=d; end 
	end
	
	//assign q_cmp=~q;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren
// 
// Create Date:    21:06:37 02/14/2013 
// Design Name: 
// Module Name:    dff_syn_low_clr_set 
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
// CLR and SET are Active Low. CLR -> Highest Priority
//
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

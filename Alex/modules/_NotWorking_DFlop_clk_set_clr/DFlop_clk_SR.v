`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: ALex Hendren
// 
// Create Date:    00:36:42 02/13/2013 
// Design Name: 
// Module Name:    DFlop_clk_SR 
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
module DFlop_clk_SR(D,clk,set,reset,Q);
	input D,clk,reset,set;
	output reg Q;
	
	always @ (posedge clk) begin
		if((set==0)&&(reset==0)) Q<=D;
		else if((set==0)&&(reset==1)) Q <= 0;
		else if((set==1)&&(reset==0)) Q <= 1;
		else if((set==1)&&(reset==1)) Q <= 1'bZ;
	end

endmodule

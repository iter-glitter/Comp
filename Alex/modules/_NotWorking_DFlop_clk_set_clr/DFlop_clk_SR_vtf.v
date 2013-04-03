`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:53:15 02/13/2013
// Design Name:   DFlop_clk_SR
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/modules/DFlop_clk_set_clr/DFlop_clk_SR_vtf.v
// Project Name:  DFlop_clk_set_clr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DFlop_clk_SR
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DFlop_clk_SR_vtf;

	// Inputs
	reg [2:0] cnt;
	reg clk;
	
	
	// Outputs
	wire Q;
	reg Q_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	//module DFlop_clk_SR(D,clk,set,reset,Q);
	DFlop_clk_SR uut (
		.D(cnt[0]), 
		.clk(clk), 
		.set(cnt[2]),
		.reset(cnt[1]), 
		.Q(Q)
	);

	//Create Clock
	initial begin
		// Initialize Inputs
		clk <= 0;
		
		// Wait 100 ns for global reset to finish
		#100 forever #60 clk = ~clk;
	end
	initial begin
		// Add stimulus here
		cnt<=0;
	end
   
	always@(posedge clk) begin
		cnt<=cnt+1;
		case(cnt[2:0])
			3'b000: Q_tc <= 0;
			3'b001: Q_tc <= 1;
			3'b010: Q_tc <= 0;
			3'b011: Q_tc <= 0;
			3'b100: Q_tc <= 1;
			3'b101: Q_tc <= 1;
			3'b110: Q_tc <= 1'bZ;
			3'b111: Q_tc <= 1'bZ;
		endcase
		
		#10 if(Q_tc==Q) error=0;
		else error=1;
	
	end
		
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:14:37 03/26/2013
// Design Name:   ls_reg
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/modules/ld_st_reg/ld_st_reg/ls_reg_vtf.v
// Project Name:  ld_st_reg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls_reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ld_st_reg_vtf;

	// Inputs
	reg [3:0] in;
	reg set;
	reg clr;
	reg clk;
	
	reg [5:0] cnt;

	// Outputs
	wire [3:0] out;
	reg [3:0] out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	ls_reg uut (
		.in(in), 
		.set(set), 
		.clr(clr), 
		.clk(clk), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		set = 0;
		clr = 0;
		clk = 0;
		cnt = 0;
	end
	
	
	always begin

		// Wait 100 ns for global reset to finish
		#100;
        
		
		#10 clk = ~clk;
	end
	
	always @(posedge clk) begin
		cnt = cnt+1;
	end
	
	always @(negedge clk) begin
		clr <= cnt[5];
		set <= cnt[4];
		in <= cnt[3:0];
	
	end
	// Add stimulus here
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin //CLEAR
			out_tc <= 4'b0000; 
		end
		else if(set==1'b0 && clr == 1'b1) begin // Store
			out_tc <= out_tc;
		end
		else if(set==1'b1 && clr == 1'b1) begin // Load
			out_tc <= in;
		end
		else begin
			out_tc <= 1'bZ;
		end
		
		#2 if(out == out_tc) begin error = 0; end
		else begin error = 1; end
	end
endmodule


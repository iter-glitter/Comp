`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:34:00 04/11/2013
// Design Name:   stack
// Module Name:   C:/Users/Hendren/Desktop/EE480-ACC/Stack/stack_vtf.v
// Project Name:  Stack
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stack
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stack_vtf;

	// Inputs
	reg en;
	reg clr;
	reg clk;
	reg con;
	reg [7:0] data_in;

	reg [10:0] ctr;
	
	integer size;
	
	// Outputs
	wire [7:0] data_out;
	reg [7:0] data_out_tc;
	reg error;
	wire full;

	// Instantiate the Unit Under Test (UUT)
	stack uut (
		.en(en), 
		.clr(clr), 
		.clk(clk), 
		.con(con), 
		.data_in(data_in), 
		.data_out(data_out), 
		.full(full)
	);

	initial begin
		// Initialize Inputs
		en = 0;
		clr = 1;
		clk = 0;
		con = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
	end

	// Generate Clock
	always
	begin
		#20 clk = ~clk;
	end
	
	always@(posedge clk) begin
		ctr = ctr+1;
	end
	
	always@(negedge clk) begin
		clr <= ctr[10];
		en <= ctr[9];
		con <= ctr [8];
		data_in <= ctr[7:0];
	end
	
	//Stimulus
	always@(posedge clk) begin
		if(clr == 1'b0) begin	// Clear all bits to zero
			data_out_tc <= 8'b00000000;
			size = 0;
			full <= 0;
		end
		else if(en == 1) begin //if enabled
			if (con == )
			begin
				data_out_tc = data_out_tc;
			end
		end
	end
	
	#1 if(data_out_tc == out) error = 0;
		else error = 1;
	end
     
	  
endmodule


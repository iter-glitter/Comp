`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:34:02 01/29/2013
// Design Name:   bfa_gate
// Module Name:   L:/EE480/HWDV1/bfa/bfa_gate_vtf.v
// Project Name:  bfa
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bfa_gate
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bfa_gate_vtf;

	// Inputs
	reg [2:0] counter;

	// Outputs
	wire sout;
	wire cout;
	reg sout_tc, cout_tc, error;

	// Instantiate the Unit Under Test (UUT)
	bfa_gate uut (
		.i0(counter[0]), 
		.i1(counter[1]), 
		.ci(counter[2]), 
		.sout(sout), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		counter=0;
		sout_tc=0;
		cout_tc=0;

		// Wait 100 ns for global reset to finish
		#100;

	end
	
	always begin
	#20 counter = counter + 1;
	
	if (counter[2:0] == 3'b000) begin
		sout_tc = 0;
		cout_tc = 0;
		end
	else if(counter[2:0] == 3'b001) begin
		sout_tc = 1;
		cout_tc = 0;
		end
	else if(counter[2:0] == 3'b010) begin
		sout_tc = 1;
		cout_tc = 0;
		end
	else if(counter[2:0] == 3'b011) begin
		sout_tc = 0;
		cout_tc = 1;
		end
	else if(counter[2:0] == 3'b100) begin
		sout_tc = 1;
		cout_tc = 0;
		end
	else if(counter[2:0] == 3'b101) begin
		sout_tc = 0;
		cout_tc = 1;
		end
	else if(counter[2:0] == 3'b110) begin
		sout_tc = 0;
		cout_tc = 1;
		end
	else if(counter[2:0] == 3'b111) begin
		sout_tc = 1;
		cout_tc = 1;
		end
	
	#1 if ((cout == cout_tc) && (sout == sout_tc)) error=0;
		else error = 1;
	
	end
	
	
endmodule


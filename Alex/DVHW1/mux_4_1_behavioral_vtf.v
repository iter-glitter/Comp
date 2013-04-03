`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:29:41 01/29/2013
// Design Name:   mux_4_1_behavioral
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW1/mux_4_1_behavioral_vtf.v
// Project Name:  DVHW1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_4_1_behavioral
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_4_1_behavioral_vtf;

	// Inputs
	reg [5:0] counter;

	// Outputs
	wire out;
	reg out_tc, error;

	// Instantiate the Unit Under Test (UUT)
	mux_4_1_behavioral uut (
		.i1(counter[0]), 
		.i2(counter[1]), 
		.i3(counter[2]), 
		.i4(counter[3]), 
		.sel(counter[5:4]), 
		.out(out)
	);

	initial 
	begin
		// Initialize Inputs
		counter = 0;
		y_tc = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	//Determine whgat theoretically correct outputs for Unit Under test should be
	always
	begin
	#20 counter = counter + 1; //Delay then increment counter
	
	//Counter[5:4] is equal to selelect (xx) or 2'bxx
	if (counter[5:4] == 2'b00) out_tc=counter[0];
	else if(counter[5:4] == 2'b01) out_tc=counter[1];
	else if(counter[5:4] == 2'b10) out_tc=counter[2];
	else if(counter[5:4] == 2'b11) out_tc=counter[3];
	else out_tc=1'bZ;
	
	#1 if (out == out_tc) error=0;
		else error=1;
	
	end
endmodule


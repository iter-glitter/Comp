`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:26 02/01/2013
// Design Name:   dec_param_enab
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW2/dec_param_enab/dec_parm_enab2.v
// Project Name:  dec_param_enab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dec_param_enab
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dec_parm_enab2;

	// Inputs
	reg [3:0] inp;
	reg enab;

	// Outputs
	wire [15:0] d;

	// Instantiate the Unit Under Test (UUT)
	dec_param_enab uut (
		.inp(inp), 
		.enab(enab), 
		.d(d)
	);

	initial begin
		// Initialize Inputs
		inp = 0;
		enab = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule


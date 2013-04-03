`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendrne
//
// Create Date:   16:14:25 02/01/2013
// Design Name:   dec_param_enab
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW2/dec_param_enab/dec_param_enab_vtf.v
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

module dec_param_enab_vtf;
	
	
	// Inputs
	reg [3:0] counter; //MSB = ENAB

	// Outputs
	wire [7:0] d;
	reg  [7:0] d_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	dec_param_enab uut (
		.inp(counter[2:0]), 
		.enab(counter[3]), 
		.d(d)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		error = 0;
		d_tc = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#40 counter = counter + 1;
	
		if( counter[3]==0 ) d_tc=8'b00000000;
		else if(counter[3]==1) 
		begin
			if(counter==4'b1000) 	  d_tc=8'b00000001;
			else if(counter==4'b1001) d_tc=8'b00000010;
			else if(counter==4'b1010) d_tc=8'b00000100;
			else if(counter==4'b1011) d_tc=8'b00001000;
			else if(counter==4'b1100) d_tc=8'b00010000;
			else if(counter==4'b1101) d_tc=8'b00100000;
			else if(counter==4'b1110) d_tc=8'b01000000;
			else if(counter==4'b1111) d_tc=8'b10000000;
		end
		else d_tc=8'bZZZZZZZZ;
	

	#1 if(d == d_tc) error = 0;
	else error = 1;	

	end

endmodule


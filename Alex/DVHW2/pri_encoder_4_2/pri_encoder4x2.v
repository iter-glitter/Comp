`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:29:05 02/01/2013
// Design Name:   pri_encoder_4_1
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW2/pri_encoder_4_2/pri_encoder_4_1_vtf.v
// Project Name:  pri_encoder_4_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pri_encoder_4_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pri_encoder_4_1_vtf;

	// Inputs
	reg [3:0] counter;

	// Outputs
	wire [1:0] out;
	wire dis;
	
	reg [1:0] out_tc;
	reg dis_tc;
	reg error;
	
	integer cnt;

	// Instantiate the Unit Under Test (UUT)
	pri_encoder_4_1 uut (
		.i(counter[3:0]), 
		.out(out), 
		.dis(dis)
	);

	initial begin
		// Initialize Inputs
		counter = 0;
		out_tc = 0;
		dis_tc = 0;
		error = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	
	end
	
	always begin
	#40 counter = counter + 1;
	
	
		if(counter==4'b0000) begin out_tc=2'bxx; dis_tc=1; end
		else if(counter[3]==1) 
			begin out_tc=2'b11; dis_tc=0; end
		else if(counter[3]==0 && counter[2]==1)
			begin out_tc=2'b10; dis_tc=0; end
		else if(counter[3]==0 && counter[2]==0 && counter[1]==1)
			begin out_tc=2'b01; dis_tc=0; end
		else if(counter[3]==0 && counter[2]==0 && counter[1]==0 && counter[0]==1)
			begin out_tc=2'b00; dis_tc=0; end
		else
			begin out_tc=2'bZZ; dis_tc=1'bZ; end
	
	#1 if( (out_tc==out) && (dis==dis_tc) ) error=0;
		else error=1;
	
	end
	
endmodule


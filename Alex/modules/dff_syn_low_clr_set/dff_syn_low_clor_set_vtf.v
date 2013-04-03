`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:15:06 02/14/2013
// Design Name:   dff_syn_low_clr_set
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/modules/dff_syn_low_clr_set/dff_syn_low_clor_set_vtf.v
// Project Name:  dff_syn_low_clr_set
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dff_syn_low_clr_set
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dff_syn_low_clor_set_vtf;


	// Inputs
	reg clk;
	reg d;
	reg set;
	reg clr;

	// Outputs
	wire q;
	wire q_cmp;
   reg q_tc,q_cmp_tc,error;

	// Instantiate the Unit Under Test (UUT)
	dff_syn_low_clr_set uut (
		.clk(clk), 
		.d(d), 
		.set(set), 
		.clr(clr), 
		.q(q), 
		.q_cmp(q_cmp)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		d = 0;
		set = 1;
		clr = 1;

		// Wait 100 ns for global reset to finish
		#100;
     
	  end
	  
	// Inclusion of '$monitor' Function to Show Line-by-Line Simulation Output Style
	initial // Initiation of a Process to Monitor Over Time Important Registers/Wires and Ports, etc.
	begin		// During Simulation Run
	
		$monitor($time, "clk=%b clr=%b set=%b d=%b q=%b q_cmp=%b q_tc=%b q_cmp_tc=%b error=%b", clk,clr,set,d,q,q_cmp,q_tc,q_cmp_tc,error); 
	end
	  
	// Generate Continually Running Clock (clk)
	// 20 nsec Cycle Time
	always
	begin
	 
	#10 clk = ~clk;
	 
	end
	 
	// Initiation of a Process (Test Vector Generation).
	// Use a Counter (c) Approach - Specify Count(s) When Inputs are High/Low.
	always	
		begin: testloop  // Start of Generation of Exhaustive Set
		integer c;
		for (c=0 ; c < 64; c=c+1)
		begin: c_loop
				
			// Test Vectors are Assigned to Inputs of MUT.

			#20		clr <= ~((~c[5]&~c[4]&~c[3]&~c[2]&c[1]&~c[0]) | (c[5]&c[4]&~c[3]&~c[2]&c[1]&c[0]) | (~c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0]));	
						set <= ~((~c[5]&~c[4]&c[3]&~c[2]&~c[1]&~c[0]) | (c[5]&~c[4]&~c[3]&~c[2]&~c[1]&c[0]) | (~c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0]));
						d <= c[3];
						
			end
			#250 error=1; 
		//#20 $finish; // Terminates Any Endless Loops That May Have Been Unknowingly Created in Testbench.
		end
	
		
		
		always @ (posedge(clk)) //Initiation of a Process To Generate Theoretically Correct Output
		begin							

		if (clr==1'b0) begin q_tc=1'b0;q_cmp_tc=1'b1; end 
		else if (set==1'b0) begin q_tc=1'b1;q_cmp_tc=1'b0; end
		else
			begin
		case (d)
			1'b0: begin q_tc=1'b0; q_cmp_tc=1'b1;end
			1'b1: begin q_tc=1'b1; q_cmp_tc=1'b0;end
			default begin q_tc=1'bZ; q_cmp_tc=1'bZ;end
		endcase

	#1	if((q==q_tc)&&(q_cmp==q_cmp_tc)) error=0; // Compare of MUT Outputs (q and q_cmp) to Theoretically
		else error=1;


		end
	end
      
endmodule


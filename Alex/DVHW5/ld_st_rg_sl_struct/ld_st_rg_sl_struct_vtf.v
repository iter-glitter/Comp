`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:33:57 02/14/2013
// Design Name:   ld_st_rg_sl_struct
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW4/ld_st_rg_sl_struct_vtf.v
// Project Name:  DVHW4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ld_st_rg_sl_struct
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ld_st_rg_sl_struct_vtf;

	// Inputs
	reg set;
	reg clk;
	reg clr;
	reg sl_in;
	reg l_s;

	// Outputs
	wire sl_out;
	reg sl_out_tc, error;

	// Instantiate the Unit Under Test (UUT)
	ld_st_rg_sl_struct uut (
		.set(set), 
		.clk(clk), 
		.clr(clr), 
		.sl_in(sl_in), 
		.l_s(l_s), 
		.sl_out(sl_out)
	);

	initial begin
		// Initialize Inputs
		set = 1;
		clk = 0;
		clr = 1;
		sl_in = 0;
		l_s = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
	
	//Generate CLOCK signal
	always begin
	#10 clk = ~clk;
	end
	
	always
		begin: testloop
		integer c;
		for(c=0; c<64; c=c+1) 
		begin: c_loop
			#20	clr <= ~((c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&c[4]&c[3]&~c[2]&c[1]&~c[0])|(c[5]&c[4]&c[3]&~c[2]&~c[1]&c[0])|(c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&~c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&~c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&~c[2]&~c[1]&~c[0])|(~c[5]&c[4]&~c[3]&c[2]&~c[1]&~c[0])|(~c[5]&~c[4]&c[3]&~c[2]&c[1]&~c[0])|(~c[5]&~c[4]&c[3]&~c[2]&~c[1]&c[0])|(~c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0]));
					set <= ~((c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&c[4]&~c[3]&c[2]&~c[1]&c[0])|(c[5]&~c[4]&c[3]&~c[2]&c[1]&~c[0])|(c[5]&~c[4]&c[3]&~c[2]&~c[1]&c[0])|(c[5]&~c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&c[2]&~c[1]&~c[0])|(~c[5]&c[4]&~c[3]&c[2]&~c[1]&~c[0])|(~c[5]&~c[4]&c[3]&c[2]&c[1]&c[0])|(~c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0])|(~c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0]));
					sl_in <= ~c[5];
					l_s <= ~c[4]; 
		end
		//#250 error=1; //Signal end of run
	end
	
	always @ (posedge(clk)) begin
		if(clr==1'b0) 
		begin 
			sl_out_tc = 0; 
		end
		else if(set==1'b0)
		begin
			sl_out_tc = 1;
		end
		else if(l_s==1'b1) 
		begin 
			sl_out_tc=sl_in; 
		end
		else 
		begin 
			sl_out_tc=sl_out_tc; 
		end
		
		
		#1 if(sl_out == sl_out_tc) error = 0;
			else error = 1;
	end

endmodule


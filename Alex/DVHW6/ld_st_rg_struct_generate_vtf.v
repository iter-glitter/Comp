`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren
//
// Create Date:   01:38:09 02/15/2013
// Design Name:   ld_st_rg_struct_generate
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW6/ld_st_rg_struct_generate_vtf.v
// Project Name:  DVHW6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ld_st_rg_struct_generate
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ld_st_rg_struct_generate_vtf;

	// Inputs
	reg set;
	reg clk;
	reg clr;
	reg [3:0] sl_in;
	reg l_s;

	// Outputs
	wire [3:0] sl_out;
	reg [3:0] sl_out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	ld_st_rg_struct_generate uut (
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
		for(c=0; c<512; c=c+1) 
		begin: c_loop
			#20	clr <= ~((c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&c[4]&c[3]&~c[2]&c[1]&~c[0])|(c[5]&c[4]&c[3]&~c[2]&~c[1]&c[0])|(c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&~c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&~c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&~c[2]&~c[1]&~c[0])|(~c[5]&c[4]&~c[3]&c[2]&~c[1]&~c[0])|(~c[5]&~c[4]&c[3]&~c[2]&c[1]&~c[0])|(~c[5]&~c[4]&c[3]&~c[2]&~c[1]&c[0])|(~c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0]));
					set <= ~((c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(c[5]&c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&c[4]&~c[3]&c[2]&~c[1]&c[0])|(c[5]&~c[4]&c[3]&~c[2]&c[1]&~c[0])|(c[5]&~c[4]&c[3]&~c[2]&~c[1]&c[0])|(c[5]&~c[4]&~c[3]&c[2]&c[1]&~c[0])|(c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&c[2]&~c[1]&c[0])|(~c[5]&c[4]&c[3]&c[2]&~c[1]&~c[0])|(~c[5]&c[4]&~c[3]&c[2]&~c[1]&~c[0])|(~c[5]&~c[4]&c[3]&c[2]&c[1]&c[0])|(~c[5]&~c[4]&c[3]&c[2]&c[1]&~c[0])|(~c[5]&~c[4]&~c[3]&c[2]&~c[1]&c[0]));
					sl_in[0] <= ~c[5];
					sl_in[1] <= ~c[6];
					sl_in[2] <= ~c[7];
					sl_in[3] <= ~c[8];
					l_s <= ~c[4]; 
		end
		//#250 error=1; //Signal end of run
	end
	
	always @ (posedge(clk)) begin
		
		begin: testloop_tc
			integer i;
			for(i=0; i<4; i=i+1)
			begin: i_loop
				if(clr==1'b0) 
				begin 
					sl_out_tc[i] = 0; 
				end
				else if(set==1'b0)
				begin
					sl_out_tc[i] = 1;
				end
				else if(l_s==1'b1) 
				begin 
					sl_out_tc[i]=sl_in[i]; 
				end
				else 
				begin 
					sl_out_tc[i]=sl_out_tc[i]; 
				end	
			end
		end
		
			#1 if(sl_out == sl_out_tc) error = 0;
				else error = 1;
	end
	
endmodule


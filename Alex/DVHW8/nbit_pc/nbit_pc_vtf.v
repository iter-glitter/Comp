`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:31:25 02/23/2013
// Design Name:   nbit_pc
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW8/nbit_pc/nbit_pc_vtf.v
// Project Name:  nbit_pc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: nbit_pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module nbit_pc_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg [1:0] ctrl;
	reg [3:0] pc_in;
	reg [6:0] cnt;
	// Outputs
	wire [3:0] pc_out;
	reg [3:0] pc_out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	nbit_pc uut (
		.clk(clk), 
		.clr(clr), 
		.ctrl(ctrl), 
		.pc_in(pc_in), 
		.pc_out(pc_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		ctrl = 0;
		pc_in = 0;
		
		cnt = 0;
		
	end
	
	always begin
		// Wait 100 ns for global reset to finish
		#100;
        
		// Generate clock signal
		#10 clk = ~clk;

	end
	
	always @ (posedge clk) begin
		//Increment counter
		cnt = cnt + 1;
	end
	
	always @ (negedge clk) begin
		clr <= cnt[6];
		ctrl <= cnt[5:4];
		pc_in <= cnt[3:0];
		
	end
   
	//Theoretically correct block
	always @ (posedge clk) begin
		if(clr==1'b0) begin pc_out_tc<=4'b0000; end
		else if(ctrl==2'b00) begin //Hold Count - Output does not change
			if     (pc_out_tc==4'b0000) begin pc_out_tc<=4'b0000; end
			else if(pc_out_tc==4'b0001) begin pc_out_tc<=4'b0001; end
			else if(pc_out_tc==4'b0010) begin pc_out_tc<=4'b0010; end
			else if(pc_out_tc==4'b0011) begin pc_out_tc<=4'b0011; end
			else if(pc_out_tc==4'b0100) begin pc_out_tc<=4'b0100; end
			else if(pc_out_tc==4'b0101) begin pc_out_tc<=4'b0101; end
			else if(pc_out_tc==4'b0110) begin pc_out_tc<=4'b0110; end
			else if(pc_out_tc==4'b0111) begin pc_out_tc<=4'b0111; end
			else if(pc_out_tc==4'b1000) begin pc_out_tc<=4'b1000; end
			else if(pc_out_tc==4'b1001) begin pc_out_tc<=4'b1001; end
			else if(pc_out_tc==4'b1010) begin pc_out_tc<=4'b1010; end
			else if(pc_out_tc==4'b1011) begin pc_out_tc<=4'b1011; end
			else if(pc_out_tc==4'b1100) begin pc_out_tc<=4'b1100; end
			else if(pc_out_tc==4'b1101) begin pc_out_tc<=4'b1101; end
			else if(pc_out_tc==4'b1110) begin pc_out_tc<=4'b1110; end
			else if(pc_out_tc==4'b1111) begin pc_out_tc<=4'b1111; end
		end
		else if(ctrl==2'b01) begin //Load in parallel
			if     (pc_in==4'b0000) begin pc_out_tc<=4'b0000; end
			else if(pc_in==4'b0001) begin pc_out_tc<=4'b0001; end
			else if(pc_in==4'b0010) begin pc_out_tc<=4'b0010; end
			else if(pc_in==4'b0011) begin pc_out_tc<=4'b0011; end
			else if(pc_in==4'b0100) begin pc_out_tc<=4'b0100; end
			else if(pc_in==4'b0101) begin pc_out_tc<=4'b0101; end
			else if(pc_in==4'b0110) begin pc_out_tc<=4'b0110; end
			else if(pc_in==4'b0111) begin pc_out_tc<=4'b0111; end
			else if(pc_in==4'b1000) begin pc_out_tc<=4'b1000; end
			else if(pc_in==4'b1001) begin pc_out_tc<=4'b1001; end
			else if(pc_in==4'b1010) begin pc_out_tc<=4'b1010; end
			else if(pc_in==4'b1011) begin pc_out_tc<=4'b1011; end
			else if(pc_in==4'b1100) begin pc_out_tc<=4'b1100; end
			else if(pc_in==4'b1101) begin pc_out_tc<=4'b1101; end
			else if(pc_in==4'b1110) begin pc_out_tc<=4'b1110; end
			else if(pc_in==4'b1111) begin pc_out_tc<=4'b1111; end
		end
		else if(ctrl==2'b10) begin //Increment by 1
			if     (pc_out_tc==4'b0000) begin pc_out_tc<=4'b0001; end
			else if(pc_out_tc==4'b0001) begin pc_out_tc<=4'b0010; end
			else if(pc_out_tc==4'b0010) begin pc_out_tc<=4'b0011; end
			else if(pc_out_tc==4'b0011) begin pc_out_tc<=4'b0100; end
			else if(pc_out_tc==4'b0100) begin pc_out_tc<=4'b0101; end
			else if(pc_out_tc==4'b0101) begin pc_out_tc<=4'b0110; end
			else if(pc_out_tc==4'b0110) begin pc_out_tc<=4'b0111; end
			else if(pc_out_tc==4'b0111) begin pc_out_tc<=4'b1000; end
			else if(pc_out_tc==4'b1000) begin pc_out_tc<=4'b1001; end
			else if(pc_out_tc==4'b1001) begin pc_out_tc<=4'b1010; end
			else if(pc_out_tc==4'b1010) begin pc_out_tc<=4'b1011; end
			else if(pc_out_tc==4'b1011) begin pc_out_tc<=4'b1100; end
			else if(pc_out_tc==4'b1100) begin pc_out_tc<=4'b1101; end
			else if(pc_out_tc==4'b1101) begin pc_out_tc<=4'b1110; end
			else if(pc_out_tc==4'b1110) begin pc_out_tc<=4'b1111; end
			else if(pc_out_tc==4'b1111) begin pc_out_tc<=4'b0000; end
		end
		else if(ctrl==2'b11) begin //Increment by inc, where inc=2
			if     (pc_out_tc==4'b0000) begin pc_out_tc<=4'b0010; end
			else if(pc_out_tc==4'b0001) begin pc_out_tc<=4'b0011; end
			else if(pc_out_tc==4'b0010) begin pc_out_tc<=4'b0100; end
			else if(pc_out_tc==4'b0011) begin pc_out_tc<=4'b0101; end
			else if(pc_out_tc==4'b0100) begin pc_out_tc<=4'b0110; end
			else if(pc_out_tc==4'b0101) begin pc_out_tc<=4'b0111; end
			else if(pc_out_tc==4'b0110) begin pc_out_tc<=4'b1000; end
			else if(pc_out_tc==4'b0111) begin pc_out_tc<=4'b1001; end
			else if(pc_out_tc==4'b1000) begin pc_out_tc<=4'b1010; end
			else if(pc_out_tc==4'b1001) begin pc_out_tc<=4'b1011; end
			else if(pc_out_tc==4'b1010) begin pc_out_tc<=4'b1100; end
			else if(pc_out_tc==4'b1011) begin pc_out_tc<=4'b1101; end
			else if(pc_out_tc==4'b1100) begin pc_out_tc<=4'b1110; end
			else if(pc_out_tc==4'b1101) begin pc_out_tc<=4'b1111; end
			else if(pc_out_tc==4'b1110) begin pc_out_tc<=4'b0000; end
			else if(pc_out_tc==4'b1111) begin pc_out_tc<=4'b0001; end
		end
	
		# 3 if(pc_out_tc == pc_out) error <= 0;
		else error <= 1;
	end
endmodule


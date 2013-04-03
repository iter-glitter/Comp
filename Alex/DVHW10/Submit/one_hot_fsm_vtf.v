`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:46:19 03/19/2013
// Design Name:   one_hot_fsm
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW10/one_hot_fsm/one_hot_fsm_vtf.v
// Project Name:  one_hot_fsm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: one_hot_fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module one_hot_fsm_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg [1:0] x;
	reg start;
	
	reg [3:0] cnt;

	// Outputs
	wire [6:0] yp;
	wire [4:0] cp;
	
	reg [6:0] yp_tc;
	reg [4:0] cp_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	one_hot_fsm uut (
		.clk(clk), 
		.clr(clr), 
		.x(x), 
		.start(start), 
		.yp(yp), 
		.cp(cp)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		x = 0;
		start = 0;
		cnt = 0;     
	end
	
	always begin
		//Wait 100ns for GSR
		#100;
		
		//Generate Clock Signal
		#10 clk = ~clk;
	end
	
	always @ (posedge clk) begin
		//Increment Counter
		cnt = cnt + 1;
	end
	
	always @ (negedge clk) begin
		//Generate Stimulus
		clr <= cnt[3];
		start <= cnt[2];
		x <= cnt[1:0];
	end
	
   //Theoretically Correct block
	always @ (posedge clk) begin
		if(clr == 1'b0) begin
			yp_tc <= 7'b0000000;
			cp_tc <= 5'b00000; end
		else if(start == 1'b1) begin
			yp_tc <= 7'b1000000;
			cp_tc <= 5'b00110; end
		else begin
			if(yp_tc == 7'b1000000) begin //If current state = A
				if(x==2'b00) begin 
					yp_tc <= 7'b1000000;
					cp_tc <= 5'b00110; end
				else if(x==2'b01) begin //New present state = C
					yp_tc <= 7'b0010000;
					cp_tc <= 5'b01110; end
				else if(x==2'b11) begin //New Present state = D
					yp_tc <= 7'b0001000;
					cp_tc <= 5'b11001; end
				else if(x==2'b10) begin //New Present State = G
					yp_tc <= 7'b0000001;
					cp_tc <= 5'b10001; end
			end
			else if(yp_tc == 7'b0100000) begin //If current state = B
				if(x==2'b00) begin  //New Present state = D
					yp_tc <= 7'b0001000;
					cp_tc <= 5'b11001; end
				else if(x==2'b01) begin //New present state = A
					yp_tc <= 7'b1000000;
					cp_tc <= 5'b00110; end
				else if(x==2'b11) begin //New Present state = A
					yp_tc <= 7'b1000000;
					cp_tc <= 5'b00110; end
				else if(x==2'b10) begin //New Present State = F
					yp_tc <= 7'b0000010;
					cp_tc <= 5'b01000; end
			end
			else if(yp_tc == 7'b0010000) begin //If current state = C
				if(x==2'b00) begin  //New Present state = B
					yp_tc <= 7'b0100000;
					cp_tc <= 5'b10101; end
				else if(x==2'b01) begin //New present state = C
					yp_tc <= 7'b0010000;
					cp_tc <= 5'b01110; end
				else if(x==2'b11) begin //New Present state = D
					yp_tc <= 7'b0001000;
					cp_tc <= 5'b11001; end
				else if(x==2'b10) begin //New Present State = E
					yp_tc <= 7'b0000100;
					cp_tc <= 5'b01101; end
			end
			else if(yp_tc == 7'b0001000) begin //If current state = D
				if(x==2'b00) begin  //New Present state = F
					yp_tc <= 7'b0000010;
					cp_tc <= 5'b01000; end
				else if(x==2'b01) begin //New present state = G
					yp_tc <= 7'b0000001;
					cp_tc <= 5'b10001; end
				else if(x==2'b11) begin //New Present state = A
					yp_tc <= 7'b1000000;
					cp_tc <= 5'b00110; end
				else if(x==2'b10) begin //New Present State = F
					yp_tc <= 7'b0000010;
					cp_tc <= 5'b01000; end
			end
			else if(yp_tc == 7'b0000100) begin //If current state = E
				if(x==2'b00) begin  //New Present state = B
					yp_tc <= 7'b0100000;
					cp_tc <= 5'b10101; end
				else if(x==2'b01) begin //New present state = E
					yp_tc <= 7'b0000100;
					cp_tc <= 5'b01101; end
				else if(x==2'b11) begin //New Present state = B
					yp_tc <= 7'b0100000;
					cp_tc <= 5'b10101; end
				else if(x==2'b10) begin //New Present State = G
					yp_tc <= 7'b0000001;
					cp_tc <= 5'b10001; end
			end
			else if(yp_tc == 7'b0000010) begin //If current state = F
				if(x==2'b00) begin  //New Present state = A
					yp_tc <= 7'b1000000;
					cp_tc <= 5'b00110; end
				else if(x==2'b01) begin //New present state = B
					yp_tc <= 7'b0100000;
					cp_tc <= 5'b10101; end
				else if(x==2'b11) begin //New Present state = E
					yp_tc <= 7'b0000100;
					cp_tc <= 5'b01101; end
				else if(x==2'b10) begin //New Present State = D
					yp_tc <= 7'b0001000;
					cp_tc <= 5'b11001; end
			end
			else if(yp_tc == 7'b0000001) begin //If current state = G
				if(x==2'b00) begin  //New Present state = G
					yp_tc <= 7'b0000001;
					cp_tc <= 5'b10001; end
				else if(x==2'b01) begin //New present state = F
					yp_tc <= 7'b0000010;
					cp_tc <= 5'b01000; end
				else if(x==2'b11) begin //New Present state = E
					yp_tc <= 7'b0000100;
					cp_tc <= 5'b01101; end
				else if(x==2'b10) begin //New Present State = C
					yp_tc <= 7'b0010000;
					cp_tc <= 5'b01110; end
			end
			else begin //handle default case - New Present State = A
				yp_tc <= 7'b1000000;
				cp_tc <= 5'b00110; end
			end
		
		#2 if( (yp==yp_tc) && (cp==cp_tc) ) begin error = 0; end
		else begin error = 1; end
	end

	
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// EE480
// DVHW9
// Parameterized Register Array Test Fixture
// reg_array_param_vtf.v
// 
// + Module uses a (2^m x n) array of registers. There are 2^m registers, each
// 	4 bits wide. 
// + Read continuously (out continuously assigned to read address (radd)).
// + Write only when write enable is high (wrt_enab)
// + Write on negedge of clock
// + Read on posedge of clock 
// + Active Low synchronous clear takes precedence
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_array_param_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg wrt_enab;
	reg [3:0] d_in;
	reg [1:0] radd;
	reg [1:0] wadd;
	reg [9:0] cnt;

	reg [3:0] reg_arr[1:0];
	
	// Outputs
	wire [3:0] d_out;
	reg [3:0] d_out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	reg_array_param uut (
		.clk(clk), 
		.clr(clr), 
		.wrt_enab(wrt_enab), 
		.d_in(d_in), 
		.radd(radd), 
		.wadd(wadd), 
		.d_out(d_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		wrt_enab = 0;
		d_in = 0;
		radd = 0;
		wadd = 0;
		
		cnt = 0;
	end
	
	always begin
		// Wait 100 ns for global reset to finish
		#100;
		
		//Generate Clock
		#10 clk=~clk;
	end
	
	always @ (posedge clk) begin
		//Increment counter
		cnt=cnt+1;
	end
	
	always @ (negedge clk) begin
		clr <= cnt[9];
		wrt_enab <= cnt[8];
		d_in <= cnt[7:4];
		radd <= cnt[3:2];
		wadd <= cnt[1:0];
	end
	
	// Add stimulus here
   
	//Always write at negedge
	always @(negedge clk) begin
		if(clr==1'b0) begin 
			reg_arr[0] = 4'b0000; 
			reg_arr[1] = 4'b0000; 
			reg_arr[2] = 4'b0000; 
			reg_arr[3] = 4'b0000; 	
		end
		else if(wrt_enab==1'b1) begin
			if(wadd==2'b00) begin
				if     (d_in==4'b0000) begin reg_arr[0]<=4'b0000; end
				else if(d_in==4'b0001) begin reg_arr[0]<=4'b0001; end
				else if(d_in==4'b0010) begin reg_arr[0]<=4'b0010; end
				else if(d_in==4'b0011) begin reg_arr[0]<=4'b0011; end
				else if(d_in==4'b0100) begin reg_arr[0]<=4'b0100; end
				else if(d_in==4'b0101) begin reg_arr[0]<=4'b0101; end
				else if(d_in==4'b0110) begin reg_arr[0]<=4'b0110; end
				else if(d_in==4'b0111) begin reg_arr[0]<=4'b0111; end
				else if(d_in==4'b1000) begin reg_arr[0]<=4'b1000; end
				else if(d_in==4'b1001) begin reg_arr[0]<=4'b1001; end
				else if(d_in==4'b1010) begin reg_arr[0]<=4'b1010; end
				else if(d_in==4'b1011) begin reg_arr[0]<=4'b1011; end
				else if(d_in==4'b1100) begin reg_arr[0]<=4'b1100; end
				else if(d_in==4'b1101) begin reg_arr[0]<=4'b1101; end
				else if(d_in==4'b1110) begin reg_arr[0]<=4'b1110; end
				else if(d_in==4'b1111) begin reg_arr[0]<=4'b1111; end
			end
			else if(wadd==2'b01) begin
				if     (d_in==4'b0000) begin reg_arr[1]<=4'b0000; end
				else if(d_in==4'b0001) begin reg_arr[1]<=4'b0001; end
				else if(d_in==4'b0010) begin reg_arr[1]<=4'b0010; end
				else if(d_in==4'b0011) begin reg_arr[1]<=4'b0011; end
				else if(d_in==4'b0100) begin reg_arr[1]<=4'b0100; end
				else if(d_in==4'b0101) begin reg_arr[1]<=4'b0101; end
				else if(d_in==4'b0110) begin reg_arr[1]<=4'b0110; end
				else if(d_in==4'b0111) begin reg_arr[1]<=4'b0111; end
				else if(d_in==4'b1000) begin reg_arr[1]<=4'b1000; end
				else if(d_in==4'b1001) begin reg_arr[1]<=4'b1001; end
				else if(d_in==4'b1010) begin reg_arr[1]<=4'b1010; end
				else if(d_in==4'b1011) begin reg_arr[1]<=4'b1011; end
				else if(d_in==4'b1100) begin reg_arr[1]<=4'b1100; end
				else if(d_in==4'b1101) begin reg_arr[1]<=4'b1101; end
				else if(d_in==4'b1110) begin reg_arr[1]<=4'b1110; end
				else if(d_in==4'b1111) begin reg_arr[1]<=4'b1111; end
			end
			else if(wadd==2'b10) begin
				if     (d_in==4'b0000) begin reg_arr[2]<=4'b0000; end
				else if(d_in==4'b0001) begin reg_arr[2]<=4'b0001; end
				else if(d_in==4'b0010) begin reg_arr[2]<=4'b0010; end
				else if(d_in==4'b0011) begin reg_arr[2]<=4'b0011; end
				else if(d_in==4'b0100) begin reg_arr[2]<=4'b0100; end
				else if(d_in==4'b0101) begin reg_arr[2]<=4'b0101; end
				else if(d_in==4'b0110) begin reg_arr[2]<=4'b0110; end
				else if(d_in==4'b0111) begin reg_arr[2]<=4'b0111; end
				else if(d_in==4'b1000) begin reg_arr[2]<=4'b1000; end
				else if(d_in==4'b1001) begin reg_arr[2]<=4'b1001; end
				else if(d_in==4'b1010) begin reg_arr[2]<=4'b1010; end
				else if(d_in==4'b1011) begin reg_arr[2]<=4'b1011; end
				else if(d_in==4'b1100) begin reg_arr[2]<=4'b1100; end
				else if(d_in==4'b1101) begin reg_arr[2]<=4'b1101; end
				else if(d_in==4'b1110) begin reg_arr[2]<=4'b1110; end
				else if(d_in==4'b1111) begin reg_arr[2]<=4'b1111; end
			end
			else if(wadd==2'b11) begin
				if     (d_in==4'b0000) begin reg_arr[3]<=4'b0000; end
				else if(d_in==4'b0001) begin reg_arr[3]<=4'b0001; end
				else if(d_in==4'b0010) begin reg_arr[3]<=4'b0010; end
				else if(d_in==4'b0011) begin reg_arr[3]<=4'b0011; end
				else if(d_in==4'b0100) begin reg_arr[3]<=4'b0100; end
				else if(d_in==4'b0101) begin reg_arr[3]<=4'b0101; end
				else if(d_in==4'b0110) begin reg_arr[3]<=4'b0110; end
				else if(d_in==4'b0111) begin reg_arr[3]<=4'b0111; end
				else if(d_in==4'b1000) begin reg_arr[3]<=4'b1000; end
				else if(d_in==4'b1001) begin reg_arr[3]<=4'b1001; end
				else if(d_in==4'b1010) begin reg_arr[3]<=4'b1010; end
				else if(d_in==4'b1011) begin reg_arr[3]<=4'b1011; end
				else if(d_in==4'b1100) begin reg_arr[3]<=4'b1100; end
				else if(d_in==4'b1101) begin reg_arr[3]<=4'b1101; end
				else if(d_in==4'b1110) begin reg_arr[3]<=4'b1110; end
				else if(d_in==4'b1111) begin reg_arr[3]<=4'b1111; end
			end
		end
	end
	
	//Always Read at Posedge
	always@(posedge clk) begin
		if(radd==2'b00) begin
			if     (reg_arr[0]==4'b0000) begin d_out_tc<=4'b0000; end
			else if(reg_arr[0]==4'b0001) begin d_out_tc<=4'b0001; end
			else if(reg_arr[0]==4'b0010) begin d_out_tc<=4'b0010; end
			else if(reg_arr[0]==4'b0011) begin d_out_tc<=4'b0011; end
			else if(reg_arr[0]==4'b0100) begin d_out_tc<=4'b0100; end
			else if(reg_arr[0]==4'b0101) begin d_out_tc<=4'b0101; end
			else if(reg_arr[0]==4'b0110) begin d_out_tc<=4'b0110; end
			else if(reg_arr[0]==4'b0111) begin d_out_tc<=4'b0111; end
			else if(reg_arr[0]==4'b1000) begin d_out_tc<=4'b1000; end
			else if(reg_arr[0]==4'b1001) begin d_out_tc<=4'b1001; end
			else if(reg_arr[0]==4'b1010) begin d_out_tc<=4'b1010; end
			else if(reg_arr[0]==4'b1011) begin d_out_tc<=4'b1011; end
			else if(reg_arr[0]==4'b1100) begin d_out_tc<=4'b1100; end
			else if(reg_arr[0]==4'b1101) begin d_out_tc<=4'b1101; end
			else if(reg_arr[0]==4'b1110) begin d_out_tc<=4'b1110; end
			else if(reg_arr[0]==4'b1111) begin d_out_tc<=4'b1111; end
		end
		else if(radd==2'b01) begin
			if     (reg_arr[1]==4'b0000) begin d_out_tc<=4'b0000; end
			else if(reg_arr[1]==4'b0001) begin d_out_tc<=4'b0001; end
			else if(reg_arr[1]==4'b0010) begin d_out_tc<=4'b0010; end
			else if(reg_arr[1]==4'b0011) begin d_out_tc<=4'b0011; end
			else if(reg_arr[1]==4'b0100) begin d_out_tc<=4'b0100; end
			else if(reg_arr[1]==4'b0101) begin d_out_tc<=4'b0101; end
			else if(reg_arr[1]==4'b0110) begin d_out_tc<=4'b0110; end
			else if(reg_arr[1]==4'b0111) begin d_out_tc<=4'b0111; end
			else if(reg_arr[1]==4'b1000) begin d_out_tc<=4'b1000; end
			else if(reg_arr[1]==4'b1001) begin d_out_tc<=4'b1001; end
			else if(reg_arr[1]==4'b1010) begin d_out_tc<=4'b1010; end
			else if(reg_arr[1]==4'b1011) begin d_out_tc<=4'b1011; end
			else if(reg_arr[1]==4'b1100) begin d_out_tc<=4'b1100; end
			else if(reg_arr[1]==4'b1101) begin d_out_tc<=4'b1101; end
			else if(reg_arr[1]==4'b1110) begin d_out_tc<=4'b1110; end
			else if(reg_arr[1]==4'b1111) begin d_out_tc<=4'b1111; end
		end
		else if(radd==2'b10) begin
			if     (reg_arr[2]==4'b0000) begin d_out_tc<=4'b0000; end
			else if(reg_arr[2]==4'b0001) begin d_out_tc<=4'b0001; end
			else if(reg_arr[2]==4'b0010) begin d_out_tc<=4'b0010; end
			else if(reg_arr[2]==4'b0011) begin d_out_tc<=4'b0011; end
			else if(reg_arr[2]==4'b0100) begin d_out_tc<=4'b0100; end
			else if(reg_arr[2]==4'b0101) begin d_out_tc<=4'b0101; end
			else if(reg_arr[2]==4'b0110) begin d_out_tc<=4'b0110; end
			else if(reg_arr[2]==4'b0111) begin d_out_tc<=4'b0111; end
			else if(reg_arr[2]==4'b1000) begin d_out_tc<=4'b1000; end
			else if(reg_arr[2]==4'b1001) begin d_out_tc<=4'b1001; end
			else if(reg_arr[2]==4'b1010) begin d_out_tc<=4'b1010; end
			else if(reg_arr[2]==4'b1011) begin d_out_tc<=4'b1011; end
			else if(reg_arr[2]==4'b1100) begin d_out_tc<=4'b1100; end
			else if(reg_arr[2]==4'b1101) begin d_out_tc<=4'b1101; end
			else if(reg_arr[2]==4'b1110) begin d_out_tc<=4'b1110; end
			else if(reg_arr[2]==4'b1111) begin d_out_tc<=4'b1111; end
		end
		else if(radd==2'b11) begin
			if     (reg_arr[3]==4'b0000) begin d_out_tc<=4'b0000; end
			else if(reg_arr[3]==4'b0001) begin d_out_tc<=4'b0001; end
			else if(reg_arr[3]==4'b0010) begin d_out_tc<=4'b0010; end
			else if(reg_arr[3]==4'b0011) begin d_out_tc<=4'b0011; end
			else if(reg_arr[3]==4'b0100) begin d_out_tc<=4'b0100; end
			else if(reg_arr[3]==4'b0101) begin d_out_tc<=4'b0101; end
			else if(reg_arr[3]==4'b0110) begin d_out_tc<=4'b0110; end
			else if(reg_arr[3]==4'b0111) begin d_out_tc<=4'b0111; end
			else if(reg_arr[3]==4'b1000) begin d_out_tc<=4'b1000; end
			else if(reg_arr[3]==4'b1001) begin d_out_tc<=4'b1001; end
			else if(reg_arr[3]==4'b1010) begin d_out_tc<=4'b1010; end
			else if(reg_arr[3]==4'b1011) begin d_out_tc<=4'b1011; end
			else if(reg_arr[3]==4'b1100) begin d_out_tc<=4'b1100; end
			else if(reg_arr[3]==4'b1101) begin d_out_tc<=4'b1101; end
			else if(reg_arr[3]==4'b1110) begin d_out_tc<=4'b1110; end
			else if(reg_arr[3]==4'b1111) begin d_out_tc<=4'b1111; end
		end
		
		#2 if(d_out == d_out_tc) begin error = 0; end
		else begin error = 1; end
	end
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:41:58 04/04/2013
// Design Name:   ram
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/Project/Modules/Ram/Ram/ram_vtf.v
// Project Name:  Ram
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg enab;
	reg rw;
	reg [7:0] Addr;
	reg [7:0] data_in;
	
	reg [18:0] cnt;
	reg error;

	// Outputs
	wire [7:0] mem0;
	wire [7:0] mem1;
	wire [7:0] mem2;
	wire [7:0] mem3;
	wire [7:0] mem4;
	wire [7:0] mem5;
	wire [7:0] mem6;
	wire [7:0] mem7;
	wire [7:0] data_out;
	
	reg [7:0] mem0_tc;
	reg [7:0] mem1_tc;
	reg [7:0] mem2_tc;
	reg [7:0] mem3_tc;
	reg [7:0] mem4_tc;
	reg [7:0] mem5_tc;
	reg [7:0] mem6_tc;
	reg [7:0] mem7_tc;
	reg [7:0] data_out_tc;

	// Instantiate the Unit Under Test (UUT)
	ram uut (
		.clk(clk), 
		.clr(clr), 
		.enab(enab), 
		.rw(rw), 
		.Addr(Addr), 
		.data_in(data_in), 
		.mem0(mem0), 
		.mem1(mem1), 
		.mem2(mem2), 
		.mem3(mem3), 
		.mem4(mem4), 
		.mem5(mem5), 
		.mem6(mem6), 
		.mem7(mem7), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		enab = 0;
		rw = 0;
		Addr = 0;
		data_in = 0;
		
		cnt = 0;
	end
	
	always begin
		// Wait 100 ns for global reset to finish
		#100;
      
		#5 clk = ~clk;
		
	end
	
	always @ (posedge clk) begin
		cnt=cnt+1;
	end
	
	always @ (negedge clk) begin
		clr <= cnt[18];
		enab <= cnt[17];
		rw <= cnt[16];
		Addr <= cnt[15:8];
		data_in <= cnt[7:0];
	end
   
	// Add stimulus here
	
	always @(posedge clk) begin
		if(clr==1'b0) begin
			mem0_tc <= 8'b00000000;
			mem1_tc <= 8'b00000000;
			mem2_tc <= 8'b00000000;
			mem3_tc <= 8'b00000000;
			mem4_tc <= 8'b00000000;
			mem5_tc <= 8'b00000000;
			mem6_tc <= 8'b00000000;
			mem7_tc <= 8'b00000000;
			data_out_tc <= 8'bZZZZZZZZ;
		end
		else if(enab==1'b0) begin
			mem0_tc <= mem0_tc;
			mem1_tc <= mem1_tc;
			mem2_tc <= mem2_tc;
			mem3_tc <= mem3_tc;
			mem4_tc <= mem4_tc;
			mem5_tc <= mem5_tc;
			mem6_tc <= mem6_tc;
			mem7_tc <= mem7_tc;
			data_out_tc <= 8'bZZZZZZZZ;
		end
		else if(enab==1'b1) begin
			if(rw==1'b0) begin //READ
					  if(Addr==8'b00000000) begin data_out_tc <= mem0_tc; end
				else if(Addr==8'b00000001) begin data_out_tc <= mem1_tc; end
				else if(Addr==8'b00000010) begin data_out_tc <= mem2_tc; end
				else if(Addr==8'b00000011) begin data_out_tc <= mem3_tc; end
				else if(Addr==8'b00000100) begin data_out_tc <= mem4_tc; end
				else if(Addr==8'b00000101) begin data_out_tc <= mem5_tc; end
				else if(Addr==8'b00000110) begin data_out_tc <= mem6_tc; end
				else if(Addr==8'b00000111) begin data_out_tc <= mem7_tc; end
			end
			else if(rw==1'b1) begin //WRITE
					  if(Addr==8'b00000000) begin mem0_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000001) begin mem1_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000010) begin mem2_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000011) begin mem3_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000100) begin mem4_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000101) begin mem5_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000110) begin mem6_tc <= data_in; data_out_tc <= data_out_tc; end
				else if(Addr==8'b00000111) begin mem7_tc <= data_in; data_out_tc <= data_out_tc; end
			end
		end
		//(data_out==data_out_tc)&&
	#2 if( (mem0==mem0_tc)&&(mem1==mem1_tc)&&(mem2==mem2_tc)&&(mem3==mem3_tc)
			&&(mem4==mem4_tc)&&(mem5==mem5_tc)&&(mem6==mem6_tc)&&(mem7==mem7_tc) ) begin error=0; end
	else begin error=1; end
	
	end
	
endmodule


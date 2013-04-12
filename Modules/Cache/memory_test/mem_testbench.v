`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:16:46 04/11/2013
// Design Name:   mem_test
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/Project/Modules/Cache/memory_test/mem_testbench.v
// Project Name:  memory_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mem_test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_testbench;

	// Inputs
	reg clk;
	reg clr;

	// Outputs
	wire [3:0] state;
	wire [7:0] data_out;
	wire hit;
	wire [7:0] addr0;
	wire [7:0] addr1;
	wire [7:0] addr2;
	wire [7:0] addr3;
	wire [7:0] data0;
	wire [7:0] data1;
	wire [7:0] data2;
	wire [7:0] data3;
	wire [7:0] ram0;
	wire [7:0] ram1;
	wire [7:0] ram2;
	wire [7:0] ram3;
	wire [7:0] ram4;
	wire [7:0] ram5;
	wire [7:0] ram6;
	wire [7:0] ram7;
	wire [1:0] access0, access1, access2, access3;
	wire [7:0] cache_addr;
	wire [7:0] cache_data;
	wire cache_clr;
	wire cache_enab;
	wire cache_rw;
	wire [1:0] cache_lru;
	wire [1:0] cache_hit;
	wire [7:0] target_addr;
	wire [7:0] target_data;
	wire target_rw;
	wire [7:0] cache_addr_in;
	wire [7:0] cache_data_in;

	// Instantiate the Unit Under Test (UUT)
	mem_test uut (
		.clk(clk), 
		.clr(clr), 
		.state(state), 
		.data_out(data_out), 
		.target_rw(target_rw),
		.hit(hit), 
		.cache_hit(cache_hit), 
		.cache_addr_in(cache_addr_in),
		.cache_data_in(cache_data_in),
		.target_addr(target_addr), 
		.target_data(target_data),
		.addr0(addr0), 
		.addr1(addr1), 
		.addr2(addr2), 
		.addr3(addr3), 
		.data0(data0), 
		.data1(data1), 
		.data2(data2), 
		.data3(data3), 
		.ram0(ram0),
		.ram1(ram1), 
		.ram2(ram2), 
		.ram3(ram3), 
		.ram4(ram4),
		.ram5(ram5), 
		.ram6(ram6), 
		.ram7(ram7), 
		.cache_addr(cache_addr), 
		.cache_data(cache_data), 
		.cache_clr(cache_clr), 
		.cache_enab(cache_enab), 
		.cache_rw(cache_rw), 
		.cache_lru(cache_lru), 
		.access0(access0),
		.access1(access1),
		.access2(access2),
		.access3(access3)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
always begin

		// Wait 100 ns for global reset to finish
		#100;
      #3 clk = ~clk;
		// Add stimulus here

	end
//	
//	always @ (negedge clk) begin
//		clr <= cnt[20];
//		enab <= cnt[19];
//		rw <= cnt[10];
//	end
   always begin
		
		#140 clr <= 1;
		
/*		#140
			clr <= 1;
			enab <= 1;
		
		#145
			rw <= 1;*/
		
		/*#200
			addr <= 8'b00000001;
			data <= 8'b11100000;
		
		#2000
			addr <= 8'b00000010;
			data <= 8'b11000000;

		#6500
			addr <= 8'b10101010;
			data <= 8'b11000000;*/
		
		
		
		
	end   
endmodule


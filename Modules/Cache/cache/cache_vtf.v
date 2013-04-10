`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:35:30 04/09/2013
// Design Name:   cache
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/Project/Modules/Cache/cache/cache_vtf.v
// Project Name:  cache
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cache
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cache_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg enab;
	reg rw;
	reg [7:0] Addr;
	reg [7:0] data_in;
	reg [18:0] cnt;

	// Outputs
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

	// Instantiate the Unit Under Test (UUT)
	cache uut (
		.clk(clk), 
		.clr(clr), 
		.enab(enab), 
		.rw(rw), 
		.Addr(Addr), 
		.data_in(data_in), 
		.data_out(data_out), 
		.hit(hit), 
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
		.ram7(ram7)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		enab = 0;
		rw = 0;
		Addr = 0;
		data_in = 0;
	end
	
	always begin
		// Wait 100 ns for global reset to finish
		#100;
		#5 clk = ~clk;
	end
		
   always @ (posedge clk) begin
	
	end
	
	// Add stimulus here
      
endmodule


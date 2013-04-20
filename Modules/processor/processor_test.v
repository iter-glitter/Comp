`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:26:00 04/19/2013
// Design Name:   processor
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/Project/Modules/processor/processor_test.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module processor_test;

	// Inputs
	reg g_clk;
	reg g_clr;
	reg in_dev_hs;
	reg out_dev_hs;
	reg out_dev_ack;
	reg [7:0] input_bus;
	
	

	// Outputs
	wire in_dev_ack;
	wire [7:0] output_bus;
	wire [7:0] mem0;
	wire [7:0] mem1;
	wire [7:0] mem2;
	wire [7:0] mem3;
	wire [7:0] mem4;
	wire [7:0] mem5;
	wire [7:0] mem6;
	wire [7:0] mem7;
	wire [7:0] c_data0;
	wire [7:0] c_data1;
	wire [7:0] c_data2;
	wire [7:0] c_data3;
	wire [7:0] c_addr0;
	wire [7:0] c_addr1;
	wire [7:0] c_addr2;
	wire [7:0] c_addr3;
	wire [1:0] c_hit;
	wire [1:0] c_LRU;
	wire cache_hit;
	wire C;
	wire V;
	wire Z;
	wire [14:0] stage0;
	wire [64:0] stage1;
	wire stage0_rdy;
	wire stage1_rdy;
	wire [7:0] stg0_instr;
	wire [7:0] stg1_instr;
	wire [7:0] pc_output;
	wire [7:0] acc_reg_out;
	wire [7:0] alu_out_w;

	// Instantiate the Unit Under Test (UUT)
	processor uut (
		.g_clk(g_clk), 
		.g_clr(g_clr), 
		.in_dev_hs(in_dev_hs), 
		.out_dev_hs(out_dev_hs), 
		.out_dev_ack(out_dev_ack), 
		.in_dev_ack(in_dev_ack), 
		.input_bus(input_bus), 
		.output_bus(output_bus), 
		.mem0(mem0), 
		.mem1(mem1), 
		.mem2(mem2), 
		.mem3(mem3), 
		.mem4(mem4), 
		.mem5(mem5), 
		.mem6(mem6), 
		.mem7(mem7), 
		.c_data0(c_data0), 
		.c_data1(c_data1), 
		.c_data2(c_data2), 
		.c_data3(c_data3), 
		.c_addr0(c_addr0), 
		.c_addr1(c_addr1), 
		.c_addr2(c_addr2), 
		.c_addr3(c_addr3), 
		.c_hit(c_hit), 
		.c_LRU(c_LRU), 
		.cache_hit(cache_hit), 
		.C(C), 
		.V(V), 
		.Z(Z), 
		.stage0(stage0), 
		.stage1(stage1),
		.stage0_rdy(stage0_rdy),
		.stage1_rdy(stage1_rdy),
		.stg0_instr(stg0_instr),
		.stg1_instr(stg1_instr),
		.pc_output(pc_output),
		.acc_reg_out(acc_reg_out),
		.alu_out_w(alu_out_w)
	);

	initial begin
		// Initialize Inputs
		g_clk = 0;
		g_clr = 0;
		in_dev_hs = 1;
		out_dev_hs = 1;
		out_dev_ack = 1;
		input_bus = 8'b00001010;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin 
		#10 g_clk = ~g_clk; 
	end
	
	always begin
		#100 g_clr <= 1'b1;
	end
	
      
endmodule


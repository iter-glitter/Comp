`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Memory structure test
//
//////////////////////////////////////////////////////////////////////////////////
module mem_test(clk, clr, rw, enab, addr, data, state, data_out, hit, addr0, 
					addr1, addr2, addr3, data0, data1, data2, data3,
					ram0, ram1, ram2, ram3,
					cache_addr, cache_data, i_out, cache_clr, cache_enab, cache_rw, cache_lru, cache_hit,
					target_addr, target_data, target_rw, cache_input);
	reg [7:0] test_addr[7:0];
	initial begin
		test_addr[0] = 8'b00000001;	
		test_addr[1] = 8'b00000010;
		test_addr[2] = 8'b00000100;
		test_addr[3] = 8'b00001000;
		test_addr[4] = 8'b00010000;
		test_addr[5] = 8'b00100000;
		test_addr[6] = 8'b01000000;
		test_addr[7] = 8'b10000000;
	end
   reg [7:0] test_data [7:0];
	initial begin
		test_data[0] = 8'b00000000;
		test_data[1] = 8'b00000001;
		test_data[2] = 8'b00000010;
		test_data[3] = 8'b00000011;
		test_data[4] = 8'b00000100;
		test_data[5] = 8'b00000101;
		test_data[6] = 8'b00000110;
		test_data[7] = 8'b00000111;
	end
	
	input clk, clr, rw, enab;
	input [7:0] addr;
	input [7:0] data;
	reg [7:0] addr_wire, data_wire;
	output hit;
	output [7:0] data_out;
	output [7:0] addr0, addr1, addr2, addr3;
	output [7:0] data0, data1, data2, data3;
	output [7:0] ram0, ram1, ram2, ram3;
	output [3:0] state;
	output [1:0] cache_lru, cache_hit;
	integer i;
	output [31:0] i_out;
	assign i_out = i;
	
	output reg [7:0] cache_addr;
	output reg [7:0] cache_data;
	output reg cache_clr, cache_enab, cache_rw;
	
	output  [7:0] target_data;
	output  [7:0] target_addr;
	output target_rw;
	wire [7:0] target_data_wire, target_addr_wire;
	wire target_rw_wire;
	assign target_data = target_data_wire;
	assign target_addr = target_addr_wire;
	assign target_rw = target_rw_wire;
	
	wire c_hit;
	wire [7:0] c_data_out;
	wire [7:0] c_addr0, c_addr1, c_addr2, c_addr3;
	wire [7:0] c_data0, c_data1, c_data2, c_data3;
	wire [7:0] c_ram0, c_ram1, c_ram2, c_ram3, c_ram4, c_ram5, c_ram6, c_ram7;
	
	assign hit = c_hit;
	assign data_out = c_data_out;
	assign addr0 = c_addr0;
	assign addr1 = c_addr1;
	assign addr2 = c_addr2;
	assign addr3 = c_addr3;
	assign data0 = c_data0;
	assign data1 = c_data1;
	assign data2 = c_data2;
	assign data3 = c_data3;
	assign ram0 = c_ram0;
	assign ram1 = c_ram1;
	assign ram2 = c_ram2;
	assign ram3 = c_ram3;
	
	wire [1:0] lru_wire, hit_wire;
	assign cache_lru = lru_wire;
   assign cache_hit = hit_wire;
	wire [3:0] state_wire;
	assign state = state_wire;
	
	output [7:0] cache_input;
	wire [7:0] cache_input_wire;
	assign cache_input = cache_input_wire;
	
	/*		 cache(clk,clr,enab,rw,Addr,data_in,data_out, hit, addr0,  
					addr1, addr2, addr3, data0, data1, data2, data3,
					ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7);*/
	cache memory(clk,clr,enab,rw,cache_addr,cache_data, 
					c_data_out, c_hit, c_addr0, c_addr1, c_addr2, c_addr3, c_data0, c_data1,
					 c_data2, c_data3, c_ram0, c_ram1, c_ram2, c_ram3, 
					 state_wire, lru_wire, hit_wire, target_addr_wire, target_data_wire, target_rw_wire, cache_input_wire);
	
	always @(posedge clk) begin
		
		#200
			cache_addr <= 8'b00000001;
			cache_data <= 8'b11100000;
		
		#2000
			cache_addr <= 8'b00000010;
			cache_data <= 8'b11000000;

		#6500
			cache_addr <= 8'b10101010;
			cache_data <= 8'b11000000;
	
	end

	/*initial begin
		i = 0;
	end
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin
			cache_clr <= 1'b0;
		end
		else if(enab==1'b0) begin
			cache_clr <= 1'b1;
			cache_enab <= 1'b0;
		end
		else if(enab==1'b1) begin
			cache_clr <= 1'b1;
			cache_enab <= 1'b1;
			if(rw==1'b0) begin 			//READ
				cache_rw <= 1'b0;
				cache_addr <= test_addr[i];
				cache_data <= test_addr[i];
			end
			else if(rw==1'b1) begin 	//WRITE
				cache_rw <= 1'b1;
				cache_addr <= test_addr[i];
				cache_data <= test_addr[i];
			end
		end
		
	end
	
	always @ (negedge clk) begin
		i <= i + 1;
		if(i==8) begin i<=0; end
	end*/

endmodule

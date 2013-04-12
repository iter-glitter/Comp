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
module mem_test(clk, clr, state,  data_out, target_rw, hit, cache_hit, target_addr, 
					cache_addr_in, cache_data_in, target_data, addr0, 
					addr1, addr2, addr3, data0, data1, data2, data3,
					 cache_lru, access0, access1, access2, access3, 
					ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7,
					cache_addr, cache_data, cache_clr, cache_enab, cache_rw);
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
	
	input clk, clr;
	reg rw, enab;
	reg [7:0] addr;
	reg [7:0] data;
	reg [7:0] addr_wire, data_wire;
	output hit;
	output [7:0] data_out;
	output [7:0] addr0, addr1, addr2, addr3;
	output [7:0] data0, data1, data2, data3;
	output [7:0] ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7;
	output [1:0] access0, access1, access2, access3;
	output [3:0] state;
	output [1:0] cache_lru, cache_hit;
	integer i;
	
	output reg [7:0] cache_addr;
	output reg [7:0] cache_data;
	output cache_clr, cache_enab, cache_rw;
	
	
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
	wire [1:0] c_access0, c_access1, c_access2, c_access3;
	
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
	assign ram4 = c_ram4;
	assign ram5 = c_ram5;
	assign ram6 = c_ram6;
	assign ram7 = c_ram7;
	
	assign access0 = c_access0;
	assign access1 = c_access1;
	assign access2 = c_access2;
	assign access3 = c_access3;
	
	wire [1:0] lru_wire, hit_wire;
	assign cache_lru = lru_wire;
   assign cache_hit = hit_wire;
	wire [3:0] state_wire;
	assign state = state_wire;
	
	output [7:0] cache_addr_in;
	output [7:0] cache_data_in;
	wire [7:0] c_addr_in_wire;
	wire [7:0] c_data_in_wire;
	assign cache_addr_in = c_addr_in_wire;
	assign cache_data_in = c_data_in_wire;
	
	wire cache_rw_wire;
	assign cache_rw_wire = rw;
	assign cache_rw = cache_rw_wire;
	
	/*		 cache(clk,clr,enab,rw,Addr,data_in,data_out, hit, addr0, 
					addr1, addr2, addr3, data0, data1, data2, data3, access0, access1, access2, access3,
					ram0, ram1, ram2, ram3, state, curr_LRU, 
					cache_hit, target_addr, target_data, target_rw, cache_input_out); */
	cache memory(clk,clr,enab,rw,cache_addr,cache_data, 
					c_data_out, c_hit, c_addr0, c_addr1, c_addr2, c_addr3, c_data0, c_data1,
					 c_data2, c_data3, c_access0, c_access1, c_access2, c_access3, c_ram0, c_ram1, c_ram2, c_ram3, c_ram4, c_ram5, c_ram6, c_ram7, 
					 state_wire, lru_wire, hit_wire, target_addr_wire, target_data_wire, target_rw_wire, c_addr_in_wire, c_data_in_wire);
	
	initial begin
		cache_addr <= 8'b00000000;
		cache_data <= 8'b00000000;
		rw <= 1'b1;
	end
	
	always begin
		#100 enab <= 1'b1;
		
		#200 cache_addr <= 8'b00000001;
			cache_data <= 8'b11100000;
		
		#1500 cache_addr <= 8'b00000010;
			cache_data <= 8'b11000000;

		#3000 cache_addr <= 8'b00000011;
			cache_data <= 8'b11000111;
			
		#4500 cache_addr <= 8'b00000100;
			cache_data <= 8'b00011000;

		#9000 cache_addr <= 8'b00000010;

		#10500 cache_addr <= 8'b00000111;
			
		#19000 cache_addr <= 8'b00000001;
	
	end

	always @ (posedge clk) begin
		#8000 rw <= ~rw;
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

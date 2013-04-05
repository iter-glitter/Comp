`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
//  Cache : Fully Associative Cache - Behavioral Style (Parameterized)
//				4 Word Cache - Data: 8 bits wide, Address: 8 bits wide
//				Replacement Implementation: Least Recently Used (LRU)
//
// Inputs: Addr, enab, clr, rw, data_in
//				Addr: Target memory address
//				data_in: input line for data, Write to target address
//				enab: Chip enable line
//				clr:	Active low synchronous clear
//				rw:	Read/Write control line
//
// Outputs: data_out, addr0, addr1, addr2, addr3, data0, data1, data2, data3, hit
//				data_out: Output data port, Read from target address
//				addr0-3:	 Current contents of address registers within cache
//				data0-3:	 Current contents of data registers within cache
//				hit:		 Flags if the address was matched in the cache
//
//
//   rw    enab   clr    function
//   x      x      0     Clear all cache contents to zero *Top Priority
//   x 		0      1     RAM Chip not enabled - Do not read or write
//   0 		1      1     Read Target Address
//   1 		1      1		 Write 
//
//////////////////////////////////////////////////////////////////////////////////
module cache(clk,clr,enab,rw,Addr,data_in,data_out, hit, addr0, 
					addr1, addr2, addr3, data0, data1, data2, data3);
	//Specify address and data width
	parameter d_width = 8;
	parameter a_width = 8;
	parameter n = 4; //Cache size
	//Input Ports
	input clk, clr, enab, rw;
	input [a_width-1:0] Addr;
	input [d_width-1:0] data_in;
	//Output Ports
	output reg hit;
	output reg [d_width-1:0] data_out;
	output [a_width-1:0] addr0;
	output [a_width-1:0] addr1;
	output [a_width-1:0] addr2;
	output [a_width-1:0] addr3;
	output [d_width-1:0] data0;
	output [d_width-1:0] data1;
	output [d_width-1:0] data2;
	output [d_width-1:0] data3;
	//Declare Cache Registers
	reg [d_width-1:0] cache_data [n-1:0];
	reg [a_width-1:0] cache_addr [n-1:0];
	reg [1:0] cache_access [n-1:0];
	
	//Declare Cache Flag Registers
	reg curr_LRU;	//Index of current least recently used address
	reg [1:0] cache_hit; //Index of cache hit
	integer i;
	reg [3:0] state; //Current State Register
	
	//Assign Cache Data Monitor Outputs
	assign data0 = cache_data[0];
	assign data1 = cache_data[1];
	assign data2 = cache_data[2];
	assign data3 = cache_data[3];
	//Assign Cache Memory Address Monitor Outputs
	assign addr0 = cache_addr[0];
	assign addr1 = cache_addr[1];
	assign addr2 = cache_addr[2];
	assign addr3 = cache_addr[3];
	
	//Declare DATA Ram unit and wires to control the RAM
	reg ram_clr, ram_rw, ram_enab;
	wire [a_width-1:0] ram_addr;
	wire [d_width-1:0] ram_data_in;
	wire [d_width-1:0] ram_data_out;
	wire [d_width-1:0] ram_mem0;
	wire [d_width-1:0] ram_mem1;
	wire [d_width-1:0] ram_mem2;
	wire [d_width-1:0] ram_mem3;
	wire [d_width-1:0] ram_mem4;
	wire [d_width-1:0] ram_mem5;
	wire [d_width-1:0] ram_mem6;
	wire [d_width-1:0] ram_mem7;
	ram	DATA_RAM(clk, ram_clr, ram_enab, ram_rw, ram_addr, ram_data_in, 
							ram_mem0, ram_mem1, ram_mem2, ram_mem3, ram_mem4, 
							ram_mem5, ram_mem6, ram_mem7, ram_data_out);
	
	
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin //Clear Cache + DATA RAM
			state <= 0;
		end
		else if(enab==1'b0) begin //High Z State for output if chip not enabled
			state <= 0;
		end
		else if(enab==1'b1) begin //Only Read/Write if Cache Chip Enabled
			if(rw==1'b0) begin //READ
				ram_enab <= 1'b0;
				//Test if target address exists in cache entries
				for(i=0; i<n; i=i+1) begin:Read_Hit_Loop
					if(Addr==cache_addr[i]) begin //HIT @ Index i
						cache_hit <= i;
						hit <= 1'b1;
					end
				end
				if(hit==1'b1) begin						//HIT  on READ
					state <= 1;
				end //End Read Hit
				else begin									//MISS on READ
					hit <= 1'b0;
					ram_enab <= 1'b1;
					ram_addr <= cache_addr[curr_LRU];
					ram_data_in <= cache_data[curr_LRU];
					
				end //End Read Miss
			end //End Read
			else if(rw==1'b1) begin //WRITE
				ram_enab <= 1'b0;
				//Test if target address exists in cache entries
				if(Addr==cache_addr[0]) begin hit <= 1'b1; end
				else if(Addr==cache_addr[1]) begin hit <= 1'b1; end
				else if(Addr==cache_addr[2]) begin hit <= 1'b1; end
				else if(Addr==cache_addr[3]) begin hit <= 1'b1; end
			end
		end
		
	end
	
	
	always @ (negedge clk) begin
		case(state)
		0: //Clear State
		begin
			ram_clr <= 1'b0;
			for(i=0; i<4; i=i+1) begin:CLR_loop
				cache_data[i] <= 0;
				cache_addr[i] <= 0;
				cache_access[i] <= 0;
				//data_out <= 8'bZZZZZZZZ;
			end
		end
		1: //Read Hit
		begin
			data_out <= cache_data[cache_hit];
			//Update Access Records for LRU
			for(i=0; i<n; i=i+1) begin:Update_Access_Loop
				if(i!=cache_hit) begin 
					if(cache_access[i]>cache_access[cache_hit]) begin
						//Outdated Access record, decrement records greater than 
						//the hit record by 1. Hit record will be set to highest
						//access metric of 3, indicating most recently used. 
						cache_access[i] <= cache_access[i]-1;
						if(cache_access[i]==0) begin curr_LRU <= i; end
					end
				end
			end //End Update_Access_Loop
			//Update hit index to most recently used entry
			cache_access[cache_hit] <= 3;
		end
		endcase
		
	end

endmodule

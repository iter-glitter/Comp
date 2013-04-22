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
/*module cache(clk,clr,enab,rw,Addr,data_in,data_out, hit_out, addr0, 
					addr1, addr2, addr3, data0, data1, data2, data3, access0, access1, access2, access3,
					ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7, state, curr_LRU, 
					cache_hit, target_addr, target_data, target_rw_out, c_addrIN_out, c_dataIN_out);*/
module cache(clk,clr,enab,rw,Addr,data_in,data_out, hit_out, 
					addr0, addr1, addr2, addr3, data0, data1, data2, data3, 
					ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7, curr_LRU, cache_hit, target_rw_out, c_dataIN_out, state);
					
	
	//Specify address and data width
	parameter d_width = 8;
	parameter a_width = 8;
	parameter n = 4; //Cache size
	//Input Ports
	input clk, clr, enab, rw;
	input [a_width-1:0] Addr;
	input [d_width-1:0] data_in;
	//Output Ports
	output hit_out;
	output reg [d_width-1:0] data_out;
//	output [a_width:0] c_addrIN_out;
	output [d_width:0] c_dataIN_out;
	output [a_width-1:0] addr0;
	output [a_width-1:0] addr1;
	output [a_width-1:0] addr2;
	output [a_width-1:0] addr3;
	output [d_width-1:0] data0;
	output [d_width-1:0] data1;
	output [d_width-1:0] data2;
	output [d_width-1:0] data3;
	/*output [1:0] access0;
	output [1:0] access1;
	output [1:0] access2;
	output [1:0] access3;*/
	//Output Ports For Monitoring RAM Contents
	output [a_width-1:0] ram0;
	output [a_width-1:0] ram1;
	output [a_width-1:0] ram2;
	output [a_width-1:0] ram3;
	output [a_width-1:0] ram4;
	output [a_width-1:0] ram5;
	output [a_width-1:0] ram6;
	output [a_width-1:0] ram7;
	//Declare Cache Registers
	reg [d_width-1:0] cache_data [n-1:0];
	reg [a_width-1:0] cache_addr [n-1:0];
	reg [1:0] cache_access [n-1:0];
	
	//Declare Cache Flag Registers
	output reg [1:0] curr_LRU;		//Index of current least recently used address
	output reg [1:0] cache_hit; 	//Index of cache hit
	reg [d_width-1:0] target_addr; //Target memory address to be saved on miss
	reg [d_width-1:0] target_data;	//Target data to be saved on a miss (write)
	reg hit;
	wire hit_wire;
	assign hit_wire=hit;
	assign hit_out=hit_wire;
	wire [7:0] c_addrIN_wire;
	wire [7:0] c_dataIN_wire;
//	assign c_addrIN_wire = Addr;
	assign c_dataIN_wire = data_in;
//	assign c_addrIN_out = c_addrIN_wire;
	assign c_dataIN_out = c_dataIN_wire;
	output target_rw_out;
	wire target_rw_wire;
	reg target_rw;	//Tartget Read or Write Value to save on miss
	assign target_rw_wire = target_rw;
	assign target_rw_out = target_rw_wire;
	integer i;
	output reg [3:0] state; 		//Current State Register
	
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
	//Assign Cache Access Output
	/*assign access0 = cache_access[0];
	assign access1 = cache_access[1];
	assign access2 = cache_access[2];
	assign access3 = cache_access[3];*/
	
	//Declare DATA Ram unit and wires to control the RAM
	reg ram_clr, ram_rw, ram_enab;
	reg [a_width-1:0] ram_addr;
	reg [d_width-1:0] ram_data_in;
	wire [d_width-1:0] ram_data_out;
	
	wire [d_width-1:0] ram_mem0;
	wire [d_width-1:0] ram_mem1;
	wire [d_width-1:0] ram_mem2;
	wire [d_width-1:0] ram_mem3;
	wire [d_width-1:0] ram_mem4;
	wire [d_width-1:0] ram_mem5;
	wire [d_width-1:0] ram_mem6;
	wire [d_width-1:0] ram_mem7;
	//Connect RAM contents with Cache Output Ports
	assign ram0 = ram_mem0;
	assign ram1 = ram_mem1;
	assign ram2 = ram_mem2;
	assign ram3 = ram_mem3;
	assign ram4 = ram_mem4;
	assign ram5 = ram_mem5;
	assign ram6 = ram_mem6;
	assign ram7 = ram_mem7;
	ram	DATA_RAM(clk, ram_clr, ram_enab, ram_rw, ram_addr, ram_data_in, 
							ram_mem0, ram_mem1, ram_mem2, ram_mem3, ram_mem4, 
							ram_mem5, ram_mem6, ram_mem7, ram_data_out);
	
	initial begin
		curr_LRU <= 2'b00;
		hit <= 1'b0;
		cache_hit <= 2'b11;
		ram_clr <= 1'b1;
	end
	

	always @ (posedge clk) begin
		if(clr==1'b0) begin //Clear Cache + DATA RAM
			state <= 0;
		end
		else if(enab==1'b0) begin //High Z State for output if chip not enabled
			state <= 0;
		end
		else if(enab==1'b1) begin //Only Read/Write if Cache Chip Enabled
			case(state) 
			0: //Initial State
			begin
				hit <= 1'b0; //Initialize the test condition
				//Test if target address exists in cache entries
				for(i=0; i<n; i=i+1) begin:Read_Hit_Loop
					if(Addr==cache_addr[i]) begin    //HIT @ Index i
						cache_hit <= i;
						hit <= 1;
					end
				end
				target_addr <= Addr;
				target_data <= data_in;
				state <= 1;
				if(rw==1'b0) begin //read miss
					target_rw <= 0; 
				end
				else if (rw==1'b1) begin //write miss
					target_rw <= 1; 
				end
			end //End Hit test
			1: begin	//Identify hit or miss						
				if(hit==1) begin						//HIT  - T0
					state <= 0; end //Reset
				else if(hit==0) begin
					state <= 2; 						//MISS - T1
				end
				else begin
					hit <= 1'bZ;
					state <= 0;
				end
			end
			2:	state <= 3;
			3: begin
				if(target_rw==1'b0)
					state <= 4;
				else if(target_rw==1'b1)
					state <= 6;
			end
			4: state <= 5;
			5: state <= 8;
			6: state <= 7;
			7: state <= 8;
			8: state <= 9;
			9: state <= 10;
			10: state <= 11;
			11: state <= 12;
			12: begin
				if(target_rw==1'b0) //Read Miss
					state <= 13;
				else if(target_rw==1'b1) //Write Miss
					state <= 14;
			end
			13: state <= 0;
			14: state <= 0;
			default: state <= 0;
			endcase
		
		end							//End Read/WRITE if Cache Enabled
		
	end								//End @ Posedge
	

	always @ (state) begin
		if(clr==1'b0) begin
			//ram_clr <= 1'b0;
			for(i=0; i<4; i=i+1) begin:CLR_loop
				cache_data[i] <= 8'b00000000;
				cache_addr[i] <= 8'b00000000;
				cache_access[i] <= 0;
			end
			curr_LRU <= 2'b00;
		end
		if(enab==1'b1) begin
			case(state)
			0: //HIT Test
			begin
				//Wait for next clock cycle
			end
			1: //HIT
			begin
				if(hit==1'b1) begin //Update Access Records for LRU
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
					cache_access[cache_hit] <= 3; //Update hit index to MRU
					if(rw==1'b0) begin //Hit Read
						data_out <= cache_data[cache_hit];
					end else begin //Hit Write
						cache_data[cache_hit] <= data_in;
					end
				end
			end
			
			2: //Miss - Prepare to write to RAM from cache
			begin
				ram_enab <= 1'b1; //enable ram
				ram_rw <= 1'b1; //write
			end
			3: //Miss - Write LRU entry to RAM
			begin
				ram_addr <= cache_addr[curr_LRU];
				ram_data_in <= cache_data[curr_LRU];
			end
			4: //Miss READ- Prepare to Read from RAM
			begin
				ram_rw <= 1'b0;
				ram_addr <= target_addr;
			end
			5: //Miss READ - Fill Cache with target address
			begin
				cache_data[curr_LRU] <= ram_data_out;
				cache_addr[curr_LRU] <= target_addr;
			end
			6: //Miss WRITE - Write Target to RAM
			begin
				//ram_addr <= target_addr;
				//ram_data_in <= target_data;
			end
			7: //Miss WRITE - Fill CURR LRU
			begin
				cache_data[curr_LRU] <= data_in;
				cache_addr[curr_LRU] <= target_addr;
			end
			8: //Miss - Update Cache Access Records
			begin
				for(i=0; i<n; i=i+1) begin:Update_Access_Miss
					if(i!=curr_LRU) begin 
						if(cache_access[i]==2'b00) begin
							curr_LRU <= i;
						end else begin 
							cache_access[i] <= cache_access[i]-1;
						end
					end else if(i==curr_LRU) begin
						cache_access[i] <= 3;
					end
				end
			end
			9: //Miss - Set new LRU
			begin 
				for(i=0; i<n; i=i+1) begin:Update_LRU
					if(i!=curr_LRU) begin 
						if(cache_access[i]==2'b00) begin
							curr_LRU <= i;
						end
					end
				end
			end
			10: //Miss - Do Nothing (Eat Up Clock Cycles For Delay)
			begin
				ram_enab <= 1'b0;
			end
			11: //Miss - Do Nothing (Eat Up Clock Cycles For Delay)
			begin
				ram_enab <= 1'b0;
			end
			12: //Miss - Do Nothing (Eat Up Clock Cycles For Delay)
			begin
				ram_enab <= 1'b0;
			end
			13: //Miss READ - Output Targeted Memory Data
			begin
				i = cache_access[3];
				data_out <= cache_data[i];
			end
			14: //Miss WRITE - Do Nothing
			begin
				ram_enab <= 1'b0;
			end
			endcase
		end
	end

endmodule

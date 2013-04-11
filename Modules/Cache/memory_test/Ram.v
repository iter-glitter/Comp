`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
//  RAM : Random Access Memory module - Behavioral Style (Parameterized)
//				RAM unit has 8 bit wide data field and 256 addresses (2**8)
//
// Inputs: Addr, enab, clr, rw, data_in
//				Addr: Target memory address
//				data_in: input line for data, Write to target address
//				enab: Chip enable line
//				clr:	Active low synchronous clear
//				rw:	Read/Write control line
//
// Outputs: mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, data_out
//				mem0-7 are 8 outputs used for checking the current
//					contents of the RAM chip
//				data_out: Output data port, Read from target address
//
//   rw    enab   clr    function
//   x      x      0     Clear all RAM contents to zero *Top Priority
//   x 		0      1     RAM Chip not enabled - Do not read or write
//   0 		1      1     Read Target Address
//   1 		1      1		 Write 
//
//////////////////////////////////////////////////////////////////////////////////
module ram(clk, clr, enab, rw, Addr, data_in, mem0, mem1, mem2, mem3, mem4, mem5, 
				mem6, mem7, data_out);
	parameter d_width = 8;
	parameter a_width = 8;
	//Input Ports
	input clk, clr, enab, rw;
	input [a_width-1:0] Addr;
	input	[d_width-1:0] data_in;
	//Output Ports
	output [d_width-1:0] mem0;
	output [d_width-1:0] mem1;
	output [d_width-1:0] mem2;
	output [d_width-1:0] mem3;
	output [d_width-1:0] mem4;
	output [d_width-1:0] mem5;
	output [d_width-1:0] mem6;
	output [d_width-1:0] mem7;
	output reg [d_width-1:0] data_out;
	//Declare memory register
	reg [d_width-1:0] memory [2**a_width-1:0];
	//Define Loop Variable i
	integer i;
	
	//Assign mem0-7 to first 8 memory indices
	assign mem0 = memory[0];
	assign mem1 = memory[1];
	assign mem2 = memory[2];
	assign mem3 = memory[3];
	assign mem4 = memory[4];
	assign mem5 = memory[5];
	assign mem6 = memory[6];
	assign mem7 = memory[7];
	
	initial begin
		memory[0] = 8'b00001111;
		memory[1] = 8'b00111111;
		memory[2] = 8'b01111111;
		memory[3] = 8'b11101111;
		memory[4] = 8'b00011000;
		memory[5] = 8'b00011000;
		memory[6] = 8'b11011011;
		memory[7] = 8'b10011001;
	end
	
	//Handle CLR/READ/WRITE at positive edge of clk
	always @(posedge clk) begin
		if(clr==1'b0) begin:clrBlock //Clear memory contents
			for(i=0; i<(2**a_width); i=i+1) begin:Clr_Loop
				memory[i] <= 0;
				data_out <= 8'b01010101;
			end	
		end
		else if(enab==1'b1) begin //Only Read/Write if RAM Chip enabled
			if(rw==1'b0) begin //Read 
				data_out <= memory[Addr];
			end
			else if(rw==1'b1) begin //Write
				memory[Addr] <= data_in;
			end
		end
		else if(enab==1'b0) begin //High Z state for output if chip not enabled
			data_out <= 8'b01010101;
		end
	end
	
endmodule

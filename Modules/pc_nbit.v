`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
//  nbit_pc : n-bit program counter built using behavioral syntax. 
//
// Active low synchronous clear
//
//  ctrl   clr    function
//   x      0     Clear all PC bits to zero. *Top Priority
//   00     1     Hold Count
//   01     1     Parallel Load
//   10     1	  Increment by 1
//   11		1 	  increment by inc (increment variable)
//
//////////////////////////////////////////////////////////////////////////////////
module nbit_pc(clk,clr, ctrl, pc_in, pc_out);
	parameter n=8; //default 4-bit program counter
	parameter inc=2; //default increment value
	input clk, clr;
	input [1:0] ctrl;
	input [n-1:0] pc_in;
	output reg [n-1:0] pc_out;
	
	always @(posedge clk) begin 
		if(clr==0) begin 
			pc_out <= 0; 
		end
		else begin
			case(ctrl)
				0: pc_out <= pc_out; //Hold Count - Out = Previous state
				1: pc_out <= pc_in; //Parallel load
				2: pc_out <= pc_out+1; //Increment PC by 1
				3: pc_out <= pc_out+inc; //Increment by increment variable. 
				default: pc_out <= pc_out; //Do nothing for any other case
			endcase
		end
	end
endmodule

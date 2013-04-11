`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:    stack 
//
// Description:
//		Parameterized stack with synchronous active low clear
//
//////////////////////////////////////////////////////////////////////////////////
module stack(en, clr, clk, con, data_in, data_out, full);
	parameter width = 8; //the width of the data in bits
	parameter depth = 2; // amout of data
	input en; 	// enable 
	input clr; 	// clear all contents
	input clk;	// the clock
	input con;	// controller signal. pop when con=1. push when con=0;
	input [width-1:0] data_in;
	output reg full; // inform controller if stack full. 1 on full, else 0
	output reg [width-1:0] data_out;
		
	reg empty; 		// 1 if the stack is empty, else 0
	reg [width-1:0] data [(2**depth)-1:0]; // reg to hold the data
	
	integer i;
	integer size; // the amount of data in the stack at any given time
	
	always@(posedge clk)
	begin
		if(clr == 0)
		begin
			for(i=0; i<(2**depth); i=i+1)
			begin
				data[i] <= 0;
			end
			full <= 0;
			empty <= 1;
			size = 0;
		end
		else
		begin
			if (en == 1) // if the stack is enabled
			begin
				if (con == 0) // if controller says push 
				begin
					if( full == 0 ) //if stack not full
					begin
						data[size] <= data_in; // store data
						size = size + 1; // increment
						empty <= 0;
						if(size == (2**depth))
						begin
							full <= 1; // controller must pop to make room
						end
					end
				end
				else // pop --> controller = 1 
				begin
					if(empty == 0) //if the stack is not empty
					begin
						data_out <= data[size]; // output last data in
						size = size - 1; // decrement
						full <= 0;
						if(size == 0)
						begin
							empty <= 1; //stack is empty
						end
					end
				end
			end
		end
	end	

endmodule

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
//		Control States
//			00		push
//			01		pop
//			10		Do nothing
//			11		Do nothing
//
//  
//  
//  
//////////////////////////////////////////////////////////////////////////////////
module stack(en, clr, clk, con, data_in, data_out);
	parameter width = 8; //the width of the data in bits
	parameter depth = 3; // amout of data
	input en; 	// enable 
	input clr; 	// clear all contents
	input clk;	// the clock
	input [1:0] con;	// controller signal. pop when con=01. push when con=00. do nothing when con=10/11;
	input [width-1:0] data_in;
	reg full; // inform controller if stack full. 1 on full, else 0
	output reg [width-1:0] data_out;
	
	reg [(2**depth)-1:0] size;   // the amount of data in the stack at any given time
	reg empty; 		// 1 if the stack is empty, else 0
	reg [width-1:0] data [(2**depth)-1:0]; // reg to hold the data
	
	integer i; 
	
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
			size <= 0;
			data_out <= 0;
		end
		else
		begin
			if (en == 1) // if the stack is enabled
			begin
				if (con == 2'b00) // if controller says push 
				begin
					if( full == 0 ) //if stack not full
					begin 
						if(size < (2**depth))
						begin
							data[size] <= data_in; // store data
							empty <= 0;
							size <= size + 1; // increment
						end
						else
							full <= 1; // stack is full - controller must pop to make room
					end
				end
				else if( con == 2'b01) // pop --> controller = 1 
				begin
					if(empty == 0) //if the stack is not empty
					begin
						if(size > 0)
						begin
							data_out <= data[size-1]; // output last data in
							full <= 0;
							size <= size - 1; // decrement
						end
						else
							empty <= 1; //stack is empty
					end
				end
			end
		end
	end	

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Module Name:    Shifter 
//
// Description:		8-bit Load Store param shifter for the accumulator reg
//
//		Priority (highest lowest): clr, set, clk 
//			set and clr are synchronous, and active low
//			
//		ctrl[1] ctrl[0]	 |	Function:
//			0		0	 |	store
//			0		1	 |	Load in Parallel
//			1		0	 |	Left Shift			
//			1		1	 |	Righ Shift			
//
//////////////////////////////////////////////////////////////////////////////////
module LdStr_shifter(Reg_in,clr,set,clk,Ls,Rs,ctrl,num_shift,Reg_out);
	parameter n = 8; //8-bit accum reg + *Note - if change must change num_shift manually
	input clr,set,clk,Ls,Rs;	// Ls = Left Shift bit. Rs = Right Shift bit. (1 or 0)
	input [1:0] ctrl;			// control signal
	input [n-1:0] Reg_in;		// input data to be operated on
	input [2:0] num_shift;		// the number of shifts to execute (0 < num_shift < 7) | see ISA
	
	output reg [n-1:0] Reg_out;
	reg curr, prev;
	
	integer i, j;
	always@(posedge clk) begin
		if(clr == 1'b0) begin	// Clear all bits to zero
			for(i=0;i<n;i=i+1) begin 
				Reg_out[i] = 8'b00000000;
			end
		end
		else if(set == 1'b0) begin // Set all bits to one
			for(i=0;i<n;i=i+1) begin
				Reg_out[i] = 1'b1;
			end
		end
		else if(ctrl == 2'b00) begin //Keep value stored in register
				Reg_out = Reg_out;
		end
		else if(ctrl == 2'b01) begin //Load in parallel
				Reg_out = Reg_in;
		end
		else if(ctrl == 2'b10) begin //Left Shift
			for(i=0; i<num_shift; i=i+1) begin // number of shifts to perform
				prev = Reg_out[0]; 
				Reg_out[0] = Ls; 
				for(j=1;j<n;j=j+1) begin
						curr = Reg_out[j]; //save current value
						Reg_out[j] = prev; //set current position value to previous position value
						prev = curr;
				end
			end
		end
		else if(ctrl == 2'b11) begin //Right Shift 
			for(i=0; i<num_shift; i=i+1) begin // number of shifts to perform
				prev = Reg_out[n-1];
				Reg_out[n-1] = Rs;  
				for(j=(n-2);j>=0;j=j-1) begin
						curr = Reg_out[j]; //save current value
						Reg_out[j] = prev; //set current position value to previous position value
						prev = curr;
				end
			end
		end
	end

endmodule

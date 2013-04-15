`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Controller Unit
//
// Moore Model Finite State Machine (FSM) implements control of stage 0 of the
// accumulator processor. 
// 
//////////////////////////////////////////////////////////////////////////////////
module stage0(clk, clr, instr, data, i_pending, stg1_state, 
					stg0_state, ctrl, pc_out);
	//Inputs
	input clk, clr;
	input i_pending;			//Pending interrupt signal sent from MHVPIS
	input [7:0] data;			//Contents of IR1_0 - Data Register
	input [7:0] instr;		//Contents of IR0_0 - Instruction Register
	input stg1_state;			//Handshake control line - Stage 1 interface
	
	//Outputs
	output reg stg0_state;		//Handshake control line - Stage 0 (this unit) status
	output reg [7:0] pc_out;	//Used to set PC address
	output reg [20:0] ctrl; 	//21 bit control line - control and select points
	
	
	//Define Stage 0 state parameters
	parameter T0 =  15'b000000000000000;  
	parameter T1 =  15'b000000000000001;  
	parameter T2 =  15'b000000000000010;  
	parameter T3 =  15'b000000000000100;  
	parameter T4 =  15'b000000000001000;  
	parameter T5 =  15'b000000000010000;  
	parameter T6 =  15'b000000000100000;  
	parameter T7 =  15'b000000001000000;  
	parameter T8 =  15'b000000010000000;  
	parameter T9 =  15'b000000100000000;  
	parameter T10 = 15'b000010000000000; 
	parameter T11 = 15'b000100000000000;
	parameter T12 = 15'b001000000000000; 
	parameter T13 = 15'b010000000000000; 
	parameter T14 = 15'b100000000000000;
	
	
endmodule

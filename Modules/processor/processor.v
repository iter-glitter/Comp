`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Proccessor
//
// 
//////////////////////////////////////////////////////////////////////////////////
module processor(clk, clr, in_dev_hs, out_dev_hs, out_dev_ack, in_dev_ack);
	
	//Define Inputs
	input clk;						//Global Clock
	input clr;						//Global Clr
	input in_dev_hs;				//INPUT Device Handshake - Data Ready
	input out_dev_hs;				//OUTPUT Device Handhsake - Device Ready to Receive
	input out_dev_ack;			//OUTPUT Device Handshake - Data received

	//Define Outputs
	output in_dev_ack;			//INPUT Device Handshake - Data Received by proc
	
	//Wire Definitions
	wire [7:0] ir1_0_in, ir1_0_out, ir0_0_in, ir0_0_out;
	wire [7:0] ir1_1_out, ir0_1_out;
	wire ir1_0_s, ir0_0_s, ir1_1_s, ir0_1_s;
	
	wire ccr_V, ccr_Z, ccr_C;
	
	
	//Controllers
	//stage0(clk, clr, instr, i_pending, ccr_z, stg1_state, stg0_state, ctrl, pc_out);
	//stage0 ctrl0(clk, clr, ir0_1_out, 
	//stage1(clk, clr, instr, ir_data, mdr_data, stg0_state, input_rdy, out_recv, 
				//out_dev_rdy, cache_hit, stg1_state, ctrl, num_shift, input_recv);
				
	//MHVPIS
	
	
	//Functional Units
	//module ld_st_reg(clk, clr, set, in, out);
	//Load Store Registers
	ld_st_reg IR1_0(clk, clr, ir1_0_s, ir1_0_in, ir1_0_out); //Stage 0 OPERAND REG
	ld_st_reg IR0_0(clk, clr, ir0_0_s, ir0_0_in, ir0_0_out); //Stage 0 INSTR REG 
	ld_st_reg IR1_0(clk, clr, ir1_1_s, ir1_0_out, ir1_1_out); //Stage 1 OPERAND REG
	ld_st_reg IR0_0(clk, clr, ir0_1_s, ir0_0_out, ir0_1_out); //Stage 1 INSTR REG 
	
endmodule

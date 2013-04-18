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
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Wire Definitions  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//State Control Lines
	wire [20:0] ctrl0;
	wire [55:0] ctrl1;
	
	//Controller Wires
	wire stg1_state, stg0_state;
	wire [7:0] stg0_pc;
	
	
	//Instruction Memory Wire
	wire imem_rw, imem_en;
	assign imem_rw = ctrl0[10];
	assign imem_en = ctrl0[9];
	wire [15:0] imem_out;
	
	//MHVPIS Wire
	wire [3:0] itr_in, itr_mask;
	wire itr_en, i_pending;
	wire [7:0] itr_pc_addr;
	assign itr_en = ctrl0[8];
	
	//Instruction Registers
	wire [7:0] ir1_0_in, ir1_0_out, ir0_0_in, ir0_0_out;
	wire [7:0] ir1_1_out, ir0_1_out;
	wire ir1_0_s, ir0_0_s, ir1_1_s, ir0_1_s;
	assign ir1_0_in = imem_out[15:8];
	assign ir0_0_in = imem_out[7:0];
	
	//Condition Code Registers
	wire ccr_V, ccr_Z, ccr_C;
	
	//Program Counter Wire
	wire [1:0] pc_ctrl, PCs_ctrl;
	assign pc_ctrl = ctrl0[18:17];
	wire [7:0] pc_in, pc_out, pc_stack_out;
	wire PCs_en;
	assign PCs_ctrl = ctrl0[4:3];
	assign PCs_en = ctrl0[5];
	
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Controller Units  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

	//Controllers
	wire [7:0] ctrl0_pc;
	//stage0(clk, clr, instr, i_pending, ccr_z, stg1_state, stg0_state, ctrl, stg0_pc_out);
	stage0 controller0(clk, clr, ir0_1_out, i_pending, ccr_z, stg1_state, 
							stg0_state,	ctrl0, stg0_pc);
	//stage1(clk, clr, instr, ir_data, mdr_data, stg0_state, input_rdy, out_recv, 
				//out_dev_rdy, cache_hit, stg1_state, ctrl, num_shift, input_recv);
				
	//MHVPIS
	//MHVPIS(clk, itr_clr, itr_in, mask_in, itr_en, i_pending, PC_out);	
	MHVPIS ITR_SYSTEM(clk, clr, itr_in, itr_mask, itr_en, i_pending, itr_pc_addr);
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Functional Units  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	
	//Program Counter
	//module nbit_pc(clk,clr, ctrl, pc_in, pc_out);
	nbit_pc PC(clk, clr, pc_ctrl, pc_in, pc_out);
	//PC Stack
	//module stack(en, clr, clk, con, data_in, data_out);
	stack PC_STACK(PCs_en, clr, clk, PCs_ctrl, pc_out, pc_stack_out);

	//Instruction Registers
	//module ld_st_reg(clk, clr, set, in, out);
	//Load Store Registers
	ld_st_reg IR1_0(clk, clr, ir1_0_s, ir1_0_in, ir1_0_out); //Stage 0 OPERAND REG
	ld_st_reg IR0_0(clk, clr, ir0_0_s, ir0_0_in, ir0_0_out); //Stage 0 INSTR REG 
	ld_st_reg IR1_1(clk, clr, ir1_1_s, ir1_0_out, ir1_1_out); //Stage 1 OPERAND REG
	ld_st_reg IR0_1(clk, clr, ir0_1_s, ir0_0_out, ir0_1_out); //Stage 1 INSTR REG 
	

//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Instruction Memory  ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//module ram(clk, clr, enab, rw, Addr, data_out);
	ram iRAM(clk, clr, imem_en, imem_rw, pc_out, imem_out);
	
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Multiplexers  //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//mux_4_1(i0, i1, i2, i3, sel, out);
	
	//MUX Select Lines
	wire [1:0] CP8_9;
	assign CP8_9 = ctrl0[7:6];
	//MUX Units
	mux_4_1 MUX_PC(pc_stack_out, itr_pc_addr, stg0_pc, ir1_0_out);
	
endmodule

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
module processor(clk, clr, in_dev_hs, out_dev_hs, out_dev_ack, in_dev_ack,
					input_bus, output_bus);
	
	//Define Inputs
	input clk;						//Global Clock
	input clr;						//Global Clr
	input in_dev_hs;				//INPUT Device Handshake - Data Ready
	input out_dev_hs;				//OUTPUT Device Handhsake - Device Ready to Receive
	input out_dev_ack;			//OUTPUT Device Handshake - Data received
	input [7:0] input_bus;		//INPUT data bus

	//Define Outputs
	output in_dev_ack;			//INPUT Device Handshake - Data Received by proc
	output [7:0] output_bus;   //OUTPUT data bus
	
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
	
	//Shifter Wires
	wire [7:0] shft_out;
	wire [1:0] sh_ctrl;
	wire [2:0] num_shift;
	wire sh_set, LS, RS;
	assign sh_ctrl = ctrl1[4:3];
	assign LS = ctrl1[2];
	assign RS = ctrl1[1];
	assign sh_set = ctrl1[0];
	
	//Cache Wires
	wire [7:0] cache_out, ch_addr0, ch_addr1, ch_addr2, ch_addr3;
	wire [7:0] ch_data0, ch_data1, ch_data2, ch_data3;
	wire ch_en, ch_rw, ch_hit;
	wire [1:0] curr_hit, ch_LRU;
	wire [7:0] ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7;
	
	
	//Condition Code Registers
	wire ccr_V, ccr_Z, ccr_C;
	
	//Program Counter Wire
	wire [1:0] pc_ctrl;
	assign pc_ctrl = ctrl0[18:17];
	wire [7:0] pc_in, pc_out;
	
	
	//Stack Wire
	wire [1:0] PCs_ctrl, ACCs_ctrl;
	wire PCs_en, ACCs_en;
	wire [7:0] pc_stack_out, acc_stack_out;
	assign PCs_ctrl = ctrl0[4:3];
	assign PCs_en = ctrl0[5];
	assign ACCs_ctrl = ctrl0[1:0];
	assign ACCs_en = ctrl0[2];
	
	//ALU Wires
	wire [2:0] alu_ctrl;
	assign alu_ctrl = ctrl1[31:29];
	wire alu_cin;
	assign alu_cin = ctrl1[28];
	wire [7:0] ALU_in1, alu_out;
	
	//Data Register Wires
	wire [7:0] mdr_in, mdr_out, mar_in, mar_out, acc_s_reg_out;
	wire [7:0] b_reg_in, b_out, a_reg_in, a_out, acc_in, acc_out;
	wire mar_s, mdr_s, a_s, b_s, acc_s, acc_s_reg_clr, acc_s_reg_set;
	assign mar_s = ctrl1[15];
	assign mdr_s = ctrl1[14];
	assign a_s   = ctrl1[33];
	assign b_s   = ctrl1[25];
	assign acc_s = ctrl1[32];
	assign acc_s_reg_clr = ctrl0[12];
	assign acc_s_reg_set = ctrl0[11];
	
	
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
	
	//ALU
	//module alu_nbit(in0,in1,c_in,ctrl,c_out,alu_out,V, Z);
	alu_nbit ALU(acc_out, ALU_in1, alu_cin, alu_ctrl, ccr_C, alu_out, ccr_F, ccr_Z);
	
	//Program Counter
	//module nbit_pc(clk,clr, ctrl, pc_in, pc_out);
	nbit_pc PC(clk, clr, pc_ctrl, pc_in, pc_out);
	
	//Stacks
	//module stack(en, clr, clk, con, data_in, data_out);
	stack PC_STACK(PCs_en, clr, clk, PCs_ctrl, pc_out, pc_stack_out);
	stack ACC_STACK(ACCs_en, clr, clk, ACCs_ctrl, acc_out, acc_stack_out);
	
	//Shifter
	//LdStr_shifter(Reg_in,clr,set,clk,Ls,Rs,ctrl,num_shift,Reg_out);
	LdStr_shifter SHIFTER(acc_out, clr, sh_set, clk, LS, RS, sh_ctrl, num_shift, shft_out);

	//Load Store Registers
	//module ld_st_reg(clk, clr, set, in, out);
	//Instruction Registers
	ld_st_reg IR1_0(clk, clr, ir1_0_s, ir1_0_in, ir1_0_out); //Stage 0 OPERAND REG
	ld_st_reg IR0_0(clk, clr, ir0_0_s, ir0_0_in, ir0_0_out); //Stage 0 INSTR REG 
	ld_st_reg IR1_1(clk, clr, ir1_1_s, ir1_0_out, ir1_1_out); //Stage 1 OPERAND REG
	ld_st_reg IR0_1(clk, clr, ir0_1_s, ir0_0_out, ir0_1_out); //Stage 1 INSTR REG 
	//Data Registers
	ld_st_reg MDR(clk, clr, mdr_s, mdr_in, mdr_out); //Stage 1 - MDR REG
	ld_st_reg MAR(clk, clr, mar_s, mar_in, mar_out); //Stage 1 - MAR REG
	ld_st_reg A_REG(clk, clr, a_s, a_reg_in, a_out); 
	ld_st_reg B_REG(clk, clr, b_s, b_reg_in, b_out);
	ld_st_reg ACC(clk, clr, acc_s, acc_in, acc_out); //ACCUMULATOR REG
	ld_st_reg ACC_s_reg(clk, acc_s_reg_clr, acc_s_reg_set,
								acc_stack_out, acc_s_reg_out);
	

//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Instruction Memory  ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//module ram(clk, clr, enab, rw, Addr, data_out);
	iram iRAM(clk, clr, imem_en, imem_rw, pc_out, imem_out);
	
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Multiplexers  //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	
	
	//MUX Select Lines
	wire CP10;
	wire [1:0] CP1_0, CP8_9, CP12_11, CP14_13;
	wire [2:0] CP4_3_2, CP7_6_5;
	assign CP1_0 = ctrl1[10:9];
	assign CP4_3_2 = ctrl1[13:11];
	assign CP7_6_5 = ctrl1[7:5];
	assign CP8_9 = ctrl0[7:6];
	assign CP10 = ctrl1[8];
	assign CP12_11 = ctrl1[27:26];
	assign CP14_13 = ctrl1[24:23];

	
	//MUX Units
	//module mux_2_1(i0, i1, sel, out);
	mux_2_1 MUX_MAR(mdr_out, IR1_1_out, CP10, mar_in);
	
	//mux_4_1(i0, i1, i2, i3, sel, out);
	mux_4_1 MUX_PC(pc_stack_out, itr_pc_addr, stg0_pc, ir1_0_out, CP8_9, pc_in);
	mux_4_1 MUX_ALU(b_out, a_out, mdr_out, 1'b1, CP1_0, ALU_in1);
	mux_4_1 MUX_A(IR1_1_out, acc_out, mdr_out, 1'b0, CP12_11, a_reg_in);
	mux_4_1 MUX_B(IR1_1_out, acc_out, mdr_out, 1'b0, CP14_13, b_reg_in);
	
	//module mux_5_1(i0, i1, i2, i3, i4, sel, out);
	mux_5_1 MUX_ACC(shft_out, mdr_out, IR1_1_out, alu_out, acc_s_reg_out, 
							CP4_3_2, alu_in);
	mux_5_1 MUX_MDR(input_bus, b_out, a_out, acc_out, cache_out, 
							CP7_6_5, mdr_in);
	
	
endmodule

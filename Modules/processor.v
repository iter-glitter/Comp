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
/* DEBUG IO Port Mapping
module processor(g_clk, g_clr, in_dev_hs, out_dev_hs, out_dev_ack, in_dev_ack,
					input_bus, output_bus, mem0, mem1, mem2, mem3, mem4, mem5, mem6,
					mem7, mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15,
					c_data0, c_data1, c_data2, c_data3, c_addr0, c_addr1, c_addr2,
					c_addr3, c_hit, c_LRU, cache_hit, C, V, Z, stage0, stage1,
					stage0_rdy, stage1_rdy, stg1_instr, stg0_instr, pc_output, acc_reg_out, alu_out_w,
					a_reg_out, b_reg_out, mar_out_w, mdr_out_w, num_shift_out, shifter_out, ch_output , 
					ch_target_rw, ch_target_data, ch_state, ram_data_in, ram_addr_in, ch_miss_loop, 
					itr_pend, itr_reg, mask_reg, pc_s_out, acc_s_out);
					*/
module processor(g_clk, g_clr, in_dev_hs, out_dev_hs, out_dev_ack, in_dev_ack,
					input_bus, output_bus, mem0, mem1, mem2, mem3, mem4, mem5, mem6,
					mem7, mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15,
					c_data0, c_data1, c_data2, c_data3, c_addr0, c_addr1, c_addr2,
					c_addr3, c_hit, c_LRU, cache_hit, C, V, Z,
					stage0_rdy, stage1_rdy, pc_output, acc_reg_out, alu_out_w,
					a_reg_out, b_reg_out, mar_out_w, mdr_out_w, itr_pend, itr_reg, mask_reg);

	//Define Inputs
	input g_clk;					//Global Clock
	input g_clr;					//Global g_clr
	input in_dev_hs;				//INPUT Device Handshake - Data Ready
	input out_dev_hs;				//OUTPUT Device Handhsake - Device Ready to Receive
	input out_dev_ack;			//OUTPUT Device Handshake - Data received
	input [7:0] input_bus;		//INPUT data bus
	

	//Define Outputs
	output in_dev_ack;			//INPUT Device Handshake - Data Received by proc
	output [7:0] output_bus;   //OUTPUT data bus
	output [7:0] pc_output;			
//	output [71:0] stage1;
//	output [15:0] stage0;
	output stage0_rdy, stage1_rdy;
	output [7:0] acc_reg_out;
	output [7:0] alu_out_w;
	output [7:0] a_reg_out;
	output [7:0] b_reg_out;
	output [7:0] mdr_out_w;
	output [7:0] mar_out_w;
	output C, V, Z;
//	output [2:0] num_shift_out;
//	output [7:0] shifter_out;
//	output [7:0] ch_output;
//	output [7:0] ch_target_data;
//	output ch_target_rw;
//	output [3:0] ch_state;
//	output [7:0] ram_data_in;
//	output [7:0] ram_addr_in;
//	output [4:0] ch_miss_loop;
	output itr_pend;
	output [3:0] mask_reg, itr_reg;
//	output [7:0] pc_s_out, acc_s_out;
	
	//Cache Outputs
	output [7:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7;
	output [7:0] mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15;
	output [7:0] c_data0, c_data1, c_data2, c_data3;
	output [7:0] c_addr0, c_addr1, c_addr2, c_addr3;
	output [1:0] c_hit, c_LRU;
	output cache_hit;
	
	
//	output [7:0] stg0_instr, stg1_instr;			//DEBUG OUTPUT
	wire [7:0] stg0_instr_w, stg1_instr_w;
//	assign stg0_instr = stg0_instr_w;				//DEBUG OUTPUT
//	assign stg1_instr = stg1_instr_w;				//DEBUG OUTPUT
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Wire Definitions  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//State Control Lines
	wire [20:0] ctrl0;
	wire [35:0] ctrl1;
	wire [71:0] state1_w;
	wire [15:0] state0_w;
	//assign stage1 = state1_w;				//DEBUG OUTPUT
	//assign stage0 = state0_w;				//DEBUG OUTPUT
	
	//Controller Wires
	wire stg1_state, stg0_state, stg1_state2;
	wire [7:0] stg0_pc;
	wire [4:0] ch_miss_loop_wire;
	assign ch_miss_loop = ch_miss_loop_wire;
	wire [7:0] output_bus_w;
	assign output_bus = output_bus_w;
	
	//Instruction Memory Wire
	wire imem_rw, imem_en;
	assign imem_rw = ctrl0[11];
	assign imem_en = ctrl0[10];
	wire [15:0] imem_out;
	
	//Condition Code Registers
	wire ccr_V, ccr_Z, ccr_C;
	
	//MHVPIS Wire
	wire [3:0] itr_in, itr_mask, itr_out, itr_mask_out;
	wire itr_en, i_pending, itr_clr, invalid_opcode;
	wire [7:0] itr_pc_addr;
	wire v_state;
	assign itr_clr = ctrl0[9];
	assign itr_en = ctrl0[8];
	assign itr_in[0] = ccr_Z;
	assign itr_in[1] = v_state;
	assign itr_in[2] = invalid_opcode;
	assign itr_in[3] = in_dev_hs;
	assign itr_pend = i_pending;
	assign itr_reg = itr_out;
	assign mask_reg = itr_mask_out;
	
	//Instruction Registers
	wire [7:0] ir1_0_in, ir1_0_out, ir0_0_in, ir0_0_out;
	wire [7:0] ir1_1_out, ir0_1_out;
	wire ir1_0_s, ir0_0_s, ir1_1_s, ir0_1_s;
	wire ir1_0_c, ir0_0_c, ir1_1_c, ir0_1_c;
	assign ir0_0_s = ctrl0[14];
	assign ir0_0_c = ctrl0[15];
	assign ir1_0_s = ctrl0[16];
	assign ir1_0_c = ctrl0[17];
	
	assign ir0_1_s = ctrl1[19];
	assign ir0_1_c = ctrl1[20];
	assign ir1_1_s = ctrl1[17];
	assign ir1_1_c = ctrl1[18];
	
	assign ir1_0_in = imem_out[7:0];
	assign ir0_0_in = imem_out[15:8];
	
	//Shifter Wires
	wire [7:0] shft_out;
	wire [1:0] sh_ctrl;
	wire [2:0] num_shift;
	wire sh_set, LS, RS;
	assign sh_ctrl = ctrl1[4:3];
	assign LS = ctrl1[2];
	assign RS = ctrl1[1];
	assign sh_set = ctrl1[0];
	//assign num_shift_out = num_shift;				//DEBUG OUTPUT
	//assign shifter_out = shft_out;					//DEBUG OUTPUT
	
	//Cache Wires
	wire [7:0] cache_out, ch_addr0, ch_addr1, ch_addr2, ch_addr3;
	wire [7:0] ch_data0, ch_data1, ch_data2, ch_data3;
	wire ch_en, ch_rw, ch_hit;
	wire [1:0] curr_hit, ch_LRU;
	wire [7:0] ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7;
	wire [7:0] ram8, ram9, ram10, ram11, ram12, ram13, ram14, ram15;
	wire cache_target_rw;
	wire [7:0] ch_target_data_wire, ch_ram_data, ch_ram_addr;
	wire [3:0] ch_state_w;
	assign ch_en = ctrl1[23];
	assign ch_rw = ctrl1[22];	
//	assign ch_output = cache_out;							//DEBUG OUTPUT
//	assign ch_target_rw = cache_target_rw;				//DEBUG OUTPUT
//	assign ch_target_data = ch_target_data_wire;		//DEBUG OUTPUT
//	assign ch_state = ch_state_w;							//DEBUG OUTPUT
//	assign ram_data_in = ch_ram_data;					//DEBUG OUTPUT
//	assign ram_addr_in = ch_ram_addr;					//DEBUG OUTPUT
	
	//Program Counter Wire
	wire [1:0] pc_ctrl;
	assign pc_ctrl = ctrl0[19:18];
	wire [7:0] pc_in, pc_out;
	assign pc_output = pc_out;
	
	//Stack Wire
	wire [1:0] PCs_ctrl, ACCs_ctrl;
	wire PCs_en, ACCs_en;
	wire [7:0] pc_stack_out, acc_stack_out;
	assign PCs_ctrl = ctrl0[4:3];
	assign PCs_en = ctrl0[5];
	assign ACCs_ctrl = ctrl0[1:0];
	assign ACCs_en = ctrl0[2];
//	assign pc_s_out = pc_stack_out; 			//DEBUG OUTPUT
//	assign acc_s_out = acc_stack_out;		//DEBUG OUTPUT
	
	//ALU Wires
	wire [2:0] alu_ctrl;
	assign alu_ctrl = ctrl1[32:30];
	wire alu_cin;
	assign alu_cin = ctrl1[29];
	wire [7:0] ALU_in1, alu_out;
	assign alu_out_w = alu_out;
	
	//Data Register Wires
	wire [7:0] mdr_in, mdr_out, mar_in, mar_out, acc_s_reg_out;
	wire [7:0] b_reg_in, b_out, a_reg_in, a_out, acc_in, acc_out;
	wire mar_s, mdr_s, a_s, b_s, acc_s, acc_s_reg_g_clr, acc_s_reg_set;
	assign mar_s = ctrl1[16];
	assign mdr_s = ctrl1[15];
	assign a_s   = ctrl1[34];
	assign b_s   = ctrl1[26];
	assign acc_s = ctrl1[33];
	assign acc_s_reg_g_clr = ctrl0[13];
	assign acc_s_reg_set = ctrl0[12];
	assign acc_reg_out = acc_out;
	assign a_reg_out = a_out;
	assign b_reg_out = b_out;
	assign mdr_out_w = mdr_out;
	assign mar_out_w = mar_out;
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Controller Units  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

	//Controllers
	wire [7:0] ctrl0_pc;
	//stage0(clk, clr, instr, data_in, i_pending, ccr_z, ccr_v, stg1_state, 
	//				stg0_state, ctrl, pc_out, itr_mask, stage0, stg0_instr, v_state,
	//				invalid_opcode);
	stage0 controller0(g_clk,g_clr,ir0_0_out,ir1_0_out,i_pending,ccr_Z,
							ccr_V, stg1_state, stg0_state, ctrl0, stg0_pc, 
							itr_mask, state0_w, stg0_instr_w, v_state,
							invalid_opcode);
	//stage1(clk, clr, instr, ir_data, mdr_data, stg0_state, input_rdy, out_recv, 
	//			out_dev_rdy, cache_hit, stg1_state, ctrl, num_shift, input_recv, stage1, 
	//			output_data, stg1_instr, ch_miss_loop);
	stage1 controller1(g_clk ,g_clr, ir0_1_out, ir1_1_out, mdr_out, stg0_state, 
							in_dev_hs, out_dev_ack, out_dev_hs, ch_hit, stg1_state, 
							ctrl1, num_shift, in_dev_ack, state1_w, 
							output_bus_w, stg1_instr_w, ch_miss_loop_wire);
	assign stage1_rdy = stg1_state;
	assign stage0_rdy = stg0_state;
				
	//MHVPIS
	//MHVPIS(g_clk, itr_g_clr, itr_in, mask_in, itr_en, i_pending, PC_out);	
	MHVPIS ITR_SYSTEM(g_clk, itr_clr, itr_in, itr_mask, itr_en, i_pending, itr_pc_addr, itr_out, itr_mask_out);
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Functional Units  //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	
	//ALU
	//module alu_nbit(in0,in1,c_in,ctrl,c_out,alu_out,V, Z);
	alu_nbit ALU(acc_out, ALU_in1, alu_cin, alu_ctrl, ccr_C, alu_out, ccr_V, ccr_Z);
	
	//Program Counter
	//module nbit_pc(g_clk,g_clr, ctrl, pc_in, pc_out);
	nbit_pc PC(g_clk, g_clr, pc_ctrl, pc_in, pc_out);
	
	//Data Cache + Data RAM 
	cache DATA_CACHE(g_clk, g_clr, ch_en, ch_rw, mar_out, mdr_out, cache_out, ch_hit, 
					ch_addr0, ch_addr1, ch_addr2, ch_addr3, 
					ch_data0, ch_data1, ch_data2, ch_data3, 
					ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7, ram8, ram9, ram10, ram11, ram12, ram13, ram14, ram15,
					ch_LRU, curr_hit, cache_target_rw, ch_target_data_wire, ch_state_w, ch_ram_data, ch_ram_addr);
	
	//Assign Outputs to wires
	assign mem0 = ram0;
	assign mem1 = ram1;
	assign mem2 = ram2;
	assign mem3 = ram3;
	assign mem4 = ram4;
	assign mem5 = ram5;
	assign mem6 = ram6;
	assign mem7 = ram7;
	assign mem8 = ram8;
	assign mem9 = ram9;
	assign mem10 = ram10;
	assign mem11 = ram11;
	assign mem12 = ram12;
	assign mem13 = ram13;
	assign mem14 = ram14;
	assign mem15 = ram15;
	assign c_data0 = ch_data0;
	assign c_data1 = ch_data1;
	assign c_data2 = ch_data2;
	assign c_data3 = ch_data3;
	assign c_addr0 = ch_addr0;
	assign c_addr1 = ch_addr1;
	assign c_addr2 = ch_addr2;
	assign c_addr3 = ch_addr3;
	assign c_hit = curr_hit;
	assign c_LRU = ch_LRU;
	assign cache_hit = ch_hit;
	assign C = ccr_C;
	assign V = ccr_V;
	assign Z = ccr_Z;
	
	//Stacks
	//module stack(en, g_clr, g_clk, con, data_in, data_out);
	stack PC_STACK(PCs_en, g_clr, g_clk, PCs_ctrl, pc_out, pc_stack_out);
	stack ACC_STACK(ACCs_en, g_clr, g_clk, ACCs_ctrl, acc_out, acc_stack_out);
	
	//Shifter
	//LdStr_shifter(Reg_in,g_clr,set,g_clk,Ls,Rs,ctrl,num_shift,Reg_out);
	LdStr_shifter SHIFTER(acc_out, g_clr, sh_set, g_clk, LS, RS, sh_ctrl, num_shift, shft_out);

	//Load Store Registers
	//module ld_st_reg(g_clk, g_clr, set, in, out);
	//Instruction Registers
	ld_st_reg IR1_0(g_clk, ir1_0_c, ir1_0_s, ir1_0_in, ir1_0_out); //Stage 0 OPERAND REG
	ld_st_reg IR0_0(g_clk, ir0_0_c, ir0_0_s, ir0_0_in, ir0_0_out); //Stage 0 INSTR REG 
	ld_st_reg IR1_1(g_clk, ir1_1_c, ir1_1_s, ir1_0_out, ir1_1_out); //Stage 1 OPERAND REG
	ld_st_reg IR0_1(g_clk, ir0_1_c, ir0_1_s, ir0_0_out, ir0_1_out); //Stage 1 INSTR REG 
	//Data Registers
	ld_st_reg MDR(g_clk, g_clr, mdr_s, mdr_in, mdr_out); //Stage 1 - MDR REG
	ld_st_reg MAR(g_clk, g_clr, mar_s, mar_in, mar_out); //Stage 1 - MAR REG
	ld_st_reg A_REG(g_clk, g_clr, a_s, a_reg_in, a_out); 
	ld_st_reg B_REG(g_clk, g_clr, b_s, b_reg_in, b_out);
	ld_st_reg ACC(g_clk, g_clr, acc_s, acc_in, acc_out); //ACCUMULATOR REG
	ld_st_reg ACC_s_reg(g_clk, acc_s_reg_g_clr, acc_s_reg_set, acc_stack_out, acc_s_reg_out);
	

//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Instruction Memory  ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	//module ram(g_clk, g_clr, enab, rw, Addr, data_out);
	//iram iRAM(g_clk, g_clr, imem_en, imem_rw, pc_out, imem_out);
	iramP1 iRAMP1(g_clk, g_clr, imem_en, imem_rw, pc_out, imem_out);
	//iramFib iRAMFib(g_clk, g_clr, imem_en, imem_rw, pc_out, imem_out);
	//iramITR iRAM_ITR(g_clk, g_clr, imem_en, imem_rw, pc_out, imem_out);
	//iramSUB iRAM_ITR(g_clk, g_clr, imem_en, imem_rw, pc_out, imem_out);
	
	
//////////////////////////////////////////////////////////////////////////////////
////////////////////////  Multiplexers  //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	
	
	//MUX Select Lines
	wire CP10;
	wire [1:0] CP8_9, CP12_11, CP14_13;
	wire [2:0] CP1_0, CP4_3_2, CP7_6_5;
	assign CP1_0 = ctrl1[11:9];
	assign CP4_3_2 = ctrl1[14:12];
	assign CP7_6_5 = ctrl1[7:5];
	assign CP8_9 = ctrl0[7:6];
	assign CP10 = ctrl1[8];
	assign CP12_11 = ctrl1[28:27];
	assign CP14_13 = ctrl1[25:24];

	//MUX Units
	//module mux_2_1(i0, i1, sel, out);
	mux_2_1 MUX_MAR(mdr_out, ir1_1_out, CP10, mar_in);
	
	//mux_4_1(i0, i1, i2, i3, sel, out);
	mux_4_1 MUX_PC(pc_stack_out, itr_pc_addr, stg0_pc, ir1_0_out, CP8_9, pc_in);
	mux_3_1 MUX_A(ir1_1_out, acc_out, mdr_out, CP12_11, a_reg_in);
	mux_3_1 MUX_B(ir1_1_out, acc_out, mdr_out, CP14_13, b_reg_in);
	
	//module mux_5_1(i0, i1, i2, i3, i4, sel, out);
	mux_5_1 MUX_ACC(shft_out, mdr_out, ir1_1_out, alu_out, acc_s_reg_out, 
							CP4_3_2, acc_in);
	mux_5_1 MUX_MDR(input_bus, b_out, a_out, acc_out, cache_out, 
							CP7_6_5, mdr_in);
	mux_ALU MUX_ALU(b_out, a_out, mdr_out, ir1_1_out, acc_out, CP1_0, ALU_in1);
	
	
endmodule

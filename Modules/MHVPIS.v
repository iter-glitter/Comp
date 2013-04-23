`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Maskable Hardware Vectorized Priority Interrupt System
//
// 4 different interrupts handled using priority assignment.
// 
// 		PRIORITY  | Interrupt Service Routine
//		------------------------------------
//			  0   | Zero ALU output	
//			  1   | Overflow (ALU) Output
//			  2   | Illegal OPcode
//			  3	| INPUT/OUTPUT Interrupt
//
//
//////////////////////////////////////////////////////////////////////////////////
module MHVPIS(clk, itr_clr, itr_in, mask_in, itr_en, i_pending, PC_out, ITR_register, MASK_register);
	input clk;					//Input clock signal
	//input clr;				//Active low clear for whole system
	input itr_clr;				//Clear pending interrupts
	input itr_en;				//Enable or disable interrupt handler
	input [3:0] mask_in;		//Register containing interrupt mask vector (size: 4)
	input [3:0] itr_in;		//Vector containing interrupt input signals
	

	output i_pending;		//Pending interrupt
	output [7:0] PC_out;	//Memory address containing ISR 
	output [3:0] ITR_register, MASK_register;
	
	reg [7:0] isr_addr1, isr_addr2; //ISR Addresses
	reg [7:0] isr_addr3, isr_addr4; //ISR Addresses
	
	initial begin //define ISR Addresses
		isr_addr1[7:0] = 8'b10010110; //ISR1 
		isr_addr2[7:0] = 8'b10110100; //ISR2 180 - Handle Overflow
		isr_addr3[7:0] = 8'b11010111; //ISR3 
		isr_addr4[7:0] = 8'b01010110; //ISR4 150 - Handle Zero Output
	end
	
	wire [3:0] itr_and_w;
	wire [1:0] encoder_w;
	wire itr_pending_w;
	
	wire [3:0] itr_reg_w;
	wire [3:0] mask_reg_w;
	assign MASK_register = mask_reg_w;
	assign ITR_register = itr_reg_w;
	
	//module ld_st_reg(clk, clr, set, in, out);
	//Interrupt Register - Load Store
	ld_st_reg_4bit ITR_REG(clk, itr_clr, itr_en, itr_in, itr_reg_w);
	//Mask Register - Load Store
	ld_st_reg_4bit MASK_REG(clk, itr_clr, itr_en, mask_in, mask_reg_w);
	
	//priority logic
	// ITR1: 1000
	// ITR2: 0100
	// ITR3: 0010
	// ITR4: 0001
	and andITR1(itr_and_w[0], itr_reg_w[0], mask_reg_w[0]);//Priority: 1
	and andITR2(itr_and_w[1], itr_reg_w[1], mask_reg_w[1]);//Priority: 2
	and andITR3(itr_and_w[2], itr_reg_w[2], mask_reg_w[2]);//Priority: 3
	and andITR4(itr_and_w[3], itr_reg_w[3], mask_reg_w[3]);//Priority: 4
	
	//Encoder - Using Priority Encoder - Select Target PC Address
	//module pri_encoder_4_2(in, enab, out, valid);
	pri_encoder_4_2 ENCODER(itr_and_w, 1'b1, encoder_w, itr_pending_w);
	
	//Check if interrupt pending should be enabled
	and iPendingEnab(i_pending, itr_pending_w, itr_en);
	
	//Select Output using mux 4x1 MUX. Output from Encoder = Select Lines
	//module mux_4_1_behavioral(i1, i2, i3, i4, sel, out);
	mux_4_1 PC_MUX(isr_addr1, isr_addr2, isr_addr3, isr_addr4, encoder_w, PC_out);
	

endmodule

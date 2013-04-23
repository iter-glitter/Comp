`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Controller Unit 0
//
// Moore Model Finite State Machine (FSM) implements control of stage 0 of the
// accumulator processor. 
// 
//////////////////////////////////////////////////////////////////////////////////
module stage0(clk, clr, instr, data_in, i_pending, ccr_z, stg1_state, 
					stg0_state, ctrl, pc_out, itr_mask, stage0, stg0_instr);
	//Inputs
	input clk, clr;
	input ccr_z;				//Condition Code Register Z - Zero Flag (For Branch)
	input i_pending;			//Pending interrupt signal sent from MHVPIS
	//input [7:0] data;			//Contents of IR0_0 - Data Register
	input [7:0] instr;		//Contents of IR0_0 - Instruction Register
	input stg1_state;			//Handshake control line - Stage 1 interface
	input [7:0] data_in;		//Contents of IR1_0 - Operand Register
	
	//Outputs
	output reg stg0_state;		//Handshake control line - Stage 0 (this unit) status
	output reg [7:0] pc_out;	//Used to set PC address
	output reg [20:0] ctrl; 	//21 bit control line - control and select points
	
	output reg [15:0] stage0; 	//Current Controller state
	output [7:0] stg0_instr;
	output reg [3:0] itr_mask;	//Output ITR mask
	
	wire [7:0] stg0_instr_w;
	assign stg0_instr_w = instr;
	assign stg0_instr = stg0_instr_w;
	
	//Define Stage 0 state parameters
	parameter T0 =  16'b0000000000000001;  
	parameter T1 =  16'b0000000000000010; //Logic States   
	parameter T2 =  16'b0000000000000100;  
	parameter T3 =  16'b0000000000001000;  
	parameter T4 =  16'b0000000000010000;  
	parameter T5 =  16'b0000000000100000; //Logic States  
	parameter T6 =  16'b0000000001000000;  
	parameter T7 =  16'b0000000010000000; //Logic States  
	parameter T8 =  16'b0000000100000000; //Logic States   
	parameter T9 =  16'b0000001000000000; //Logic States   
	parameter T10 = 16'b0000010000000000; 
	parameter T11 = 16'b0000100000000000; //Logic States  
	parameter T12 = 16'b0001000000000000; 
	parameter T13 = 16'b0010000000000000; 
	parameter T14 = 16'b0100000000000000;
	parameter T15 = 16'b1000000000000000;
	
	//Define Stage 0 control points
	parameter CP0=21'b101101010010010110110;
	parameter CP1=21'b100101010011100110110;
	parameter CP2=21'b100101010011100100100;
	parameter CP3=21'b101101010011101110110;
	parameter CP4=21'b100111110011100110110;
	parameter CP5=21'b100101010011100110110;
	parameter CP6=21'b110101010011100110110;
	parameter CP7=21'b100101010011100110110;
	parameter CP8=21'b100101010011100110110;
	parameter CP9=21'b100101010011100110110;
	parameter CP10=21'b101101010011111110110;
	parameter CP11=21'b100101010011100110110;
	parameter CP12=21'b100101010011100100100;
	parameter CP13=21'b100101010010100101101;
	parameter CP14=21'b100101010011100110110;
	parameter CP15=21'b101101011010100111111;
	
	//Define OPcodes that will be executed by this controller
	parameter BRA  = 5'b00110;
	parameter JMP  = 5'b00111;
	parameter BSR  = 5'b10101;
	parameter RTS  = 5'b01000;
	parameter RTI  = 5'b01001;
	parameter LMSK = 5'b01110;
	
	//Define flags
	parameter BEQ = 3'b000; //BRA - If Equal
	parameter BNE = 3'b001; //BRA - If Not Equal
	
	//Control Flags
	reg [2:0] bra_loop; //Branch Wait Flag
	reg itr_state; //1: Handling Interrupt 0: No ITR
	reg itr_pc_loop;
	
	initial begin
		pc_out <= 8'b00000000;
		bra_loop <= 3'b000;
		itr_state <= 1'b0;
		itr_pc_loop <= 1'b0;
	end
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin
			stage0 <= T0;
		end
		else begin 
			case(stage0) 
			T0: stage0 <= T4;
			T1: if((i_pending==1'b1)&&(itr_state==1'b0)) begin stage0 <= T2; end
				 else begin stage0 <= T4; end
			T2: begin
					stage0 <= T3;
					itr_state <= 1'b1;
				 end
			T3: if(itr_pc_loop==1'b1) begin
					stage0 <= T4;
					itr_pc_loop <= 1'b0;
				 end
				 else begin
					itr_pc_loop <= (itr_pc_loop + 1);
					stage0 <= T3;
				 end
			T4: stage0 <= T5;
			T5: if(instr[7:3]==BRA) begin stage0 <= T8; end
				 else if(instr[7:3]==JMP) begin stage0 <= T10; end
				 else if(instr[7:3]==BSR) begin stage0 <= T12; end
				 else if(instr[7:3]==RTS) begin stage0 <= T13; end
				 else if(instr[7:3]==RTI) begin stage0 <= T13; end
				 else if(instr[7:3]==LMSK) begin stage0 <= T14; end
				 else begin stage0 <= T7; end
			T6: stage0 <= T1;
			T7: if(stg1_state==1'b1) begin 	//Stage1 Handshake				
						stage0 <= T6; 				//Restart Fetch Cycle
				 end else begin stage0 <= T7; end	//Wait for Stage1 Handshake
			T8: begin
						//stg0_state <= 1'b1;				//Start Stage1
						if(stg1_state==1'b1) begin		//Continue Branch
							if(instr[2:0]==BEQ) begin stage0 <= T9; end
							else if (instr[2:0]==BNE) begin stage0 <= T11; end
							else begin stage0 <= T6; end
						end else begin
							stage0 <= T8;					//Wait for stage1 Handshake
						end
					end
			T9: if(bra_loop==3'b001) begin
					if(ccr_z==1'b1) begin stage0 <= T10; end 	//Branch
					else begin stage0 <= T6; end
					bra_loop <= 3'b000;
				 end else begin 
					if(ccr_z==1'b1) begin stage0 <= T10; end 	//Branch
					else begin stage0 <= T9; end
					bra_loop <= (bra_loop + 1);
				 end
				 
			T10: stage0 <= T1; 		
			T11:if(bra_loop==3'b001) begin 
					if(ccr_z==1'b0) begin stage0 <= T10; end //Branch
					else begin stage0 <= T6; end
					bra_loop <= 3'b000;
				 end else begin 
					if(ccr_z==1'b1) begin stage0 <= T6; end //Branch
					else begin stage0 <= T11; end
					bra_loop <= (bra_loop + 1);
				end
			T12: stage0 <= T10;
			T13: if(instr[7:3]==RTI) begin
					itr_state <= 1'b0;
					stage0 <= T15;
				  end else begin 
					stage0 <= T15;
				  end
			T14: begin 
					stage0 <= T6;
					if(instr[7:3]==LMSK) begin	itr_mask <= data_in[3:0]; end
				  end
			T15: stage0 <= T7;
			default: stage0 <= T6;
			endcase 
		end
	end
	
	always @ (stage0) begin
		case(stage0) 
			T0: ctrl <= CP0;
			T1: ctrl <= CP1;
			T2: ctrl <= CP2;
			T3: ctrl <= CP3;
			T4: ctrl <= CP4;
			T5: ctrl <= CP5;
			T6: begin
					ctrl <= CP6;
					stg0_state <= 1'b0;
				 end
			T7: begin
				ctrl <= CP7;
				stg0_state <= 1'b1; 		//Stage0 Finished
				end
			T8: begin
				ctrl <= CP8;
				stg0_state <= 1'b1; 		//Stage0 Finished
				end
			T9: begin
					ctrl <= CP9;
					stg0_state <= 1'b0;
				 end
			T10: ctrl <= CP10;
			T11: begin
					ctrl <= CP11;
					stg0_state <= 1'b0;
				 end
			T12: ctrl <= CP12;
			T13: ctrl <= CP13;
			T14: ctrl <= CP14;
			T15: ctrl <= CP15;
			default: ctrl <= CP1;
		endcase
	end
	
endmodule

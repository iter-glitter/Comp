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
module stage0(clk, clr, instr, i_pending, ccr_z, stg1_state, 
					stg0_state, ctrl, pc_out, stage0, stg0_instr);
	//Inputs
	input clk, clr;
	input ccr_z;				//Condition Code Register Z - Zero Flag (For Branch)
	input i_pending;			//Pending interrupt signal sent from MHVPIS
	//input [7:0] data;			//Contents of IR1_0 - Data Register
	input [7:0] instr;		//Contents of IR0_0 - Instruction Register
	input stg1_state;			//Handshake control line - Stage 1 interface
	
	//Outputs
	output reg stg0_state;		//Handshake control line - Stage 0 (this unit) status
	output reg [7:0] pc_out;	//Used to set PC address
	output reg [20:0] ctrl; 	//21 bit control line - control and select points
	
	output reg [14:0] stage0; 			//Current Controller state
	output [7:0] stg0_instr;
	
	wire [7:0] stg0_instr_w;
	assign stg0_instr_w = instr;
	assign stg0_instr = stg0_instr_w;
	
	//Define Stage 0 state parameters
	parameter T0 =  15'b000000000000001;  
	parameter T1 =  15'b000000000000010; //Logic States   
	parameter T2 =  15'b000000000000100;  
	parameter T3 =  15'b000000000001000;  
	parameter T4 =  15'b000000000010000;  
	parameter T5 =  15'b000000000100000; //Logic States  
	parameter T6 =  15'b000000001000000;  
	parameter T7 =  15'b000000010000000; //Logic States  
	parameter T8 =  15'b000000100000000; //Logic States   
	parameter T9 =  15'b000001000000000; //Logic States   
	parameter T10 = 15'b000010000000000; 
	parameter T11 = 15'b000100000000000; //Logic States  
	parameter T12 = 15'b001000000000000; 
	parameter T13 = 15'b010000000000000; 
	parameter T14 = 15'b100000000000000;
	
	//Define Stage 0 control points
	parameter CP0 =  20'b10110101001010110110;
	parameter CP1 =  20'b10010101001100110110; //Logic State
	parameter CP2 =  20'b10010101001100100100;
	parameter CP3 =  20'b10110101001101110110;
	parameter CP4 =  20'b10011111001100110110;
	parameter CP5 =  20'b10010101001100110110; //Logic State
	parameter CP6 =  20'b11010101001100110110;
	parameter CP7 =  20'b10010101001100110110; //Logic State
	parameter CP8 =  20'b10010101001100110110; //Logic State
	parameter CP9 =  20'b10010101001100110110; //Logic State
	parameter CP10 = 20'b10110101001111110110;
	parameter CP11 = 20'b10010101001100110110; //Logic State
	parameter CP12 = 20'b10010101001100100100;
	parameter CP13 = 20'b10110101101100101101;
	parameter CP14 = 20'b10010101001100110110;
	
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
	
	initial begin
		pc_out <= 8'b00000000;
	end
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin
			stage0 <= T0;
		end
		else begin 
			case(stage0) 
			T0: stage0 <= T1;
			T1: if(i_pending==1'b1) begin stage0 <= T2; end
				 else begin stage0 <= T4; end
			T2: stage0 <= T3;
			T3: stage0 <= T4;
			T4: stage0 <= T5;
			T5: stage0 <= T6; 
			T6: if(instr[7:3]==BRA) begin stage0 <= T8; end
				 else if(instr[7:3]==JMP) begin stage0 <= T10; end
				 else if(instr[7:3]==BSR) begin stage0 <= T12; end
				 else if(instr[7:3]==RTS) begin stage0 <= T13; end
				 else if(instr[7:3]==RTI) begin stage0 <= T13; end
				 else if(instr[7:3]==LMSK) begin stage0 <= T14; end
				 else begin stage0 <= T7; end
			T7: if(stg1_state==1'b1) begin 	//Stage1 Handshake				
						stage0 <= T1; 				//Restart Fetch Cycle
				 end else begin stage0 <= T7; end	//Wait for Stage1 Handshake
			T8: begin
						//stg0_state <= 1'b1;				//Start Stage1
						if(stg1_state==1'b1) begin		//Continue Branch
							if(instr[2:0]==BEQ) begin stage0 <= T9; end
							else if (instr[2:0]==BNE) begin stage0 <= T11; end
							else begin stage0 <= T1; end
						end else begin
							stage0 <= T8;					//Wait for stage1 Handshake
						end
					end
			T9: if(ccr_z==1'b1) begin stage0 <= T10; end 	//Branch
				else begin stage0 <= T1; end						
			T10: stage0 <= T1; 		
			T11: if(ccr_z==1'b0) begin stage0 <= T10; end //Branch
				else begin stage0 <= T1; end
			T12: stage0 <= T10;
			T13: stage0 <= T7;
			T14: stage0 <= T1;
			default: stage0 <= T1;
			endcase 
		end
	end
	
	always @ (stage0) begin
		case(stage0) 
			T0: ctrl <= CP0;
			T1: begin
					ctrl <= CP1;
					stg0_state <= 1'b0;
				 end
			T2: ctrl <= CP2;
			T3: ctrl <= CP3;
			T4: ctrl <= CP4;
			T5: ctrl <= CP5;
			T6: ctrl <= CP6;
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
			default: ctrl <= CP1;
		endcase
	end
	
endmodule

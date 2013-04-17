`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Controller Unit 1
//
// Moore Model Finite State Machine (FSM) implements control of stage 1 of the
// accumulator processor. 
// 
//////////////////////////////////////////////////////////////////////////////////
module stage1(clk, clr, instr, ir_data, mdr_data, stg0_state, 
					cache_hit, stg1_state, ctrl, num_shift);
	//Inputs
	input clk, clr;
	input [7:0] ir_data;				//Contents of IR1_0 - Data Register
	input [7:0] mdr_data;			//Contents of IR1_0 - Data Register
	input [7:0] instr;				//Contents of IR0_0 - Instruction Register
	input stg0_state;					//Handshake control line - Stage 1 interface
	input cache_hit;					//Hit signal from the cache
	
	//Outputs
	output reg stg1_state;			//Handshake control line - Stage 0 status
	output reg [34:0] ctrl; 		//21 bit control line - control and sel points
	output reg [2:0] num_shift;	//Control Shifter - Number to shift by
	
	reg [55:0] stage1; 			//Current Controller state
	
	//Temporary Registers
	
	
	//Define Stage 1 state encoding
	parameter T0  = 56'b00000000000000000000000000000000000000000000000000000001;
	parameter T1  = 56'b00000000000000000000000000000000000000000000000000000010;
	parameter T2  = 56'b00000000000000000000000000000000000000000000000000000100;
	parameter T3  = 56'b00000000000000000000000000000000000000000000000000001000;
	parameter T4  = 56'b00000000000000000000000000000000000000000000000000010000;
	parameter T5  = 56'b00000000000000000000000000000000000000000000000000100000;
	parameter T6  = 56'b00000000000000000000000000000000000000000000000001000000;
	parameter T7  = 56'b00000000000000000000000000000000000000000000000010000000;
	parameter T8  = 56'b00000000000000000000000000000000000000000000000100000000;
	parameter T9  = 56'b00000000000000000000000000000000000000000000001000000000;
	parameter T10 = 56'b00000000000000000000000000000000000000000000010000000000;
	parameter T11 = 56'b00000000000000000000000000000000000000000000100000000000;
	parameter T12 = 56'b00000000000000000000000000000000000000000001000000000000;
	parameter T13 = 56'b00000000000000000000000000000000000000000010000000000000;
	parameter T14 = 56'b00000000000000000000000000000000000000000100000000000000;
	parameter T15 = 56'b00000000000000000000000000000000000000001000000000000000;
	parameter T16 = 56'b00000000000000000000000000000000000000010000000000000000;
	parameter T17 = 56'b00000000000000000000000000000000000000100000000000000000;
	parameter T18 = 56'b00000000000000000000000000000000000001000000000000000000;
	parameter T19 = 56'b00000000000000000000000000000000000010000000000000000000;
	parameter T20 = 56'b00000000000000000000000000000000000100000000000000000000;
	parameter T21 = 56'b00000000000000000000000000000000001000000000000000000000;
	parameter T22 = 56'b00000000000000000000000000000000010000000000000000000000;
	parameter T23 = 56'b00000000000000000000000000000000100000000000000000000000;
	parameter T24 = 56'b00000000000000000000000000000001000000000000000000000000;
	parameter T25 = 56'b00000000000000000000000000000010000000000000000000000000;
	parameter T26 = 56'b00000000000000000000000000000100000000000000000000000000;
	parameter T27 = 56'b00000000000000000000000000001000000000000000000000000000;
	parameter T28 = 56'b00000000000000000000000000010000000000000000000000000000;
	parameter T29 = 56'b00000000000000000000000000100000000000000000000000000000;
	parameter T30 = 56'b00000000000000000000000001000000000000000000000000000000;
	parameter T31 = 56'b00000000000000000000000010000000000000000000000000000000;
	parameter T32 = 56'b00000000000000000000000100000000000000000000000000000000;
	parameter T33 = 56'b00000000000000000000001000000000000000000000000000000000;
	parameter T34 = 56'b00000000000000000000010000000000000000000000000000000000;
	parameter T35 = 56'b00000000000000000000100000000000000000000000000000000000;
	parameter T36 = 56'b00000000000000000001000000000000000000000000000000000000;
	parameter T37 = 56'b00000000000000000010000000000000000000000000000000000000;
	parameter T38 = 56'b00000000000000000100000000000000000000000000000000000000;
	parameter T39 = 56'b00000000000000001000000000000000000000000000000000000000;
	parameter T40 = 56'b00000000000000010000000000000000000000000000000000000000;
	parameter T41 = 56'b00000000000000100000000000000000000000000000000000000000;
	parameter T42 = 56'b00000000000001000000000000000000000000000000000000000000;
	parameter T43 = 56'b00000000000010000000000000000000000000000000000000000000;
	parameter T44 = 56'b00000000000100000000000000000000000000000000000000000000;
	parameter T45 = 56'b00000000001000000000000000000000000000000000000000000000;
	parameter T46 = 56'b00000000010000000000000000000000000000000000000000000000;
	parameter T47 = 56'b00000000100000000000000000000000000000000000000000000000;
	parameter T48 = 56'b00000001000000000000000000000000000000000000000000000000;
	parameter T49 = 56'b00000010000000000000000000000000000000000000000000000000;
	parameter T50 = 56'b00000100000000000000000000000000000000000000000000000000;
	parameter T51 = 56'b00001000000000000000000000000000000000000000000000000000;
	parameter T52 = 56'b00010000000000000000000000000000000000000000000000000000;
	parameter T53 = 56'b00100000000000000000000000000000000000000000000000000000;
	parameter T54 = 56'b01000000000000000000000000000000000000000000000000000000;
	parameter T55 = 56'b10000000000000000000000000000000000000000000000000000000;
	
	//Define Stage 1 control points
	parameter CP0 =  35'b10000000000000011110001110110000000;
	parameter CP1 =  35'b10000000000010010101001110110000000;
	parameter CP2 =  35'b10000000000010010100001110110000000;
	parameter CP3 =  35'b10000000000010010100101110110000000;
	parameter CP4 =  35'b10000000000000011110001110110000000;
	parameter CP5 =  35'b10000000000010010101001110110000000;
	parameter CP6 =  35'b10000000000010010100001110110000000;
	parameter CP7 =  35'b10000000000010010100101110110000000;
	parameter CP8 =  35'b10000000000010010101001110110000000;
	parameter CP9 =  35'b10000000000000011110001110110000000;
	parameter CP10 = 35'b10100000000000010100001110110000000;
	parameter CP11 = 35'b10100000000000010100001100110000000;
	parameter CP12 = 35'b10100110000000010100001110110000000;
	parameter CP13 = 35'b10100110000000010100001100110000000;
	parameter CP14 = 35'b10101000000000010100001110110000000;
	parameter CP15 = 35'b10101000000000010100001100110000000;
	parameter CP16 = 35'b10110000000000010100001110110000000;
	parameter CP17 = 35'b10110000000000010100001100110000000;
	parameter CP18 = 35'b10111000000000010100001110110000000;
	parameter CP19 = 35'b10000000000000010100001110110001000;
	parameter CP20 = 35'b10100000000000010100000010110010100;
	parameter CP21 = 35'b10000000010100010100001110110000000;
	parameter CP22 = 35'b10100000000000010100000010110010100;
	parameter CP23 = 35'b10100000000000010100001100110000000;
	parameter CP24 = 35'b10100000000000010100000010110011010;
	parameter CP25 = 35'b10000000010100010100001110110000000;
	parameter CP26 = 35'b10100000000000010100000010110011010;
	parameter CP27 = 35'b10100000000000010100001100110000000;
	parameter CP28 = 35'b10100000000000010100000010110010000;
	parameter CP29 = 35'b10100000000000010100000010110010100;
	parameter CP30 = 35'b10100000000000010100000010110011000;
	parameter CP31 = 35'b10100000000000010100000010110011010;
	parameter CP32 = 35'b10100000000000010100000110110000000;
	parameter CP33 = 35'b10100000000000010100001010110000000;
	parameter CP34 = 35'b10000000000000010100101110101100000;
	parameter CP35 = 35'b10000000000011010100001110110000000;
	parameter CP36 = 35'b11000001000000010100001110110000000;
	parameter CP37 = 35'b11000000000000010100001110110000000;
	parameter CP38 = 35'b10000000000000010100101110101000000;
	parameter CP39 = 35'b10000000011000010100001110110000000;
	parameter CP40 = 35'b10000000010000010100001110110000000;
	parameter CP41 = 35'b10000000000000010100101110100100000;
	parameter CP42 = 35'b10000000000000010100001110110000000;
	parameter CP43 = 35'b10000000000000010100001110110000000;
	parameter CP44 = 35'b10000000000000010100101110100000000;
	parameter CP45 = 35'b10000000000000010100001110110000000;
	parameter CP46 = 35'b10000000000000010100001110110000000;
	parameter CP47 = 35'b10000000000000010100001110110000000;
	parameter CP48 = 35'b10000000000000010100001110110000000;
	parameter CP49 = 35'b10000000000000010100001110110000000;
	parameter CP50 = 35'b10000000000000010100001110110000000;
	parameter CP51 = 35'b10000000000000011110001110110000000;
	parameter CP52 = 35'b10100110000000010100001101110000000;
	parameter CP53 = 35'b10100000000000010100010010110000000;
	parameter CP54 = 35'b10000000000000010100001110110001000;
	parameter CP55 = 35'b10000000000010010100001110110000000;
	
	//Parameterize Instruction OPcodes
	parameter opADD  = 5'b00000; 
	parameter opSUB  = 5'b00001;
	parameter opOR	  = 5'b00011;
	parameter opAND  = 5'b00100;
	parameter opCOMP = 5'b10000;
	parameter opMULDIV = 5'b00010;
	parameter opSHFT = 5'b00101;
	parameter opBRA  = 5'b00110;
	parameter opRTS  = 5'b01000;
	parameter opRTI  = 5'b01001;
	parameter opLOAD = 5'b01010;
	parameter opSTOR = 5'b01011;
	parameter opLDA  = 5'b10001;
	parameter opSTA  = 5'b10010;
	parameter opLDB  = 5'b10011;
	parameter opSTB  = 5'b10100;
	parameter opINPUT = 5'b01100;
	parameter opOUTPUT = 5'b01101;
	parameter opLMSK = 5'b01110;
	parameter opNOP  = 5'b01111;
	
	//Parameterize Instruction Flags
	parameter flDIR = 3'b000; 		//Direct
	parameter flIND = 3'b001;		//Indirect
	parameter flIMM = 3'b010;		//Immediate
	parameter flMUL_DIR = 3'b000;	//Multiply Direct
	parameter flMUL_IND = 1'b001;	//Multiply Indirect
	parameter flDIV_DIR = 1'b010;	//Multiply Direct
	parameter flDIV_IND = 1'b011;	//Multiply Indirect
	parameter flMUL = 1'b0;			//MULDIV Multiply
	parameter flDIV = 1'b1;			//MULDIV Division
	parameter flLS0 = 3'b000;		//Left Shift 0
	parameter flLS1 = 3'b001;		//Left Shift 1
	parameter flRS0 = 3'b010;		//Right Shift 0
	parameter flRS1 = 3'b011;		//Right Shift 1

	always @ (posedge clk) begin
		if(clr==1'b0) begin
			stage1 <= T55;
		end
		else begin
			case(stage1)
				T0:  if(instr[7:3]==opSHFT) begin stage1 <= T54; end
					  else begin stage1 <= T1; end
				T1:  stage1 <= T2;
				T2:  if(cache_hit==1'b1) begin stage1 <= T3; end //Handle cache hit
					  else begin stage1 <= T3; end
				T3: 	case(instr[7:3])
							opADD: stage1 <= T10;
							opSUB: stage1 <= T12;
							opOR:	 stage1 <= T14;
							opAND: stage1 <= T16;
							opMULDIV: stage1 <= T54;
						endcase
				T4:  stage1 <= T5;
				T5:  stage1 <= T6;
				T6:  if(cache_hit==1'b1) begin stage1 <= T7; end //Handle cache hit
					  else begin stage1 <= T7; end
				T7:  stage1 <= T8;
				T8:  stage1 <= T2;
				T9:  case(instr[7:3])
							opADD: stage1 <= T11;
							opSUB: stage1 <= T13;
							opOR:  stage1 <= T15;
							opAND: stage1 <= T17;
					  endcase
				T10: stage1 <= T55;
				T11: stage1 <= T55;
				T12: stage1 <= T55;
				T13: stage1 <= T55;
				T14: stage1 <= T55; 
				T15: stage1 <= T55;
				T16: stage1 <= T55;
				T17: stage1 <= T55;
				T18: stage1 <= T55;
				T19: case(instr[1])
							flMUL: case(mdr_data[0])
										0: stage1 <= T20; //Even Parity
										1: stage1 <= T21; //Odd Parity
									 endcase
							flDIV: case(mdr_data[0])
										0: stage1 <= T24; //Even Parity
										1: stage1 <= T25; //Odd Parity
									 endcase
					  endcase
				T20: stage1 <= T55;
				T21: stage1 <= T22;
				T22: stage1 <= T23;
				T23: stage1 <= T55;
				T24: stage1 <= T55;
				T25: stage1 <= T26;  
				T26: stage1 <= T27;
				T27: stage1 <= T55;
				T28: stage1 <= T55;
				T29: stage1 <= T55;
				T30: stage1 <= T55;
				T31: stage1 <= T55;
				T32:  ;
				T33:  ;
				T34:  ;
				T35:  ;
				T36:  ;
				T37:  ;
				T38:  ;
				T39:  ;
				T40:  ;
				T41:  ;
				T42:  ;
				T43:  ;
				T44:  ;
				T45:  ;
				T46:  ;  
				T47:  ;
				T48:  ;
				T49:  ;
				T50:  ;
				T51: stage1 <= T52;
				T52: stage1 <= T55;
				T53: stage1 <= T55;
				T54:  case(instr[7:3])
							opSHFT: case(instr[2:0])
										flLS0: stage1 <= T28;
										flLS1: stage1 <= T29;
										flRS0: stage1 <= T30;
										flRS1: stage1 <= T31;
									  endcase
							opMULDIV: stage1 <= T19;			
						endcase
				T55:	if(stg0_state==1'b1) begin  		//Digest OPcode
							case(instr[7:3]) 
								opADD:	case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
											endcase
								opSUB:	case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
											endcase
								opOR:	case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
											endcase
								opAND:	case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
											endcase
								opCOMP: stage1 <= T18;
								opMULDIV: case(instr[2:0])
												flMUL_DIR: stage1 <= T0;
												flMUL_IND: stage1 <= T4;
												flDIV_DIR: stage1 <= T0;
												flDIV_IND: stage1 <= T4;
											 endcase								
								opSHFT: stage1 <= T0;
								opBRA:  stage1 <= T51;
								opRTS:  stage1 <= T53; 
								opRTI:  stage1 <= T53;
								opLOAD: ;
								opSTOR: ;
								opLDA: ;
								opSTA: ;
								opLDB: ;
								opSTB: ;
								opINPUT: ;
								opOUTPUT: ;
								opLMSK: ;
								opNOP: ;
								default: stage1 <= T55;
							endcase
						end
				default: stage1 <= T55;
			endcase
		end
	end
	
	always @ (stage1) begin
		case(stage1) 
			T0: begin
					ctrl <= CP0;
					stg1_state <= 1'b0;
				 end
			T1: ctrl <= CP1;
			T2: ctrl <= CP2;
			T3: ctrl <= CP3;
			T4: begin
					ctrl <= CP4;
					stg1_state <= 1'b0;
				 end
			T5: ctrl <= CP5;
			T6: ctrl <= CP6;
			T7: ctrl <= CP7;
			T8: ctrl <= CP8;
			T9: begin
					ctrl <= CP9;
					stg1_state <= 1'b0;
				 end
			T10: ctrl <= CP10;
			T11: ctrl <= CP11;
			T12: ctrl <= CP12;
			T13: ctrl <= CP13;
			T14: ctrl <= CP14; 
			T15: ctrl <= CP15;
			T16: ctrl <= CP16;
			T17: ctrl <= CP17;
			T18: begin
					ctrl <= CP18;
					stg1_state <= 1'b0;
				  end
			T19: ctrl <= CP19;
			T20: begin
					ctrl <= CP20;
					num_shift <= (mdr_data[2:0] << 1);
				  end
			T21: ctrl <= CP21;
			T22: begin
					ctrl <= CP22;
					num_shift <= (mdr_data[2:0] << 1);
				  end
			T23: ctrl <= CP23;
			T24: begin
					ctrl <= CP24;
					num_shift <= (mdr_data[2:0] >> 1);
				  end
			T25: ctrl <= CP25; 
			T26: begin
					ctrl <= CP26;
					num_shift <= (mdr_data[2:0] >> 1);
				  end
			T27: ctrl <= CP27;
			T28: begin
					ctrl <= CP28;
					num_shift <= ir_data[2:0];
				  end
			T29: begin
					ctrl <= CP29;
					num_shift <= ir_data[2:0];
				  end
			T30: begin
					ctrl <= CP30;
					num_shift <= ir_data[2:0];
				  end
			T31: begin
					ctrl <= CP31;
					num_shift <= ir_data[2:0];
				  end
			T32: ctrl <= CP32;
			T33: ctrl <= CP33;
			T34: ctrl <= CP34;
			T35: ctrl <= CP35;
			T36: ctrl <= CP36;
			T37: ctrl <= CP37;
			T38: ctrl <= CP38;
			T39: ctrl <= CP39;
			T40: ctrl <= CP40;
			T41: ctrl <= CP41;
			T42: ctrl <= CP42;
			T43: ctrl <= CP43;
			T44: ctrl <= CP44;
			T45: ctrl <= CP45;
			T46: ctrl <= CP46; 
			T47: ctrl <= CP47;
			T48: ctrl <= CP48;
			T49: ctrl <= CP49;
			T50: ctrl <= CP50;
			T51: ctrl <= CP51;
			T52: ctrl <= CP52;
			T53: ctrl <= CP53;
			T54: ctrl <= CP54;
			T55: begin
					ctrl <= CP55;
					stg1_state <= 1'b1;
				  end
			default: ctrl <= CP0;
		endcase
	end
	
endmodule

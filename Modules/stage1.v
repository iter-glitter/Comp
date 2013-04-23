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
module stage1(clk, clr, instr, ir_data, mdr_data, stg0_state, input_rdy, out_recv, 
				out_dev_rdy, cache_hit, stg1_state, ctrl, num_shift, input_recv, stage1, stg1_instr, ch_miss_loop);
	//Inputs
	input clk, clr;
	input [7:0] ir_data;			//Contents of IR1_0 - Data Register
	input [7:0] mdr_data;		//Contents of IR1_0 - Data Register
	input [7:0] instr;			//Contents of IR0_0 - Instruction Register
	input stg0_state;				//Handshake control line - Stage 1 interface
	input cache_hit;				//Hit signal from the cache
	input input_rdy;				//Handhsake control line - Input device
	input out_dev_rdy;			//Handshake control line - Output Device Ready
	input out_recv;				//Handshake Control Line - Out Dev Received Data
	
	//Outputs
	output reg stg1_state;			//Handshake control line - Stage 0 status
	output reg [35:0] ctrl; 		//21 bit control line - control and sel points
	output reg [2:0] num_shift;		//Control Shifter - Number to shift by
	output reg input_recv;			//Handhsake Control Line - Input Received
	
	output reg [71:0] stage1; 				//Current Controller state
	
	//INPUT/OUTPUT Handshake registers
	reg rdy_recv;						//Ready to Receive Flag
	reg rdy_out;						//Ready to OUTPUT Flag
	
	//Stage1 Pipeline Ready
	reg stg1_rdy;
	
	//Cache Miss Loop
	output reg [4:0] ch_miss_loop;
	reg ch_hit_loop;
	
	//Stage 1 Instruciton IN - Output
	output [7:0] stg1_instr;
	wire [7:0] stg1_instr_w;
	assign stg1_instr_w = instr;
	assign stg1_instr = stg1_instr_w;
	
	//Define Stage 1 state encoding
	parameter T0  = 72'b000000000000000000000000000000000000000000000000000000000000000000000001;
	parameter T1  = 72'b000000000000000000000000000000000000000000000000000000000000000000000010;
	parameter T2  = 72'b000000000000000000000000000000000000000000000000000000000000000000000100;
	parameter T3  = 72'b000000000000000000000000000000000000000000000000000000000000000000001000;
	parameter T4  = 72'b000000000000000000000000000000000000000000000000000000000000000000010000;
	parameter T5  = 72'b000000000000000000000000000000000000000000000000000000000000000000100000;
	parameter T6  = 72'b000000000000000000000000000000000000000000000000000000000000000001000000;
	parameter T7  = 72'b000000000000000000000000000000000000000000000000000000000000000010000000;
	parameter T8  = 72'b000000000000000000000000000000000000000000000000000000000000000100000000;
	parameter T9  = 72'b000000000000000000000000000000000000000000000000000000000000001000000000;
	parameter T10 = 72'b000000000000000000000000000000000000000000000000000000000000010000000000;
	parameter T11 = 72'b000000000000000000000000000000000000000000000000000000000000100000000000;
	parameter T12 = 72'b000000000000000000000000000000000000000000000000000000000001000000000000;
	parameter T13 = 72'b000000000000000000000000000000000000000000000000000000000010000000000000;
	parameter T14 = 72'b000000000000000000000000000000000000000000000000000000000100000000000000;
	parameter T15 = 72'b000000000000000000000000000000000000000000000000000000001000000000000000;
	parameter T16 = 72'b000000000000000000000000000000000000000000000000000000010000000000000000;
	parameter T17 = 72'b000000000000000000000000000000000000000000000000000000100000000000000000;
	parameter T18 = 72'b000000000000000000000000000000000000000000000000000001000000000000000000;
	parameter T19 = 72'b000000000000000000000000000000000000000000000000000010000000000000000000;
	parameter T20 = 72'b000000000000000000000000000000000000000000000000000100000000000000000000;
	parameter T21 = 72'b000000000000000000000000000000000000000000000000001000000000000000000000;
	parameter T22 = 72'b000000000000000000000000000000000000000000000000010000000000000000000000;
	parameter T23 = 72'b000000000000000000000000000000000000000000000000100000000000000000000000;
	parameter T24 = 72'b000000000000000000000000000000000000000000000001000000000000000000000000;
	parameter T25 = 72'b000000000000000000000000000000000000000000000010000000000000000000000000;
	parameter T26 = 72'b000000000000000000000000000000000000000000000100000000000000000000000000;
	parameter T27 = 72'b000000000000000000000000000000000000000000001000000000000000000000000000;
	parameter T28 = 72'b000000000000000000000000000000000000000000010000000000000000000000000000;
	parameter T29 = 72'b000000000000000000000000000000000000000000100000000000000000000000000000;
	parameter T30 = 72'b000000000000000000000000000000000000000001000000000000000000000000000000;
	parameter T31 = 72'b000000000000000000000000000000000000000010000000000000000000000000000000;
	parameter T32 = 72'b000000000000000000000000000000000000000100000000000000000000000000000000;
	parameter T33 = 72'b000000000000000000000000000000000000001000000000000000000000000000000000;
	parameter T34 = 72'b000000000000000000000000000000000000010000000000000000000000000000000000;
	parameter T35 = 72'b000000000000000000000000000000000000100000000000000000000000000000000000;
	parameter T36 = 72'b000000000000000000000000000000000001000000000000000000000000000000000000;
	parameter T37 = 72'b000000000000000000000000000000000010000000000000000000000000000000000000;
	parameter T38 = 72'b000000000000000000000000000000000100000000000000000000000000000000000000;
	parameter T39 = 72'b000000000000000000000000000000001000000000000000000000000000000000000000;
	parameter T40 = 72'b000000000000000000000000000000010000000000000000000000000000000000000000;
	parameter T41 = 72'b000000000000000000000000000000100000000000000000000000000000000000000000;
	parameter T42 = 72'b000000000000000000000000000001000000000000000000000000000000000000000000;
	parameter T43 = 72'b000000000000000000000000000010000000000000000000000000000000000000000000;
	parameter T44 = 72'b000000000000000000000000000100000000000000000000000000000000000000000000;
	parameter T45 = 72'b000000000000000000000000001000000000000000000000000000000000000000000000;
	parameter T46 = 72'b000000000000000000000000010000000000000000000000000000000000000000000000;
	parameter T47 = 72'b000000000000000000000000100000000000000000000000000000000000000000000000;
	parameter T48 = 72'b000000000000000000000001000000000000000000000000000000000000000000000000;
	parameter T49 = 72'b000000000000000000000010000000000000000000000000000000000000000000000000;
	parameter T50 = 72'b000000000000000000000100000000000000000000000000000000000000000000000000;
	parameter T51 = 72'b000000000000000000001000000000000000000000000000000000000000000000000000;
	parameter T52 = 72'b000000000000000000010000000000000000000000000000000000000000000000000000;
	parameter T53 = 72'b000000000000000000100000000000000000000000000000000000000000000000000000;
	parameter T54 = 72'b000000000000000001000000000000000000000000000000000000000000000000000000;
	parameter T55 = 72'b000000000000000010000000000000000000000000000000000000000000000000000000;
	parameter T56 = 72'b000000000000000100000000000000000000000000000000000000000000000000000000;
	parameter T57 = 72'b000000000000001000000000000000000000000000000000000000000000000000000000;
	parameter T58 = 72'b000000000000010000000000000000000000000000000000000000000000000000000000;
	parameter T59 = 72'b000000000000100000000000000000000000000000000000000000000000000000000000;
	parameter T60 = 72'b000000000001000000000000000000000000000000000000000000000000000000000000;
	parameter T61 = 72'b000000000010000000000000000000000000000000000000000000000000000000000000;
	parameter T62 = 72'b000000000100000000000000000000000000000000000000000000000000000000000000;
	parameter T63 = 72'b000000001000000000000000000000000000000000000000000000000000000000000000;
	parameter T64 = 72'b000000010000000000000000000000000000000000000000000000000000000000000000;
	parameter T65 = 72'b000000100000000000000000000000000000000000000000000000000000000000000000;
	parameter T66 = 72'b000001000000000000000000000000000000000000000000000000000000000000000000;
	parameter T67 = 72'b000010000000000000000000000000000000000000000000000000000000000000000000;
	parameter T68 = 72'b000100000000000000000000000000000000000000000000000000000000000000000000;
	parameter T69 = 72'b001000000000000000000000000000000000000000000000000000000000000000000000;
	parameter T70 = 72'b010000000000000000000000000000000000000000000000000000000000000000000000;
	parameter T71 = 72'b100000000000000000000000000000000000000000000000000000000000000000000000;

	//Define Stage 1 control points
	parameter CP0=36'b100000000000000111100011110110000001;
	parameter CP1=36'b100000000000000101010011110110000001;
	parameter CP2=36'b100000000000100101000011110110000001;
	parameter CP3=36'b100000000000100101001011110110000001;
	parameter CP4=36'b100000000000000111100011110110000001;
	parameter CP5=36'b100000000000000101010011110110000001;
	parameter CP6=36'b100000000000100101000011110110000001;
	parameter CP7=36'b100000000000000101001011110110000001;
	parameter CP8=36'b100000000000000101010011110010000001;
	parameter CP9=36'b100000000000000111100011110110000001;
	parameter CP10=36'b101000000000000101000011010110000001;
	parameter CP11=36'b101000000000000101000011011110000001;
	parameter CP12=36'b101001100000000101000011010110000001;
	parameter CP13=36'b101001100000000101000011011110000001;
	parameter CP14=36'b101010000000000101000011010110000001;
	parameter CP15=36'b101010000000000101000011011110000001;
	parameter CP16=36'b101100000000000101000011010110000001;
	parameter CP17=36'b101100000000000101000011011110000001;
	parameter CP18=36'b101110000000000101000011010110000001;
	parameter CP19=36'b100000000000000101000011100110001001;
	parameter CP20=36'b101000000000000101000000100110000001;
	parameter CP21=36'b100000000101000101000011100110000001;
	parameter CP22=36'b101000000000000101000000100110000001;
	parameter CP23=36'b101000000000000101000011000110000001;
	parameter CP24=36'b101000000000000101000000100110000001;
	parameter CP25=36'b100000000110000101000011100110000001;
	parameter CP26=36'b101000000000000101000000100110000001;
	parameter CP27=36'b101000000000000101000011000110000001;
	parameter CP28=36'b101000000000000101000000100110000001;
	parameter CP29=36'b101000000000000101000000100110000001;
	parameter CP30=36'b101000000000000101000000100110000001;
	parameter CP31=36'b101000000000000101000000100110000001;
	parameter CP32=36'b101000000000000101000001100110000001;
	parameter CP33=36'b101000000000000101000010100110000001;
	parameter CP34=36'b100000000000110101001011100101100001;
	parameter CP35=36'b100000000000110101000011100110000001;
	parameter CP36=36'b110000010000000101000011100110000001;
	parameter CP37=36'b110000000000000101000011100110000001;
	parameter CP38=36'b100000000000110101001011100101000001;
	parameter CP39=36'b100000000110000101000011100110000001;
	parameter CP40=36'b100000000100000101000011100110000001;
	parameter CP41=36'b100000000000110101001011100100100001;
	parameter CP42=36'b100000000000000101000011100110000001;
	parameter CP43=36'b100000000000000101000011100110000001;
	parameter CP44=36'b100000000000000101001011100100000001;
	parameter CP45=36'b100000000000000101000011100110000001;
	parameter CP46=36'b100000000000000101000011100110000001;
	parameter CP47=36'b100000000000000101000011100110000001;
	parameter CP48=36'b100000000000000101000011100110000001;
	parameter CP49=36'b100000000000000101000011100110000001;
	parameter CP50=36'b100000000000000101000011100110000001;
	parameter CP51=36'b100000000000000111100011100110000001;
	parameter CP52=36'b101001100000000101000011001110000001;
	parameter CP53=36'b101000000000000101000100100110000001;
	parameter CP54=36'b100000000000000101000011100110001001;
	parameter CP55=36'b100000000000000111000011100110000001;
	parameter CP56=36'b100000000000000111000011100110000001;
	parameter CP57=36'b100000000000000101000000100110010001;
	parameter CP58=36'b101000000000000101000000100110010101;
	parameter CP59=36'b101000000000000101000000100110011001;
	parameter CP60=36'b101000000000000101000000100110011011;
	parameter CP61=36'b100000000000000101000000100110010001;
	parameter CP62=36'b100000000000000101000000100110010001;
	parameter CP63=36'b100000000000000101000000100110011001;
	parameter CP64=36'b100000000000000101000000100110011001;
	parameter CP65=36'b100000000000110101000011100101100001;
	parameter CP66=36'b100000000000100101000011100001100001;
	parameter CP67=36'b100000000000110101000011100001100001;
	parameter CP68=36'b100000000000100101000011100001100001;
	parameter CP69=36'b100000000000100101000011100001100001;
	parameter CP70=36'b100000000000100101000011100001100001;
	parameter CP71=36'b100000000000110101000011100110000001;


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
	parameter flMUL_IND = 3'b001;	//Multiply Indirect
	parameter flDIV_DIR = 3'b010;	//Multiply Direct
	parameter flDIV_IND = 3'b011;	//Multiply Indirect
	parameter flMUL = 1'b0;			//MULDIV Multiply
	parameter flDIV = 1'b1;			//MULDIV Division
	parameter flLS0 = 3'b000;		//Left Shift 0
	parameter flLS1 = 3'b001;		//Left Shift 1
	parameter flRS0 = 3'b010;		//Right Shift 0
	parameter flRS1 = 3'b011;		//Right Shift 1

	initial begin
		rdy_recv <= 1'b1;
		rdy_out <= 1'b1;
		stg1_rdy <= 1'b0;
		stg1_state <= 1'b0;
		ch_miss_loop <= 5'b00000;
		ch_hit_loop <= 1'b0;
	end
	
	always @ (posedge clk) begin
		if(clr==1'b0) begin
			stage1 <= T55;
		end
		else begin
			case(stage1)
				T0: if(instr[7:3]==opSHFT) begin stage1 <= T54; end
					 else begin stage1 <= T1; end
				T1: case(instr[7:3])
						opSTOR: stage1 <= T65;
						opSTA: stage1 <= T65;
						opSTB: stage1 <= T65;
						opINPUT: stage1 <= T65;
						default: stage1 <= T68; 
					 endcase
				T2:if(ch_hit_loop==1'b1) begin
						if(cache_hit==1'b1) begin 	//Handle cache hit
							case(instr[7:3])
								opSTOR: stage1 <= T55;
								opSTA: stage1 <= T55;
								opSTB: stage1 <= T55;
								opINPUT: stage1 <= T55;
								default: stage1 <= T3; 
							endcase
							ch_hit_loop <= 1'b0;
							ch_miss_loop <= 5'b00000;
						end else	begin				//HANDLE MISS
							if(ch_miss_loop==5'b01011) begin
								case(instr[7:3])
									opSTOR: stage1 <= T55;
									opSTA: stage1 <= T55;
									opSTB: stage1 <= T55;
									opINPUT: stage1 <= T55;
									default: stage1 <= T3; 
								endcase 
								ch_miss_loop <= 5'b00000;
								ch_hit_loop <= 1'b0;
							end
							else begin
								ch_miss_loop <= (ch_miss_loop + 1);
								stage1 <= T2;
							end
						end
					end else begin
						ch_hit_loop <= (ch_hit_loop + 1);
						stage1 <= T2; 
					end	
				T3: case(instr[7:3])
							opADD: stage1 <= T10;
							opSUB: stage1 <= T12;
							opOR:	 stage1 <= T14;
							opAND: stage1 <= T16;
							opMULDIV: stage1 <= T54;
							opLOAD: stage1 <= T32;
							opLDA: stage1 <= T36;
							opLDB: stage1 <= T39;
							opOUTPUT: stage1 <= T48;
						endcase
				T4:  stage1 <= T5;
				T5: case(instr[7:3])
						opSTOR: stage1 <= T66;
						opSTA: stage1 <= T66;
						opSTB: stage1 <= T66;
						opINPUT: stage1 <= T66;
						default: stage1 <= T69; 
					 endcase
				T6: if(ch_hit_loop==1'b1) 
						begin
							if(cache_hit==1'b1) begin 	//Handle cache hit
								stage1 <= T7;
								ch_hit_loop <= 1'b0;
								ch_miss_loop <= 5'b00000;
							end
							else begin				//HANDLE MISS
								if(ch_miss_loop==5'b01011) begin
									ch_miss_loop <= 5'b00000;
									ch_hit_loop <= 1'b0;
									stage1 <= T7;
								end
								else begin
									ch_miss_loop <= (ch_miss_loop + 1);
									stage1 <= T6;
								end
							end
						end 
					else begin
						ch_hit_loop <= (ch_hit_loop + 1);
						stage1 <= T6; 
					end	
				T7:  stage1 <= T8;
				T8:  case(instr[7:3])
						opSTOR: stage1 <= T67;
						opSTA: stage1 <= T67;
						opSTB: stage1 <= T67;
						opINPUT: stage1 <= T67;
						default: stage1 <= T70; 
					 endcase 
				T9:  case(instr[7:3])
							opADD: stage1 <= T11;
							opSUB: stage1 <= T13;
							opOR:  stage1 <= T15;
							opAND: stage1 <= T17;
							opLOAD: stage1 <= T33;
							opLDA: stage1 <= T37;
							opLDB: stage1 <= T40;
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
										0: stage1 <= T61; //Even Parity
										1: stage1 <= T21; //Odd Parity
									 endcase
							flDIV: case(mdr_data[0])
										0: stage1 <= T63; //Even Parity
										1: stage1 <= T25; //Odd Parity
									 endcase
					  endcase
				T20: stage1 <= T55;
				T21: stage1 <= T62;
				T22: stage1 <= T23;
				T23: stage1 <= T55;
				T24: stage1 <= T55;
				T25: stage1 <= T64;  
				T26: stage1 <= T27;
				T27: stage1 <= T55;
				T28: stage1 <= T55;
				T29: stage1 <= T55;
				T30: stage1 <= T55;
				T31: stage1 <= T55;
				T32: stage1 <= T55;
				T33: stage1 <= T55;
				T34: stage1 <= T35;	
				T35: begin 
						if(instr[7:3]==opINPUT) begin	input_recv <= 1'b1; end
						stage1 <= T71;
					  end
				T36: stage1 <= T55;
				T37: stage1 <= T55;
				T38: stage1 <= T35;
				T39: stage1 <= T55;
				T40: stage1 <= T55;
				T41: stage1 <= T35;
				T42:  if(rdy_recv==1'b1) begin 
							stage1 <= T43; end
						else begin stage1 <= T42; end
				T43:  if(input_rdy==1'b1) begin
							case(instr[2:0])
								flDIR: stage1 <= T0;
								flIND: stage1 <= T4;
							endcase end
						else begin stage1 <= T43; end
				T44: stage1 <= T35;
				T45: if(input_recv == 1'b1) begin
							stage1 <= T55;
							input_recv <= 1'b0;
						end
					  else begin stage1 <= T44; end 
				T46: if(rdy_out==1'b1) begin stage1 <= T47; end
					  else begin stage1 <= T46; end
				T47: if(out_dev_rdy==1'b1) begin stage1 <= T4; end
					  else begin stage1 <= T47; end
				T48: stage1 <= T49;
				T49: if(out_recv==1'b1) begin stage1 <= T55; end
					  else begin stage1 <= T48; end
				T50: stage1 <= T55;
				T51: stage1 <= T52;
				T52: stage1 <= T55;
				T53: stage1 <= T55;
				T54: case(instr[7:3])
							opSHFT: case(instr[2:0])
										flLS0: stage1 <= T57;
										flLS1: stage1 <= T58;
										flRS0: stage1 <= T59;
										flRS1: stage1 <= T60;
									  endcase
							opMULDIV: stage1 <= T19;			
					  endcase
				T55: if(stg0_state==1'b1) begin
							 stage1 <= T56;
					  end
					  else stage1 <= T55;
				T56: if(stg0_state==1'b1) begin  	//Digest OPcode
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
								opLOAD: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
										  endcase
								opSTOR: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
										  endcase
								opLDA: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
										 endcase
								opSTA: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
										 endcase
								opLDB: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
												flIMM: stage1 <= T9;
										 endcase
								opSTB: case(instr[2:0])
												flDIR: stage1 <= T0;
												flIND: stage1 <= T4;
										 endcase
								opINPUT: stage1 <= T42;
								opOUTPUT: stage1 <= T46;
								opNOP: stage1 <= T50;
								default: stage1 <= T55;
							endcase
						end
						else begin stage1 <= T56; end //Bubble pipeline
				T57: stage1 <= T28;
				T58: stage1 <= T29;
				T59: stage1 <= T30;
				T60: stage1 <= T31;
				T61: stage1 <= T20;
				T62: stage1 <= T22;
				T63: stage1 <= T24;
				T64: stage1 <= T26;
				T65: case(instr[7:3])
						opSTOR: stage1 <= T34;
						opSTA: stage1 <= T38;
						opSTB: stage1 <= T41;
						opINPUT: stage1 <= T44;
						default: stage1 <= T2; 
					 endcase   
				T66: stage1 <= T6;
				T67: case(instr[7:3])
						opSTOR: stage1 <= T34;
						opSTA: stage1 <= T38;
						opSTB: stage1 <= T41;
						opINPUT: stage1 <= T44;
						default: stage1 <= T2; 
					  endcase 
				T68: stage1 <= T2;
				T69: stage1 <= T6;
				T70: stage1 <= T2;
				T71: if(ch_hit_loop==1'b1) begin
						if(cache_hit==1'b1) begin 	//Handle cache hit
							case(instr[7:3])
								opSTOR: stage1 <= T55;
								opSTA: stage1 <= T55;
								opSTB: stage1 <= T55;
								opINPUT: stage1 <= T55;
								default: stage1 <= T3; 
							endcase
							ch_hit_loop <= 1'b0;
							ch_miss_loop <= 5'b00000;
						end else	begin				//HANDLE MISS
							if(ch_miss_loop==5'b01011) begin
								case(instr[7:3])
									opSTOR: stage1 <= T55;
									opSTA: stage1 <= T55;
									opSTB: stage1 <= T55;
									opINPUT: stage1 <= T55;
									default: stage1 <= T3; 
								endcase 
								ch_miss_loop <= 5'b00000;
								ch_hit_loop <= 1'b0;
							end
							else begin
								ch_miss_loop <= (ch_miss_loop + 1);
								stage1 <= T71;
							end
						end
					end else begin
						ch_hit_loop <= (ch_hit_loop + 1);
						stage1 <= T71; 
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
					rdy_recv <= 1'b1;
					rdy_out <= 1'b1;
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
			T20: ctrl <= CP20;
			T21: ctrl <= CP21;
			T22: ctrl <= CP22;
			T23: ctrl <= CP23;
			T24: ctrl <= CP24;
			T25: ctrl <= CP25; 
			T26: ctrl <= CP26;
			T27: ctrl <= CP27;
			T28: ctrl <= CP28;
			T29: ctrl <= CP29;
			T30: ctrl <= CP30;
			T31: ctrl <= CP31;
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
			T42: begin
					ctrl <= CP42;
					stg1_state <= 1'b0;
				  end
			T43: ctrl <= CP43;
			T44: ctrl <= CP44;
			T45: ctrl <= CP45;
			T46: begin
					ctrl <= CP46;
					stg1_state <= 1'b0;
				  end
			T47: ctrl <= CP47;
			T48: ctrl <= CP48;
			T49: ctrl <= CP49;
			T50: begin
					ctrl <= CP50;
					stg1_state <= 1'b0;
				  end
			T51: begin
					ctrl <= CP51;
					stg1_state <= 1'b0;
				  end
			T52: ctrl <= CP52;
			T53: begin
					ctrl <= CP53;
					stg1_state <= 1'b0;
				 end
			T54: ctrl <= CP54;
			T55: ctrl <= CP55;
			T56: begin
					ctrl <= CP56;
					stg1_state <= 1'b1;
				  end
			T57: begin
					ctrl <= CP57;
					num_shift <= ir_data[2:0];
				  end
			T58: begin
					ctrl <= CP58;
					num_shift <= ir_data[2:0];
				  end
			T59: begin
					ctrl <= CP59;
					num_shift <= ir_data[2:0];
				  end
			T60: begin
					ctrl <= CP60;
					num_shift <= ir_data[2:0];
				  end 
			T61: begin
					ctrl <= CP61;
					num_shift <= (mdr_data[3:0] >> 1);
				  end
			T62: begin
					ctrl <= CP62;
					num_shift <= (mdr_data[3:0] >> 1);
				  end
			T63: begin
					ctrl <= CP63;
					num_shift <= ((mdr_data[3:0] >> 1)+1);
				  end
			T64: begin
					ctrl <= CP64;
					num_shift <= ((mdr_data[3:0] >> 1)+1);
				  end
			T65: ctrl <= CP65;
			T66: ctrl <= CP66;
			T67: ctrl <= CP67;
			T68: ctrl <= CP68;
			T69: ctrl <= CP69;
			T70: ctrl <= CP70;
			T71: ctrl <= CP71;
			default: ctrl <= CP0;
		endcase
	end
	
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
//  RAM : Random Access Memory module - Behavioral Style (Parameterized)
//				RAM unit has 8 bit wide data field and 256 addresses (2**8)
//
// Inputs: Addr, enab, clr, rw, data_in
//				Addr: Target memory address
//				data_in: input line for data, Write to target address
//				enab: Chip enable line
//				clr:	Active low synchronous clear
//				rw:	Read/Write control line
//
// Outputs: mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, data_out
//				mem0-7 are 8 outputs used for checking the current
//					contents of the RAM chip
//				data_out: Output data port, Read from target address
//
//   rw    enab   clr    function
//   x      x      0     Clear all RAM contents to zero *Top Priority
//   x 		0      1     RAM Chip not enabled - Do not read or write
//   0 		1      1     Read Target Address
//   1 		1      1		 Write 
//
//////////////////////////////////////////////////////////////////////////////////
module ram(clk, clr, enab, rw, Addr, data_in, mem0, mem1, mem2, mem3, mem4, mem5, 
				mem6, mem7, data_out);
	parameter d_width = 8;
	parameter a_width = 8;
	//Input Ports
	input clk, clr, enab, rw;
	input [a_width-1:0] Addr;
	input	[d_width-1:0] data_in;
	//Output Ports
	output [d_width-1:0] mem0;
	output [d_width-1:0] mem1;
	output [d_width-1:0] mem2;
	output [d_width-1:0] mem3;
	output [d_width-1:0] mem4;
	output [d_width-1:0] mem5;
	output [d_width-1:0] mem6;
	output [d_width-1:0] mem7;
	output reg [d_width-1:0] data_out;
	//Declare memory register
	reg [d_width-1:0] memory [2**a_width-1:0];
	//Define Loop Variable i
	integer i;
	
	//Assign mem0-7 to first 8 memory indices
	assign mem0 = memory[0];
	assign mem1 = memory[1];
	assign mem2 = memory[2];
	assign mem3 = memory[3];
	assign mem4 = memory[4];
	assign mem5 = memory[5];
	assign mem6 = memory[6];
	assign mem7 = memory[7];
	
	initial begin
		memory[0] = 8'b00000000;
		memory[1] = 8'b00000001;
		memory[2] = 8'b01111111;
		memory[3] = 8'b11101111;
		memory[4] = 8'b00011000;
		memory[5] = 8'b00011000;
		memory[6] = 8'b11011011;
		memory[7] = 8'b10011001;
		memory[8] = 8'b00000000;
		memory[9] = 8'b00000000;
		memory[10] = 8'b00000000;
		memory[11] = 8'b00000000;
		memory[12] = 8'b00000000;
		memory[13] = 8'b00000000;
		memory[14] = 8'b00000000;
		memory[15] = 8'b00000000;
		memory[16] = 8'b00000000;
		memory[17] = 8'b00000000;
		memory[18] = 8'b00000000;
		memory[19] = 8'b00000000;
		memory[20] = 8'b00000000;
		memory[21] = 8'b00000000;
		memory[22] = 8'b00000000;
		memory[23] = 8'b00000000;
		memory[24] = 8'b00000000;
		memory[25] = 8'b00000000;
		memory[26] = 8'b00000000;
		memory[27] = 8'b00000000;
		memory[28] = 8'b00000000;
		memory[29] = 8'b00000000;
		memory[30] = 8'b00000000;
		memory[31] = 8'b00000000;
		memory[32] = 8'b00000000;
		memory[33] = 8'b00000000;
		memory[34] = 8'b00000000;
		memory[35] = 8'b00000000;
		memory[36] = 8'b00000000;
		memory[37] = 8'b00000000;
		memory[38] = 8'b00000000;
		memory[39] = 8'b00000000;
		memory[40] = 8'b00000000;
		memory[41] = 8'b00000000;
		memory[42] = 8'b00000000;
		memory[43] = 8'b00000000;
		memory[44] = 8'b00000000;
		memory[45] = 8'b00000000;
		memory[46] = 8'b00000000;
		memory[47] = 8'b00000000;
		memory[48] = 8'b00000000;
		memory[49] = 8'b00000000;
		memory[50] = 8'b00000000;
		memory[51] = 8'b00000000;
		memory[52] = 8'b00000000;
		memory[53] = 8'b00000000;
		memory[54] = 8'b00000000;
		memory[55] = 8'b00000000;
		memory[56] = 8'b00000000;
		memory[57] = 8'b00000000;
		memory[58] = 8'b00000000;
		memory[59] = 8'b00000000;
		memory[60] = 8'b00000000;
		memory[61] = 8'b00000000;
		memory[62] = 8'b00000000;
		memory[63] = 8'b00000000;
		memory[64] = 8'b00000000;
		memory[65] = 8'b00000000;
		memory[66] = 8'b00000000;
		memory[67] = 8'b00000000;
		memory[68] = 8'b00000000;
		memory[69] = 8'b00000000;
		memory[70] = 8'b00000000;
		memory[71] = 8'b00000000;
		memory[72] = 8'b00000000;
		memory[73] = 8'b00000000;
		memory[74] = 8'b00000000;
		memory[75] = 8'b00000000;
		memory[76] = 8'b00000000;
		memory[77] = 8'b00000000;
		memory[78] = 8'b00000000;
		memory[79] = 8'b00000000;
		memory[80] = 8'b00000000;
		memory[81] = 8'b00000000;
		memory[82] = 8'b00000000;
		memory[83] = 8'b00000000;
		memory[84] = 8'b00000000;
		memory[85] = 8'b00000000;
		memory[86] = 8'b00000000;
		memory[87] = 8'b00000000;
		memory[88] = 8'b00000000;
		memory[89] = 8'b00000000;
		memory[90] = 8'b00000000;
		memory[91] = 8'b00000000;
		memory[92] = 8'b00000000;
		memory[93] = 8'b00000000;
		memory[94] = 8'b00000000;
		memory[95] = 8'b00000000;
		memory[96] = 8'b00000000;
		memory[97] = 8'b00000000;
		memory[98] = 8'b00000000;
		memory[99] = 8'b00000000;
		memory[100] = 8'b00000000;
		memory[101] = 8'b00000000;
		memory[102] = 8'b00000000;
		memory[103] = 8'b00000000;
		memory[104] = 8'b00000000;
		memory[105] = 8'b00000000;
		memory[106] = 8'b00000000;
		memory[107] = 8'b00000000;
		memory[108] = 8'b00000000;
		memory[109] = 8'b00000000;
		memory[110] = 8'b00000000;
		memory[111] = 8'b00000000;
		memory[112] = 8'b00000000;
		memory[113] = 8'b00000000;
		memory[114] = 8'b00000000;
		memory[115] = 8'b00000000;
		memory[116] = 8'b00000000;
		memory[117] = 8'b00000000;
		memory[118] = 8'b00000000;
		memory[119] = 8'b00000000;
		memory[120] = 8'b00000000;
		memory[121] = 8'b00000000;
		memory[122] = 8'b00000000;
		memory[123] = 8'b00000000;
		memory[124] = 8'b00000000;
		memory[125] = 8'b00000000;
		memory[126] = 8'b00000000;
		memory[127] = 8'b00000000;
		memory[128] = 8'b00000000;
		memory[129] = 8'b00000000;
		memory[130] = 8'b00000000;
		memory[131] = 8'b00000000;
		memory[132] = 8'b00000000;
		memory[133] = 8'b00000000;
		memory[134] = 8'b00000000;
		memory[135] = 8'b00000000;
		memory[136] = 8'b00000000;
		memory[137] = 8'b00000000;
		memory[138] = 8'b00000000;
		memory[139] = 8'b00000000;
		memory[140] = 8'b00000000;
		memory[141] = 8'b00000000;
		memory[142] = 8'b00000000;
		memory[143] = 8'b00000000;
		memory[144] = 8'b00000000;
		memory[145] = 8'b00000000;
		memory[146] = 8'b00000000;
		memory[147] = 8'b00000000;
		memory[148] = 8'b00000000;
		memory[149] = 8'b00000000;
		memory[150] = 8'b00000000;
		memory[151] = 8'b00000000;
		memory[152] = 8'b00000000;
		memory[153] = 8'b00000000;
		memory[154] = 8'b00000000;
		memory[155] = 8'b00000000;
		memory[156] = 8'b00000000;
		memory[157] = 8'b00000000;
		memory[158] = 8'b00000000;
		memory[159] = 8'b00000000;
		memory[160] = 8'b00000000;
		memory[161] = 8'b00000000;
		memory[162] = 8'b00000000;
		memory[163] = 8'b00000000;
		memory[164] = 8'b00000000;
		memory[165] = 8'b00000000;
		memory[166] = 8'b00000000;
		memory[167] = 8'b00000000;
		memory[168] = 8'b00000000;
		memory[169] = 8'b00000000;
		memory[170] = 8'b00000000;
		memory[171] = 8'b00000000;
		memory[172] = 8'b00000000;
		memory[173] = 8'b00000000;
		memory[174] = 8'b00000000;
		memory[175] = 8'b00000000;
		memory[176] = 8'b00000000;
		memory[177] = 8'b00000000;
		memory[178] = 8'b00000000;
		memory[179] = 8'b00000000;
		memory[180] = 8'b00000000;
		memory[181] = 8'b00000000;
		memory[182] = 8'b00000000;
		memory[183] = 8'b00000000;
		memory[184] = 8'b00000000;
		memory[185] = 8'b00000000;
		memory[186] = 8'b00000000;
		memory[187] = 8'b00000000;
		memory[188] = 8'b00000000;
		memory[189] = 8'b00000000;
		memory[190] = 8'b00000000;
		memory[191] = 8'b00000000;
		memory[192] = 8'b00000000;
		memory[193] = 8'b00000000;
		memory[194] = 8'b00000000;
		memory[195] = 8'b00000000;
		memory[196] = 8'b00000000;
		memory[197] = 8'b00000000;
		memory[198] = 8'b00000000;
		memory[199] = 8'b00000000;
		memory[200] = 8'b00000000;
		memory[201] = 8'b00000000;
		memory[202] = 8'b00000000;
		memory[203] = 8'b00000000;
		memory[204] = 8'b00000000;
		memory[205] = 8'b00000000;
		memory[206] = 8'b00000000;
		memory[207] = 8'b00000000;
		memory[208] = 8'b00000000;
		memory[209] = 8'b00000000;
		memory[210] = 8'b00000000;
		memory[211] = 8'b00000000;
		memory[212] = 8'b00000000;
		memory[213] = 8'b00000000;
		memory[214] = 8'b00000000;
		memory[215] = 8'b00000000;
		memory[216] = 8'b00000000;
		memory[217] = 8'b00000000;
		memory[218] = 8'b00000000;
		memory[219] = 8'b00000000;
		memory[220] = 8'b00000000;
		memory[221] = 8'b00000000;
		memory[222] = 8'b00000000;
		memory[223] = 8'b00000000;
		memory[224] = 8'b00000000;
		memory[225] = 8'b00000000;
		memory[226] = 8'b00000000;
		memory[227] = 8'b00000000;
		memory[228] = 8'b00000000;
		memory[229] = 8'b00000000;
		memory[230] = 8'b00000000;
		memory[231] = 8'b00000000;
		memory[232] = 8'b00000000;
		memory[233] = 8'b00000000;
		memory[234] = 8'b00000000;
		memory[235] = 8'b00000000;
		memory[236] = 8'b00000000;
		memory[237] = 8'b00000000;
		memory[238] = 8'b00000000;
		memory[239] = 8'b00000000;
		memory[240] = 8'b00000000;
		memory[241] = 8'b00000000;
		memory[242] = 8'b00000000;
		memory[243] = 8'b00000000;
		memory[244] = 8'b00000000;
		memory[245] = 8'b00000000;
		memory[246] = 8'b00000000;
		memory[247] = 8'b00000000;
		memory[248] = 8'b00000000;
		memory[249] = 8'b00000000;
		memory[250] = 8'b00000000;
		memory[251] = 8'b00000000;
		memory[252] = 8'b00000000;
		memory[253] = 8'b00000000;
		memory[254] = 8'b00000000;
		memory[255] = 8'b00000000;
	end
	
	//Handle CLR/READ/WRITE at positive edge of clk
	always @(posedge clk) begin
		if(clr==1'b0) begin:clrBlock //Clear memory contents
			for(i=0; i<(2**a_width); i=i+1) begin:Clr_Loop
				memory[i] <= 0;
				data_out <= 8'b00000000;
			end	
		end
		else if(enab==1'b1) begin //Only Read/Write if RAM Chip enabled
			if(rw==1'b0) begin //Read 
				data_out <= memory[Addr];
			end
			else if(rw==1'b1) begin //Write
				memory[Addr] <= data_in;
			end
		end
		else if(enab==1'b0) begin //High Z state for output if chip not enabled
			data_out <= 8'b01010101;
		end
	end
	
endmodule

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
//   1 		1      1     Write 
//
//////////////////////////////////////////////////////////////////////////////////
//module ram(clk, clr, enab, rw, Addr, data_in, mem0, mem1, mem2, mem3, mem4, mem5, 
//				mem6, mem7, data_out);
module iram(clk, clr, enab, rw, Addr, data_out);
	parameter d_width = 16;
	parameter a_width = 8;
	//Input Ports
	input clk, clr, enab, rw;
	input [a_width-1:0] Addr;
	//input	[d_width-1:0] data_in;
	//Output Ports
	/*output [d_width-1:0] mem0;
	output [d_width-1:0] mem1;
	output [d_width-1:0] mem2;
	output [d_width-1:0] mem3;
	output [d_width-1:0] mem4;
	output [d_width-1:0] mem5;
	output [d_width-1:0] mem6;
	output [d_width-1:0] mem7;*/
	output reg [d_width-1:0] data_out;
	//Declare memory register
	reg [d_width-1:0] memory [2**a_width-1:0];
	//Define Loop Variable i
	integer i;
	
	//Assign mem0-7 to first 8 memory indices
	/*assign mem0 = memory[0];
	assign mem1 = memory[1];
	assign mem2 = memory[2];
	assign mem3 = memory[3];
	assign mem4 = memory[4];
	assign mem5 = memory[5];
	assign mem6 = memory[6];
	assign mem7 = memory[7];*/
	
	initial begin
		memory[0] = 16'b0101001000000001;
		memory[1] = 16'b0000001000000010;
		memory[2] = 16'b0101100000000000;
		memory[3] = 16'b1000100000000000;
		memory[4] = 16'b0001000000000000;
		memory[5] = 16'b0010100000000010;
		memory[6] = 16'b0001000000000000;
		memory[7] = 16'b0000101000000011;
		memory[8] = 16'b0101100000000001;
		memory[9] = 16'b0101000000000000;
		memory[10] = 16'b0001000000000001;
		memory[11] = 16'b0101100000000010;
		memory[12] = 16'b0000101000000111;
		memory[13] = 16'b0010100000000010;
		memory[14] = 16'b0101100100000000;
		memory[15] = 16'b0010101100000001;
		memory[16] = 16'b0010001000011111;
		memory[17] = 16'b0000001000000111;
		memory[18] = 16'b0001000000000000;
		memory[19] = 16'b0101100000000100;
		memory[20] = 16'b0111100000000000;
		memory[21] = 16'b0111100000000000;
		memory[22] = 16'b0111100000000000;
		memory[23] = 16'b0111100000000000;
		memory[24] = 16'b0001101000000100;
		memory[25] = 16'b0101100100000010;
		memory[26] = 16'b1001100100000010;
		memory[27] = 16'b0000000000000000;
		memory[28] = 16'b0000000000000000;
		memory[29] = 16'b0000000000000000;
		memory[30] = 16'b0000000000000000;
		memory[31] = 16'b0000000000000000;
		memory[32] = 16'b0000000000000000;
		memory[33] = 16'b0000000000000000;
		memory[34] = 16'b0000000000000000;
		memory[35] = 16'b0000000000000000;
		memory[36] = 16'b0000000000000000;
		memory[37] = 16'b0000000000000000;
		memory[38] = 16'b0000000000000000;
		memory[39] = 16'b0000000000000000;
		memory[40] = 16'b0000000000000000;
		memory[41] = 16'b0000000000000000;
		memory[42] = 16'b0000000000000000;
		memory[43] = 16'b0000000000000000;
		memory[44] = 16'b0000000000000000;
		memory[45] = 16'b0000000000000000;
		memory[46] = 16'b0000000000000000;
		memory[47] = 16'b0000000000000000;
		memory[48] = 16'b0000000000000000;
		memory[49] = 16'b0000000000000000;
		memory[50] = 16'b0000000000000000;
		memory[51] = 16'b0000000000000000;
		memory[52] = 16'b0000000000000000;
		memory[53] = 16'b0000000000000000;
		memory[54] = 16'b0000000000000000;
		memory[55] = 16'b0000000000000000;
		memory[56] = 16'b0000000000000000;
		memory[57] = 16'b0000000000000000;
		memory[58] = 16'b0000000000000000;
		memory[59] = 16'b0000000000000000;
		memory[60] = 16'b0000000000000000;
		memory[61] = 16'b0000000000000000;
		memory[62] = 16'b0000000000000000;
		memory[63] = 16'b0000000000000000;
		memory[64] = 16'b0000000000000000;
		memory[65] = 16'b0000000000000000;
		memory[66] = 16'b0000000000000000;
		memory[67] = 16'b0000000000000000;
		memory[68] = 16'b0000000000000000;
		memory[69] = 16'b0000000000000000;
		memory[70] = 16'b0000000000000000;
		memory[71] = 16'b0000000000000000;
		memory[72] = 16'b0000000000000000;
		memory[73] = 16'b0000000000000000;
		memory[74] = 16'b0000000000000000;
		memory[75] = 16'b0000000000000000;
		memory[76] = 16'b0000000000000000;
		memory[77] = 16'b0000000000000000;
		memory[78] = 16'b0000000000000000;
		memory[79] = 16'b0000000000000000;
		memory[80] = 16'b0000000000000000;
		memory[81] = 16'b0000000000000000;
		memory[82] = 16'b0000000000000000;
		memory[83] = 16'b0000000000000000;
		memory[84] = 16'b0000000000000000;
		memory[85] = 16'b0000000000000000;
		memory[86] = 16'b0000000000000000;
		memory[87] = 16'b0000000000000000;
		memory[88] = 16'b0000000000000000;
		memory[89] = 16'b0000000000000000;
		memory[90] = 16'b0000000000000000;
		memory[91] = 16'b0000000000000000;
		memory[92] = 16'b0000000000000000;
		memory[93] = 16'b0000000000000000;
		memory[94] = 16'b0000000000000000;
		memory[95] = 16'b0000000000000000;
		memory[96] = 16'b0000000000000000;
		memory[97] = 16'b0000000000000000;
		memory[98] = 16'b0000000000000000;
		memory[99] = 16'b0000000000000000;
		memory[100] = 16'b0000000000000000;
		memory[101] = 16'b0000000000000000;
		memory[102] = 16'b0000000000000000;
		memory[103] = 16'b0000000000000000;
		memory[104] = 16'b0000000000000000;
		memory[105] = 16'b0000000000000000;
		memory[106] = 16'b0000000000000000;
		memory[107] = 16'b0000000000000000;
		memory[108] = 16'b0000000000000000;
		memory[109] = 16'b0000000000000000;
		memory[110] = 16'b0000000000000000;
		memory[111] = 16'b0000000000000000;
		memory[112] = 16'b0000000000000000;
		memory[113] = 16'b0000000000000000;
		memory[114] = 16'b0000000000000000;
		memory[115] = 16'b0000000000000000;
		memory[116] = 16'b0000000000000000;
		memory[117] = 16'b0000000000000000;
		memory[118] = 16'b0000000000000000;
		memory[119] = 16'b0000000000000000;
		memory[120] = 16'b0000000000000000;
		memory[121] = 16'b0000000000000000;
		memory[122] = 16'b0000000000000000;
		memory[123] = 16'b0000000000000000;
		memory[124] = 16'b0000000000000000;
		memory[125] = 16'b0000000000000000;
		memory[126] = 16'b0000000000000000;
		memory[127] = 16'b0000000000000000;
		memory[128] = 16'b0000000000000000;
		memory[129] = 16'b0000000000000000;
		memory[130] = 16'b0000000000000000;
		memory[131] = 16'b0000000000000000;
		memory[132] = 16'b0000000000000000;
		memory[133] = 16'b0000000000000000;
		memory[134] = 16'b0000000000000000;
		memory[135] = 16'b0000000000000000;
		memory[136] = 16'b0000000000000000;
		memory[137] = 16'b0000000000000000;
		memory[138] = 16'b0000000000000000;
		memory[139] = 16'b0000000000000000;
		memory[140] = 16'b0000000000000000;
		memory[141] = 16'b0000000000000000;
		memory[142] = 16'b0000000000000000;
		memory[143] = 16'b0000000000000000;
		memory[144] = 16'b0000000000000000;
		memory[145] = 16'b0000000000000000;
		memory[146] = 16'b0000000000000000;
		memory[147] = 16'b0000000000000000;
		memory[148] = 16'b0000000000000000;
		memory[149] = 16'b0000000000000000;
		memory[150] = 16'b0000000000000000;
		memory[151] = 16'b0000000000000000;
		memory[152] = 16'b0000000000000000;
		memory[153] = 16'b0000000000000000;
		memory[154] = 16'b0000000000000000;
		memory[155] = 16'b0000000000000000;
		memory[156] = 16'b0000000000000000;
		memory[157] = 16'b0000000000000000;
		memory[158] = 16'b0000000000000000;
		memory[159] = 16'b0000000000000000;
		memory[160] = 16'b0000000000000000;
		memory[161] = 16'b0000000000000000;
		memory[162] = 16'b0000000000000000;
		memory[163] = 16'b0000000000000000;
		memory[164] = 16'b0000000000000000;
		memory[165] = 16'b0000000000000000;
		memory[166] = 16'b0000000000000000;
		memory[167] = 16'b0000000000000000;
		memory[168] = 16'b0000000000000000;
		memory[169] = 16'b0000000000000000;
		memory[170] = 16'b0000000000000000;
		memory[171] = 16'b0000000000000000;
		memory[172] = 16'b0000000000000000;
		memory[173] = 16'b0000000000000000;
		memory[174] = 16'b0000000000000000;
		memory[175] = 16'b0000000000000000;
		memory[176] = 16'b0000000000000000;
		memory[177] = 16'b0000000000000000;
		memory[178] = 16'b0000000000000000;
		memory[179] = 16'b0000000000000000;
		memory[180] = 16'b0000000000000000;
		memory[181] = 16'b0000000000000000;
		memory[182] = 16'b0000000000000000;
		memory[183] = 16'b0000000000000000;
		memory[184] = 16'b0000000000000000;
		memory[185] = 16'b0000000000000000;
		memory[186] = 16'b0000000000000000;
		memory[187] = 16'b0000000000000000;
		memory[188] = 16'b0000000000000000;
		memory[189] = 16'b0000000000000000;
		memory[190] = 16'b0000000000000000;
		memory[191] = 16'b0000000000000000;
		memory[192] = 16'b0000000000000000;
		memory[193] = 16'b0000000000000000;
		memory[194] = 16'b0000000000000000;
		memory[195] = 16'b0000000000000000;
		memory[196] = 16'b0000000000000000;
		memory[197] = 16'b0000000000000000;
		memory[198] = 16'b0000000000000000;
		memory[199] = 16'b0000000000000000;
		memory[200] = 16'b0000000000000000;
		memory[201] = 16'b0000000000000000;
		memory[202] = 16'b0000000000000000;
		memory[203] = 16'b0000000000000000;
		memory[204] = 16'b0000000000000000;
		memory[205] = 16'b0000000000000000;
		memory[206] = 16'b0000000000000000;
		memory[207] = 16'b0000000000000000;
		memory[208] = 16'b0000000000000000;
		memory[209] = 16'b0000000000000000;
		memory[210] = 16'b0000000000000000;
		memory[211] = 16'b0000000000000000;
		memory[212] = 16'b0000000000000000;
		memory[213] = 16'b0000000000000000;
		memory[214] = 16'b0000000000000000;
		memory[215] = 16'b0000000000000000;
		memory[216] = 16'b0000000000000000;
		memory[217] = 16'b0000000000000000;
		memory[218] = 16'b0000000000000000;
		memory[219] = 16'b0000000000000000;
		memory[220] = 16'b0000000000000000;
		memory[221] = 16'b0000000000000000;
		memory[222] = 16'b0000000000000000;
		memory[223] = 16'b0000000000000000;
		memory[224] = 16'b0000000000000000;
		memory[225] = 16'b0000000000000000;
		memory[226] = 16'b0000000000000000;
		memory[227] = 16'b0000000000000000;
		memory[228] = 16'b0000000000000000;
		memory[229] = 16'b0000000000000000;
		memory[230] = 16'b0000000000000000;
		memory[231] = 16'b0000000000000000;
		memory[232] = 16'b0000000000000000;
		memory[233] = 16'b0000000000000000;
		memory[234] = 16'b0000000000000000;
		memory[235] = 16'b0000000000000000;
		memory[236] = 16'b0000000000000000;
		memory[237] = 16'b0000000000000000;
		memory[238] = 16'b0000000000000000;
		memory[239] = 16'b0000000000000000;
		memory[240] = 16'b0000000000000000;
		memory[241] = 16'b0000000000000000;
		memory[242] = 16'b0000000000000000;
		memory[243] = 16'b0000000000000000;
		memory[244] = 16'b0000000000000000;
		memory[245] = 16'b0000000000000000;
		memory[246] = 16'b0000000000000000;
		memory[247] = 16'b0000000000000000;
		memory[248] = 16'b0000000000000000;
		memory[249] = 16'b0000000000000000;
		memory[250] = 16'b0000000000000000;
		memory[251] = 16'b0000000000000000;
		memory[252] = 16'b0000000000000000;
		memory[253] = 16'b0000000000000000;
		memory[254] = 16'b0000000000000000;
		memory[255] = 16'b0000000000000000;
	end
	
	//Handle CLR/READ/WRITE at positive edge of clk
	always @(posedge clk) begin
		if(clr==1'b0) begin:clrBlock //Clear memory contents
			memory[0] = 16'b0101001000000001;
			memory[1] = 16'b0000001000000010;
			memory[2] = 16'b0101100000000000;
			memory[3] = 16'b1000100000000000;
			memory[4] = 16'b0001000000000000;
			memory[5] = 16'b0010100000000010;
			memory[6] = 16'b0001000000000000;
			memory[7] = 16'b0000101000000011;
			memory[8] = 16'b0101100000000001;
			memory[9] = 16'b0101000000000000;
			memory[10] = 16'b0001000000000001;
			memory[11] = 16'b0101100000000010;
			memory[12] = 16'b0000101000000111;
			memory[13] = 16'b0010100000000010;
			memory[14] = 16'b0101100100000000;
			memory[15] = 16'b0010101100000001;
			memory[16] = 16'b0010001000011111;
			memory[17] = 16'b0000001000000111;
			memory[18] = 16'b0001000000000000;
			memory[19] = 16'b0101100000000100;
			memory[20] = 16'b0111100000000000;
			memory[21] = 16'b0111100000000000;
			memory[22] = 16'b0111100000000000;
			memory[23] = 16'b0111100000000000;
			memory[24] = 16'b0001101000000100;
			memory[25] = 16'b0101100100000010;
			memory[26] = 16'b1001100100000010;
			memory[27] = 16'b0000000000000000;
			memory[28] = 16'b0000000000000000;
			memory[29] = 16'b0000000000000000;
			memory[30] = 16'b0000000000000000;
			memory[31] = 16'b0000000000000000;
			memory[32] = 16'b0000000000000000;
			memory[33] = 16'b0000000000000000;
			memory[34] = 16'b0000000000000000;
			memory[35] = 16'b0000000000000000;
			memory[36] = 16'b0000000000000000;
			memory[37] = 16'b0000000000000000;
			memory[38] = 16'b0000000000000000;
			memory[39] = 16'b0000000000000000;
			memory[40] = 16'b0000000000000000;
			memory[41] = 16'b0000000000000000;
			memory[42] = 16'b0000000000000000;
			memory[43] = 16'b0000000000000000;
			memory[44] = 16'b0000000000000000;
			memory[45] = 16'b0000000000000000;
			memory[46] = 16'b0000000000000000;
			memory[47] = 16'b0000000000000000;
			memory[48] = 16'b0000000000000000;
			memory[49] = 16'b0000000000000000;
			memory[50] = 16'b0000000000000000;
			memory[51] = 16'b0000000000000000;
			memory[52] = 16'b0000000000000000;
			memory[53] = 16'b0000000000000000;
			memory[54] = 16'b0000000000000000;
			memory[55] = 16'b0000000000000000;
			memory[56] = 16'b0000000000000000;
			memory[57] = 16'b0000000000000000;
			memory[58] = 16'b0000000000000000;
			memory[59] = 16'b0000000000000000;
			memory[60] = 16'b0000000000000000;
			memory[61] = 16'b0000000000000000;
			memory[62] = 16'b0000000000000000;
			memory[63] = 16'b0000000000000000;
			memory[64] = 16'b0000000000000000;
			memory[65] = 16'b0000000000000000;
			memory[66] = 16'b0000000000000000;
			memory[67] = 16'b0000000000000000;
			memory[68] = 16'b0000000000000000;
			memory[69] = 16'b0000000000000000;
			memory[70] = 16'b0000000000000000;
			memory[71] = 16'b0000000000000000;
			memory[72] = 16'b0000000000000000;
			memory[73] = 16'b0000000000000000;
			memory[74] = 16'b0000000000000000;
			memory[75] = 16'b0000000000000000;
			memory[76] = 16'b0000000000000000;
			memory[77] = 16'b0000000000000000;
			memory[78] = 16'b0000000000000000;
			memory[79] = 16'b0000000000000000;
			memory[80] = 16'b0000000000000000;
			memory[81] = 16'b0000000000000000;
			memory[82] = 16'b0000000000000000;
			memory[83] = 16'b0000000000000000;
			memory[84] = 16'b0000000000000000;
			memory[85] = 16'b0000000000000000;
			memory[86] = 16'b0000000000000000;
			memory[87] = 16'b0000000000000000;
			memory[88] = 16'b0000000000000000;
			memory[89] = 16'b0000000000000000;
			memory[90] = 16'b0000000000000000;
			memory[91] = 16'b0000000000000000;
			memory[92] = 16'b0000000000000000;
			memory[93] = 16'b0000000000000000;
			memory[94] = 16'b0000000000000000;
			memory[95] = 16'b0000000000000000;
			memory[96] = 16'b0000000000000000;
			memory[97] = 16'b0000000000000000;
			memory[98] = 16'b0000000000000000;
			memory[99] = 16'b0000000000000000;
			memory[100] = 16'b0000000000000000;
			memory[101] = 16'b0000000000000000;
			memory[102] = 16'b0000000000000000;
			memory[103] = 16'b0000000000000000;
			memory[104] = 16'b0000000000000000;
			memory[105] = 16'b0000000000000000;
			memory[106] = 16'b0000000000000000;
			memory[107] = 16'b0000000000000000;
			memory[108] = 16'b0000000000000000;
			memory[109] = 16'b0000000000000000;
			memory[110] = 16'b0000000000000000;
			memory[111] = 16'b0000000000000000;
			memory[112] = 16'b0000000000000000;
			memory[113] = 16'b0000000000000000;
			memory[114] = 16'b0000000000000000;
			memory[115] = 16'b0000000000000000;
			memory[116] = 16'b0000000000000000;
			memory[117] = 16'b0000000000000000;
			memory[118] = 16'b0000000000000000;
			memory[119] = 16'b0000000000000000;
			memory[120] = 16'b0000000000000000;
			memory[121] = 16'b0000000000000000;
			memory[122] = 16'b0000000000000000;
			memory[123] = 16'b0000000000000000;
			memory[124] = 16'b0000000000000000;
			memory[125] = 16'b0000000000000000;
			memory[126] = 16'b0000000000000000;
			memory[127] = 16'b0000000000000000;
			memory[128] = 16'b0000000000000000;
			memory[129] = 16'b0000000000000000;
			memory[130] = 16'b0000000000000000;
			memory[131] = 16'b0000000000000000;
			memory[132] = 16'b0000000000000000;
			memory[133] = 16'b0000000000000000;
			memory[134] = 16'b0000000000000000;
			memory[135] = 16'b0000000000000000;
			memory[136] = 16'b0000000000000000;
			memory[137] = 16'b0000000000000000;
			memory[138] = 16'b0000000000000000;
			memory[139] = 16'b0000000000000000;
			memory[140] = 16'b0000000000000000;
			memory[141] = 16'b0000000000000000;
			memory[142] = 16'b0000000000000000;
			memory[143] = 16'b0000000000000000;
			memory[144] = 16'b0000000000000000;
			memory[145] = 16'b0000000000000000;
			memory[146] = 16'b0000000000000000;
			memory[147] = 16'b0000000000000000;
			memory[148] = 16'b0000000000000000;
			memory[149] = 16'b0000000000000000;
			memory[150] = 16'b0000000000000000;
			memory[151] = 16'b0000000000000000;
			memory[152] = 16'b0000000000000000;
			memory[153] = 16'b0000000000000000;
			memory[154] = 16'b0000000000000000;
			memory[155] = 16'b0000000000000000;
			memory[156] = 16'b0000000000000000;
			memory[157] = 16'b0000000000000000;
			memory[158] = 16'b0000000000000000;
			memory[159] = 16'b0000000000000000;
			memory[160] = 16'b0000000000000000;
			memory[161] = 16'b0000000000000000;
			memory[162] = 16'b0000000000000000;
			memory[163] = 16'b0000000000000000;
			memory[164] = 16'b0000000000000000;
			memory[165] = 16'b0000000000000000;
			memory[166] = 16'b0000000000000000;
			memory[167] = 16'b0000000000000000;
			memory[168] = 16'b0000000000000000;
			memory[169] = 16'b0000000000000000;
			memory[170] = 16'b0000000000000000;
			memory[171] = 16'b0000000000000000;
			memory[172] = 16'b0000000000000000;
			memory[173] = 16'b0000000000000000;
			memory[174] = 16'b0000000000000000;
			memory[175] = 16'b0000000000000000;
			memory[176] = 16'b0000000000000000;
			memory[177] = 16'b0000000000000000;
			memory[178] = 16'b0000000000000000;
			memory[179] = 16'b0000000000000000;
			memory[180] = 16'b0000000000000000;
			memory[181] = 16'b0000000000000000;
			memory[182] = 16'b0000000000000000;
			memory[183] = 16'b0000000000000000;
			memory[184] = 16'b0000000000000000;
			memory[185] = 16'b0000000000000000;
			memory[186] = 16'b0000000000000000;
			memory[187] = 16'b0000000000000000;
			memory[188] = 16'b0000000000000000;
			memory[189] = 16'b0000000000000000;
			memory[190] = 16'b0000000000000000;
			memory[191] = 16'b0000000000000000;
			memory[192] = 16'b0000000000000000;
			memory[193] = 16'b0000000000000000;
			memory[194] = 16'b0000000000000000;
			memory[195] = 16'b0000000000000000;
			memory[196] = 16'b0000000000000000;
			memory[197] = 16'b0000000000000000;
			memory[198] = 16'b0000000000000000;
			memory[199] = 16'b0000000000000000;
			memory[200] = 16'b0000000000000000;
			memory[201] = 16'b0000000000000000;
			memory[202] = 16'b0000000000000000;
			memory[203] = 16'b0000000000000000;
			memory[204] = 16'b0000000000000000;
			memory[205] = 16'b0000000000000000;
			memory[206] = 16'b0000000000000000;
			memory[207] = 16'b0000000000000000;
			memory[208] = 16'b0000000000000000;
			memory[209] = 16'b0000000000000000;
			memory[210] = 16'b0000000000000000;
			memory[211] = 16'b0000000000000000;
			memory[212] = 16'b0000000000000000;
			memory[213] = 16'b0000000000000000;
			memory[214] = 16'b0000000000000000;
			memory[215] = 16'b0000000000000000;
			memory[216] = 16'b0000000000000000;
			memory[217] = 16'b0000000000000000;
			memory[218] = 16'b0000000000000000;
			memory[219] = 16'b0000000000000000;
			memory[220] = 16'b0000000000000000;
			memory[221] = 16'b0000000000000000;
			memory[222] = 16'b0000000000000000;
			memory[223] = 16'b0000000000000000;
			memory[224] = 16'b0000000000000000;
			memory[225] = 16'b0000000000000000;
			memory[226] = 16'b0000000000000000;
			memory[227] = 16'b0000000000000000;
			memory[228] = 16'b0000000000000000;
			memory[229] = 16'b0000000000000000;
			memory[230] = 16'b0000000000000000;
			memory[231] = 16'b0000000000000000;
			memory[232] = 16'b0000000000000000;
			memory[233] = 16'b0000000000000000;
			memory[234] = 16'b0000000000000000;
			memory[235] = 16'b0000000000000000;
			memory[236] = 16'b0000000000000000;
			memory[237] = 16'b0000000000000000;
			memory[238] = 16'b0000000000000000;
			memory[239] = 16'b0000000000000000;
			memory[240] = 16'b0000000000000000;
			memory[241] = 16'b0000000000000000;
			memory[242] = 16'b0000000000000000;
			memory[243] = 16'b0000000000000000;
			memory[244] = 16'b0000000000000000;
			memory[245] = 16'b0000000000000000;
			memory[246] = 16'b0000000000000000;
			memory[247] = 16'b0000000000000000;
			memory[248] = 16'b0000000000000000;
			memory[249] = 16'b0000000000000000;
			memory[250] = 16'b0000000000000000;
			memory[251] = 16'b0000000000000000;
			memory[252] = 16'b0000000000000000;
			memory[253] = 16'b0000000000000000;
			memory[254] = 16'b0000000000000000;
			memory[255] = 16'b0000000000000000;
		end
		else if(enab==1'b1) begin //Only Read/Write if RAM Chip enabled
			if(rw==1'b0) begin //Read 
				data_out <= memory[Addr];
			end
			else if(rw==1'b1) begin //Write
				//memory[Addr] <= data_in;
			end
		end
		else if(enab==1'b0) begin //High Z state for output if chip not enabled
			data_out <= 16'b1000000010000000;
		end
	end
	
endmodule

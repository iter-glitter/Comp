`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer: Alex Hendren
// 
// Create Date:    22:55:10 01/24/2013 
// Design Name: 	 DVHW1
// Module Name:    bfa_gate 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Binary full adder with gate description
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// 
//
//////////////////////////////////////////////////////////////////////////////////
module bfa_gate(i0, i1, ci, sout, cout);

	input i0, i1, ci;
	output sout, cout;
	wire wxor, wand0, wand1;
	
	// Output, input, input
	xor Xor0(wxor, i0, i1);
	xor Xor1(sout, wxor, ci);
	and And0(wand0, wxor, ci);
	and And1(wand1, i0, i1);
	or  Or0(cout, wand0, wand1);
	
	
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE480
// Engineer:  Alex Hendren
// 
// Create Date:    15:58:03 02/01/2013 
// Design Name: 
// Module Name:    dec_param_enab 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dec_param_enab(inp, enab, d);
	parameter n=3;
	input [(n-1):0]inp;
	input enab;
	output [((2**n)-1):0]d;
	reg [((2**n)-1):0]d;
	integer i;

	
	always @(inp or enab)
	begin
		if (enab == 1'b0)
		
			for(i=0;i<(2**n);i=i+1) 
			begin
			d[i]=1'b0; //Set zero not high impedance
			end
		
		else
		
		for (i=0;i<(2**n);i=i+1) 
		begin
			if(inp==i)
				d[i]=1;
			else
				d[i]=0;
		
		end
	end

endmodule

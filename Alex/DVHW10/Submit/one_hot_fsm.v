`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:00 03/19/2013 
// Design Name: 
// Module Name:    one_hot_fsm 
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
module one_hot_fsm(clk, clr, x, start, yp, cp);
	input clk, start, clr; 
	input [1:0] x;
	output reg [4:0] cp; //Control Points
	output reg [6:0] yp; //One-Hot Encoded "Present State"
	reg	[6:0] Y;	// Y - Next State
	
	parameter a=7'b1000000;
	parameter b=7'b0100000;
	parameter c=7'b0010000;
	parameter d=7'b0001000;
	parameter e=7'b0000100;
	parameter f=7'b0000010;
	parameter g=7'b0000001;
	
	always @ (x or yp) begin //Determine next state Y process
		case(yp)
		a: 	  if(x==2'b00) begin Y=a; end
			else if(x==2'b01) begin Y=c; end
			else if(x==2'b11) begin Y=d; end
			else if(x==2'b10) begin Y=g; end
		b: 	  if(x==2'b00) begin Y=d; end
			else if(x==2'b01) begin Y=a; end
			else if(x==2'b11) begin Y=a; end
			else if(x==2'b10) begin Y=f; end
		c: 	  if(x==2'b00) begin Y=b; end
			else if(x==2'b01) begin Y=c; end
			else if(x==2'b11) begin Y=d; end
			else if(x==2'b10) begin Y=e; end
		d: 	  if(x==2'b00) begin Y=f; end
			else if(x==2'b01) begin Y=g; end
			else if(x==2'b11) begin Y=a; end
			else if(x==2'b10) begin Y=f; end
		e: 	  if(x==2'b00) begin Y=b; end
			else if(x==2'b01) begin Y=e; end
			else if(x==2'b11) begin Y=b; end
			else if(x==2'b10) begin Y=g; end
		f: 	  if(x==2'b00) begin Y=a; end
			else if(x==2'b01) begin Y=b; end
			else if(x==2'b11) begin Y=e; end
			else if(x==2'b10) begin Y=d; end
		g: 	  if(x==2'b00) begin Y=g; end
			else if(x==2'b01) begin Y=f; end
			else if(x==2'b11) begin Y=e; end
			else if(x==2'b10) begin Y=c; end
		default:	Y=a;
		endcase
	end
	
	//Clear, Reset and State Transition Process
	
	always @(posedge clk) begin
		if(clr==1'b0) begin yp=7'b0000000; end
		else if (start==1'b1) begin yp=a; end
		else	begin yp = Y; end
	end
	
	//Output Control Points
	
	always @ (yp) begin
		case (yp)
			a: cp=5'b00110;
			b: cp=5'b10101;
			c: cp=5'b01110;
			d: cp=5'b11001;
			e: cp=5'b01101;
			f: cp=5'b01000;
			g: cp=5'b10001;
			default: cp=5'b00000;
		endcase
	end
	
endmodule

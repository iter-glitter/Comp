`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// EE480 - DVHW7
// Load/Store/Shift Register
// January 18, 2013
//
// Precedence: 
// Active Low
// clr, set, clk -> cntrols
//
// ctrl[1] ctrl[0] | function
//		0		  0	 | Store
//		0		  1	 | LD In Parallel
// 	1		  0	 |	LS - Left Shift 1-bit
//	   1		  1	 | RS - Right Shift 1-bit
//
//////////////////////////////////////////////////////////////////////////////////
module ld_st_shift_nbit(clk,clr,set,ctrl,ls,rs,reg_in,reg_out);
	parameter n=4;
	input clk, clr, set, ls, rs;
	input [1:0] ctrl;
	input [n-1:0] reg_in;
	
	output reg [n-1:0] reg_out;
	reg [n-1:0] register;
	reg [n-1:0] temp; //Hold previous value during shift
	
	always @ (posedge(clk)) begin
			if( clr == 1'b0 ) begin:clearBlock
				integer i;
				for(i=0; i<n; i=i+1) begin:clearLoop
					register[i]=1'b0;
					reg_out=register;
				end
			end
			else if( set == 1'b0 ) begin:setBlock
				integer i;
				for(i=0; i<n; i=i+1) begin:setLoop
					register[i]=1'b1;
					reg_out=register;
				end
			end
			else if( ctrl[1:0]==2'b00 ) begin //store
				register=register;
				reg_out=register;
			end
			else if( ctrl[1:0]==2'b01 ) begin//Load In Parallel
				register=reg_in;
				reg_out=register;
			end
			else if( ctrl[1:0]==2'b10 ) begin:LS //LS
				integer i;
				for(i=0; i<n; i=i+1) begin:lsLoop
					reg_out[i] = register[i]; //Shift current value out
					if(i==0) begin temp[0] = ls; end
					else begin temp[i] = reg_out[i-1]; end //Grab the previous register's output
					register[i] = temp[i]; //Store Previous register's value
				end
				reg_out=register;
			end	
			else if( ctrl[1:0]==2'b11 ) begin:RS //RS
				integer i;
				for(i=0; i<n; i=i+1) begin:rsLoop
					reg_out[i] = register[i]; //Shift current value out
					if(i==(n-1)) begin temp[n-1] = rs; end
					else begin temp[i] = reg_out[i+1]; end //Grab the previous register's output
					register[i] = temp[i]; //Store Previous register's value
				end
				reg_out=register;
			end	
	end //end always@posedge clk
endmodule

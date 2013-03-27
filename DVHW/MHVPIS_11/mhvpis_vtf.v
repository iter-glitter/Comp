`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:00:34 03/26/2013
// Design Name:   MHVPIS
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW11/MHVPIS/mhvpis_vtf.v
// Project Name:  MHVPIS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MHVPIS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mhvpis_vtf;

	// Inputs
	reg clk;
	reg itr_clr;
	reg [3:0] itr_in;
	reg [3:0] mask_in;
	reg itr_en;
	
	reg [9:0] cnt;

	// Outputs
	wire i_pending;
	wire [7:0] PC_out;
	
	reg i_pending_tc;
	reg [7:0] PC_out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	MHVPIS uut (
		.clk(clk), 
		.itr_clr(itr_clr), 
		.itr_in(itr_in), 
		.mask_in(mask_in), 
		.itr_en(itr_en), 
		.i_pending(i_pending), 
		.PC_out(PC_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		itr_clr = 0;
		itr_en = 0;
		itr_in = 0;
		mask_in = 0;
		
		cnt = 0;
	end
	
	always begin //create clock
		// Wait 100 ns for global reset to finish
		#100;
      #10 clk = ~clk;
	end
	
	always @ (posedge clk) begin
		cnt = cnt + 1;
	end
	
	always @ (negedge clk) begin
		itr_clr <= cnt[9];
		itr_en <= cnt[8];
		itr_in <= cnt[7:4];
		mask_in <= cnt[3:0];
	end

	// Add stimulus here
	
	always @ (posedge clk) begin
	
		if( (itr_en == 1'b0) || (itr_clr == 1'b0) ) begin //Interrupts disabled or clear
			i_pending_tc <= 1'b0;
			PC_out_tc <= 8'b00000000;
		end 
		//Assume Interrupts Enabled, Clear False
		else if(itr_in[3]==1'b1) begin //ISR1
			if(mask_in[3]==1'b1) begin
				i_pending_tc <= 1'b1;
				PC_out_tc <= 8'b11110101;
			end
			else if(itr_in[2]==1'b1) begin //ISR2
				if(mask_in[2]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11100110;
				end
				else if(itr_in[1]==1'b1) begin //ISR3
					if(mask_in[1]==1'b1) begin
						i_pending_tc <= 1'b1;
						PC_out_tc <= 8'b11010111;
					end
					else if(itr_in[0]==1'b1) begin //ISR4
						if(mask_in[0]==1'b1) begin
							i_pending_tc <= 1'b1;
							PC_out_tc <= 8'b11001000;
						end
						else begin
							i_pending_tc <= 1'b0;
							PC_out_tc <= 8'b00000000;
						end
					end
					else begin
						i_pending_tc <= 1'b0;
						PC_out_tc <= 8'b00000000;
					end
				end
				else if(itr_in[0]==1'b1) begin //ISR4
					if(mask_in[0]==1'b1) begin
						i_pending_tc <= 1'b1;
						PC_out_tc <= 8'b11001000;
					end
					else begin
						i_pending_tc <= 1'b0;
						PC_out_tc <= 8'b00000000;
					end
				end
				
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			else if(itr_in[1]==1'b1) begin //ISR3
				if(mask_in[1]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11010111;
				end
				else if(itr_in[0]==1'b1) begin //ISR4
					if(mask_in[0]==1'b1) begin
						i_pending_tc <= 1'b1;
						PC_out_tc <= 8'b11001000;
					end
					else begin
						i_pending_tc <= 1'b0;
						PC_out_tc <= 8'b00000000;
					end
				end
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			else if(itr_in[0]==1'b1) begin //ISR4
				if(mask_in[0]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11001000;
				end
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			else begin
				i_pending_tc <= 1'b0;
				PC_out_tc <= 8'b00000000;
			end
		end
		
		
		
		
		//ISR2 Steps
		else if(itr_in[2]==1'b1) begin //ISR2
			if(mask_in[2]==1'b1) begin
				i_pending_tc <= 1'b1;
				PC_out_tc <= 8'b11100110;
			end
			else if(itr_in[1]==1'b1) begin //ISR3
				if(mask_in[1]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11010111;
				end
				else if(itr_in[0]==1'b1) begin //ISR4
					if(mask_in[0]==1'b1) begin
						i_pending_tc <= 1'b1;
						PC_out_tc <= 8'b11001000;
					end
					else begin
						i_pending_tc <= 1'b0;
						PC_out_tc <= 8'b00000000;
					end
				end
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			else if(itr_in[0]==1'b1) begin //ISR4
				if(mask_in[0]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11001000;
				end
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			
			else begin
				i_pending_tc <= 1'b0;
				PC_out_tc <= 8'b00000000;
			end
		end
		
		//ISR3 Steps
		else if(itr_in[1]==1'b1) begin //ISR3
			if(mask_in[1]==1'b1) begin
				i_pending_tc <= 1'b1;
				PC_out_tc <= 8'b11010111;
			end
			else if(itr_in[0]==1'b1) begin //ISR4
				if(mask_in[0]==1'b1) begin
					i_pending_tc <= 1'b1;
					PC_out_tc <= 8'b11001000;
				end
				else begin
					i_pending_tc <= 1'b0;
					PC_out_tc <= 8'b00000000;
				end
			end
			else begin
				i_pending_tc <= 1'b0;
				PC_out_tc <= 8'b00000000;
			end
		end
		
		
		//ISR4 Steps
		else if(itr_in[0]==1'b1) begin //ISR4
			if(mask_in[0]==1'b1) begin
				i_pending_tc <= 1'b1;
				PC_out_tc <= 8'b11001000;
			end
			else begin
				i_pending_tc <= 1'b0;
				PC_out_tc <= 8'b00000000;
			end
		end
		
		else begin
			i_pending_tc <= 1'b0;
			PC_out_tc <= 8'b00000000;
		end

		#2 if( (i_pending_tc == i_pending) && (PC_out==PC_out_tc) ) begin error <= 0; end
			else begin error <= 1; end
	end
endmodule


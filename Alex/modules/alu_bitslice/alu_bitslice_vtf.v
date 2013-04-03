`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:14:25 02/05/2013
// Design Name:   alu_bitslice
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW3/alu_bitslice_2/alu_bitslice_vtf.v
// Project Name:  alu_bitslice_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_bitslice
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_bitslice_vtf;

	// Inputs
	reg [5:0] counter;

	// Outputs
	wire c_out;
	wire f_out;
	reg f_out_tc;
	reg c_out_tc;
	reg error;

	// Instantiate the Unit Under Test (UUT)
	alu_bitslice uut (
		.a(counter[0]), 
		.b(counter[1]),  
		.c(counter[5:3]),
		.c_in(counter[2]),
		.c_out(c_out), 
		.f_out(f_out)
	);

	initial begin
		// Initialize Inputs
		counter=0;
		f_out_tc=0;
		c_out_tc=0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#40 counter = counter + 1;
	
	if(counter[5:3]==3'b000) begin
		case(counter[2:0]) 
			3'b000: begin f_out_tc=0; c_out_tc=0; end
			3'b001: begin f_out_tc=1; c_out_tc=0; end
			3'b010: begin f_out_tc=1; c_out_tc=0; end
			3'b011: begin f_out_tc=0; c_out_tc=1; end
			3'b100: begin f_out_tc=1; c_out_tc=0; end
			3'b101: begin f_out_tc=0; c_out_tc=1; end
			3'b110: begin f_out_tc=0; c_out_tc=1; end
			3'b111: begin f_out_tc=1; c_out_tc=1; end
		endcase
	end
	else if(counter[5:3]==3'b001) begin
		case(counter[2:0])
			3'b000: begin f_out_tc=1; c_out_tc=0; end //Post Negation: 010
			3'b001: begin f_out_tc=0; c_out_tc=1; end //Post Negation: 011
			3'b010: begin f_out_tc=0; c_out_tc=0; end //Post Negation: 000
			3'b011: begin f_out_tc=1; c_out_tc=0; end //Post Negation: 001
			3'b100: begin f_out_tc=0; c_out_tc=1; end //Post Negation: 110
			3'b101: begin f_out_tc=1; c_out_tc=1; end //Post Negation: 111
			3'b110: begin f_out_tc=1; c_out_tc=0; end //Post Negation: 100
			3'b111: begin f_out_tc=0; c_out_tc=1; end //Post Negation: 101
		endcase
	end
	else if(counter[5:3]==3'b010) begin
		case(counter[2:0]) 
			3'b000: begin f_out_tc=0; c_out_tc=0; end
			3'b001: begin f_out_tc=1; c_out_tc=0; end
			3'b010: begin f_out_tc=1; c_out_tc=0; end
			3'b011: begin f_out_tc=1; c_out_tc=1; end
			3'b100: begin f_out_tc=0; c_out_tc=0; end
			3'b101: begin f_out_tc=1; c_out_tc=1; end
			3'b110: begin f_out_tc=1; c_out_tc=1; end
			3'b111: begin f_out_tc=1; c_out_tc=1; end
		endcase
	end
	else if(counter[5:3]==3'b011) begin
		case(counter[2:0])
			3'b000: begin f_out_tc=1; c_out_tc=0; end //Negated: 010
			3'b001: begin f_out_tc=1; c_out_tc=1; end //Negated: 011
			3'b010: begin f_out_tc=0; c_out_tc=0; end //Negated: 000
			3'b011: begin f_out_tc=1; c_out_tc=0; end //Negated: 001
			3'b100: begin f_out_tc=1; c_out_tc=1; end //Negated: 110
			3'b101: begin f_out_tc=1; c_out_tc=1; end //Negated: 111
			3'b110: begin f_out_tc=0; c_out_tc=0; end //Negated: 100
			3'b111: begin f_out_tc=1; c_out_tc=1; end //Negated: 101

		endcase
	end
	else if(counter[5:3]==3'b100) begin
		case(counter[2:0])
			3'b000: begin f_out_tc=0; c_out_tc=0; end
			3'b001: begin f_out_tc=0; c_out_tc=0; end
			3'b010: begin f_out_tc=0; c_out_tc=0; end
			3'b011: begin f_out_tc=1; c_out_tc=1; end
			3'b100: begin f_out_tc=0; c_out_tc=0; end
			3'b101: begin f_out_tc=0; c_out_tc=1; end
			3'b110: begin f_out_tc=0; c_out_tc=1; end
			3'b111: begin f_out_tc=1; c_out_tc=1; end
		endcase
	end
	else if(counter[5:3]==3'b101) begin
		case(counter[2:0])
			3'b000: begin f_out_tc=0; c_out_tc=0; end //Negated: 010
			3'b001: begin f_out_tc=1; c_out_tc=1; end //Negated: 011
			3'b010: begin f_out_tc=0; c_out_tc=0; end //Negated: 000
			3'b011: begin f_out_tc=0; c_out_tc=0; end //Negated: 001
			3'b100: begin f_out_tc=0; c_out_tc=1; end //Negated: 110
			3'b101: begin f_out_tc=1; c_out_tc=1; end //Negated: 111
			3'b110: begin f_out_tc=0; c_out_tc=0; end //Negated: 100
			3'b111: begin f_out_tc=0; c_out_tc=1; end //Negated: 101
		endcase
	end
	else if(counter[5:3]==3'b110) begin
		case(counter[2:0]) 
			3'b000: begin f_out_tc=1; c_out_tc=0; end //Negated: 001
			3'b001: begin f_out_tc=0; c_out_tc=0; end //Negated: 000
			3'b010: begin f_out_tc=1; c_out_tc=0; end //Negated: 011
			3'b011: begin f_out_tc=0; c_out_tc=1; end //Negated: 010
			3'b100: begin f_out_tc=1; c_out_tc=0; end //Negated: 101
			3'b101: begin f_out_tc=0; c_out_tc=1; end //Negated: 100
			3'b110: begin f_out_tc=1; c_out_tc=1; end //Negated: 111
			3'b111: begin f_out_tc=0; c_out_tc=1; end //Negated: 110
		endcase
	end
	else if(counter[5:3]==3'b111) begin
		case(counter[2:0]) 
			3'b000: begin f_out_tc=1; c_out_tc=0; end //Negated: 010
			3'b001: begin f_out_tc=1; c_out_tc=1; end //Negated: 011
			3'b010: begin f_out_tc=0; c_out_tc=0; end //Negated: 000
			3'b011: begin f_out_tc=0; c_out_tc=0; end //Negated: 001
			3'b100: begin f_out_tc=1; c_out_tc=1; end //Negated: 110
			3'b101: begin f_out_tc=1; c_out_tc=1; end //Negated: 111
			3'b110: begin f_out_tc=0; c_out_tc=0; end //Negated: 100
			3'b111: begin f_out_tc=0; c_out_tc=1; end //Negated: 101
		endcase
	end
	
	#1 if( (f_out_tc==f_out) && (c_out_tc==c_out) ) error=0;
		else error=1;
		
	end
	
endmodule


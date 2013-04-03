`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:39 02/12/2013
// Design Name:   n_bit_alu_generate
// Module Name:   D:/Users/Hendren/My Documents/School/EE480/DVHW4/n_bit_alu_generate/n_bit_alu_generate_vtf.v
// Project Name:  n_bit_alu_generate
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: n_bit_alu_generate
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module n_bit_alu_generate_vtf;

	// Inputs

	integer i;
	reg [11:0] cnt;
	

	// Outputs
	wire c_out;
	wire [3:0] f_out;
	wire V;
	reg [3:0] f_out_tc;
	reg c_out_tc;
	reg v_tc;
	
	reg temp_c, notB, overflow_check;
	reg error;
	

	// Instantiate the Unit Under Test (UUT)
	n_bit_alu_generate uut (
		.a(cnt[3:0]), 
		.b(cnt[7:4]), 
		.c_in(cnt[8]), 
		.c(cnt[11:9]), 
		.c_out(c_out), 
		.f_out(f_out), 
		.V(V)
	);

	initial begin
		// Initialize Inputs
		cnt=0;
		f_out_tc=0;
		c_out_tc=0;
		v_tc=0;
		temp_c=0;
		overflow_check=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#20 cnt=cnt+1;
	

	//cnt[((2*n)+3):((2*n)+1)] = 3 Control Bits (3 MSB)
	if(cnt[11:9]==3'b000) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			//a[i]=cnt[i] b[i]=cnt[i+n] c_in=cnt[2*n]
			if((cnt[i] + cnt[i+4] + temp_c)==0) begin f_out_tc[i]=0; temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==1) begin f_out_tc[i]=1; temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==2) begin f_out_tc[i]=0; temp_c=1; end
			else if((cnt[i] + cnt[i+4] + temp_c)==3) begin f_out_tc[i]=1; temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	else if(cnt[11:9]==3'b001) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			if(cnt[i+4]==1) notB=0;
			else if(cnt[i+4]==0) notB=1;
			//a[i]=cnt[i] b[i]=cnt[i+n] c_in=cnt[2*n]
			if((cnt[i] + notB + temp_c)==0) begin f_out_tc[i]=0; temp_c=0; end
			else if((cnt[i] + notB + temp_c)==1) begin f_out_tc[i]=1; temp_c=0; end
			else if((cnt[i] + notB + temp_c)==2) begin f_out_tc[i]=0; temp_c=1; end
			else if((cnt[i] + notB + temp_c)==3) begin f_out_tc[i]=1; temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b010) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			//Maintain Carray Out
			if((cnt[i] + cnt[i+4] + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + cnt[i+4] + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform OR operation
			f_out_tc[i] = cnt[i]|cnt[i+4];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b011) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			if(cnt[i+4]==1) notB=0;
			else if(cnt[i+4]==0) notB=1;
			//Maintain carry out
			if((cnt[i] + notB + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + notB + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform OR
			f_out_tc[i] = cnt[i]|~cnt[i+4];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b100) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			//Maintain Carray Out
			if((cnt[i] + cnt[i+4] + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + cnt[i+4] + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform AND operation
			f_out_tc[i] = cnt[i]&cnt[i+4];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b101) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			if(cnt[i+4]==1) notB=0;
			else if(cnt[i+4]==0) notB=1;
			//Maintain carry out
			if((cnt[i] + notB + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + notB + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform AND
			f_out_tc[i] = cnt[i]&~cnt[i+4];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b110) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			//Maintain Carray Out
			if((cnt[i] + cnt[i+4] + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + cnt[i+4] + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + cnt[i+4] + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform NOT A
			f_out_tc[i] = ~cnt[i];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	else if(cnt[11:9]==3'b111) begin
		temp_c = cnt[8];
		for(i=0;i<4;i=i+1) begin
			if(cnt[i+4]==1) notB=0;
			else if(cnt[i+4]==0) notB=1;
			//Maintain carry out
			if((cnt[i] + notB + temp_c)==0) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==1) begin temp_c=0; end
			else if((cnt[i] + notB + temp_c)==2) begin temp_c=1; end
			else if((cnt[i] + notB + temp_c)==3) begin temp_c=1; end
			
			if(i==2) overflow_check=temp_c;
			//Perform NOT B
			f_out_tc[i] = ~cnt[i+4];
		end
		c_out_tc=temp_c;
		if( (c_out_tc^overflow_check)==1) v_tc=1;
		else v_tc=0;
	end
	
	#1 if( (f_out_tc==f_out) && (c_out_tc==c_out) && (v_tc==V) ) error=0;
	else error=1;
		
	end
      
endmodule


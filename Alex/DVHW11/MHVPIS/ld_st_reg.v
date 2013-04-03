`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////
//Alex Hendren
//Sean McFeely
//EE480 - Heath
//DVHW 11 - Interrupt System (ld_st reg)
//Parameterized load store register built on DVHW6. 
//
//
//
//   set  clr  funct
//    0    0    clear register to zero
//		1	  0	 clear register to zero
//    0    1    store
//    1    1    load from input
//
///////////////////////////////////////////////////////////////////////////////////////
module ld_st_reg(in, set, clr, clk, out);
    parameter n = 4;            //register size in bits
    input [n-1:0] in;           //load input
    input set;                  //set
    input clr;                  //active-low clear
    input clk;                  //clock
    output reg [n-1:0] out;     //output
    
    always@(posedge clk)
    begin
        if(clr == 0)            //clear to 0s
        begin
            out <= 0;
        end
		  else if( (set==0) && (clr==0) ) begin //clear to 0s
				out <= 0;
		  end
        else if(set == 1)       //load
        begin
            out <= in;
        end
        else             			//store
        begin
            out <= out;
        end
    end
    
endmodule

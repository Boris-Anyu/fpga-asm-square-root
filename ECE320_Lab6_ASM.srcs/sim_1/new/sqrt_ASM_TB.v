`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Boris Anyu
// Course: ECE 320 - Lab 6
// Description: 8-bit integer square root testbench
//////////////////////////////////////////////////////////////////////////////////

module sqrt_ASM_TB();
        reg [7:0] Data;
        reg clock, reset;
        wire [7:0] R;
        wire [7:0] N;
        wire Done;
        wire LED16_G;
        wire [7:0] Data_IN;
        wire [3:0] R_tens, R_ones, N_tens, N_ones, Data_IN_tens, Data_IN_ones;
        
        sqrt_ASM uut (
            .Data(Data),
            .clock(clock),
            .reset(reset),
            .R(R),
            .Done(Done),
            .N(N),
            .LED16_G(LED16_G),
            .Data_IN(Data_IN),
            .R_tens(R_tens),
            .R_ones(R_ones),
            .N_tens(N_tens),
            .N_ones(N_ones),
            .Data_IN_tens(Data_IN_tens),
            .Data_IN_ones(Data_IN_ones)
        );
            
        initial begin
            clock = 0;
        end
           
        always begin 
           #80 clock = ~clock;
        end
         
        initial begin 
            reset = 1;
            Data = 8'd0;
            
           #50 reset = 0; 
           
           #100 Data = 8'd34; 
           
           #2000;
        end

endmodule
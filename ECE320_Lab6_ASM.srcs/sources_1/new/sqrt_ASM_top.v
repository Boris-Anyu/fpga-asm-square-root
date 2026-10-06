`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Boris Anyu
// Course: ECE 320 - Lab 6
// Description: 8-bit integer square root using ASM design
//////////////////////////////////////////////////////////////////////////////////


module sqrt_ASM_top (Data, clock, reset, CLK100MHz, seg, an, LED16_G);
        input [7:0]Data;
        input clock, reset, CLK100MHz;
        output [0:7]seg;
        output [7:0] an; 
        output LED16_G;
        
        wire [7:0]R;
        wire Done;
        wire [7:0]N;
        wire [7:0]Data_IN;
        
        wire [3:0] R_tens;         
        wire [3:0] R_ones;         
        wire [3:0] N_tens;         
        wire [3:0] N_ones;         
        wire [3:0] Data_IN_tens;   
        wire [3:0] Data_IN_ones;   
        
        wire [1:7] X1_R;
        wire [1:7] X2_R;
        wire [1:7] X1_N;
        wire [1:7] X2_N;
        wire [1:7] X1_Data_IN;
        wire [1:7] X2_Data_IN;
        
        
        
        sqrt_ASM uut1(
            .Data(Data),
            .clock(clock),
            .reset(reset),
            .R(R),
            .Done(Done),
            .LED16_G(LED16_G),
            .N(N),
            .Data_IN(Data_IN),
            .R_tens(R_tens),
            .R_ones(R_ones),
            .N_tens(N_tens),
            .N_ones(N_ones),
            .Data_IN_tens(Data_IN_tens),
            .Data_IN_ones(Data_IN_ones)
 
            );
        
        //R    
        seg7_decoder uut2(
            .A(R_ones),
            .X(X1_R)
            );
            
        seg7_decoder uut3(
            .A(R_tens),
            .X(X2_R)
            );                 
        
        //N    
        seg7_decoder uut4(       
            .A(N_ones),               
            .X(X1_N)               
            );                   
                                 
        seg7_decoder uut5(       
            .A(N_tens),               
            .X(X2_N)               
            );                   
        
        
        //Data_IN               
        seg7_decoder uut6(        
            .A(Data_IN_ones),               
            .X(X1_Data_IN)               
            );                   
                                 
        seg7_decoder uut7(       
            .A(Data_IN_tens),               
            .X(X2_Data_IN)               
            );                   
                
            
            
         sSegDisplay_8 uut8(
        .ck(CLK100MHz),
        .digit0(X1_R), 
        .digit1(X2_R), 
        .digit2(X1_N),
        .digit3(X2_N),
        .digit4(7'b111_1111),
        .digit5(7'b111_1111),
        .digit6(X1_Data_IN), 
        .digit7(X2_Data_IN),  
        .seg(seg),
        .an(an)
         );
         

            
        
endmodule

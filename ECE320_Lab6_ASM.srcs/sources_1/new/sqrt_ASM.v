`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Boris Anyu
// Course: ECE 320 - Lab 6
// Description: 8-bit integer square root using ASM design
//////////////////////////////////////////////////////////////////////////////////


module sqrt_ASM(Data, clock, reset, R, Done, N, LED16_G, Data_IN, R_tens, R_ones, N_tens, N_ones, Data_IN_tens, Data_IN_ones);
        parameter n=8, log2n=3;
        input clock, reset;
        input [n-1:0] Data;
       
        output reg Done;
        
        output reg [n-1:0]R;
        output reg [n-1:0]N;
        output LED16_G;
        output [7:0] Data_IN;
        
        output [3:0] R_tens;
        output [3:0] R_ones;
        output [3:0] N_tens;
        output [3:0] N_ones;
        output [3:0] Data_IN_tens;
        output [3:0] Data_IN_ones;
              
        
        reg[1:0] present_state, next;
        
        parameter S0=2'b00, S1=2'b01, S2=2'b10;
        
        //next state logic
        always @(present_state, N, R)
            case(present_state)
                S0: if (N==0) next = S0; else next = S1;
                S1: if (N>=R) next = S1; else next = S2;
                S2: next = S2;
                default next = S0;
            endcase
        
        //state transition
        always@(posedge clock or posedge reset)
            if(reset)  present_state <=S0;                      
                else present_state <= next;
                
        //register transfer operation
        always @(posedge clock or posedge reset)
        
            if (reset) 
            begin
                N    <= Data;
                R    <= 8'd1;
                Done <= 1'b0; 
            
            end 
            
            else 
            
            begin
            
            case(present_state)
                S0:if(N==0)
                    begin
                        N<=Data;
                        R <= 8'd1;
                        Done <= 1'b0;
                    end 
                
                S1: if (N>=R)
                      begin
                        N<=N-R;
                        R<=R+2'd2; 
                      end
                     else 
                        begin
                         R<=R>>1;
                     end 
                     
               S2: Done<=1'b1;  
           endcase  
           end
           
      //output logic
      assign LED16_G = Done;   
      assign Data_IN = Data;  
      
      assign R_tens = R/10;
      assign R_ones = R%10;
      
      assign N_tens = N/10;
      assign N_ones = N%10;
      
      assign Data_IN_tens = Data/10;
      assign Data_IN_ones = Data%10;
      
    
            
endmodule

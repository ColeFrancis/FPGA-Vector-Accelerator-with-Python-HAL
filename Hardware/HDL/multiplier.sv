`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 10:02:01 AM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module single_multiplier #(
        parameter BITS = 8,
        parameter OUT_SHIFT = 0
    )(
        input logic signed [BITS-1:0] A,
        input logic signed [BITS-1:0] B,
        output logic signed [BITS-1:0] P
    );
    
    logic [2*BITS-1:0] temp_P;
    
    assign temp_P = A * B;
    
    always_comb begin
        for (int i=0; i<BITS; i++) begin
            P[i] = temp_P[i+OUT_SHIFT];
        end
    end
endmodule

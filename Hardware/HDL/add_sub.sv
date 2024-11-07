`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 10:14:45 AM
// Design Name: 
// Module Name: add_sub
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


module single_add_sub #(
        parameter BITS = 8
    )(
        input logic [BITS-1:0] A,
        input logic [BITS-1:0] B,
        input logic sub,
        output logic [BITS-1:0] S
    );
    
    logic[BITS-1:0] B_int;
    
    assign B_int = B ^ {BITS{sub}};
    
    assign S = A + B_int + sub;
    
endmodule

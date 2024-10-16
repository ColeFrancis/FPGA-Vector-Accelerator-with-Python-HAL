`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Justin 
// 
// Create Date: 10/11/2024 04:04:02 PM
// Design Name: 
// Module Name: dotProduct
// Project Name: 
// Target Devices: Basys 3
// Tool Versions: 
// Description: takes in 2 vectors and preforms the dot product
// 
// Dependencies: None
// 
// Revision: 0.02
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module dotProduct #(parameter MATRIXSIZE = 10, parameter INTSIZE = 8)(
    input clk,
    input [0:INTSIZE * MATRIXSIZE - 1] a_flat,   // Flattened input a
    input [0:INTSIZE * MATRIXSIZE - 1] b_flat,   // Flattened input b
    output reg [0:INTSIZE - 1] o = 0
);
    
    //initialize the 8 bit vectors
    reg [0:INTSIZE - 1] a [0:MATRIXSIZE - 1];
    reg [0:INTSIZE - 1] b [0:MATRIXSIZE - 1];

    integer i;

    always @ (posedge clk) begin
        // Unflatten the inputs back into arrays
        for (i = 0; i < MATRIXSIZE; i = i+1) begin
            a[i] = a_flat[i*INTSIZE +: INTSIZE];
            b[i] = b_flat[i*INTSIZE +: INTSIZE];
        end
        
        //reset the output
        o = 0;
        
        //preform the multiplication
        for (i = 0; i < MATRIXSIZE; i = i+1) begin
            o = o + (a[i] * b[i]);
        end
    end    
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 05:56:14 PM
// Design Name: 
// Module Name: register
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


module register #(
        parameter BITS = 8
    )(
        input logic [BITS-1:0] in,
        input logic set,
        input logic en,
        output logic [BITS-1:0] out
    );
    
    logic [BITS-1:0] inter;
    
    always_ff @(posedge set) begin
        inter <= in;
    end
        
    always_comb begin
        if (en) begin
            out = inter;
        end else begin
            out = 'z;
        end
    end 
       
endmodule

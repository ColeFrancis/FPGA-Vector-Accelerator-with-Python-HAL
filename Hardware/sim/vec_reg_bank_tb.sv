`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2024 04:03:05 PM
// Design Name: 
// Module Name: vec_reg_bank_tb
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


module vec_reg_bank_tb;
    parameter BITS = 8;
    parameter N = 2;
    
    logic [BITS-1:0] data_in [N-1:0];
    logic [3:0] in_sel;
    logic write;
    logic [3:0] out_sel_a;
    logic [3:0] out_sel_b;
    logic out_en_a;
    logic out_en_b;
    logic [BITS-1:0] out_a [N-1:0];
    logic [BITS-1:0] out_b [N-1:0];
    
    vec_reg_bank #(
        .BITS(BITS),
        .N(N)
    ) bank (
        .data_in(data_in),
        .in_sel(in_sel),
        .write(write),
        .out_sel_a(out_sel_a),
        .out_sel_b(out_sel_b),
        .out_en_a(out_en_a),
        .out_en_b(out_en_b),
        .out_a(out_a),
        .out_b(out_b)
    );
    
    initial begin
        data_in[0] = 8'b00001111;
        data_in[1] = 8'b00111100;
        
        in_sel = 0;
         
        #10
        
        write = 1;
        
        #5
        
        write = 0;
        in_sel = 1;
        data_in[0] = 8'b11111111;
        data_in[1] = 8'b01111110;
        
        #5
        
        write = 1;
        
        #5 
        
        write = 0;
        in_sel = 2;
        data_in[0] = 8'b00000001;
        data_in[1] = 8'b00000000;
        
        #5
        
        write = 1;
        
        #5
        
        out_sel_a = 2;
        out_sel_b = 0;
        out_en_a = 1;
        out_en_b = 1;
    end
endmodule

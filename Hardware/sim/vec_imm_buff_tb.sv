`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:33:10 PM
// Design Name: 
// Module Name: vec_imm_buff_tb
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


module vec_imm_buff_tb;
    parameter N = 8;
    
    logic [7:0] in;
    logic set;
    logic en;
    logic clk;
    logic [7:0] out [N-1:0];
    logic [7:0] out_len;
    logic done;
    
    vec_imm_buff #(
        .N(N)
    ) buff (
        .in(in),
        .set(set),
        .en(en),
        .clk(clk),
        .out(out),
        .out_len(out_len),
        .done(done)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    logic [7:0] test_in[4:0];
    
    initial begin
        test_in[0] = 4;
        test_in[1] = 8'b01010101;
        test_in[2] = 8'b00110011;
        test_in[3] = 8'b00001111;
        test_in[4] = 8'b11111111;
        
        set = 1;
        en = 0;
        
        in = test_in[0];
        
        #10
        
        set = 0;
        in = test_in[1];
        
        #10
            
            in = test_in[2];
        
        #10
        
        en = 1;
        in = test_in[3];
        
        #10
        
        in = test_in[4];
    end
endmodule

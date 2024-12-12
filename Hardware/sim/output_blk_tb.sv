`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 09:12:34 PM
// Design Name: 
// Module Name: output_blk_tb
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


module output_blk_tb;
    parameter FIFO_DEPTH = 4;
    parameter BAUD = 10_000_000;
    
    logic clk;
    logic rst;
    logic set;
    logic [7:0] in;
    logic tx;
    logic full;
    
    output_blk #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .BAUD(BAUD)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .set(set),
        .in(in),
        .tx(tx),
        .full(full)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        in = 8'b01010101;
        set = 0;
        
        #100
        
        rst = 0;
        
        #50
        
        set = 1;
        
        #10
        
        set = 0;
        in = 8'b00110011;
        
        #10
        
        set = 1;
        
        #10
        
        set = 0;
        in = 8'b00001111;
        
        #10
        
        set = 1;
        
        #10
        
        set = 0;
        in = 8'b00111100;
        
        #10
        
        set = 1;
        
        #10
        
        set = 0;
        in = 9'b11000011;
        
        #10
        
        set = 1;
        
        #10
        
        set = 0;
        
        
    end
endmodule

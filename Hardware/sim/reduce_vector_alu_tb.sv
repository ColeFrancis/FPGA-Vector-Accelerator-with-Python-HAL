`timescale 1ns / 1ps

module reduce_vector_alu_tb;
    parameter BITS = 8;
    parameter N = 8;
    parameter VEC_IN_LEN = 4;
    
    logic [BITS-1:0] in [N-1:0];
    logic [1:0] sel;
    logic set;
    logic clk;
    logic [BITS-1:0] out;
    logic done;
    logic en;
    
    reduce_vector_alu #(
        .BITS(BITS),
        .N(N)
    )DUT(
        .in(in),
        .in_len(VEC_IN_LEN),
        .sel(sel),
        .set(set),
        .clk(clk),
        .out(out),
        .done(done),
        .en(en)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        in[3] = 8'b00000011;
        in[2] = 8'b00010010;
        in[1] = 8'b01000000;
        in[0] = 8'b00000100;
        
        en = 1;
        sel = 2'b01;
        
        #5
        
        set = 1;
        
        #5
        
        set = 0;
    end
endmodule

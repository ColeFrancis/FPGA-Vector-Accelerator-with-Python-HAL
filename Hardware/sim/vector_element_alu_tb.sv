`timescale 1ns / 1ps

module vector_element_alu_tb;
    parameter BITS = 8;
    parameter N = 4;
    parameter MULT_SHIFT = 0;
    
    logic [BITS-1:0] A [N-1:0];
    logic [BITS-1:0] B [N-1:0];
    logic [BITS-1:0] scalar;
    logic [2:0] op_sel;
    logic scalar_sel;
    logic set;
    logic [BITS-1:0] S [N-1:0];
    logic en;
    
    vector_element_alu #(
        .BITS(BITS),
        .N(N),
        .MULT_SHIFT(MULT_SHIFT)
    ) alu (
        .A(A),
        .B(B),
        .scalar(scalar),
        .op_sel(op_sel),
        .scalar_sel(scalar_sel),
        .set(set),
        .S(S),
        .en(en)
    );
    
    initial begin
        op_sel = 0;
        scalar_sel = 1;
        en = 0;
        set = 0;
        
        A[3] = 20;
        A[2] = 10;
        A[1] = 5;
        A[0] = 0;
        
        scalar = -1;
        
        #10
        
        set = 1;
        en = 1;
        
        #5
        
        set = 0;
      
        
        for (int i=0; i<8; i++) begin
            op_sel = op_sel + 1;
            #5;
            set = 1;
            #5;
            set = 0;
        end
    end
endmodule

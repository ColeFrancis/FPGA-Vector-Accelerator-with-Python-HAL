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

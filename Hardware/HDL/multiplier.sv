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

module vector_element_alu #(
        parameter BITS = 8,
        parameter N = 64,
        parameter MULT_SHIFT = 0
    )(
        input logic [BITS-1:0] A [N-1:0],
        input logic [BITS-1:0] B [N-1:0],
        input logic [BITS-1:0] scalar,
        input logic [2:0] op_sel,
        input logic scalar_sel,
        input logic set,
        input logic en,
        output logic [BITS-1:0] S [N-1:0]
    );
    
    logic [BITS-1:0] B_inter [N-1:0];
    
    genvar i;
    generate
        for (i=0; i<N; i++) begin
            assign B_inter[i] = scalar_sel ? scalar : B[i];
            
            single_element_alu #(
                .BITS(BITS),
                .MULT_SHIFT(MULT_SHIFT)
            ) alu (
                .A(A[i]),
                .B(B_inter[i]),
                .sel(op_sel),
                .set(set),
                .S(S[i]),
                .en(en)
            );
        end
    endgenerate
    
endmodule

module single_element_alu #(
        parameter BITS = 8,
        parameter MULT_SHIFT = 0
    )(
        input logic [BITS-1:0] A,
        input logic [BITS-1:0] B,
        input logic [2:0] sel,
        input logic set,
        input logic en,
        output logic [BITS-1:0] S
    );
    
    logic [BITS-1:0] S_int;
    
    logic [BITS-1:0] add_sub_out;
    logic [BITS-1:0] mult_out;
    logic [BITS-1:0] cmp_out;
    
    always_comb begin
        if (sel[2]) begin // Logic
            case (sel[1:0])
                2'b00: S_int = A & B;
                2'b01: S_int = A | B;
                2'b10: S_int = A ^ B;
                2'b11: S_int = ~A;
            endcase
        end else begin // Arithmetic
            if (sel[1]) begin // Multiply / Compare
                if (sel[0]) begin
                    S_int = cmp_out;
                end else begin
                    S_int = mult_out;
                end
            end else begin // Add / Sub
                S_int = add_sub_out;
            end
        end
    end
    
    // cmp_out = 1 if A>B, 0 if A==B, and -1 if A<B
    assign cmp_out[BITS-1:1] = { (BITS-1) {add_sub_out[BITS-1]} };
    assign cmp_out[0] = |add_sub_out;
    
    single_add_sub #(
        .BITS(BITS)
    ) adder (
        .A(A),
        .B(B),
        .sub(sel[0]),
        .S(add_sub_out)
    );
    
    single_multiplier #(
        .BITS(BITS),
        .OUT_SHIFT(MULT_SHIFT)
    ) mult (
        .A(A),
        .B(B),
        .P(mult_out)
    ); 
    
    register #(
        .BITS(BITS)
    ) r (
        .in(S_int),
        .set(set),
        .en(en),
        .out(S)
    );
endmodule

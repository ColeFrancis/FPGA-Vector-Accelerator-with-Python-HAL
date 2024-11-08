module vector_reg #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] in [N-1:0],
        input logic set,
        input logic en,
        output logic [BITS-1:0] out [N-1:0]
    );
    
    genvar i;
    generate
        for (i=0; i<N; i++) begin
            register #(
                .BITS(BITS)
            ) r(
                .in(in[i]),
                .set(set),
                .en(en),
                .out(out[i])
            );
        end
    endgenerate
endmodule

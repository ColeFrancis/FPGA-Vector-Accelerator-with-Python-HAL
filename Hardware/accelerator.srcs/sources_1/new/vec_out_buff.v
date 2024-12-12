module vec_out_buff #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] in [N-1:0],
        input logic [7:0] in_len,
        input logic clk,
        output logic [BITS-1:0] out
    );
endmodule

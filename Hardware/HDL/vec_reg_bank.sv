module vec_reg_bank #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] data_in [N-1:0],
        input logic [3:0] in_sel,
        input logic write,
        input logic [3:0] out_sel_a,
        input logic [3:0] out_sel_b,
        input logic out_en_a,
        input logic out_en_b,
        output logic [BITS-1:0] out_a [N-1:0],
        output logic [BITS-1:0] out_b [N-1:0]
    );
    
    logic [15:0] reg_write;
    logic [BITS-1:0] reg_out [15:0][N-1:0];
    
    // Input write
    demux_16 demux (
        .in(write),
        .sel(in_sel),
        .out(reg_write)
    );
    
    // Output A
    vec_mux_16 #(
        .BITS(BITS),
        .N(N)
    ) mux_a (
        .in(reg_out),
        .sel(out_sel_a),
        .en(out_en_a),
        .out(out_a)
    );
    
    // Output B
    vec_mux_16 #(
        .BITS(BITS),
        .N(N)
    ) mux_b (
        .in(reg_out),
        .sel(out_sel_b),
        .en(out_en_b),
        .out(out_b)
    );
    
    // Generate vector registers
    genvar i;
    generate
        for (i=0; i<16; i++) begin
            vector_reg #() r (
                .in(data_in),
                .set(reg_write[i]),
                .en(1),
                .out(reg_out[i])
            );
        end
    endgenerate
endmodule

module vec_mux_16 #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] in [15:0][N-1:0],
        input logic [3:0] sel,
        input logic en,
        output logic [BITS-1:0] out [N-1:0]
    );
    
    logic [BITS-1:0] out_int [N-1:0];
    
    always_comb begin
        case (sel)
            0: out_int = in[0];
            1: out_int = in[1];
            2: out_int = in[2];
            3: out_int = in[3];
            4: out_int = in[4];
            5: out_int = in[5];
            6: out_int = in[6];
            7: out_int = in[7];
            8: out_int = in[8];
            9: out_int = in[9];
            10: out_int = in[10];
            11: out_int = in[11];
            12: out_int = in[12];
            13: out_int = in[13];
            14: out_int = in[14];
            15: out_int = in[15];
        endcase
    end
    
    always_comb begin
        if (en) begin
            for (int i = 0; i < N; i++) begin
                out[i] = out_int[i];
            end
        end else begin
            for (int i = 0; i < N; i++) begin
                out[i] = 'z;
            end
        end
    end
endmodule

module demux_16 (
        input logic in,
        input logic [3:0] sel,
        output logic [15:0] out
    );
    
    always_comb begin
        case (sel)
            0: out[0] = in;
            1: out[1] = in;
            2: out[2] = in;
            3: out[3] = in;
            4: out[4] = in;
            5: out[5] = in;
            6: out[6] = in;
            7: out[7] = in;
            8: out[8] = in;
            9: out[9] = in;
            10: out[10] = in;
            11: out[11] = in;
            12: out[12] = in;
            13: out[13] = in;
            14: out[14] = in;
            15: out[15] = in;
        endcase
    end

endmodule

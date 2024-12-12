module reduce_vector_alu #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic signed [BITS-1:0] in [N-1:0],
        input logic [BITS-1:0] in_len,
        input logic [1:0] sel,
        input logic set, // Save the values into the initial layer registers and start
        input logic en,
        input logic clk,
        output logic signed [BITS-1:0] out,
        output logic done // when the value is valid
    );
    
    logic [BITS-1:0] in_saved [N-1:0];
    
    logic signed [BITS-1:0] sum_internal;
    logic [BITS-1:0] or_internal;
    logic signed [BITS-1:0] max_val;
    logic signed [BITS-1:0] min_val;
    
    logic [$clog2(N):0] index;
    logic running;
    
    // First layer register
    genvar i;
    generate
        for (i=0; i<N; i++) begin
            register #(
                .BITS(BITS)
            ) r (
                .in(in[i]),
                .set(set),
                .en(1),
                .out(in_saved[i])
            );
        end
    endgenerate
    
    // Selects output
    always_comb begin
        if (en) begin
            case (sel)
                2'b00: out = sum_internal;
                2'b01: out = or_internal;
                2'b10: out = min_val;
                2'b11: out = max_val;
            endcase
        end else begin
            out = 'z;
        end
    end
    
    // Finds sum, or reduce, min, and max values
    always_ff @(posedge clk) begin
        if (set) begin
            sum_internal <= 0;
            or_internal <= 0;
            max_val <= {1, {(BITS-1){1'b0}}};
            min_val <= {0, {(BITS-1){1'b1}}};
            index <= 0;
            done <= 0;
            running <= 1;
                
        end else if (running) begin 
            if (index < in_len) begin // Ran every cycle as long as running 
                if ($signed(in_saved[index]) > max_val)
                    max_val <= in_saved[index];
                else if ($signed(in_saved[index]) < min_val)
                    min_val <= in_saved[index];
                
                sum_internal <= sum_internal + in_saved[index];
                or_internal <= or_internal | in_saved[index];
                
                index <= index + 1;
                    
            end else begin
                running <= 0;
                done <= 1;
            end
        end
    end
endmodule

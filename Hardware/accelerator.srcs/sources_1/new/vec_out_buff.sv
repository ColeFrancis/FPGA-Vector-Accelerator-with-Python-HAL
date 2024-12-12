module vec_out_buff #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] in [N-1:0],
        input logic [BITS-1:0] in_len,
        input logic set,
        input logic clk,
        output logic [BITS-1:0] out,
        output logic done
    );
    
    logic [BITS-1:0] in_inter [N-1:0];
    logic [BITS-1:0] in_len_inter;
    
    logic [$clog2(N):0] index;
    logic running;
    
    vector_reg #(
        .BITS(BITS),
        .N(N)
    ) buff (
        .in(in),
        .set(set),
        .en(1),
        .out(in_inter)
    );
    
    //State machine
    always_ff @(posedge clk) begin
        if (set) begin
            in_len_inter <= in_len;
            index <= 0;
            running <= 1;
            done <= 0;
            
            out <= 'z;
            
        end else if (running) begin
            if (index < in_len_inter) begin
                out <= in_inter[index];
                index <= index + 1;
                
            end else begin
                running <= 0;
                done <= 1;
                
                out <= 'z;
            end
            
        end else begin
            out <= 'z;
        end
    end
endmodule

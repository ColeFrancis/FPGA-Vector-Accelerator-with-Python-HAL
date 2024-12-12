module vec_imm_buff #(
        parameter BITS = 8,
        parameter N = 64
    )(
        input logic [BITS-1:0] in,
        input logic set, 
        input logic en,
        input logic clk,
        output logic [BITS-1:0] out [N-1:0],
        output logic [BITS-1:0] out_len,
        output logic done
    );
    
    logic [BITS-1:0] out_inter [N-1:0];
    logic [BITS-1:0] out_len_inter;
    
    logic [$clog2(N):0] index;
    logic running;
    
    // Tri state output 
    assign out_len = (en) ? out_len_inter : 'z; 
    genvar i;
    generate
        for (i=0; i<N; i++) 
            assign out[i] = en ? out_inter[i] : 'z; 
    endgenerate
    
    // State machine
    always_ff @(posedge clk) begin
        if (set) begin
            done <= 0;
            index <= 0;
            out_len_inter <= in;
            running <= 1;
            
            foreach (out_inter[i]) out_inter[i] <= '0;
            
        end else if (running) begin
            if (index < out_len_inter) begin
                out_inter[index] <= in;
                index <= index + 1;
                
            end else begin
                running <= 0;
                done <= 1;
            end
        end
    end
endmodule
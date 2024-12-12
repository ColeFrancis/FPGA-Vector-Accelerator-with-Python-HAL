module register #(
        parameter BITS = 8
    )(
        input logic [BITS-1:0] in,
        input logic set,
        input logic en,
        input logic clk,
        output logic [BITS-1:0] out
    );
    
    logic [BITS-1:0] mem;
    
    always_ff @(posedge clk) begin
        if(set) mem <= in;
    end
        
    assign out = en ? mem : 'z;
       
endmodule

module data_path #(
        parameter N = 64,
        parameter BITS = 8,
        parameter MULT_SHIFT = 0,
        parameter BAUD = 100_000
    )(
        input logic clk,
        input logic rst,
        input logic rx,
        output logic tx
    );
    
    logic [BITS-1:0] data_bus_a [N-1:0]; // out of regbank a and into vec alu(a) and reduce alu
    logic [BITS-1:0] len_bus_a;
    logic [BITS-1:0] data_bus_b [N-1:0]; // out of regbank b, vec # buffer, and vec alu and into vec alu(b), reg bank, and vec out buffer
    logic [BITS-1:0] len_bus_b;
    logic [BITS-1:0] scalar_bus; // out of scalar # buffer and scalar accum, and into vec alu (scalar)
    
    logic [BITS-1:0] in_bus; // out of input_blk and into inst reg, vec # buffer, and scalar # buffer
    logic [BITS-1:0] out_bus; // out of vec out buffer and recude alu and into output_blk
    
    
endmodule

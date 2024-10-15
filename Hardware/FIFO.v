module fifo #(
    parameter DEPTH_LOG = 6 // LOG2 of depth
)(
    input clk,
    input rst,                // Reset signal
    input wr_en,              // Write enable
    input rd_en,              // Read enable
    input [DATA_WIDTH-1:0] data_in,      // 8-bit data input
    output reg [DATA_WIDTH-1:0] data_out, // 8-bit data output
    output reg full,          // FIFO full indicator
    output reg empty          // FIFO empty indicator
);

    parameter DATA_WIDTH = 8;

    reg [7:0] fifo_mem [(2**DEPTH_LOG)-1:0];  // FIFO memory with depth of 4 words (8 bits each)
    reg [DEPTH_LOG-1:0] write_ptr = 0;   // Write pointer (2-bit for 4-word depth)
    reg [DEPTH_LOG-1:0] read_ptr = 0;    // Read pointer (2-bit for 4-word depth)
    reg [DEPTH_LOG:0] fifo_count = 0;  // Counter to keep track of the number of elements in FIFO

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            write_ptr <= 0;
            read_ptr <= 0;
            fifo_count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                fifo_mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                fifo_count <= fifo_count + 1;
            end
            
            // Read operation
            if (rd_en && !empty) begin
                data_out <= fifo_mem[read_ptr];
                read_ptr <= read_ptr + 1;
                fifo_count <= fifo_count - 1;
            end
            
            // Full and empty flag management
            full <= (fifo_count == 4);
            empty <= (fifo_count == 0);
        end
    end
endmodule

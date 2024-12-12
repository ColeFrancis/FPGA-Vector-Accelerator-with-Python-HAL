module output_blk #(
        parameter FIFO_DEPTH = 64, // must be a power of two for the internal FIFO to work properly (they must use the full range of values so the pointers will wrap around immediatly)
        parameter BAUD = 100_000
    ) (
        input logic clk, rst,
        input logic set,
        input logic [7:0] in,
        output logic tx,
        output logic full
    );
    
    logic [7:0] uart_in;
    logic uart_busy, uart_send;
    
    logic [7:0] mem [FIFO_DEPTH-1:0];
    logic [$clog2(FIFO_DEPTH)-1:0] write_ptr = 0;
    logic [$clog2(FIFO_DEPTH)-1:0] read_ptr = 0;
    
    assign full = ((write_ptr + 1) == read_ptr);
    assign empty = (write_ptr == read_ptr);
    
    uart_tx #(
        .BAUD(BAUD)
    ) Uart (
        .clk(clk),
        .rst(rst),
        .start(uart_send),
        .data_in(uart_in),
        .tx(tx),
        .busy(uart_busy)
    );
    
    always_ff @(posedge clk) begin
        if (rst) begin
            write_ptr <= 0;
            
        end else begin
            if (!full && set) begin
                mem[write_ptr] <= in;
                write_ptr <= write_ptr + 1;
            end
        end
    end
    
    logic state;
    always_ff @(posedge clk) begin
        if (rst) begin
            state <= 0;
            read_ptr <= 0;
            
        end else begin
            case (state) 
                0: begin
                    if (!empty && !uart_busy) begin 
                        uart_in <= mem[read_ptr];
                        read_ptr <= read_ptr + 1;
                        
                        state <= 1;
                        uart_send <= 1;
                    end
                end
                1: begin
                    state <= 0;
                    uart_send <= 0;
                end
            endcase
        end
    end
endmodule

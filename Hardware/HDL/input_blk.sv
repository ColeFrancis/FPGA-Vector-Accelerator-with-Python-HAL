module input_blk #(
        parameter BAUD = 100_000
    ) (
        input logic clk, rst,
        input logic rx,
        output logic [7:0] out
    );
    
    logic [7:0] uart_out;
    
    uart_rx #(
        .BAUD(BAUD)
    ) Uart (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data_valid(uart_done),
        .data_out(uart_out)
    );
    
    always_ff @(posedge clk) begin
        if (uart_done) out <= uart_out;
        else out <= '0;
    end
endmodule

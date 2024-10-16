`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Justin
// 
// Create Date: 10/11/2024 04:04:02 PM
// Design Name: 
// Module Name: cellTB
// Project Name: 
// Target Devices: Test bench
// Tool Versions: 
// Description: The test bench for the multiplierCell module
// 
// Dependencies: None
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cellTB(); 
    //initialize the wires/regesters
    wire [0:7] matOut;
    reg clk;
    reg [0:7] a [0:4];
    reg [0:7] b [0:4];
    
    initial begin
        //fill vector a
        a[0] = 8'd4;
        a[1] = 8'd6;
        a[2] = 8'd8;
        a[3] = 8'd4;
        a[4] = 8'd2;
        
        //fill vector b
        b[0] = 8'd3;
        b[1] = 8'd9;
        b[2] = 8'd1;
        b[3] = 8'd5;
        b[4] = 8'd1;
        
        //start the clock
        clk = 0;
        #100;
        forever #10 clk = ~clk;
    end
    
    //initialize the flattened versions of the vectors
    wire [5*8-1:0] a_flat;
    wire [5*8-1:0] b_flat;
    
    //flatten the vectors
    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : flatten_arrays
            assign a_flat[i*8 +: 8] = a[i];  // Flatten each element of a
            assign b_flat[i*8 +: 8] = b[i];  // Flatten each element of b
        end
    endgenerate
    
    //instantiate the multiplierCell module
    multiplierCell #(.MATRIXSIZE(5)) DUT (
        .clk(clk),
        .a_flat(a_flat),
        .b_flat(b_flat),
        .o(matOut)
    );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2023 01:09:23 PM
// Design Name: 
// Module Name: BTL_board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BTL_board(
  input wire clk, // clock - from board
  input wire rst, // reset - button
  input wire data_1b_in, // input data (type each bit) _button
  input wire wr_en, // sign when want to write - switch 
  input wire rd_en, // sign when when can read - switch 
  output wire temp_clk, // longer clock to show - LED to sign the clock
  output reg data_1b_out, // output data (show each bit) LED
  output reg empty, // FIFO empty flag - LED
  output reg full // FIFO full flag - LED
    );

// wr_ptr / rd_ptr
reg [2:0] rd_idx = 0;
reg [2:0] wr_idx = 0;

// longer clock to show
longer_clk A(clk, temp_clk);
  
// Define the FIFO depth (FIFO buffer size)
parameter DEPTH = 8;

// Create a register to hold the FIFO data (buffer can store 8 data 1bit-words)
reg mem [0 : (DEPTH - 1)];

// Initialize FIFO empty and full flags
always @(*) begin
  empty = (wr_idx == rd_idx);
  full = ((wr_idx + 1) % DEPTH == rd_idx);
end

// Write operation
always @(posedge temp_clk) begin
        if (rst) begin
            wr_idx <= 0;
        end
        else if (wr_en && !full) begin
            mem[wr_idx] <= data_1b_in;
            wr_idx <= (wr_idx + 1) % DEPTH;
        end
end

// Read operation
always @(posedge temp_clk) begin
        if (rst) begin
                rd_idx <= 0;
        end
        else if (rd_en && !empty) begin
            data_1b_out <= mem[rd_idx];
            rd_idx <= (rd_idx + 1) % DEPTH;
        end
end

endmodule


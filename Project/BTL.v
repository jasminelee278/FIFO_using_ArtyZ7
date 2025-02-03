`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 08:22:56 AM
// Design Name: 
// Module Name: BTL
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


module BTL(
  input wire clk, // clock
  input wire rst, // reset
  input wire wr_en, // write enable
  input wire rd_en, // read enable
  input wire [7:0] data_in, // input data
  output reg [7:0] data_out, // output data
  output reg empty, // FIFO empty flag
  output reg full // FIFO full flag
    );

// Define the FIFO depth (FIFO buffer size)
parameter DEPTH = 8;

// Create a register to hold the FIFO data (buffer can store 8 data 8bit-words)
reg [7:0] mem [0 : DEPTH - 1];

// wr_ptr / rd_ptr
reg [2:0] rd_idx = 0;
reg [2:0] wr_idx = 0;



// Initialize FIFO empty and full flags
always @(*) begin
  empty = (wr_idx == rd_idx);
  full = ((wr_idx + 1) % DEPTH == rd_idx);
end
    
// Write operation
always @(posedge clk) begin
  if (rst) begin
    wr_idx <= 0;
  end
  else if (wr_en && !full) begin
    mem[wr_idx] <= data_in;
    wr_idx <= (wr_idx + 1) % DEPTH;
  end
end

// Read operation
always @(posedge clk) begin
  if (rst) begin
    rd_idx <= 0;
  end
  else if (rd_en && !empty) begin
    data_out <= mem[rd_idx];
    rd_idx <= (rd_idx + 1) % DEPTH;
  end
end 
    
endmodule

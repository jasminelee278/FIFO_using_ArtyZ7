`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 08:29:28 AM
// Design Name: 
// Module Name: BTL_tb
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


module BTL_tb();

// Inputs
reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] data_in;

// Outputs
wire [7:0] data_out;
wire empty;
wire full;

// Instantiate the FIFO module
BTL dut (
  .clk(clk),
  .rst(rst),
  .wr_en(wr_en),
  .rd_en(rd_en),
  .data_in(data_in),
  .data_out(data_out),
  .empty(empty),
  .full(full)
);

// Clock generator
initial begin
  clk = 0;
  forever #10 clk = ~clk;
end

// Reset
initial begin
  rst = 1;
  #20 rst = 0;
end

// Test case 1: Write data into the FIFO
initial begin
  #20 wr_en = 1;
  data_in = 8'b10101010;
  #20 wr_en = 0;
  rd_en = 1;
  #20 rd_en = 1;
  #20 
  rd_en = 0;
  wr_en = 1;
  data_in = 8'b11110000;
  #20
  data_in = 8'b00001001;
  #20 
  data_in = 8'b10101010;
  #20
  data_in = 8'b10101001;
  #20
  data_in = 8'b00000000;
  #20
  data_in = 8'b11111111;
  #20 
  data_in = 8'b01010101;
  #20 
  data_in = 8'b10101010;
  #20
  wr_en = 0;
  rd_en = 1;
end

initial begin
  #500 $stop;
end



endmodule


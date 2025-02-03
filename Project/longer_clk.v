`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 09:19:24 AM
// Design Name: 
// Module Name: longer_clk
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


module longer_clk(clk, new_clk);

input clk;
output reg new_clk = 0;

parameter freq = 125000000;
reg [31:0] counter = 0;

always @(posedge clk) begin
	if (counter == freq - 1)
	   begin
	       new_clk <= ~new_clk;
	       counter <= 0; // set back to count
	   end
    else
        begin
            counter <= counter + 1; // count 
        end
end	   
endmodule
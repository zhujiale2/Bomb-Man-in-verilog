`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:56 01/07/2014 
// Design Name: 
// Module Name:    wallmask 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// 0dditional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module wallmask(
input wire clk,
	input wire [9:0] px, py,
	output wire [2:0] col
);
	reg [0:15] green [0:15];
	reg [0:15] blue [0:15];
	reg [0:15] red [0:15];
	initial begin
      red[15] = 16'b1101111110111111;
      red[14] = 16'b1101111110111111;
      red[13] = 16'b1101111110111111;
      red[12] = 16'b0000000000000000;
      red[11] = 16'b1111101111110111;
      red[10] = 16'b1111101111110111;
      red[9] = 16'b1111101111110111;
      red[8] = 16'b0000000000000000;
      red[7] = 16'b1011111101111111;
      red[6] = 16'b1011111101111111;
      red[5] = 16'b1011111101111111;
      red[4] = 16'b0000000000000000;
      red[3] = 16'b1111011111101111;
      red[2] = 16'b1111011111101111;
      red[1] = 16'b1111011111101111;
      red[0] = 16'b1111011111101111;
	end
	assign col[2] = (green[py%16] & (1<<(15-px%16)))>0 ? 1 : 0;
	assign col[1] = (blue[py%16] & (1<<(15-px%16)))>0 ? 1 : 0;
	assign col[0] = (red[py%16] & (1<<(15-px%16)))>0 ? 1 : 0;
endmodule

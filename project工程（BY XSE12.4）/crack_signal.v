`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:50 01/04/2014 
// Design Name: 
// Module Name:    crack_signal 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module crack_signal(
	input wire clk,
	input wire [1:36] bomb_x, bomb_y,
	input wire [1:6] crack_num,
	input wire [9:0] px, py,
	output wire crack
);
	reg crack_on;
	initial crack_on = 0;
	parameter block_width = 16;
	parameter offset = 1;
	always @(posedge clk) begin
		if (crack_num>0) begin
			if (crack_num[1] && ((bomb_x[1:6]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[1:6]==py/block_width && (py/block_width%2==1))))
				crack_on = 1;
			else if (crack_num[2] && ((bomb_x[7:12]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[7:12]==py/block_width && (py/block_width%2==1))))
				crack_on = 1;
			else if (crack_num[3] && ((bomb_x[13:18]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[13:18]==py/block_width && (py/block_width%2==1))))
				crack_on = 1;
			else if (crack_num[4] && ((bomb_x[19:24]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[19:24]==py/block_width && (py/block_width%2==1))))
				crack_on = 1;
			else if (crack_num[5] && ((bomb_x[25:30]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[25:30]==py/block_width && (py/block_width%2==1)))) 
				crack_on = 1;
			else if (crack_num[6] && ((bomb_x[31:36]==(px+offset)/block_width && (px+offset)/block_width%2==1)
			|| (bomb_y[31:36]==py/block_width && (py/block_width%2==1)))) 
				crack_on = 1;
			else crack_on = 0;
		end
		else crack_on = 0;
	end
	assign crack = crack_on;
endmodule

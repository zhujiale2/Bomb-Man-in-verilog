`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:03 01/03/2014 
// Design Name: 
// Module Name:    move_man2 
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
module move_man2(
	input wire clk,
	input wire [3:0] control,
	input wire [1:36] bomb_x, bomb_y,
	input wire [9:0] anotherx, anothery,
	output wire [9:0] outx, outy
);
	parameter block_width   = 16;
	parameter screen_width  = 39;
	parameter screen_height = 29;
	wire up, down, left, right;
	reg flag;
	reg [9:0] lx, ly;
	reg [9:0] x, y;
	initial begin
		lx = 0; ly = 0;
		x = 39; y = 29;
	end
	
	pbdebounce p1(clk, control[3], right);
	pbdebounce p2(clk, control[0], left);
	pbdebounce p3(clk, control[2], down);
	pbdebounce p4(clk, control[1], up);
	clk1ms m4(clk, clk_1ms);
	always@(posedge clk_1ms) begin
		if (up && y>0) begin
			lx = x; ly = y-1;
			flag = (bomb_x[1:6]==lx) && (bomb_y[1:6]==ly)
					||(bomb_x[7:12]==lx) && (bomb_y[7:12]==ly)
					||(bomb_x[13:18]==lx) && (bomb_y[13:18]==ly)
					||(bomb_x[19:24]==lx) && (bomb_y[19:24]==ly)
					||(bomb_x[25:30]==lx) && (bomb_y[25:30]==ly)
					||(bomb_x[31:36]==lx) && (bomb_y[31:36]==ly);
			if (!flag && x%2==1 && (lx!=anotherx || ly!=anothery)) y = y-1;
		end
		else if (down && y<screen_height) begin
			lx = x; ly = y+1;
			flag = (bomb_x[1:6]==lx) && (bomb_y[1:6]==ly)
					||(bomb_x[7:12]==lx) && (bomb_y[7:12]==ly)
					||(bomb_x[13:18]==lx) && (bomb_y[13:18]==ly)
					||(bomb_x[19:24]==lx) && (bomb_y[19:24]==ly)
					||(bomb_x[25:30]==lx) && (bomb_y[25:30]==ly)
					||(bomb_x[31:36]==lx) && (bomb_y[31:36]==ly);			
			if (!flag && x%2==1 && (lx!=anotherx || ly!=anothery)) y = y+1;
		end
		else if (left && x>0) begin
			lx = x-1; ly = y;
			flag = (bomb_x[1:6]==lx) && (bomb_y[1:6]==ly)
					||(bomb_x[7:12]==lx) && (bomb_y[7:12]==ly)
					||(bomb_x[13:18]==lx) && (bomb_y[13:18]==ly)
					||(bomb_x[19:24]==lx) && (bomb_y[19:24]==ly)
					||(bomb_x[25:30]==lx) && (bomb_y[25:30]==ly)
					||(bomb_x[31:36]==lx) && (bomb_y[31:36]==ly);
			if (!flag && y%2==1 && (lx!=anotherx || ly!=anothery)) x = x-1;
		end
		else if (right && x<screen_width) begin
			lx = x+1; ly = y;
			flag = (bomb_x[1:6]==lx) && (bomb_y[1:6]==ly)
					||(bomb_x[7:12]==lx) && (bomb_y[7:12]==ly)
					||(bomb_x[13:18]==lx) && (bomb_y[13:18]==ly)
					||(bomb_x[19:24]==lx) && (bomb_y[19:24]==ly)
					||(bomb_x[25:30]==lx) && (bomb_y[25:30]==ly)
					||(bomb_x[31:36]==lx) && (bomb_y[31:36]==ly);
			if (!flag && y%2==1 && (lx!=anotherx || ly!=anothery)) x = x+1;
		end
		else begin
			x = x;
			y = y;
		end
	end
	assign outx = x;
	assign outy = y;
endmodule


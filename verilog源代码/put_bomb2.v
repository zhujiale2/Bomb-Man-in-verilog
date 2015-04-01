`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:05 01/03/2014 
// Design Name: 
// Module Name:    put_bomb2 
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
module put_bomb2(
	input wire clk, bomb,
	input wire [9:0] x, y,
	output wire [19:36] bomb_x, bomb_y,
	output wire [1:6] crack_num
);
	wire flag, clk_1ms;
	parameter left = 19;
	parameter right = 36;
	parameter limit = 3000;
	parameter shine = 1000;
	parameter offset = 3;
	reg set;
	reg [1:6] crack;
	reg [1:3] num;
	reg [12:0] timer1, timer2, timer3;
	reg [11:0] shinning1, shinning2, shinning3;
	reg [19:36] bx, by;
	pbdebounce p1(clk, bomb, flag);
	clk1ms c1(clk, clk_1ms);
	initial begin
		set <= 1;
		crack <= 0;
		num <= 0;
		timer1 <= 0;
		timer2 <= 0;
		timer3 <= 0;
		shinning1 <= 0;
		shinning2 <= 0;
		shinning3 <= 0;
	end
	assign crack_num = crack;
	always @(posedge clk_1ms) begin
		if (set==1) begin
			bx = bomb_x;
			by = bomb_y;
			set = 0;
		end
//stop shinning
		if (shinning1>=shine) begin
			bx[left:left+5] = 0;
			by[left:left+5] = 0;
			num[1] = 0;
			crack[offset+1] = 0;
			shinning1 = 0;
		end
		if (shinning2>=shine) begin
			bx[left+6:left+11] = 0;
			by[left+6:left+11] = 0;
			num[2] = 0;
			crack[offset+2] = 0;
			shinning2 = 0;
		end
		if (shinning3>=shine) begin
			bx[left+12:left+17] = 0;
			by[left+12:left+17] = 0;
			num[3] = 0;
			crack[offset+3] = 0;
			shinning3 = 0;
		end
//timer count
		if (timer1>0) timer1 = timer1-1;
		if (timer2>0) timer2 = timer2-1;
		if (timer3>0) timer3 = timer3-1;
//bomb crack
		if (num[1] && timer1<=0) begin
			timer1 = 0;
			crack[offset+1] = 1;
			shinning1 = shinning1+1;
		end
		else if (num[2] && timer2<=0) begin
			timer2 = 0;
			crack[offset+2] = 1;
			shinning2 = shinning2+1;
		end
		else if (num[3] && timer3<=0) begin
			timer3 = 0;
			crack[offset+3] = 1;
			shinning3 = shinning3+1;
		end
//get bomb signal
		if (flag) begin
			if (num[1]==0) begin
				bx[left:left+5] = x;
				by[left:left+5] = y;
				num[1] = 1;
				timer1 = limit;
			end
			else if (num[2]==0) begin
				bx[left+6:left+11] = x;
				by[left+6:left+11] = y;
				num[2] = 1;
				timer2 = limit;
			end
			else if (num[3]==0) begin
				bx[left+12:left+17] = x;
				by[left+12:left+17] = y;
				num[3] = 1;
				timer3 = limit;
			end
		end
	end
	assign bomb_x = bx;
	assign bomb_y = by;
endmodule

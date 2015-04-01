`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:44 12/14/2013 
// Design Name: 
// Module Name:    vga_test 
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

module TOP
( 
	input wire clk,
	input wire [2:0] sw, 
	output wire hsync, vsync, 
	output wire [2:0] rgb,
	input wire [3:0] btn1, btn2,//control for player 1 and 2
	input wire bomb1, bomb2
);
//color definition
	parameter BLACK = 3'b000;
	parameter WHITE = 3'b111;
	parameter RED   = 3'b001;
	parameter GREEN = 3'b100;
	parameter BLUE  = 3'b010;
	parameter YELLOW= 3'b101;
	parameter PINK  = 3'b011;
	parameter SKY   = 3'b110;
	parameter block_width   = 16;
	parameter screen_width  = 39;
	parameter screen_height = 29;
//signal declaration 
	reg reset;
	reg [2:0] rgb_reg;
	wire [2:0] bkg_col, crack_col, wall_col, man1_col, man2_col, bomb_col; 
	wire [9:0] px, py;
	wire [9:0] x1, y1;
	wire [9:0] x2, y2;
	wire video_on, wall_on, player1_on, player2_on, bomb_on, end_on;
	wire [1:36] bomb_x, bomb_y;	
	wire [1:6] crack_num1, crack_num2, crack_num, crack_on;
	wire p1win, p2win;
// instantiate vga sync circuit 
	vga_sync vsync_unit(.clk(clk) , .reset(reset), .hsync(hsync),
	.vsync(vsync),	.video_on(video_on), .p_tick(), .pixel_x(px), .pixel_y(py)); 
// reset
	initial begin
		reset = 0;
		reset = 1;
		reset = 0;
	end
//draw wall	
	assign wall_on = ((px/block_width%2==0) && (py/block_width%2==0));
//move control
	put_bomb1 m5(clk, bomb1, x1, y1, bomb_x[1:18], bomb_y[1:18], crack_num1);
	put_bomb2 m6(clk, bomb2, x2, y2, bomb_x[19:36], bomb_y[19:36], crack_num2);
	move_man1 m1(clk, btn1, bomb_x, bomb_y, x2, y2, x1, y1);
	move_man2 m2(clk, btn2, bomb_x, bomb_y, x1, y1, x2, y2);
	assign bomb_on = (bomb_x[1:6]==(px/block_width)) && (bomb_y[1:6]==(py/block_width))
						||(bomb_x[7:12]==(px/block_width)) && (bomb_y[7:12]==(py/block_width))
						||(bomb_x[13:18]==(px/block_width)) && (bomb_y[13:18]==(py/block_width))
						||(bomb_x[19:24]==(px/block_width)) && (bomb_y[19:24]==(py/block_width))
						||(bomb_x[25:30]==(px/block_width)) && (bomb_y[25:30]==(py/block_width))
						||(bomb_x[31:36]==(px/block_width)) && (bomb_y[31:36]==(py/block_width));
	assign player1_on = (px/block_width==x1)&&(py/block_width==y1);
	assign player2_on = (px/block_width==x2)&&(py/block_width==y2);
	assign crack_num = crack_num1 | crack_num2; 
	winmap m4(clk, px, py, end_on);
	bombmask m7 (clk, px, py, bomb_col);
	man1mask m9 (clk, px, py, man1_col);
	man2mask m10(clk, px, py, man2_col);
	wallmask m11(clk, px, py, wall_col);
	bkgmask m12(clk, px, py, bkg_col);
	crackmask m13(clk, px, py, crack_col);
	crack_signal m3(clk, bomb_x, bomb_y, crack_num, px, py, crack_on);
	wire [1:2] flag;
	endflag m8(clk, crack_on, player1_on, player2_on, flag);
//	assign p1win = (crack_on && player2_on || flag);
//	assign p2win = (crack_on && player1_on || flag);
//rgb_reg settings	 
	reg win1, win2;
	reg [30:0] times;
	always @(posedge clk , posedge reset) begin
			if (reset) 
				rgb_reg <= BLACK; 
			else if (flag[2]) begin
				if (end_on) rgb_reg <= GREEN;
				else rgb_reg <= BLACK;
			end
			else if (flag[1]) begin
				if (end_on) rgb_reg <= BLUE;
				else rgb_reg <= BLACK;
			end
			else if (wall_on)
				rgb_reg <= wall_col;
			else if (bomb_on)
				rgb_reg <= bomb_col;
			else if (player1_on)
				rgb_reg <= man1_col;
			else if (player2_on)
				rgb_reg <= man2_col;
			else if (crack_on)
				rgb_reg <= crack_col;
			else 
				rgb_reg <= BLACK;
	end	
// output
	assign rgb = rgb_reg; 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:02 01/07/2014 
// Design Name: 
// Module Name:    endflag 
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
module endflag(
	input wire clk, crack_on, player1_on, player2_on,
	output wire [1:2] flag
);
	reg [1:2] out;
	initial out <= 0;
	assign flag = out;
	always @(posedge clk) begin
		if (crack_on) begin //当前像素点在爆炸范围
			if (player1_on) out[1] = 1; //当前像素点上有人物1
			if (player2_on) out[2] = 1; //当前像素点上有人物2
		end
	end
endmodule

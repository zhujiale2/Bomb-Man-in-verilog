`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:54 12/14/2013 
// Design Name: 
// Module Name:    pbdebounce 
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
module clk1ms(
	input wire clk,
	output wire clk_1ms
);
	reg [15:0]cnt;
	reg tmp;
	initial begin
		cnt <= 0;
		tmp <= 0;
	end
	always@(posedge clk) begin
		if (cnt<25000) begin
			cnt <= cnt+1;
		end
		else begin
			cnt <= 0;
			tmp = ~tmp;
		end
	end
	assign clk_1ms = tmp;
endmodule


module pbdebounce(
	input wire clk,
	input wire button,
	output reg pbreg
);
	reg [7:0] pbshift;
	wire clk_1ms;
	reg [15:0] tmp;
	initial begin
		tmp <= 0;
		pbreg <= 0;
		pbshift <= 0;
	end
	clk1ms m4(clk, clk_1ms);
	always@(posedge clk_1ms) begin
		pbshift<=pbshift<<1;//左移1位
		pbshift[0]<=button;
		if (pbshift==0) begin
			tmp <= 0;
			pbreg<=0;
		end
		else if (pbshift==8'b11111111) begin// pbshift八位全为1
			if (tmp<1) begin
				tmp <= tmp+1;
				pbreg<=1;
			end
			else begin
				pbreg <= 0;
			end
		end
	end
endmodule


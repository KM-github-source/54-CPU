module MULTU(
	input clk,
	input reset,
	input start,
	input [31:0] a,
	input [31:0] b,
	output [63:0] z
);
wire [64:0] TMP;
assign TMP = {1'b0,a}*{1'b0,b};
assign z = TMP[63:0];
endmodule
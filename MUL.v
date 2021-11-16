module MUL(
	input clk,
	input reset,
	input start,
	input [31:0] a,
	input [31:0] b,
	output [63:0] z
);
wire signed [31:0] a_tmp;
wire signed [31:0] b_tmp;
assign a_tmp = $signed(a);
assign b_tmp = $signed(b);
assign z = a_tmp*b_tmp;
endmodule
module HILOreg(
	input clk,
	input rst,
	input wena,
	input [31:0] data_in,
	output [31:0] data_out
);
reg [31:0] HILO_reg;
always @(negedge clk or posedge rst)
begin
	if(rst)
		HILO_reg <= 32'h0;
	else if(wena)
		HILO_reg <= data_in;
end
assign data_out = HILO_reg;
endmodule
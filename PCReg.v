module PCReg(
    input PC_clk,
    input PC_rst,
    input PC_ena,
    input PC_wena,
    input [31:0] PC_in,
    output [31:0] PC_out
);
reg [31:0] PCRegister;
always @(negedge PC_clk or posedge PC_rst) begin
    if (PC_ena) begin
        if (PC_rst) begin
            PCRegister <= 32'h00400000;
        end
        else if (PC_wena) begin
            PCRegister <= PC_in;
        end
    end
end
assign PC_out = PC_ena ? PCRegister : 32'bz;

endmodule
module RegFile(
    input RF_ena,
    input RF_rst,
    input RF_clk,
    input RF_W,
    input [4:0] Rdc,
    input [4:0] Rsc,
    input [4:0] Rtc,
    input [31:0] Rd,
    output [31:0] Rs,
    output [31:0] Rt
);
reg [31:0] array_reg [0:31];
assign Rs = RF_ena ? array_reg[Rsc] : 32'bz;
assign Rt = RF_ena ? array_reg[Rtc] : 32'bz;
always @ (negedge RF_clk or posedge RF_rst)
begin
    if(RF_rst) begin
        array_reg[0] <= 32'b0;
        array_reg[1] <= 32'b0;
        array_reg[2] <= 32'b0;
        array_reg[3] <= 32'b0;
        array_reg[4] <= 32'b0;
        array_reg[5] <= 32'b0;
        array_reg[6] <= 32'b0;
        array_reg[7] <= 32'b0;
        array_reg[8] <= 32'b0;
        array_reg[9] <= 32'b0;
        array_reg[10] <= 32'b0;
        array_reg[11] <= 32'b0;
        array_reg[12] <= 32'b0;
        array_reg[13] <= 32'b0;
        array_reg[14] <= 32'b0;
        array_reg[15] <= 32'b0;
        array_reg[16] <= 32'b0;
        array_reg[17] <= 32'b0;
        array_reg[18] <= 32'b0;
        array_reg[19] <= 32'b0;
        array_reg[20] <= 32'b0;
        array_reg[21] <= 32'b0;
        array_reg[22] <= 32'b0;
        array_reg[23] <= 32'b0;
        array_reg[24] <= 32'b0;
        array_reg[25] <= 32'b0;
        array_reg[26] <= 32'b0;
        array_reg[27] <= 32'b0;
        array_reg[28] <= 32'b0;
        array_reg[29] <= 32'b0;
        array_reg[30] <= 32'b0;
        array_reg[31] <= 32'b0;
    end
    else if(RF_W && RF_ena && (Rdc != 5'b0)) begin
        array_reg[Rdc] <= Rd;
    end
end

endmodule
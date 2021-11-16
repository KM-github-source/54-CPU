module CP0(
	input clk,
	input rst,
	input mfc0, //CPU instruction is Mfc0
	input mtc0, //CPU instruction is Mtc0
	input [31:0] pc,
	input [4:0] addr, //Specifies CP0 register
	input [31:0] data, //Data from GP register to replace CP0 register
	input exception, 
	input eret, //instruction is ERET(Exception Return)
	input [4:0] cause,
	output [31:0] rdata, //Data from CP0 register for GP register
	output [31:0] status,
	output [31:0] exc_addr //Address for PC output [31:0]exc_addr // Address for PC at the beginning of an exception
);
reg [31:0] CP0_reg [0:31];
assign status = CP0_reg[12];
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		CP0_reg[0] <= 32'b0;
		CP0_reg[1] <= 32'b0;
		CP0_reg[2] <= 32'b0;
		CP0_reg[3] <= 32'b0;
		CP0_reg[4] <= 32'b0;
		CP0_reg[5] <= 32'b0;
		CP0_reg[6] <= 32'b0;
		CP0_reg[7] <= 32'b0;
		CP0_reg[8] <= 32'b0;
		CP0_reg[9] <= 32'b0;
		CP0_reg[10] <= 32'b0;
		CP0_reg[11] <= 32'b0;
		CP0_reg[12] <= 32'b0;
		CP0_reg[13] <= 32'b0;
		CP0_reg[14] <= 32'b0;
		CP0_reg[15] <= 32'b0;
		CP0_reg[16] <= 32'b0;
		CP0_reg[17] <= 32'b0;
		CP0_reg[18] <= 32'b0;
		CP0_reg[19] <= 32'b0;
		CP0_reg[20] <= 32'b0;
		CP0_reg[21] <= 32'b0;
		CP0_reg[22] <= 32'b0;
		CP0_reg[23] <= 32'b0;
		CP0_reg[24] <= 32'b0;
		CP0_reg[25] <= 32'b0;
		CP0_reg[26] <= 32'b0;
		CP0_reg[27] <= 32'b0;
		CP0_reg[28] <= 32'b0;
		CP0_reg[29] <= 32'b0;
		CP0_reg[30] <= 32'b0;
		CP0_reg[31] <= 32'b0;
	end
	else
	begin
		if(mtc0)
		begin
			CP0_reg[addr] <= data;
		end
		else if(exception) //SYSCALL,BREAK,TEQ
		begin
			CP0_reg[12] <= (status << 5); //status
			CP0_reg[13] <= {24'b0, cause, 2'b0}; //cause
			CP0_reg[14] <= pc; //EPC
		end
		else if(eret)
		begin
			CP0_reg[12] <= (status >> 5); //status
		end
	end
end
assign exc_addr = eret ? (CP0_reg[14] + 4) : 32'h00400004;
assign rdata = mfc0 ? CP0_reg[addr] : 32'hzzzzzzzz;
endmodule
module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
);
    wire [31:0] IM_instr;
    wire [31:0] Rt;
    wire [31:0] ALU_R;
    wire CS;
    wire DM_W;
    wire DM_R;
    wire [31:0] DM_addr;
    wire [31:0] IM_addr;
    wire [31:0] DM_rdata;
	wire [1:0] Bit_S;

    assign inst=IM_instr;
    assign DM_addr = (ALU_R - 32'h10010000);
    assign IM_addr = (pc- 32'h00400000);

    imem instr_mem(
        .a(IM_addr[12:2]),
        .spo(IM_instr)
    );

    CPU_54 sccpu(
        .CPU_clk(clk_in),
        .CPU_rst(reset),
        .IM_instr(IM_instr),
        .DM_rdata(DM_rdata),
        .DM_CS(CS),
        .DM_W(DM_W),
        .DM_R(DM_R),
        .Rt_to_DM(Rt),
        .ALUR_to_DM(ALU_R),
        .PC_to_IM(pc),
        .Bit_S(Bit_S)
    );

    DMEM DMEM_uut(
        .DM_clk(clk_in),
        .CS(CS),
        .DM_R(DM_R),
        .DM_W(DM_W),
        .Addr(DM_addr[10:0]),
        .Data_In(Rt),
        .Bit_S(Bit_S),
        .Data_Out(DM_rdata)
     );   
    
endmodule
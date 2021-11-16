module CPU_54(
    input CPU_clk,
    input CPU_rst,
    input [31:0] IM_instr,
    input [31:0] DM_rdata,
    output DM_CS,
    output DM_W,
    output DM_R,
    output [31:0] Rt_to_DM,
    output [31:0] ALUR_to_DM,
    output [31:0] PC_to_IM,
    output [1:0] Bit_S
    //output [2:0]DM_R_select //DM_R 8 bit 16 bit 32 bit
);
//signals of instructions
//instruction 1-17
    wire [31:0] Rs;
    wire add_, addu_, sub_, subu_, and_, or_, xor_, nor_;
    wire slt_, sltu_, sll_, srl_, sra_, sllv_, srlv_, srav_, jr_;
    assign add_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_000);
    assign addu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_001);
    assign sub_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_010);
    assign subu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_011);
    assign and_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_100);
    assign or_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_101);
    assign xor_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_110);
    assign nor_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_111);
    assign slt_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_010);
    assign sltu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_011);
    assign sll_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_000);
    assign srl_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_010);
    assign sra_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_011);
    assign sllv_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_100);
    assign srlv_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_110);
    assign srav_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_111);
    assign jr_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_000);
//instruction 18-29
    wire addi_, addiu_, andi_, ori_, xori_, lw_, sw_, beq_, bne_;
    wire slti_, sltiu_, lui_;
    assign addi_ = (IM_instr[31:26] == 6'b001_000);
    assign addiu_ = (IM_instr[31:26] == 6'b001_001);
    assign andi_ = (IM_instr[31:26] == 6'b001_100);
    assign ori_ = (IM_instr[31:26] == 6'b001_101);
    assign xori_ = (IM_instr[31:26] == 6'b001_110);
    assign lw_ = (IM_instr[31:26] == 6'b100_011);
    assign sw_ = (IM_instr[31:26] == 6'b101_011);
    assign beq_ = (IM_instr[31:26] == 6'b000_100);
    assign bne_ = (IM_instr[31:26] == 6'b000_101);
    assign slti_ = (IM_instr[31:26] == 6'b001_010);
    assign sltiu_ = (IM_instr[31:26] == 6'b001_011);
    assign lui_ = (IM_instr[31:26] == 6'b001_111);
//instruction 30-31
    wire j_, jal_;
    assign j_ = (IM_instr[31:26] == 6'b000_010);
    assign jal_ = (IM_instr[31:26] == 6'b000_011);
//instruction 32-54
    wire clz_, divu_, div_, multu_, mul_;
    wire lb_, lbu_, lh_, lhu_;
    wire sb_, sh_;
    wire mfhi_, mflo_;
    wire mthi_, mtlo_;
    wire bgez_, jalr_;
    wire break_, syscall_, teq_, eret_, mfc0_, mtc0_; //CP0

    assign clz_ = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b100_000);
    assign divu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_011);
    assign div_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_010);
    assign multu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_001);
    assign mul_ = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b000_010);

    assign lb_ = (IM_instr[31:26] == 6'b100_000);
    assign lbu_ = (IM_instr[31:26] == 6'b100_100);
    assign lh_ = (IM_instr[31:26] == 6'b100_001);
    assign lhu_ = (IM_instr[31:26] == 6'b100_101);

    assign sb_ = (IM_instr[31:26] == 6'b101_000);
    assign sh_ = (IM_instr[31:26] == 6'b101_001);

    assign mfhi_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_000);
    assign mflo_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_010);

    assign mthi_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_001);
    assign mtlo_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_011);

    assign bgez_ = (IM_instr[31:26] == 6'b000_001);
    assign jalr_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_001);

    assign break_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_101);
    assign syscall_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_100);
    assign teq_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b110_100);
    assign eret_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[5:0] == 6'b011_000);
    assign mfc0_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[25:21] == 5'b00000);
    assign mtc0_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[25:21] == 5'b00100);

    wire [31:0] CLZ_tmp;
    assign CLZ_tmp = (Rs[31]==1? 32'h00000000:Rs[30]==1? 32'h00000001:Rs[29]==1? 32'h00000002:Rs[28]==1? 32'h00000003:Rs[27]==1? 32'h00000004:
                     Rs[26]==1? 32'h00000005:Rs[25]==1? 32'h00000006:Rs[24]==1? 32'h00000007:Rs[23]==1? 32'h00000008:Rs[22]==1? 32'h00000009:
                     Rs[21]==1? 32'h0000000a:Rs[20]==1? 32'h0000000b:Rs[19]==1? 32'h0000000c:Rs[18]==1? 32'h0000000d:Rs[17]==1? 32'h0000000e:
                     Rs[16]==1? 32'h0000000f:Rs[15]==1? 32'h00000010:Rs[14]==1? 32'h00000011:Rs[13]==1? 32'h00000012:Rs[12]==1? 32'h00000013:
                     Rs[11]==1? 32'h00000014:Rs[10]==1? 32'h00000015:Rs[9]==1? 32'h00000016:Rs[8]==1? 32'h00000017:Rs[7]==1? 32'h00000018:
                     Rs[6]==1? 32'h00000019:Rs[5]==1? 32'h0000001a:Rs[4]==1? 32'h0000001b:Rs[3]==1? 32'h0000001c:Rs[2]==1? 32'h0000001d:
                     Rs[1]==1? 32'h0000001e:Rs[0]==1? 32'h0000001f:32'h00000020);

//control signals
    //wire IM_R;
    wire [4:0] Rdc;
    wire [4:0] Rsc;
    wire [4:0] Rtc;
    wire [4:0] ALUC;
    wire RF_W;

    wire M1_1;
    wire M1_2;
    wire M2;

    wire M3_1;
    wire M3_2;
    wire M3_3;
    wire M3_4;
    wire M3_5;
    wire M3_6;
    wire M3_7;

    wire M4_1;
    wire M4_2;
    wire M5_1;
    wire M5_2;
    wire M6_1;
    wire M6_2;

    wire M7_1;
    wire M7_2;
    wire M7_3;
    wire M7_4;

    wire M8_1;
    wire M8_2;
    wire M8_3;
    wire M8_4;

//transport interface
    //DMEM
    wire [31:0] DM_DATA;

    //CP0
    wire exception;
    wire [4:0] cause;
    wire [31:0] CP0_wdata;
    wire [31:0] CP0_rdata;
    wire [31:0] status;
    wire [31:0] exc_addr;

    //HILO
    wire HI_ctrl;
    wire LO_ctrl;
    wire [31:0] HI_out;
    wire [31:0] HI_in;
    wire [31:0] LO_out;
    wire [31:0] LO_in;


    wire busy = 0;
    //DIVU
    wire [31:0] divu_q;
    wire [31:0] divu_r;
    wire divu_busy;
    wire [31:0] divu_q_tmp;
    wire [31:0] divu_r_tmp;

    //DIV
    wire [31:0] div_q;
    wire [31:0] div_r;
    wire div_busy;
    wire [31:0] div_q_tmp;
    wire [31:0] div_r_tmp;

    //MULTU
    wire [63:0] multu_r;
    //MUL
    wire [63:0] mul_r;

    wire [31:0] ALU_out;
    wire [31:0] NPC;
    wire [31:0] Rt;
    wire [31:0] PC_form_PCReg;

    wire [31:0] Ext5_out;
    wire [31:0] Ext18_out;
    wire [31:0] Ext16_out;
    wire [31:0] Ext16_sign;
    wire [31:0] Ext16_unsign;
    wire Ext16_sign_Judge;

    //wire [31:0] MUX1_1_out;
    //wire [31:0] MUX1_2_out;
    wire [31:0] MUX1_out;
    wire [31:0] MUX2_out;
    wire [31:0] MUX3_out;

    //wire [31:0] MUX4_1_out;
    //wire [31:0] MUX4_2_out;
    //wire [31:0] MUX4_out;

    //wire [31:0] MUX5_1_out;
    //wire [31:0] MUX5_2_out;
    wire [31:0] MUX5_out;

    //wire [31:0] MUX6_1_out;
    //wire [31:0] MUX6_2_out;
    wire [31:0] MUX6_out;

    //wire [31:0] MUX7_out;
    //wire [31:0] MUX8_out;

    wire Zero;
    wire Carry;
    wire Negative;
    wire OverFlow;
//assign
    assign PC_to_IM = PC_form_PCReg;
    //CP0
    assign CP0_wdata = Rt;
    assign exception = (break_ || syscall_ || (teq_ && Zero));
    assign cause = break_ ? 5'b01001 : (syscall_ ? 5'b01000 : (teq_ ? 5'b01101 : 5'b00000));

    //DIVU DIV
    //assign divu_q = divu_busy ? 32'bz : divu_q_tmp;
    //assign divu_r = divu_busy ? 32'bz : divu_r_tmp;
    //assign div_q = div_busy ? 32'bz : div_q_tmp;
    //assign div_r = div_busy ? 32'bz : div_r_tmp;

    assign busy = (divu_busy || div_busy);

    //DMEM
    assign DM_CS = (lw_ || lb_ || lbu_ || lh_ || lhu_ || sw_ || sb_ || sh_);
    assign DM_W = (sw_ || sb_ || sh_);
    assign DM_R = (lw_ || lb_ || lbu_ || lh_ || lhu_);

    //bit select of DM_in
    //assign Rt_to_DM = sb_ ? {24'b0,Rt[7:0]} : (sh_ ? {16'b0,Rt[15:0]} : Rt);
    assign Rt_to_DM = Rt;

    assign ALUR_to_DM = ALU_out;
    assign Rsc = IM_instr[25:21];
    assign Rtc = IM_instr[20:16];
    assign RF_W = !(sw_ || sb_ || sh_ || jr_ || j_ || beq_ || bne_ || bgez_ || mtc0_ || eret_ || syscall_ || teq_ || break_ || divu_ || div_ || multu_ || mthi_ || mtlo_);

    assign M1_1 = (!j_ && !jal_ && !jalr_);
    assign M1_2 = (jr_ || jalr_);
    assign M2 = ((beq_ && Zero) || (bne_ && !Zero) || (bgez_ && (Rs[31]==1'b0)));

    //assign M3 = !lw_;
    assign M3_1 = (lw_ || lb_ || lbu_ || lh_ || lhu_);
    assign M3_2 = mfc0_;
    assign M3_3 = mflo_;
    assign M3_4 = mfhi_;
    assign M3_5 = mul_;
    assign M3_6 = clz_;
    //assign M3_7 = multu_;

    assign M4_1 = (addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || slti_ || sltiu_ || lui_ || lb_ || lbu_ || lh_ || lhu_ || mfc0_);
    assign M4_2 = jal_;
    assign M5_1 = (sll_ || srl_ || sra_);
    assign M5_2 = (jal_ || jalr_);
    assign M6_1 = (addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || sw_ || slti_ || sltiu_ || lui_ || lb_ || lbu_ || lh_ || lhu_ || sb_ || sh_);
    assign M6_2 = (jal_ || jalr_);

    assign M7_1 = mtlo_;
    assign M7_2 = divu_;
    assign M7_3 = div_;
    assign M7_4 = multu_;

    assign M8_1 = mthi_;
    assign M8_2 = divu_;
    assign M8_3 = div_;
    assign M8_4 = multu_;

    //assign MUX4_1_out = M4_1 ? IM_instr[20:16] : IM_instr[15:11];
    //assign MUX4_2_out = M4_2 ? 5'd31 : MUX4_1_out;
    assign Rdc = M4_2 ? 5'd31 : (M4_1 ? IM_instr[20:16] : IM_instr[15:11]);
    //assign Rdc = MUX4_out;
    
    //bit select of DM_out
    assign DM_DATA = (lb_ ? {{24{DM_rdata[31]}},DM_rdata[31:24]} : (lbu_ ? {24'b0,DM_rdata[31:24]} : (lh_ ? {{16{DM_rdata[31]}},DM_rdata[31:16]} : (lhu_ ? {16'b0,DM_rdata[31:16]} : DM_rdata))));
    //assign DM_DATA = (lb_ ? {{24{DM_rdata[7]}},DM_rdata[7:0]} : (lbu_ ? {24'b0,DM_rdata[7:0]} : (lh_ ? {{16{DM_rdata[15]}},DM_rdata[15:0]} : (lhu_ ? {16'b0,DM_rdata[15:0]} : DM_rdata))));
    assign Bit_S = (sb_ ? 0 : (sh_ ? 1 : 2));

    assign ALUC[4] = lui_;
    assign ALUC[3] = slt_ || sltu_ || slti_ || sltiu_ || sll_ || srl_ || sra_ || sllv_ || srlv_ || srav_;
    assign ALUC[2] = and_ || andi_ || or_ || ori_ || xor_ || xori_ || nor_ || sra_ || sllv_ || srlv_ || srav_;
    assign ALUC[1] = sub_ || subu_ || beq_ || bne_ || bgez_ || teq_ || xor_ || xori_ || nor_ || sll_ || srl_ || srlv_ || srav_;
    assign ALUC[0] = addu_ || addiu_ || subu_ || beq_ || bne_ || bgez_ || teq_ || or_ || ori_ || nor_ || sltu_ || sltiu_ || srl_ || sllv_ || srav_ || jal_ || jalr_;

    assign NPC = PC_form_PCReg + 4;

    assign Ext5_out = {27'b0, IM_instr[10:6]};
    assign Ext18_out = {{14{IM_instr[15]}}, {IM_instr[15:0], 2'b0}};
    assign Ext16_sign_Judge = (sw_ || sb_ || sh_ || lw_ || lb_ || lbu_ || lh_ || lhu_ || addi_ || addiu_ || slti_ || sltiu_);
    assign Ext16_sign = {{16{IM_instr[15]}}, IM_instr[15:0]};
    assign Ext16_unsign = {16'b0, IM_instr[15:0]};
    assign Ext16_out = Ext16_sign_Judge ? Ext16_sign : Ext16_unsign;

    //assign MUX1_1_out = M1_1 ? MUX2_out : {PC_form_PCReg[31:28], IM_instr[25:0], 2'b0};
    //assign MUX1_2_out = M1_2 ? Rs : MUX1_1_out;
    assign MUX2_out = M2 ? (NPC + Ext18_out) : NPC;
    assign MUX1_out = ((eret_ || exception) ? exc_addr :(M1_2 ? Rs : (M1_1 ? MUX2_out : {PC_form_PCReg[31:28], IM_instr[25:0], 2'b0})));

    //待调整
    //assign MUX3_out = M3 ? ALU_out : DM_rdata;
    assign MUX3_out = M3_1 ? DM_DATA : (M3_2 ? CP0_rdata : (M3_3 ? LO_out : (M3_4 ? HI_out : (M3_5 ? mul_r[31:0] : (M3_6 ? CLZ_tmp : ALU_out)))));

    //assign MUX5_1_out = M5_1 ? Ext5_out : Rs;
    //assign MUX5_2_out = M5_2 ? PC_form_PCReg : MUX5_1_out;
    assign MUX5_out = M5_2 ? PC_form_PCReg : (M5_1 ? Ext5_out : Rs);

    //assign MUX6_1_out = M6_1 ? Ext16_out : Rt;
    //assign MUX6_2_out = M6_2 ? 32'd4 : MUX6_1_out;
    assign MUX6_out = M6_2 ? 32'd4 : (M6_1 ? Ext16_out : Rt);

    assign LO_ctrl = (divu_ || div_ || mtlo_ || multu_);
    assign HI_ctrl = (divu_ || div_ || mthi_ || multu_);
    //assign LO_ctrl = (divu_ || div_ || mtlo_ || multu_ || mul_);
    //assign HI_ctrl = (divu_ || div_ || mthi_ || multu_ || mul_);

    assign LO_in = M7_1 ? Rs : (M7_2 ? divu_q : (M7_3 ? div_q : (M7_4 ? multu_r[31:0] : 0)));
    assign HI_in = M8_1 ? Rs : (M8_2 ? divu_r : (M8_3 ? div_r : (M8_4 ? multu_r[63:32] : 0)));
    //assign LO_in = M7_1 ? Rs : (M7_2 ? divu_q : (M7_3 ? div_q : (M7_4 ? multu_r[31:0] : mul_r[31:0])));
    //assign HI_in = M8_1 ? Rs : (M8_2 ? divu_r : (M8_3 ? div_r : (M8_4 ? multu_r[63:32] : mul_r[63:32])));

    DIVU divu(
        .dividend(Rs),
        .divisor(Rt),
        .start(divu_),
        .clock(CPU_clk),
        .reset(CPU_rst),
        .q(divu_q),
        .r(divu_r),
        .busy(divu_busy)
    );

    DIV div(
        .dividend(Rs),
        .divisor(Rt),
        .start(div_),
        .clock(CPU_clk),
        .reset(CPU_rst),
        .q(div_q),
        .r(div_r),
        .busy(div_busy)
    );

    MULTU multu(
        .clk(CPU_clk),
        .reset(CPU_rst),
        .start(multu_),
        .a(Rs),
        .b(Rt),
        .z(multu_r)
    );

    MUL mul(
        .clk(CPU_clk),
        .reset(CPU_rst),
        .start(mul_),
        .a(Rs),
        .b(Rt),
        .z(mul_r)
    );

    HILOreg HI(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .wena(HI_ctrl),
        .data_in(HI_in),
        .data_out(HI_out)
    );

    HILOreg LO(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .wena(LO_ctrl),
        .data_in(LO_in),
        .data_out(LO_out)
    );

    CP0 cp0(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .mfc0(mfc0_),
        .mtc0(mtc0_),
        .pc(PC_form_PCReg),
        .addr(IM_instr[15:11]),
        .data(CP0_wdata),
        .exception(exception),
        .eret(eret_),
        .cause(cause),
        .rdata(CP0_rdata),
        .status(status),
        .exc_addr(exc_addr)
    );

    PCReg PCReg_uut(
        .PC_clk(CPU_clk),
        .PC_rst(CPU_rst),
        .PC_ena(1),
        .PC_wena(!busy),
        .PC_in(MUX1_out),
        .PC_out(PC_form_PCReg)
    );

    RegFile cpu_ref(
        .RF_clk(CPU_clk),
        .RF_rst(CPU_rst),
        .RF_ena(1),
        .RF_W(RF_W),
        .Rdc(Rdc),
        .Rsc(Rsc),
        .Rtc(Rtc),
        .Rd(MUX3_out),
        .Rs(Rs),
        .Rt(Rt)
    );

    ALU ALU_uut(
        .A(MUX5_out),
        .B(MUX6_out),
        .ALUC(ALUC),
        .Result(ALU_out),
        .Zero(Zero),
        .Carry(Carry),
        .Negative(Negative),
        .OverFlow(OverFlow)
    );

endmodule
`timescale 1ns / 1ps
module cpu_tb;
    reg clk, rst;
    wire [31:0] inst, pc;
    //reg [31:0] cnt;
    //wire [10:0] dma, ima;
    //integer file_open;
    integer counter = 0;
    initial begin
        //$readmemh("C:/CPU_54_ME/52_bgez_hex.txt", sc.IMEM_uut.IM_Reg);
        //file_open = $fopen("single_result.txt");
        clk = 1'b1;
        rst = 1'b1;
        #10;
        rst = 1'b0;
    end

    always begin
        #20 clk = ~clk;
        if(clk == 1'b0) begin
            if(counter == 10000) begin
                //$fclose(file_open);
            end
            else begin
                counter = counter + 1;
                //$fdisplay(file_open, "pc: %h", sc.sccpu.PCReg_uut.PC_out);
                //$fdisplay(file_open, "instr: %h", sc.IM_instr);
                //$fdisplay(file_open, "regfile0: %h", sc.sccpu.cpu_ref.array_reg[0]);
                //$fdisplay(file_open, "regfile1: %h", sc.sccpu.cpu_ref.array_reg[1]);
                //$fdisplay(file_open, "regfile2: %h", sc.sccpu.cpu_ref.array_reg[2]);
                //$fdisplay(file_open, "regfile3: %h", sc.sccpu.cpu_ref.array_reg[3]);
                //$fdisplay(file_open, "regfile4: %h", sc.sccpu.cpu_ref.array_reg[4]);
                //$fdisplay(file_open, "regfile5: %h", sc.sccpu.cpu_ref.array_reg[5]);
                //$fdisplay(file_open, "regfile6: %h", sc.sccpu.cpu_ref.array_reg[6]);
                //$fdisplay(file_open, "regfile7: %h", sc.sccpu.cpu_ref.array_reg[7]);
                //$fdisplay(file_open, "regfile8: %h", sc.sccpu.cpu_ref.array_reg[8]);
                //$fdisplay(file_open, "regfile9: %h", sc.sccpu.cpu_ref.array_reg[9]);
                //$fdisplay(file_open, "regfile10: %h", sc.sccpu.cpu_ref.array_reg[10]);
                //$fdisplay(file_open, "regfile11: %h", sc.sccpu.cpu_ref.array_reg[11]);
                //$fdisplay(file_open, "regfile12: %h", sc.sccpu.cpu_ref.array_reg[12]);
                //$fdisplay(file_open, "regfile13: %h", sc.sccpu.cpu_ref.array_reg[13]);
                //$fdisplay(file_open, "regfile14: %h", sc.sccpu.cpu_ref.array_reg[14]);
                //$fdisplay(file_open, "regfile15: %h", sc.sccpu.cpu_ref.array_reg[15]);
                //$fdisplay(file_open, "regfile16: %h", sc.sccpu.cpu_ref.array_reg[16]);
                //$fdisplay(file_open, "regfile17: %h", sc.sccpu.cpu_ref.array_reg[17]);
                //$fdisplay(file_open, "regfile18: %h", sc.sccpu.cpu_ref.array_reg[18]);
                //$fdisplay(file_open, "regfile19: %h", sc.sccpu.cpu_ref.array_reg[19]);
                //$fdisplay(file_open, "regfile20: %h", sc.sccpu.cpu_ref.array_reg[20]);
                //$fdisplay(file_open, "regfile21: %h", sc.sccpu.cpu_ref.array_reg[21]);
                //$fdisplay(file_open, "regfile22: %h", sc.sccpu.cpu_ref.array_reg[22]);
                //$fdisplay(file_open, "regfile23: %h", sc.sccpu.cpu_ref.array_reg[23]);
                //$fdisplay(file_open, "regfile24: %h", sc.sccpu.cpu_ref.array_reg[24]);
                //$fdisplay(file_open, "regfile25: %h", sc.sccpu.cpu_ref.array_reg[25]);
                //$fdisplay(file_open, "regfile26: %h", sc.sccpu.cpu_ref.array_reg[26]);
                //$fdisplay(file_open, "regfile27: %h", sc.sccpu.cpu_ref.array_reg[27]);
                //$fdisplay(file_open, "regfile28: %h", sc.sccpu.cpu_ref.array_reg[28]);
                //$fdisplay(file_open, "regfile29: %h", sc.sccpu.cpu_ref.array_reg[29]);
                //$fdisplay(file_open, "regfile30: %h", sc.sccpu.cpu_ref.array_reg[30]);
                //$fdisplay(file_open, "regfile31: %h", sc.sccpu.cpu_ref.array_reg[31]);
            end
        end
    end
    sccomp_dataflow sc(
        .clk_in(clk),
        .reset(rst),
        .inst(inst),
        .pc(pc)
        //.dm_addr(dma),
        //.im_addr(ima)
    );

endmodule
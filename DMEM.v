module DMEM(
    input DM_clk,
    input CS,
    input DM_R,
    input DM_W,
    input [10:0] Addr,
    input [31:0] Data_In,
    input [1:0] Bit_S, //sb : 0, sh : 1, sw : 2
    output [31:0] Data_Out
);

//reg [31:0] MEM [0:2047];
reg [7:0] MEM [0:2047];
assign Data_Out = CS ? (DM_R ? ({MEM[Addr],MEM[Addr+1],MEM[Addr+2],MEM[Addr+3]}) : 32'b0) : 32'bz;
always @ (negedge DM_clk or posedge CS)
begin
    if(CS && DM_W)
    begin
        //MEM[Addr] <= Data_In;
        case(Bit_S)
        1'd0: MEM[Addr] <= Data_In[7:0];
        1'd1: 
        begin
            MEM[Addr] <= Data_In[15:8];
            MEM[Addr+1] <= Data_In[7:0];
        end
        2: 
        begin
            MEM[Addr] <= Data_In[31:24];
            MEM[Addr+1] <= Data_In[23:16];
            MEM[Addr+2] <= Data_In[15:8];
            MEM[Addr+3] <= Data_In[7:0];
        end
        endcase
    end
end
endmodule
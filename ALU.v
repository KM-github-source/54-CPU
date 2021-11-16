module ALU(
    input [31:0] A,
    input [31:0] B,
    input [4:0] ALUC,
    output [31:0] Result,
    output Zero,
    output Carry,
    output Negative,
    output OverFlow);

    parameter ADD = 5'b00000;
    parameter ADDU = 5'b00001;
    parameter SUB = 5'b00010;
    parameter SUBU = 5'b00011;
    parameter AND = 5'b00100;
    parameter OR = 5'b00101;
    parameter XOR = 5'b00110;
    parameter NOR = 5'b00111;

    parameter SLT = 5'b01000;
    parameter SLTU = 5'b01001;

    parameter SLL = 5'b01010;
    parameter SRL = 5'b01011;
    parameter SRA = 5'b01100;
    parameter SLLV = 5'b01101;
    parameter SRLV = 5'b01110;
    parameter SRAV = 5'b01111;

    parameter LUI = 5'b10000;

    wire signed [31:0] signed_A, signed_B;
    reg [32:0] R;
    assign signed_A = A;
    assign signed_B = B;
    always @ (*) begin
        case(ALUC)
            ADD:    R <= signed_A + signed_B;
            ADDU:   R <= A + B;
            SUB:    R <= signed_A - signed_B;
            SUBU:   R <= A - B;
            AND:    R <= A & B;
            OR:     R <= A | B;
            XOR:    R <= A ^ B;
            NOR:    R <= ~(A | B);

            SLT:    R <= (signed_A < signed_B) ? 1 : 0;
            SLTU:   R <= (A < B) ? 1 : 0;

            SLL:    R <= B << A;
            SRL:    R <= B >> A;
            SRA:    R <= signed_B >>> signed_A;
            SLLV:   R <= B << A[4:0];
            SRLV:   R <= B >> A[4:0];
            SRAV:   R <= signed_B >>> signed_A[4:0];

            LUI:    R <= {B[15:0], 16'b0};
        endcase
    end
    assign Result = R[31:0]; 
    assign Zero = (R == 32'b0) ? 1 : 0;
    assign Carry = R[32];
    assign Negative = (ALUC == SLT || ALUC == SLTU) ? R[0] : R[31];
    assign OverFlow = R[32];
endmodule
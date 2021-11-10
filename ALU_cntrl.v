
module alucontrol (
    input [1:0] ALUOp,
    input [5:0] Function,
    output reg [3:0] ALUControl
    );

wire [7:0] ALUControlIn;

assign ALUControlIn = {ALUOp,Function};

    always @(ALUControlIn)
    begin
        casex (ALUControlIn)
            8'b10100000: ALUControl=4'b0000;    // 0010;    Add
            8'b10100010: ALUControl=4'b0001;    // 0110;    Subtracr
            8'b10100100: ALUControl=4'b0010;    // 0000;    AND
            8'b10100101: ALUControl=4'b0011;    // 0001;    OR
            8'b10101010: ALUControl=4'b0100;    //          NAND
            8'b10101011: ALUControl=4'b0101;    // 0111;    NOR
            8'b10101111: ALUControl=4'b1000;    //          SLT
            8'b01xxxxxx: ALUControl=4'b0001;    //          BEQ/BNEQ
            8'b00xxxxxx: ALUControl=4'b0000;    //          Jump
            default: ALUControl=4'b0010;
        endcase
    end
endmodule
module ControlUnit (
    output reg [1:0] ALUOp,
    output reg RegDst, MemtoReg, Jump, Branch, MemRead, MemWrite, ALUSrc, RegWrite, Branchn,
    input [5:0] Opcode,
    input clk, reset
);

    always @(posedge clk)
    begin
        if (reset) begin
            RegDst = 0;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            Branchn = 0;
            Jump = 0;
            ALUOp = 2'b00;
        end
        case (Opcode)
        6'b000000   : begin             //R-Type
            RegDst = 1;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            Branchn = 0;
            Jump = 0;
            ALUOp = 2'b00;
        end
        6'b000100   : begin             // Branch Equal 
            RegDst = 1'bx;
            ALUSrc = 0;
            MemtoReg = 1'bx;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 1;
            Branchn = 0;
            Jump = 0;
            ALUOp = 2'b01;
        end
        6'b000110   : begin             // Branch Not Equal
            RegDst = 0;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            Branchn = 1;
            Jump = 0;
            ALUOp = 2'b01;
        end
        6'b100011   : begin             // Load Word
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            Branchn = 1;
            Jump = 0;

            ALUOp = 2'b00;
        end
        6'b101011   : begin             // Store Word
            RegDst = 1'bx;
            ALUSrc = 1;
            MemtoReg = 1'bx;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            Branchn = 1;
            Jump = 0;
            ALUOp = 2'b00;
        end
        6'b100110   : begin             // Jump
            RegDst = 1'bx;
            ALUSrc = 1'bx;
            MemtoReg = 1'bx;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1'bx;
            Branchn = 0;
            Jump = 1;
            ALUOp = 2'b00;
        end
        6'b101000   : begin             // Add Immediate
            RegDst = 0;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            Branchn = 0;
            Jump = 0;
            ALUOp = 2'b00;
        end
        default: begin
            RegDst = 1;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            Branchn = 0;
            Jump = 0;
            ALUOp = 2'b00;
        end 
        endcase
    end
    
    
endmodule

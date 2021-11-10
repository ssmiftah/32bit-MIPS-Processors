`include "PC.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "ALU.v"
`include "ALU_cntrl.v"
`include "Register.v"
`include "Ins_mem.v"

module MIPS32_Processor (
    input clk, rst,
    output [31:0] result, pc_cnt_out
);

    wire RegDst, MemtoReg, Jump, Branch, MemRead, MemWrite, ALUSrc, RegWrite, Branchn, zero_flag, carry_flag, AndG1, AndG2, XORG1;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire [4:0] reg_r_addr_1, reg_r_addr_2, reg_w_dest, reg_w_dest_mux;
    wire [5:0] Opcode, Function;
    wire [15:0] immediate;
    wire [31:0] instr, reg_w_data, reg_r_data_1, reg_r_data_2, A, B, ALU_out, Dmem_out, Branch_addr;

    
    PC pc(clk, rst, Jump, pc_cnt_in, pc_cnt_out);        
    Ins_mem Imem(pc_cnt_out, instr);    // input from pc outputs an instruction


    // 32-bit instruction assignment

    assign Opcode = instr[31:26];
    assign reg_r_addr_1 = instr[25:21];
    assign reg_r_addr_2 = instr[20:16];
    assign reg_w_dest_mux_in = instr[15:11];
    assign immediate = instr[15:0]; 
    assign Function = instr[5:0];

    // Initializing Control Unit

    ControlUnit cu(ALUOp, RegDst, MemtoReg, Jump, Branch, MemRead, MemWrite, ALUSrc, RegWrite, Branchn, Opcode, clk, rst);

    // Initializing Register
    
    assign reg_w_dest = (RegDst)? reg_r_addr_2 : reg_w_dest_mux_in;     // Mux For immediate
    Register regis(clk, rst, reg_w_en, reg_w_dest, reg_w_data, reg_r_addr_1, reg_r_addr_2, reg_r_data_1, reg_r_data_2);
    
    // Initializing ALU Control

    ALU_cntrl aluCtrl(ALUOp, Function, ALUControl);

    // Initializing ALU

    assign A = reg_r_data_1;
    assign B = (ALUSrc)? immediate : reg_r_data_2;
    ALU alu(A, B, ALUControl, zero_flag, carry_flag, ALU_out);

    // Initializing Data Memory

    DataMemory Dmem(ALU_out, immediate, MemWrite, MemRead, clk, Dmem_out);
    assign reg_w_data = (MemtoReg)? Dmem_out : ALU_out;

    // Jump and Branch Sequence

    assign AndG1 = zero_flag & Branch;
    assign AndG2 = ~zero_flag & Branchn;
    assign XORG1 = AndG1 | AndG2;
    assign Branch_addr = pc_cnt_out + immediate;

    assign pc_cnt_in = (XORG1)? Branch_addr : pc_cnt_out;
    assign pc_cnt_in = (Jump)? instr[25:0] : Branch_addr;

    
endmodule

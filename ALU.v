module ALU (
    input [31:0] A, B,
    input [3:0] ALU_cntrl,
    output zero, carry,
    output [31:0] Out
);
    reg [31:0] r_out;
    reg c, z;
    buf b0[31:0](Out, r_out), b1(carry, c), b2(zero, z);

    always@(*) begin
        case(ALU_cntrl)
        4'b0000 : {c, r_out} = A + B;   // Add
        4'b0001 : {c, r_out} = A - B;   // Subtract
        4'b0010 : r_out = A & B;            // AND
        4'b0011 : r_out = A | B;            // OR
        4'b0100 : r_out = ~(A & B);         // NAND
        4'b0101 : r_out = ~(A | B);         // NOR
        4'b1000 : begin                     // SLT
                    if(A>B) r_out = 0;
                    else r_out = 1;
        end
        endcase

        z = (r_out == 0)? 1'b1: 1'b0;

    end
        

endmodule

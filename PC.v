module PC (
    input clk, rst,
    input[31:0] count_in,
    output reg[31:0] count_out
);

    always @(posedge clk)
    begin
        assign count_out = count_in + 1;        
    end

    always @(negedge rst) begin
        count_out = 0;        
    end

    
endmodule

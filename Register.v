module Register (
    input clk, rst, reg_w_en,
    input [4:0] reg_w_dest,
    input [31:0] reg_w_data,
    input [4:0] reg_r_addr_1, reg_r_addr_2,
    output [31:0] reg_r_data_1, reg_r_data_2
);

reg [31:0] reg_array [31:0];

assign reg_r_data_1 = (reg_r_addr_1 == 0)? 0 : reg_array[reg_r_addr_1];
assign reg_r_data_2 = (reg_r_addr_2 == 0)? 0 : reg_array[reg_r_addr_2];

always @(posedge clk) begin
    if (reg_w_en) begin
        reg_array[reg_w_dest] = reg_w_data;
    end    
end
    
endmodule

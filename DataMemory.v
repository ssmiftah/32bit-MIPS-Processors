module DataMemory(

	input [31:0]address, writedata,
	input write_en,read_en, clk,
	output [31:0]data

	);

	reg [15:0] data_mem[127:0];
	reg [31:0] temp;

	buf b[31:0] (data, temp);

	always @(posedge clk)
	begin
		if(write_en)
		begin
			data_mem[address] = writedata[31:16];
			data_mem[address + 1] = writedata[15:0];
		end

		if(read_en) temp = {data_mem[address], data_mem[address + 1]};

	end

endmodule

module counter#(parameter WIDTH = 8)(
	input clk,
	input reset,
	input enable,
	output logic [WIDTH-1:0] count
);
	//input enable, clk, reset;
	//output reg[WIDTH-1:0] count;
	//output reg[WIDTH-1:0] count;

	always @(posedge clk) begin
		if(reset) begin
//			$display("count is %d \n", count);
			count <= 8'b0;
		end else if(enable) begin
			if (^count === 1'bx) begin
				count = 1'b0;
			end
			count = count + 1;
			$display("count is %d \n", count);
		end
	end

endmodule


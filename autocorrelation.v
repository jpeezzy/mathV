`timescale 1ns/1ps
//We are performing autocorrelation across 2 signals: 
//We will do this by multiplying at discrete points
//multiplying (easy way out ) 

module autocorrelation#(parameter WIDTH = 256,
						parameter C_WIDTH = 8)(
	input clk,
	input reset,
	input logic [C_WIDTH-1:0]count,
	input logic [WIDTH-1:0] signal_1,
	input logic [WIDTH-1:0] signal_2,
	output  [WIDTH-1:0] out
);
	integer a, tmp;
	assign out[WIDTH-1:0] = tmp;
	always @(posedge clk) begin
		a = 0;
		tmp = 0;
		//$display("signal1 and signal2 are %b and %b\n", signal_1, signal_2);
		for(a = 0; a < WIDTH; a=a+1)
			if(count - a >= 0 && count - a < WIDTH)begin
				tmp = tmp+ signal_1[a +:1];//signal_1[a]*signal_2[count - a];
				//$display("count - a = %d", count-a);
				//$display("the result for this convoluation is %d \n", tmp);
			end
		$display("the result for this convoluation is %d \n", tmp);
	end
endmodule

`include "channel_capacity.v"
`include "gain_advantage.v"
`include "spread_spectrum.v"

module tb_top;
	reg clk, reset, enable;
	wire real out, out2;
	wire[3:0] count;

	initial
	begin
		clk = 0;
		reset = 0;
		enable=0;
		#100 
		$display("The gain advantage of our sample is %f \n", out);
		$display("The channel capacity of our sample is %f \n",out2);
		$display("The channel capacity of our sample is %f \n",`channel_capacity(1.4,5.666,1));
		$finish;
	end

	always
	begin
		//$display("The gain advantage of our sample is %f \n", out);
		#5 clk = !clk;
	end

	gain_advantage ga(.beta(0.132), .signal(1), .noise(1), .out(out));
	channel_capacity cc(.W(1.0), .N(1.0), .S(31.0), .C(out2));

endmodule

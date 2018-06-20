`include "channel_capacity.v"
`include "gain_advantage.v"
`include "spread_spectrum.v"
`include "autocorrelation.v"
`include "counter.v"
module tb_top;
	reg clk, reset, enable;
	wire[7:0] count; 
	//integer count;

	counter #(8)cnt(
				.clk(clk),
				.reset(reset),
				.enable(enable),
				.count(count)
	);

	wire real out, out2;

	//FOR AUTOCORRELATION TB
	parameter SIZE = 256;
	integer max_position, max, i;
	wire[SIZE-1:0] s1, s2, s3, tmp;
	integer con_out[SIZE-1:0];

	//Whenever count increases, get con_out
	always @(count) begin
		con_out[count] = s3;
	end

	assign tmp = {SIZE{1'b1}};
	assign s1 = {tmp[127:0], 128'b0};//{512{1'b1}};
	assign s2 = {64'b0, tmp[127:0], 192'b0};//{512{1'b1}};
	///////////////////////////////////////
	
	initial begin
		clk = 0;
		reset = 0;
		enable=1;
	end

	initial begin
		$dumpfile("counter.vcd");
		$dumpvars;
	end

	always
	begin
		#5 clk = !clk;
	end

	initial begin
		#2555
		$display("The gain advantage of our sample is %f \n", out);
		$display("The channel capacity of our sample is %f \n",out2);
		$display("The channel capacity to Bandwidth ratio is is %f \n",`channel_capacity(1.4,5.666,1));
		max_position = 0;
		for(i = 0; i < SIZE; i=i+1)
			if(con_out[max_position] < con_out[i])
				max_position = i; 
		$display("for auto correlation, the position N where it seems",
				" to be correlated perfectly is at position %d with a ", max_position,
				"score %d\n", con_out[max_position]);
		$finish;
	end

	autocorrelation #(SIZE, 8) ac (
							.clk(clk), 
							.reset(reset), 
							.count(count),
							.signal_1(s1), 
							.signal_2(s2), 
							.out(s3)
							);	

	gain_advantage ga(
					.beta(0.132), 
					.signal(1), 
					.noise(1), 
					.out(out)
					);

	channel_capacity cc(
					.W(1.0), 
					.N(1.0), 
					.S(31.0), 
					.C(out2)
					);

endmodule

//Module Name: channel_capacity
//this displays the relationship between the ability of a channel to transfer
//error-free information, compared with the signal to noise ratio existing in
//the channel, and the bandwidth used to transmit the information
//function: channel capacity
//W = bandwidth(in hz) 
//C = capacity in bits/sec
//N = noise power
//S = signal power
//`define channel_capacity(W, N, S) W*$ln(1+S/N)

module channel_capacity(
	input real W,
	input real N,
	input real S,
	output real C
);

assign C = W*clogb2(1+S/N);
//always @(W,N,S,C)
//define the clogb2 function
function integer clogb2;
	input integer value;
	begin
		//value = value - 1; not neccessary 
		for(clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
			value = value >> 1;
	end
endfunction
endmodule


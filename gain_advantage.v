//Module Name: gain)_advantage:

//calculates the gain advantage fomr the deviation ratio,
//and the the signal to noise ratio
//
`define process_gain(beta,signal,noise) 3*beta*beta*(signal/noise)
module gain_advantage(
	input real beta,
	input real signal,
	input real noise,
	output real out
);
assign out = 3*beta*beta*signal/noise;
endmodule

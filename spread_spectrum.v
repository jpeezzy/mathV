/* This module is built for functions that can be 
* expressed using the `define feature in verilog */

`define channel_capacity(W, N, S) W*$ln(1+S/N)

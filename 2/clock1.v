module CLOCK1 (
	input CLK, RST,
	input [2:0] nBUTTON,
	output [7:0] nHEX0, nHEX1, nHEX2, nHEX3
);

wire clr, minup,secup;
BTN_IN b0 (
	.CLK (CLK),
	.RST (RST),
	.nBIN (nBUTTON),
	.BOUT ({clr, minup, secup})
);

wire en1hz;
CNT1SEC CNT1SEC (
	.CLK (CLK),
	.RST (RST),
	.EN1HZ (en1hz)
);

wire [3:0] secL, minL;
wire [2:0] secH, minH;
wire secCA, minCA;
CNT60 SECCNT (
	.CLK (CLK), .RST (RST),
	.QH (secH), .QL (secL),
	.CA (secCA)
);
CNT60 MINCNT (
	.CLK (CLK), .RST (RST),
	.QH (minH), .QL (minL),
	.CA (minCA)
);

SEG7DEC SECL (
	.DIN (secL),
	.nHEX (nHEX0)
);
SEG7DEC SECH (
	.DIN (secH),
	.nHEX (nHEX1)
);
SEG7DEC MINL (
	.DIN (minL),
	.nHEX (nHEX2)
);
SEG7DEC MINH (
	.DIN (minH),
	.nHEX (nHEX3)
);

assign nHEX0[7] = 1'b1;
assign nHEX1[7] = 1'b1;
assign nHEX2[7] = 1'b0;
assign nHEX3[7] = 1'b1;

endmodule
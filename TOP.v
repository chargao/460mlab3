module Top (CLK,RST, GA,YA,RA, GB,YB,RB, GW,RW); 
input CLK,RST;
output GA,YA,RA, GB,YB,RB, GW,RW;

wire slowClk;

Divider Div (CLK, slowClk);
Traffic_Light TL (slowClk,RST, GA,YA,RA, GB,YB,RB, GW,RW);

endmodule

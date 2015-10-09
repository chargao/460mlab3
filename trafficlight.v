module Traffic_Light (CLK,RST, GA,YA,RA, GB,YB,RB, GW,RW);
input CLK,RST;
output reg GA,YA,RA, GB,YB,RB, GW,RW;
reg [2:0] Countdown;
reg [2:0] State, NextState;
reg Flash;

initial
begin
	State <= 0;
	NextState <= 1;
	Countdown <=7;
	Flash <= 1;
end

always @(State) //combinational
begin
	case(State) 
	0: begin NextState = 1; Countdown = 7; end 
	1: begin NextState = 2; Countdown = 3; end 
	2: begin NextState = 3; Countdown = 5; end
	3: begin NextState = 4; Countdown = 1; end 
	4: begin NextState = 5; Countdown = 3; end 
	5: begin NextState = 0; Countdown = 7; end 
	6: begin NextState = 0; Countdown = 1; end //RST 
	default: begin NextState = 0; Countdown = 0; end
	endcase
end

always @(posedge CLK)
begin
	

	if(RST) begin //maintenance mode
		State <= 6;

	end
	else begin //regular operation
		if (Countdown) Countdown <= Countdown - 1;
		else State <= NextState;

		case(State) 
		0: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b10000101;
		1: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b01000101;
		2: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b00110001;
		3: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b00101001;
		4: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b00100110; 
		5: {GA,YA,RA,GB,YB,RB,GW,RW} <=  {7'b0010010,Flash}; 
		6: {GA,YA,RA,GB,YB,RB,GW,RW} <=  {2'b00,Flash,2'b00,Flash,1'b0,Flash}; //RST 
		default: {GA,YA,RA,GB,YB,RB,GW,RW} <=  8'b00000000;
		endcase
	end

	

	Flash <= ~Flash;
end

endmodule

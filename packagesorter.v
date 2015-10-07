module Package_Sorter(CLK,Weight,Reset,Grp1,Grp2,Grp3,Grp4,Grp5,Grp6,CurrentGrp);
input CLK,Reset;
input [11:0] Weight;
output reg [7:0] Grp1,Grp2,Grp3,Grp4,Grp5,Grp6;
output reg [2:0] CurrentGrp;

reg NewItem;
reg [11:0] OldWeight;

initial 
begin
	NewItem <= 0;
	Grp1 <= 0;
	Grp2 <= 0;
	Grp3 <= 0;
	Grp4 <= 0;
	Grp5 <= 0;
	Grp6 <= 0;
	CurrentGrp <= 0;
end

always @(Weight) //combinational
begin
	if (Weight == 0) CurrentGrp = 0;
	else if	(Weight > 0    && Weight <= 200)  CurrentGrp = 1;
	else if	(Weight > 200  && Weight <= 500)  CurrentGrp = 2;
	else if	(Weight > 500  && Weight <= 800)  CurrentGrp = 3;
	else if	(Weight > 800  && Weight <= 1000) CurrentGrp = 4;
	else if	(Weight > 1000 && Weight <= 2000) CurrentGrp = 5;
	else                                      CurrentGrp = 6;
	
	if(OldWeight==0 && Weight != 0) NewItem = 1;
	else NewItem = 0;
	OldWeight = Weight;
end

always @(negedge CLK, posedge Reset) //sequential
begin
	if(!Reset) begin //clock
		if (NewItem) begin
			//measure currentGroup
			case (CurrentGrp)
				1: Grp1 <= Grp1+1;
				2: Grp2 <= Grp2+1;
				3: Grp3 <= Grp3+1;
				4: Grp4 <= Grp4+1;
				5: Grp5 <= Grp5+1;
				6: Grp6 <= Grp6+1;
				default: ; //do nothing
			endcase
		end
		else ; //do nothing
	end
	else begin //reset
		Grp1 <= 0;
		Grp2 <= 0;
		Grp3 <= 0;
		Grp4 <= 0;
		Grp5 <= 0;
		Grp6 <= 0;
	end
end

endmodule

module testbench;
  parameter n = 7;

reg [11:0] weight;
reg Reset;
reg [7:0] grp1,grp2,grp3,grp4,grp5,grp6;
reg [2:0] currentGrp;
reg CLK;

wire [7:0] grp1Out,grp2Out,grp3Out,grp4Out,grp5Out,grp6Out;
wire [2:0] currentGrpOut;

reg [11:0] weightArray [1:n];
reg ResetArray [1:n];
reg [7:0] grp1Array [1:n];
reg [7:0] grp2Array [1:n];
reg [7:0] grp3Array [1:n];
reg [7:0] grp4Array [1:n];
reg [7:0] grp5Array [1:n];
reg [7:0] grp6Array [1:n];
reg [2:0] currentGrpArray [1:n];

initial
begin
  weightArray[1] = 12'd0;
  weightArray[2] = 12'd250;
  weightArray[3] = 12'd0;
  weightArray[4] = 12'd300;
  weightArray[5] = 12'd0;
  weightArray[6] = 12'd501;
  weightArray[7] = 12'd1013;

  ResetArray[1] = 1'b1;
  ResetArray[2] = 1'b0;
  ResetArray[3] = 1'b0;
  ResetArray[4] = 1'b0;
  ResetArray[5] = 1'b0;
  ResetArray[6] = 1'b0;
  ResetArray[7] = 1'b0;
  
  grp1Array[1] = 8'd0;
  grp1Array[2] = 8'd0;
  grp1Array[3] = 8'd0;
  grp1Array[4] = 8'd0;
  grp1Array[5] = 8'd0;
  grp1Array[6] = 8'd0;
  grp1Array[7] = 8'd0;
  
  grp4Array[1] = 8'd0;
  grp4Array[2] = 8'd0;
  grp4Array[3] = 8'd0;
  grp4Array[4] = 8'd0;
  grp4Array[5] = 8'd0;
  grp4Array[6] = 8'd0;
  grp4Array[7] = 8'd0;
  
  grp5Array[1] = 8'd0;
  grp5Array[2] = 8'd0;
  grp5Array[3] = 8'd0;
  grp5Array[4] = 8'd0;
  grp5Array[5] = 8'd0;
  grp5Array[6] = 8'd0;
  grp5Array[7] = 8'd0;
  
  grp6Array[1] = 8'd0;
  grp6Array[2] = 8'd0;
  grp6Array[3] = 8'd0;
  grp6Array[4] = 8'd0;
  grp6Array[5] = 8'd0;
  grp6Array[6] = 8'd0;
  grp6Array[7] = 8'd0;
  
  grp2Array[1] = 8'd0;
  grp2Array[2] = 8'd1;
  grp2Array[3] = 8'd1;
  grp2Array[4] = 8'd2;
  grp2Array[5] = 8'd2;
  grp2Array[6] = 8'd2;
  grp2Array[7] = 8'd2;
  
  grp3Array[1] = 8'd0;
  grp3Array[2] = 8'd0;
  grp3Array[3] = 8'd0;
  grp3Array[4] = 8'd0;
  grp3Array[5] = 8'd0;
  grp3Array[6] = 8'd1;
  grp3Array[7] = 8'd1;
  
  currentGrpArray[1] = 3'd0;
  currentGrpArray[2] = 3'd2;
  currentGrpArray[3] = 3'd0;
  currentGrpArray[4] = 3'd2;
  currentGrpArray[5] = 3'd0;
  currentGrpArray[6] = 3'd3;
  currentGrpArray[7] = 3'd5;
  
  CLK = 1;
end

always
begin
  #5 CLK <= ~CLK;
end

integer i;

always
begin
  for(i=1;i<=n;i=i+1)
  begin
    $write("Test: ");
    $display(i);
    weight <= weightArray[i];
    Reset <= ResetArray[i];
    grp1 <= grp1Array[i];
    grp2 <= grp2Array[i];
    grp3 <= grp3Array[i];
    grp4 <= grp4Array[i];
    grp5 <= grp5Array[i];
    grp6 <= grp6Array[i];
    currentGrp <= currentGrpArray[i];
    
    #(40);
    
    if
    (!(
    grp1Out == grp1 &&
    grp2Out == grp2 &&
    grp3Out == grp3 &&
    grp4Out == grp4 &&
    grp5Out == grp5 &&
    grp6Out == grp6 &&
    currentGrpOut == currentGrp
    ))
    begin
      $write("ERROR: ");
      $display("Ya done goofed!");
    end
    else begin
      $display("PASSED");
      end
  end
  $display("Tests Complete!");
  $stop;
end
  Package_Sorter p1(CLK,weight,Reset,grp1Out,grp2Out,grp3Out,grp4Out,grp5Out,grp6Out,currentGrpOut);
endmodule
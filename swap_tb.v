`timescale 1ns / 1ns
module swap_tb();
reg clk,rst,load;
reg [3:0]data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7;
wire [3:0]data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;

initial
begin
#0 rst = 0;
#0 clk = 0;
#0 load=0;
#5 data_in0=8;
data_in1=7;
data_in2=6;
data_in3=5;
data_in4=4;
data_in5=3;
data_in6=2;
data_in7=1;
#11 rst=1;
#20 load=1;
//#15 load=0;

#400 $finish;
end

swap i1(
.clk(clk),.rst(rst),.load(load) ,
.data_in0(data_in0),.data_in1(data_in1),
.data_in2(data_in2),.data_in3(data_in3),
.data_in4(data_in4),.data_in5(data_in5),
.data_in6(data_in6),.data_in7(data_in7),
.data_out0(data_out0),.data_out1(data_out1),
.data_out2(data_out2),.data_out3(data_out3),
.data_out4(data_out4),.data_out5(data_out5),
.data_out6(data_out6),.data_out7(data_out7)
);

always #5 clk = ~clk;

endmodule


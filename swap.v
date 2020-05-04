module swap(
clk,rst,load,data_in0,data_in1,data_in2,data_in3,data_in4,
data_in5,data_in6,data_in7,data_out0,data_out1,data_out2,data_out3,data_out4,
data_out5,data_out6,data_out7
);

parameter s_init=0,s_load=1,s_sort=2,s_send=3,N=8,world_size=4;
input clk,rst,load;
input [3:0]data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7;
output [3:0]data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
reg [2:0]i,j;
reg [1:0]cur_state,next_state;
reg reset,load_data,swap;
reg [world_size-1:0]A[0:N-1];


always@(posedge clk or negedge rst) begin
	if(!rst)
		cur_state<=s_init;
	else 
		cur_state<=next_state;
end

always@(posedge clk) begin
	if(reset) begin
		j<=0;
		i<=0;
	end
	
	if(load_data) begin
		A[0]<=data_in0;
		A[1]<=data_in1;
		A[2]<=data_in2;
		A[3]<=data_in3;
		A[4]<=data_in4;
		A[5]<=data_in5;
		A[6]<=data_in6;
		A[7]<=data_in7;
		j<=N-1;
		i<=0;
	end

/*	
	if(swap) begin
		if(i < j) begin
			i<=i+1;
			if(A[i+1] < A[i]) begin
				A[i+1]<=A[i];
				A[i]<=A[i+1];
			end
		end
		else begin
			i<=1;
			j<=j-1;
			if(A[1] < A[0]) begin
				A[1]<=A[0];
				A[0]<=A[1];
			end
		end
	end
*/

	if(swap) begin
		if(i < j) begin	
			if(A[i+1] < A[i]) begin
				A[i+1]<=A[i];
				A[i]<=A[i+1];
			end
			i<=i+1;
		end
		else begin
			i<=0;
			j<=j-1;
		end
	end
	
end

always@(i,cur_state,j,load) begin
	next_state<=s_init;
	case(cur_state)
		s_init: begin
			next_state<=s_load;
			reset<=1;
			end
		s_load: begin
			reset<=0;
			if(load) begin
				next_state<=s_sort;
				load_data<=1;
			end
			else 
				next_state<=s_load;
			end
		s_sort: begin
			swap<=1;
			load_data<=0;
			if(j== 0 && i==0) 
				next_state<=s_send;
			else
				next_state<=s_sort;
			end
		s_send: begin
			swap<=0;
			next_state<=s_load;
			end
		default:begin
			next_state<=s_init;
		end
	endcase
end

assign data_out0=A[0];
assign data_out1=A[1];
assign data_out2=A[2];
assign data_out3=A[3];
assign data_out4=A[4];
assign data_out5=A[5];
assign data_out6=A[6];
assign data_out7=A[7];

endmodule

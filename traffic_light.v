module traffic_light(clk_1s, rst_n, green_1, red_1, yellow_1, green_2, red_2, yellow_2);
parameter STATE_1 = 3'd0;
parameter STATE_2 = 3'd1;
parameter STATE_3 = 3'd2;
parameter STATE_4 = 3'd3;
input clk_1s;
input rst_n;
output red_1;
output green_1;
output yellow_1;
output red_2;
output green_2;
output yellow_2;
reg red_1;
reg green_1;
reg yellow_1;
reg red_2;
reg green_2;
reg yellow_2;
reg [5:0] counter;
reg [1:0] state, next_state;
always @ (*)begin
green_1 = 1'b0;
yellow_1 = 1'b0;
red_1 = 1'b0;
green_2 = 1'b0;
yellow_2 = 1'b0;
red_2 = 1'b0;
next_state[1:0] = STATE_1;
case(state[1:0])
	STATE_1: begin
	green_1 = 1'b1;
	red_2 = 1'b1;
	if(counter == 6'd39) next_state[1:0] = STATE_2;
	else next_state[1:0] = STATE_1;
	end
	STATE_2: begin
	yellow_1 = 1'b1;
	red_2 = 1'b1;
	if(counter == 6'd4) next_state[1:0] = STATE_3;
	else next_state[1:0] = STATE_2;
	end
	STATE_3: begin
	red_1 = 1'b1;
	green_2 = 1'b1;
	if(counter == 6'd19) next_state[1:0] = STATE_4;
	else next_state[1:0] = STATE_3;
	end
	STATE_4: begin
	red_1 = 1'b1;
	yellow_2 = 1'b1;
	red_2 = 1'b0;
	if(counter == 6'd4) next_state[1:0] = STATE_1;
	else next_state[1:0] = STATE_4;
	end
	default: begin
	green_1 = 1'b1;
	red_2 = 1'b1;
	next_state = STATE_1;
	end
	endcase
	
	
	end
	
always @ (posedge clk_1s) begin
if(!rst_n) state[1:0] <= STATE_1;
else state[1:0] <= next_state[1:0];
end

always @ (posedge clk_1s) begin
	if(!rst_n) counter [5:0] <= 6'd0;
	else case(state)
		STATE_1: begin
			if(counter [5:0] == 6'd39) counter[5:0] <= 6'd0;
			else counter [5:0] <= counter[5:0] + 1'b1;
		end
		STATE_2: begin
			if (counter[5:0] == 6'd4) counter[5:0] <= 6'd0;
			else counter[5:0] <= counter[5:0] + 1'b1;
		end
		STATE_3: begin
			if (counter[5:0] == 6'd19) counter[5:0] <=  6'd0;
			else counter[5:0] <= counter[5:0] + 1'b1;
		end
		STATE_4: begin
			if (counter[5:0] == 6'd4) counter[5:0] <=  6'd0;
			else counter[5:0] <= counter[5:0] + 1'b1;
		end
		default: counter[5:0] <= 6'd0;
		endcase
	end




endmodule

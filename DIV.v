module DIV(
input [31:0]dividend, //被除数
input [31:0]divisor, //除数
input start, //启动除法运算
input clock,
input reset,
output [31:0]q, //商
output [31:0]r, //余数
output busy //除法器忙标志位
);
reg first;
reg busy2;
reg r_sign;
reg flag;
reg [1:0] flag_s;
reg [5:0] count;
reg [31:0] reg_q; //商
reg [31:0] reg_r; //余数
reg [31:0] reg_b; //除数
reg [31:0] tmp_q;
reg [31:0] tmp_r;
wire [32:0] sub_add;

assign sub_add = (r_sign ? ({reg_r,reg_q[31]} + {1'b0,reg_b}) : ({reg_r,reg_q[31]} - {1'b0,reg_b}));
assign r = tmp_r;
assign q = tmp_q;
assign busy = busy2;

always @ (posedge clock or posedge reset) begin
	if(reset) begin
		first <= 1;
		flag <= 0;
		flag_s <= 0;
		r_sign <= 0;
		tmp_q <= 0;
		tmp_r <= 0;
		count <= 0;
		busy2 <= 0;
		reg_q <= 0; reg_r <= 0; reg_b <= 0; 
	end
	else begin
		if(start) begin
			if(first) begin
				flag <= 0;
				reg_r <= 0;
				r_sign <= 0;
				count <= 0;
				busy2 <= 1;
				first <= 0;
				if((dividend[31] == 0) && (divisor[31] == 0)) begin
					reg_q <= dividend;
					reg_b <= divisor;
					flag_s <= 0;
				end
				else if((dividend[31] == 0) && (divisor[31] == 1)) begin
					reg_q <= dividend;
					reg_b <= (~divisor + 1);
					flag_s <= 1;
				end
				else if((dividend[31] == 1) && (divisor[31] == 0)) begin
					reg_q <= (~dividend + 1);
					reg_b <= divisor;
					flag_s <= 2;
				end
				else begin
					reg_q <= (~dividend + 1);
					reg_b <= (~divisor + 1);
					flag_s <= 3;
				end
			end
		end
		if(busy2) begin
			reg_r <= sub_add[31:0];
			r_sign <= sub_add[32];
			reg_q <= {reg_q[30:0],~sub_add[32]};
			count <= count + 1;
			if(count == 31) begin
				busy2 <= 0;
				flag <= 1;
			end
		end
	end
end
	
always @ (flag) begin
	if(flag) begin
		if(flag_s == 0) begin
			tmp_q <= reg_q;
			tmp_r <= r_sign ? (reg_r + reg_b) : reg_r;
		end
		else if(flag_s == 1) begin
			tmp_q <= (~reg_q + 1);
			tmp_r <= r_sign ? (reg_r + reg_b) : reg_r;
		end
		else if(flag_s == 2) begin
			tmp_q <= (~reg_q + 1);
			tmp_r <= (~(r_sign ? (reg_r + reg_b) : reg_r) + 1);
		end
		else begin
			tmp_q <= reg_q;
			tmp_r <= (~(r_sign ? (reg_r + reg_b) : reg_r) + 1);
		end
		flag <= 0;
		first <= 1;
	end
end
endmodule
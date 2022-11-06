// -----testbench of UART_RXer-----
`timescale 1ns/10ps

module UART_RXer_tb;

reg		clk,res;
wire		RX;
wire[7:0]	data_out;
wire		en_data_out;

reg[25:0]	RX_send;//里面装有串口字节发送数据；		

assign		RX=RX_send[0];//连接RX；

reg[12:0]	con;

UART_RXer UART_RXer(	//同名例化不用打点和括号；
			clk,
			res,
			RX,
			data_out,
			en_data_out
			);
initial begin
		clk<=0;res<=0;RX_send<={1'b1,8'haa,16'hffff};con<=0;
	#17	res<=1;
	#4000000	$finish;
end


always #5 clk<=~clk;

always@(posedge clk) begin
	if(con==5000-1)begin
	  con<=0;
	end
	else begin
	  con<=con+1;
	end
	
	if(con==0) begin
	  RX_send[24:0]<=RX_send[25:1];
	  RX_send[25]<=RX_send[0];
	end
end

initial begin
	$dumpfile("test13.vcd");
	$dumpvars(0,UART_RXer_tb);
end


endmodule

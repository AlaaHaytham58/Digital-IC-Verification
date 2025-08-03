module assert_lab(
input clk,
input rst,
input start,
input ready,
input enable,
input done,
input write,
input ack,
input ack2,
input valid,
input d_valid,
input [2:0] data_out,
input [2:0] data_in,
input error,
input lock,
input unlock,
input grant,
input request,
input go,
input op_done,
input wr_en,
input rd_en,
input flag,
input input_valid,
input output_valid,
input load,
input [7:0] data,
input req,
input gnt,
input packet_start,
input header,
input full,
input overflow,
input burst_start,
input burst_end,
input data_valid,
input [2:0] a, b,
input out);
 property prop1;
 @(posedge clk) $rose(start) |->##3 $rose(ready);
endproperty
A1:assert property(prop1);


endmodule
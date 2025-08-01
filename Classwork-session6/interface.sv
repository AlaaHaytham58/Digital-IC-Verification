interface arb_if  #(parameter N = 4)(input bit clk);
    logic[1:0] grant,request;
    bit rst;
    modport DUT (input request,rst, output grant);
    modport TEST(output request,rst,input grant);
    modport MONITOR(input request,rst, input grant);
endinterface 
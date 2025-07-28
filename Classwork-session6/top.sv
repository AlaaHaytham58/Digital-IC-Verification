`include "interface.sv"
module top;
bit clk;
bit rst;
always #50 clk=~clk;

arb_if arbif(clk);
arb_if arb_design (arbif.DUT);
arb_if arb_test (arbif.TEST);

endmodule
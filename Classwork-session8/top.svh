`include "alu_if.svh"
`include "alu_pkg.svh"
`include "uvm_macros.svh"
import uvm_pkg::*;
import alu_pkg::*;
module top;
    alu_if alu_vif();
    alu DUT(.clk(alu_vif.clk),
    .rst(alu_vif.rst),
    .a(alu_vif.a),
    .b(alu_vif.b),
    .op(alu_vif.op),
    .result(alu_vif.result)
);
initial begin 
    alu_vif.clk=0;
    forever begin
        #2ns alu_vif.clk=~alu_vif.clk;
    end
end 
initial begin
    run_test("alu_test");
end
endmodule

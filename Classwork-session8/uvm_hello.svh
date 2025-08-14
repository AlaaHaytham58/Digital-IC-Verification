module uvm_hello_world;
`include "uvm_macros.svh"
import uvm_pkg::*;
initial begin
    `uvm_info ("HELLO","HELLO this is my first kick start with uvm",UVM_HIGH);
    `uvm_info ("TOP_MODULE","HIIIIIIIIII",uvm_top.get_report_verboisty_level);
end
endmodule
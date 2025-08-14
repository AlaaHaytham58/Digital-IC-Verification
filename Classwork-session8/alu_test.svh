`ifndef ALU_TEST_SVH
`define ALU_TEST_SVH
`include "uvm_macros.svh"

`include "alu_env.svh"
import uvm_pkg::*;
class alu_test extends uvm_test;
    alu_env env;
    `uvm_component_utils(alu_test)
    function new(string name="alu_test",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void buildphase(uvm_phase phase);
     super.build_phase(phase);
    env=alu_env::type_id::create("env",this);
    `uvm_info("KAMONNNNA","alu test build phase",UVM_LOW)

    endfunction
endclass
`endif
`ifndef ALU_agent_SVH
`define ALU_agent_SVH
`include "uvm_macros.svh"
import uvm_pkg::*;
class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)
    function new(string name="alu_agent",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void buildphase(uvm_phase phase);
     super.build_phase(phase);
     `uvm_info("KAMONNNNA","alu agent build phase",UVM_LOW)
    endfunction
endclass
`endif
`ifndef ALU_TRANSACTION_SVH
`define ALU_TRANSACTION_SVH
`include"uvm_macros.svh"
import uvm_pkg::*;

class alu_transaction extends uvm_sequence_item;

  rand logic [3:0] a;
  rand logic [3:0] b;
  rand logic [1:0] op;
  logic [3:0] result;
  `uvm_object_utils_begin(alu_transaction)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_field_int(op,UVM_DEFAULT)
  `uvm_field_int(result,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name ="alu_transaction");
    super.new(name);
  endfunction
endclass

`endif
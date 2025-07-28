`include "coverage_test_.sv"

module top;
  
  bit clk,rst_n;
  logic [3:0] opcode;
  logic [7:0] data;
  logic [7:0] result;
  
  coverage_test cov_test_obj;
  
  
  opcode_processor dut(.*);
  
  initial begin
    clk = 0;
    forever begin
     #2ns clk = ~clk;
     cov_test_obj.clk = clk;
    end  
  end  
  
  initial begin
    cov_test_obj = new();
    
    rst_n = 0;
    #4ns;
    rst_n = 1;
    #2ns;

      
    do begin
      @(negedge clk);
      assert(cov_test_obj.randomize()) else $finish;
      opcode = cov_test_obj.opcode;
      data   = cov_test_obj.data;
      cov_test_obj.cg.sample();
    end while(cov_test_obj.cg.get_coverage() !=90);
	
    $stop;
  end  
  

endmodule
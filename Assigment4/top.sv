module top;
  
    logic clk,rst_n;
    always #50 clk = ~clk;

    uart_if tb_if_inst(clk, rst_n);

    uart_tx uart_top(tb_if_inst.DUT);
    uart_tb uart_tb_top(tb_if_inst.TEST);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #20 rst_n = 1;
    end

endmodule
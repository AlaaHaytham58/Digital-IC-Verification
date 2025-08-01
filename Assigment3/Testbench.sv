module uart_tb;
    import enum_pkg::*;
    import uart_packet::*;

    functionsImp func_imp;
    bit clk;
    bit rst_n;
    bit tx_start;
    bit [7:0] data_in;
    bit parity_en;
    bit even_parity;
    wire tx;
    bit tx_busy;

    bit [10:0] actual_queue[$];
    bit [10:0] expected_value[$];
    // Instantiate DUT
    uart_tx DUT(.*);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #10ns;
        rst_n = 1;
        func_imp = new();

       repeat (100) begin
            @(negedge tx_busy);
            generate_stimulus(func_imp);
            drivestim(func_imp);
            collect_output( func_imp);
            golden_model(expected_value);
            check_output(actual_queue, expected_value);
           
        end

        $stop;
    end

    // ------------------------ Functions & Tasks ------------------------

    // Generate stimulus from class constraints
    function automatic void generate_stimulus(ref functionsImp f);
        assert (f.randomize()) else begin
            $display("Randomization failed");
            $stop;
        end
    endfunction

    task automatic drivestim(ref functionsImp f);
        @(negedge clk);
        data_in      = f.data_in;
        parity_en    = f.parity_en;
        even_parity  = f.even_parity;
        tx_start=1;
        @(negedge clk);
        tx_start=0;
    endtask

  
    function automatic void golden_model( ref bit [9:0] expected_value[$]);
        expected_value.delete();
        expected_value.push_back(0); // Start bit

        for (int j = 0; j < 8; j++) begin
            expected_value.push_back(data_in[j]);
        end

        if (parity_en) begin
            bit par_value;
            if (even_parity)
                par_value = ~(^data_in); 
            else
                par_value = ^data_in;    // odd parity
            expected_value.push_back(par_value);
        end

        expected_value.push_back(1); // Stop bit
    endfunction
    task automatic collect_output( ref functionsImp f);
        logic [10:0] collected;
        if(f.parity_en)begin
            @(posedge clk);
            for (int i = 0; i < 11; i++) begin
                @(negedge clk);
                collected[i] =tx;
            end
        end 
        else begin
            @(posedge clk);
            for (int i = 0; i < 10; i++) begin
                @(negedge clk);
                collected[i] =tx;
            end
            collected[10] = 1; // Stop bit
        end
        actual_queue.push_back(collected);
        $display("DONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNE");
    endtask

    // Check actual vs expected output
    function automatic void check_output(ref bit [9:0] actual_queue[$], ref bit [9:0] expected_value[$]);
        if (actual_queue.size() != expected_value.size()) begin
            $display("Error: Size mismatch. Actual = %0d, Expected = %0d", actual_queue.size(), expected_value.size());
            return;
        end

        for (int i = 0; i < actual_queue.size(); i++) begin
            if (actual_queue[i] !== expected_value[i]) begin
             
                $display("Mismatch at index %0d: Actual = %b, Expected = %b", i, actual_queue[i], expected_value[i]);
                return;
            end
        end
        for (int i=0;i<expected_value.size();i++)begin
          $display("Expected value[%0d] = %b", i, expected_value[i]);  
    
        end
              $display("Output matches expected UART frame.");
    endfunction

endmodule

module uart_tb(uart_if.TEST interface_test);
    import enum_pkg::*;
    import uart_packet::*;

    functionsImp func_imp;
    covergroup_class cg_inst;
    bit [9:0] actual_queue[$];
    bit [9:0] expected_value[$];

    initial begin
        func_imp = new();
        cg_inst  = new();

        do begin
            @(negedge interface_test.tx_busy);
            generate_stimulus(func_imp);
            drivestim(func_imp);
            collect_output(func_imp);
            golden_model(expected_value);
            check_output(actual_queue, expected_value);
        end while (cg_inst.cg.get_coverage() < 100);

        $display("Coverage Reached 100");
        $stop;
    end

    function automatic void generate_stimulus(ref functionsImp f);
        assert (f.randomize()) else begin
            $display("Randomization failed!");
            $stop;
        end
    endfunction

    task automatic drivestim(ref functionsImp f);
        @(negedge interface_test.clk);
        interface_test.data_in     = f.data_in;
        interface_test.parity_en   = f.parity_en;
        interface_test.even_parity = f.even_parity;
        interface_test.tx_start    = 1;
        @(negedge interface_test.clk);
        interface_test.tx_start    = 0;

        cg_inst.sample(f); 
    endtask

    function automatic void golden_model(ref bit [9:0] expected_value[$]);
        expected_value.delete();
        expected_value.push_back(0); // Start bit
        for (int j = 0; j < 8; j++) begin
            expected_value.push_back(interface_test.data_in[j]);
        end
        if (interface_test.parity_en) begin
            bit par_value = (interface_test.even_parity) ? ~(^interface_test.data_in) : (^interface_test.data_in);
            expected_value.push_back(par_value);
        end
        expected_value.push_back(1); // Stop bit
    endfunction

    task automatic collect_output(ref functionsImp f);
        logic [10:0] collected;
        int i;
        int bits_to_collect = f.parity_en ? 11 : 10;

        @(posedge interface_test.clk);
        for (i = 0; i < bits_to_collect; i++) begin
            @(negedge interface_test.clk);
            collected[i] = interface_test.tx;
        end
        if (!f.parity_en) collected[10] = 1;
        actual_queue.push_back(collected);
    endtask

    function automatic void check_output(ref bit [9:0] actual_queue[$], ref bit [9:0] expected_value[$]);
        if (actual_queue.size() != expected_value.size()) begin
            $display("Mismatch in size: Actual = %0d, Expected = %0d", actual_queue.size(), expected_value.size());
            return;
        end
        for (int i = 0; i < actual_queue.size(); i++) begin
            if (actual_queue[i] !== expected_value[i]) begin
                $display("Mismatch at index %0d: Actual = %b, Expected = %b", i, actual_queue[i], expected_value[i]);
                return;
            end
        end
        $display("UART frame matched expected output.");
    endfunction
endmodule

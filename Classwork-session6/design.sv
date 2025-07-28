module arbiter #(parameter N = 4)(
    arb_if.DUT arb_bus
);

    logic [$clog2(N)-1:0] ptr;
    int index;
    
  always_ff @(posedge arb_bus.clk or posedge arb_bus.rst) begin
        if (arb_bus.rst) begin
            ptr <= 0;
            arb_bus.gnt <= 0;
        end else begin
            arb_bus.gnt <= 0;
            for (int i = 0; i < N; i++) begin
                index = (ptr + i) % N;
                if (arb_bus.req[index]) begin
                    arb_bus.gnt[index] <= 1;
                    ptr <= index + 1;
                    break;
                end
            end
        end
    end

endmodule

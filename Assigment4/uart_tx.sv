module uart_tx (uart_if.DUT interface_dut);

    localparam IDLE   = 3'd0,
               START  = 3'd1,
               DATA   = 3'd2,
               PARITY = 3'd3,
               STOP   = 3'd4;

    reg [2:0] state;
    reg [3:0] bit_cnt;
    reg [7:0] shift_reg;
    reg       parity_bit;

    always @(posedge interface_dut.clk or negedge interface_dut.rst_n) begin
        if (!interface_dut.rst_n) begin
            state               <= IDLE;
            interface_dut.tx    <= 1'b1;
            interface_dut.tx_busy <= 1'b0;
            shift_reg           <= 8'd0;
            bit_cnt             <= 4'd0;
            parity_bit          <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    interface_dut.tx <= 1'b1;
                    interface_dut.tx_busy <= 1'b0;
                    if (interface_dut.tx_start) begin
                        shift_reg <= interface_dut.data_in;
                        bit_cnt <= 4'd0;
                        parity_bit <= (interface_dut.even_parity) ? ~(^interface_dut.data_in) : (^interface_dut.data_in);
                        interface_dut.tx_busy <= 1'b1;
                        state <= START;
                    end
                end
                START: begin
                    interface_dut.tx <= 1'b0;
                    state <= DATA;
                end
                DATA: begin
                    interface_dut.tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 4'd7) begin
                        if (interface_dut.parity_en)
                            state <= PARITY;
                        else
                            state <= STOP;
                    end
                end
                PARITY: begin
                    interface_dut.tx <= parity_bit;
                    state <= STOP;
                end
                STOP: begin
                    interface_dut.tx <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule


vlog uart_tx.v
vlog enum_pkg.sv
vlog Uart_packet.sv
vlog Testbench.sv
vsim -voptargs=+acc work.uart_tb
run -all


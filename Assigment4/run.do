vlib work
vlog +cover uart_tx.sv interface.sv uart_packet.sv top.sv testbench.sv enum_pkg.sv
vsim -coverage work.top

run -all

coverage save -onexit uart_coverage.ucdb
coverage report -details -output cov_report.txt
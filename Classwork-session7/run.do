vlib work
vlog assertmodule.sv testbench.sv
vsim -assertdebug +acc -voptargs=+acc work.tb
run -all
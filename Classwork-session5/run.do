vlog testbench_.sv coverage_test_.sv +cover= -covercells
vsim work.top -cover
coverage save -onexit cov.ucdb
run -all
coverage report -details -html -output cov_report.txt
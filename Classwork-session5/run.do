vlog testbench_.sv coverage_test_.sv +cover=f -covercells
vsim work.top -cover
coverage save -onexit cov.ucdb
run -all
coverage report -details -output cov_report.txt
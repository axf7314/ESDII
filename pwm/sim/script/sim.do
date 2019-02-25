vlib work
vcom -93 -work work ../../src/pwm.vhd
vcom -93 -work work ../src/pwm_tb.vhd
vsim -voptargs=+acc pwm_tb
do wave.do
run 500000 ns

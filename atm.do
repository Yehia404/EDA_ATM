vlib work
vlog ATM.v ATM_tb.sv +cover
vsim -voptargs=+acc work.ATM_tb -cover
add wave *
coverage save ATM_tb_db.ucdb -onexit -du topmodule
run -all
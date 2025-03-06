# Create the work library
#vlib work

# Compile the package file first
vlog -sv ./Verification/v_pkg.svp

# Compiling the interface file 
#vlog -sv ./Verification/uart_interface.sv


# Compile the design files from the 'Design' folder
vlog -sv ./Design/TX.sv
vlog -sv ./Design/RX.sv
vlog -sv ./Design/Top.sv

# Compile the other design or testbench files from the 'tb' folder
vlog -sv ./Verification/uart_trans.sv
vlog -sv ./Verification/uart_generator.sv
vlog -sv ./Verification/uart_driver.sv
vlog -sv ./Verification/uart_monitor.sv
vlog -sv ./Verification/uart_scoreboard.sv
vlog -sv ./Verification/uart_env.sv
vlog -sv ./Verification/tb.sv

# Run the simulation
vsim -voptargs="+acc" -do "run -all" tb



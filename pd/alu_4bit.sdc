# ============================================================
# 4-bit ALU - Sky130 HD Timing Constraints
# Combinational design
# ============================================================

# Virtual clock for timing analysis
create_clock -name virtual_clk -period 10.0

# Input timing
set_input_delay 0.0 -clock virtual_clk [all_inputs]
set_input_transition 0.1 [all_inputs]

# Output timing
set_output_delay 0.0 -clock virtual_clk [all_outputs]
set_load 0.05 [all_outputs]
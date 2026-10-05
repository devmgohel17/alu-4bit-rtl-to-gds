# ============================================================
# 4-bit ALU - Sky130 HD
# Stage 6: Post-Route Static Timing Analysis
# ============================================================

set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
set LIB      $PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_lef $TECH_LEF
read_lef $CELL_LEF
read_liberty $LIB

read_def pd/alu_4bit_routed.def

# Timing constraints
read_sdc pd/alu_4bit.sdc

# Read extracted post-route parasitics
read_spef pd/alu_4bit_nominal.spef

puts ""
puts "============================================================"
puts "POST-ROUTE TIMING"
puts "============================================================"

report_checks \
    -path_delay max \
    -fields {slew cap input_pins} \
    -format full_clock_expanded

puts ""
puts "============================================================"
puts "WORST SLACK"
puts "============================================================"

report_worst_slack -max

puts ""
puts "============================================================"
puts "TOTAL NEGATIVE SLACK"
puts "============================================================"

report_tns

puts ""
puts "============================================================"
puts "DESIGN AREA"
puts "============================================================"

report_design_area
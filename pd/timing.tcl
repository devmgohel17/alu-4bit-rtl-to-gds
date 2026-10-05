# ============================================================
# 4-bit ALU - Sky130 HD
# Stage 4: Static Timing Analysis
#
# Current stage:
# Placement-based parasitic estimation
#
# NOTE:
# This is NOT final post-route RC extraction.
# True post-route signoff will use OpenRCX + SPEF later.
# ============================================================

set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
set LIB      $PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# ------------------------------------------------------------
# Read technology
# ------------------------------------------------------------

read_lef $TECH_LEF
read_lef $CELL_LEF
read_liberty $LIB

# ------------------------------------------------------------
# Read routed design
# ------------------------------------------------------------

read_def pd/alu_4bit_routed.def

# ------------------------------------------------------------
# Read timing constraints
# ------------------------------------------------------------

read_sdc pd/alu_4bit.sdc

# ------------------------------------------------------------
# Sky130HD RC values
#
# Values from the OpenROAD Sky130HD platform RC setup.
# ------------------------------------------------------------

set_layer_rc -layer li1  \
    -capacitance 1.499e-04 \
    -resistance 7.176e-02

set_layer_rc -layer met1 \
    -capacitance 1.72375e-04 \
    -resistance 1.20565e-03

set_layer_rc -layer met2 \
    -capacitance 1.36233e-04 \
    -resistance 1.22132e-03

set_layer_rc -layer met3 \
    -capacitance 2.14962e-04 \
    -resistance 1.66281e-04

set_layer_rc -layer met4 \
    -capacitance 1.48128e-04 \
    -resistance 1.68093e-04

set_layer_rc -layer met5 \
    -capacitance 1.54087e-04 \
    -resistance 1.83558e-05

# Via resistance

set_layer_rc -via mcon -resistance 9.249146e-03
set_layer_rc -via via  -resistance 4.5e-03
set_layer_rc -via via2 -resistance 3.368786e-03
set_layer_rc -via via3 -resistance 0.376635e-03
set_layer_rc -via via4 -resistance 0.00580e-03

# Default signal/clock wire RC layers

set_wire_rc -signal -layer met1
set_wire_rc -clock  -layer met3

# ------------------------------------------------------------
# Estimate parasitics from physical placement
# ------------------------------------------------------------

estimate_parasitics -placement

# ------------------------------------------------------------
# Timing reports
# ------------------------------------------------------------

puts ""
puts "============================================================"
puts "TIMING CHECKS"
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
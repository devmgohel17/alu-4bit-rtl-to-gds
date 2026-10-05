# ============================================================
# 4-bit ALU - Sky130 HD Physical Design
# Stage 3: Global + Detailed Routing
# ============================================================

set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef

# ------------------------------------------------------------
# Read technology and standard-cell LEF
# ------------------------------------------------------------

read_lef $TECH_LEF
read_lef $CELL_LEF

# ------------------------------------------------------------
# Read placed design
# ------------------------------------------------------------

read_def pd/alu_4bit_placed.def

# ------------------------------------------------------------
# Create Sky130HD routing tracks
#
# These values match the OpenROAD Sky130HD platform flow.
# ------------------------------------------------------------

make_tracks li1 \
    -x_offset 0.23 \
    -x_pitch 0.46 \
    -y_offset 0.17 \
    -y_pitch 0.34

make_tracks met1 \
    -x_offset 0.17 \
    -x_pitch 0.34 \
    -y_offset 0.17 \
    -y_pitch 0.34

make_tracks met2 \
    -x_offset 0.23 \
    -x_pitch 0.46 \
    -y_offset 0.23 \
    -y_pitch 0.46

make_tracks met3 \
    -x_offset 0.34 \
    -x_pitch 0.68 \
    -y_offset 0.34 \
    -y_pitch 0.68

make_tracks met4 \
    -x_offset 0.46 \
    -x_pitch 0.92 \
    -y_offset 0.46 \
    -y_pitch 0.92

make_tracks met5 \
    -x_offset 1.70 \
    -x_pitch 3.40 \
    -y_offset 1.70 \
    -y_pitch 3.40

# ------------------------------------------------------------
# Define routing layers
#
# Signal routing:
#   Minimum = met1
#   Maximum = met5
# ------------------------------------------------------------

set_routing_layers \
    -signal met1-met5

# ------------------------------------------------------------
# Global routing
# ------------------------------------------------------------

global_route \
    -guide_file pd/alu_4bit_route.guide \
    -congestion_iterations 50

# ------------------------------------------------------------
# Detailed routing
# ------------------------------------------------------------

detailed_route \
    -output_drc pd/alu_4bit_route_drc.rpt \
    -output_maze pd/alu_4bit_route_maze.log

# ------------------------------------------------------------
# Save routed design
# ------------------------------------------------------------

write_def pd/alu_4bit_routed.def
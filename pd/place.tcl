cat > pd/place.tcl <<'EOF'
# ============================================================
# 4-bit ALU - Sky130 HD Physical Design
# Stage 2: I/O Pin Placement + Standard Cell Placement
# ============================================================

set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
set LIB      $PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# ------------------------------------------------------------
# Read technology and standard-cell libraries
# ------------------------------------------------------------

read_lef $TECH_LEF
read_lef $CELL_LEF
read_liberty $LIB

# ------------------------------------------------------------
# Load existing floorplan
# ------------------------------------------------------------

read_def pd/alu_4bit_floorplan.def

# ------------------------------------------------------------
# Create routing tracks
#
# Sky130:
#   met1 = 0.170 um pitch
#   met2 = 0.300 um pitch
#   met3 = 0.300 um pitch
# ------------------------------------------------------------

make_tracks met1 \
    -x_pitch 0.170 \
    -y_pitch 0.170 \
    -x_offset 0.085 \
    -y_offset 0.085

make_tracks met2 \
    -x_pitch 0.300 \
    -y_pitch 0.300 \
    -x_offset 0.150 \
    -y_offset 0.150

make_tracks met3 \
    -x_pitch 0.300 \
    -y_pitch 0.300 \
    -x_offset 0.150 \
    -y_offset 0.150

# ------------------------------------------------------------
# Place top-level I/O pins
#
# Horizontal pins -> met3
# Vertical pins   -> met2
# ------------------------------------------------------------

place_pins \
    -hor_layers met3 \
    -ver_layers met2

# ------------------------------------------------------------
# Global placement
# ------------------------------------------------------------

global_placement \
    -density 0.50

# ------------------------------------------------------------
# Detailed placement / legalization
# ------------------------------------------------------------

detailed_placement

# ------------------------------------------------------------
# Report
# ------------------------------------------------------------

report_design_area

# ------------------------------------------------------------
# Save placed design
# ------------------------------------------------------------

write_def pd/alu_4bit_placed.def

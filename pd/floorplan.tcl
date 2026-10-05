# ============================================================
# 4-bit ALU - Sky130 HD Physical Design
# Stage 1: Initial Floorplan
# ============================================================

# ------------------------------------------------------------
# PDK
# ------------------------------------------------------------
set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

# ------------------------------------------------------------
# Technology / Cell LEF
# ------------------------------------------------------------
set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef

read_lef $TECH_LEF
read_lef $CELL_LEF

# ------------------------------------------------------------
# Timing Library
# ------------------------------------------------------------
set LIB $PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_liberty $LIB

# ------------------------------------------------------------
# Synthesized Sky130-mapped netlist
# ------------------------------------------------------------
read_verilog synth/alu_4bit_sky130.v

# ------------------------------------------------------------
# Link design
# ------------------------------------------------------------
link_design alu_4bit

# ------------------------------------------------------------
# Initial Floorplan
# ------------------------------------------------------------
# Sky130 HD standard-cell placement site = unithd
initialize_floorplan \
    -utilization 50 \
    -aspect_ratio 1.0 \
    -core_space 10 \
    -site unithd

# ------------------------------------------------------------
# Report design area
# ------------------------------------------------------------
report_design_area

# ------------------------------------------------------------
# Save initial floorplan
# ------------------------------------------------------------
write_def pd/alu_4bit_floorplan.def

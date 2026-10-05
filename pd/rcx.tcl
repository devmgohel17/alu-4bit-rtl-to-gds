# ============================================================
# 4-bit ALU - Sky130 HD
# Stage 5: Post-Route Parasitic Extraction
# ============================================================

set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef

set RCX_RULES $PDK/libs.tech/librelane/rules.openrcx.sky130A.nom.spef_extractor

# ------------------------------------------------------------
# Read technology and routed design
# ------------------------------------------------------------

read_lef $TECH_LEF
read_lef $CELL_LEF

read_def pd/alu_4bit_routed.def

# ------------------------------------------------------------
# Define nominal extraction corner
# ------------------------------------------------------------

define_process_corner \
    -ext_model_index 0 \
    $RCX_RULES

# ------------------------------------------------------------
# Extract routed parasitics
# ------------------------------------------------------------

extract_parasitics \
    -ext_model_file $RCX_RULES \
    -corner 0

# ------------------------------------------------------------
# Write SPEF
# ------------------------------------------------------------

write_spef pd/alu_4bit_nominal.spef

puts ""
puts "============================================================"
puts "POST-ROUTE RC EXTRACTION COMPLETE"
puts "============================================================"
puts "SPEF: pd/alu_4bit_nominal.spef"
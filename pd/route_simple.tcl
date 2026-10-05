set PDK /home/dev/.ciel/ciel/sky130/versions/1689ac3f2dc763876eaf967227c7dfe831b031ae/sky130A

set TECH_LEF $PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set CELL_LEF $PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef

read_lef $TECH_LEF
read_lef $CELL_LEF

read_def pd/alu_4bit_placed.def

# Routing tracks
make_tracks li1  -x_offset 0.23 -x_pitch 0.46 -y_offset 0.17 -y_pitch 0.34
make_tracks met1 -x_offset 0.17 -x_pitch 0.34 -y_offset 0.17 -y_pitch 0.34
make_tracks met2 -x_offset 0.23 -x_pitch 0.46 -y_offset 0.23 -y_pitch 0.46

# Only use li1/met1/met2 for signal routing
set_routing_layers -signal met1-met2

global_route \
    -guide_file pd/alu_4bit_simple.guide \
    -congestion_iterations 50

detailed_route \
    -output_drc pd/alu_4bit_simple_drc.rpt \
    -output_maze pd/alu_4bit_simple_maze.log

write_def pd/alu_4bit_simple_routed.def
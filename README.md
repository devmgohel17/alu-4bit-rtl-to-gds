# 4-bit ALU — RTL to GDSII

A complete RTL-to-GDSII implementation of a 4-bit Arithmetic Logic Unit (ALU) using open-source digital design and physical design tools with the SkyWater SKY130 PDK.

The project covers the digital implementation, verification, synthesis, standard-cell mapping, floorplanning, placement, routing, parasitic extraction, post-route timing analysis, physical DRC, and GDSII generation.

---

## Project Overview

The ALU accepts two 4-bit operands and a 3-bit operation code and produces a 4-bit result along with Zero and Carry status outputs.

### Supported Operations

| OP | Operation | Description |
|---|---|---|
| `000` | ADD | A + B |
| `001` | SUB | A - B |
| `010` | AND | A & B |
| `011` | OR | A \| B |
| `100` | XOR | A ^ B |
| `101` | NOT | ~A |
| `110` | LESS THAN | A < B |
| `111` | EQUAL | A == B |

The Carry output is meaningful for the addition operation, while Zero indicates whether the ALU result is zero.

---

## RTL-to-GDSII Flow

┌Verilog RTL
    │
    ▼
RTL Functional Simulation
    │
    ▼
Logic Synthesis (Yosys)
    │
    ▼
SKY130 Standard-Cell Mapping
    │
    ▼
Floorplanning (OpenROAD)
    │
    ▼
Placement (OpenROAD)
    │
    ▼
Routing (OpenROAD)
    │
    ▼
Parasitic Extraction / SPEF
    │
    ▼
Post-Route STA (OpenROAD)
    │
    ▼
Physical DRC (Magic)
    │
    ▼
GDSII

 | Category              | Tool / Technology    |
| --------------------- | -------------------- |
| RTL                   | Verilog              |
| RTL Simulation        | Icarus Verilog       |
| Waveform Analysis     | GTKWave              |
| Synthesis             | Yosys                |
| Physical Design       | OpenROAD             |
| Parasitic Extraction  | OpenROAD RCX         |
| Physical Verification | Magic                |
| Process Design Kit    | SkyWater SKY130      |
| Standard Cell Library | SKY130 HD            |
| OS / Environment      | Ubuntu 22.04 on WSL2 |

Design Flow
1. RTL Design

The ALU was implemented in synthesizable Verilog using combinational logic.

Source:

rtl/alu_4bit.v

2. Functional Verification

A self-checking Verilog testbench was developed to verify all supported ALU operations and important corner cases.

The testbench includes:

Addition
Subtraction
Bitwise AND
Bitwise OR
Bitwise XOR
Bitwise NOT
Less-than comparison
Equality comparison
Addition overflow / carry
Zero-result detection

Source:

tb/alu_4bit_tb.v

All 15 functional tests passed.

3. Logic Synthesis

Yosys was used to synthesize the RTL and generate a generic gate-level representation.

The design was subsequently mapped to the SKY130 HD standard-cell library.

Mapped netlist:

synth/alu_4bit_sky130.v

4. Floorplanning

OpenROAD was used to create the initial floorplan.

Configuration:

Target utilization: 50%
Aspect ratio: 1.0
Core spacing: 10 µm
SKY130 HD standard-cell site

Final effective utilization:

57.4%

5. Placement

Global and detailed placement were performed using OpenROAD.

The placement was legalized with zero remaining placement violations.

6. Routing

The design was routed using OpenROAD global and detailed routing.

Final routed design:

pd/alu_4bit_routed.def

A simplified metal-layer routing configuration was also generated for physical layout inspection and GDSII generation.

7. Parasitic Extraction

Post-route parasitic extraction was performed using OpenROAD RCX with the SKY130 extraction rules.

Generated SPEF:

pd/alu_4bit_nominal.spef

8. Post-Route Static Timing Analysis

Post-route timing analysis was performed using the extracted parasitics.

Timing Results
Metric	Result
Clock Period	10.0 ns
Worst Slack	+6.48 ns
TNS	0 ns
Critical Path Delay	~3.52 ns
Design Area	~388 µm²
Effective Utilization	~57.4%

The worst path was from an input operand bit to the Zero output.

9. Physical DRC

Magic was used to inspect the generated physical layout and perform physical design-rule checking.

Result:

0 DRC violations reported

10. GDSII Generation

The final physical layout was exported as GDSII for the SKY130 technology.

pd/alu_4bit_simple.gds
Key Results
Parameter	Result
Standard-cell instances	66
Design area	~388 µm²
Core area	~675.6 µm²
Effective utilization	~57.4%
Routed wire length	~1368 µm
Worst post-route slack	+6.48 ns
Total negative slack	0 ns
Critical-path delay	~3.52 ns
Physical DRC violations	0
GDSII generated	Yes

Repository Structure

alu-4bit-rtl-to-gds/
│
├── rtl/
│   └── alu_4bit.v
│
├── tb/
│   └── alu_4bit_tb.v
│
├── synth/
│   ├── alu_4bit_netlist.v
│   ├── alu_4bit_sky130.v
│   └── synth_sky130.ys
│
├── pd/
│   ├── alu_4bit.sdc
│   ├── floorplan.tcl
│   ├── place.tcl
│   ├── route.tcl
│   ├── route_simple.tcl
│   ├── timing.tcl
│   ├── rcx.tcl
│   ├── post_route_sta.tcl
│   ├── alu_4bit_floorplan.def
│   ├── alu_4bit_placed.def
│   ├── alu_4bit_routed.def
│   ├── alu_4bit_simple_routed.def
│   ├── alu_4bit_nominal.spef
│   └── alu_4bit_simple.gds
│
├── .gitignore
└── README.md

What I Learned

This project provided hands-on experience with:

Writing synthesizable Verilog RTL
Creating self-checking testbenches
RTL functional verification
Logic synthesis
Standard-cell technology mapping
SKY130 PDK integration
Floorplanning
Placement and legalization
Global and detailed routing
Parasitic extraction
SPEF generation
Static timing analysis
Physical design-rule checking
GDSII generation
Understanding the complete RTL-to-GDSII flow
Limitations

This project is intended as an open-source physical-design learning and portfolio project.

The reported timing results are based on the project's defined timing constraints and SKY130 nominal characterization setup.

LVS was investigated during the project but was not completed successfully; therefore, no LVS-passed claim is made.

Author

Dev Gohel

Electrical & Computer Engineer focused on:

Physical Design
Semiconductor Engineering
PCB Design
Hardware Engineering
Digital IC Design
Hardware Validation

GitHub: devmgohel17

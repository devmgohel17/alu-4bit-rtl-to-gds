# 4-bit ALU — RTL-to-GDSII Physical Design Flow

A complete RTL-to-GDSII implementation of a 4-bit Arithmetic Logic Unit
using the SkyWater SKY130 PDK and open-source VLSI tools.

## Overview

The ALU supports:

- Addition
- Subtraction
- AND
- OR
- XOR
- NOT
- Less-than comparison
- Equality comparison

## Architecture

Inputs:

- A[3:0]
- B[3:0]
- OP[2:0]

Outputs:

- Y[3:0]
- Zero
- Carry

## RTL-to-GDSII Flow

```text
Verilog RTL
    ↓
RTL Simulation
    ↓
Yosys Synthesis
    ↓
Sky130 Standard-Cell Mapping
    ↓
Floorplanning
    ↓
Global + Detailed Placement
    ↓
Global + Detailed Routing
    ↓
Parasitic Extraction
    ↓
Post-Route STA
    ↓
Physical DRC
    ↓
GDSII
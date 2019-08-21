* tb_INV.sp
**  ************    LibreSilicon's StdCellLibrary   *******************
**
**  Organisation:   Chipforge
**                  Germany / European Union
**
**  Profile:        Chipforge focus on fine System-on-Chip Cores in
**                  Verilog HDL Code which are easy understandable and
**                  adjustable. For further information see
**                          www.chipforge.org
**                  there are projects from small cores up to PCBs, too.
**
**  File:           StdCellLib/TBench/spice/tb_INV.sp
**
**  Purpose:        INV Testbench
**
**  ************    Spice 3f.5 / July 1993  ***************************
**
**  ///////////////////////////////////////////////////////////////////
**
**  Copyright (c) 2018 by chipforge <hsank@nospam.chipforge.org>
**  All rights reserved.
**
**      This Standard Cell Library is licensed under the Libre Silicon
**      public license; you can redistribute it and/or modify it under
**      the terms of the Libre Silicon public license as published by
**      the Libre Silicon alliance, either version 1 of the License, or
**      (at your option) any later version.
**
**      This design is distributed in the hope that it will be useful,
**      but WITHOUT ANY WARRANTY; without even the implied warranty of
**      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**      See the Libre Silicon Public License for more details.
**
**  ///////////////////////////////////////////////////////////////////

**  -------------------------------------------------------------------
**                          PARAMETERS & MODELS
**  -------------------------------------------------------------------

.param SUPPLY=5.0   $ voltage
.param LAMBDA=0.5U  $ half of the feature size
.temp 25            $ celsius

* LibreSilicon 1um Technology file
.include ls1u_models.lib

**  -------------------------------------------------------------------
**                          NETLIST
**  -------------------------------------------------------------------

.subckt INV A Z
MNA Z   A   gnd gnd lsnmos W={1*3*LAMBDA} L={2*LAMBDA} PS={5*LAMBDA} PD={5*LAMBDA} AS={W*PS} AD={W*PD}
MPA Z   A   vdd vdd lspmos W={2*3*LAMBDA} L={2*LAMBDA} PS={5*LAMBDA} PD={5*LAMBDA} AS={W*PS} AD={W*PD}
.ends

Vdd vdd gnd 'SUPPLY'
Vin a   gnd PULSE   0 'SUPPLY' 0p 100p 100p 500p 1000p
X1  a   b   INV
X2  b   c   INV
X3  c   d   INV
X4  d   e   INV
X5  e   f   INV

**  -------------------------------------------------------------------
**                          SIMULATION
**  -------------------------------------------------------------------

.tran 1p 1000p

* rising propagation delay
.measure tpdr
+ TRIG v(c) VAL='SUPPLY/2' FALL=1
+ TARG v(d) VAL='SUPPLY/2' RISE=1
* falling propagation delay
.measure tpdf
+ TRIG v(c) VAL='SUPPLY/2' RISE=1
+ TARG v(d) VAL='SUPPLY/2' FALL=1
* average propagation delay
.measure tpd param='(tpdr+tpdf)/2'
* rise time
.measure trise
+ TRIG v(c) VAL='0.2*SUPPLY' RISE=1
+ TARG v(d) VAL='0.8*SUPPLY' FALL=1
.measure tfall
+ TRIG v(c) VAL='0.8*SUPPLY' FALL=1
+ TARG v(d) VAL='0.2*SUPPLY' RISE=1
.end

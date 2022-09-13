v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Double Clock Bufferering:
- clock enable (high-active)
- de-coupling fan-in load
- 2-phase clock generation} 130 -370 0 0 0.2 0.2 {}
T {Data Input Switch:
- (inverting) tri-state driver
- clock high-active (transparent)} 10 -200 0 0 0.2 0.2 {}
T {QN Stage:
- (inverting) tri-state driver
- clock low-active (transparent)} 390 -200 0 0 0.2 0.2 {}
T {Q Stage:
- inverter} 270 -200 0 0 0.2 0.2 {}
N 180 -280 240 -280 {name=clk180 lab=clk180}
N 340 -280 410 -280 {name=clk360 lab=clk360}
N 40 -300 80 -300 {lab=X}
N 70 -10 120 -10 {lab=clk360}
N 70 -130 120 -130 {lab=clk180}
N 390 -130 440 -130 {lab=clk360}
N 390 -10 440 -10 {lab=clk180}
N 40 -70 80 -70 {lab=D}
N 180 -70 240 -70 {lab=qn}
N 520 -160 520 -70 {lab=qn}
N 210 -160 210 -70 {lab=qn}
N 210 -160 520 -160 {lab=qn}
N 500 -70 520 -70 {lab=qn}
N 370 -90 370 -70 { lab=Q}
N 40 -260 80 -260 {lab=E}
N 340 -70 400 -70 { lab=Q}
C {ipin.sym} 40 -300 0 0 {name=p1 lab=X}
C {lab_wire.sym} 230 -280 0 0 {name=l1 lab=clk180}
C {lab_wire.sym} 400 -280 0 0 {name=l0 lab=clk360}
C {ipin.sym} 40 -70 0 0 {name=p0 lab=D}
C {lab_wire.sym} 110 -130 0 0 {name=l2 lab=clk180}
C {lab_wire.sym} 430 -10 0 0 {name=l4 lab=clk180}
C {lab_wire.sym} 430 -130 0 0 {name=l5 lab=clk360}
C {lab_wire.sym} 110 -10 0 0 {name=l6 lab=clk360}
C {opin.sym} 370 -90 3 0 {name=p2 lab=Q}
C {lab_wire.sym} 520 -70 0 0 {name=l3 lab=qn}
C {ipin.sym} 40 -260 0 0 {name=p3 lab=E}
C {../Symbols/NAND2.sym} 140 -280 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 280 -280 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 120 -70 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 440 -70 0 0 {name=x5 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 280 -70 0 0 {name=x4 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}

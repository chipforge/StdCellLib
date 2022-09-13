v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Double Clock Bufferering:
- 2 clock enable (low-active, 'or'ed)
- de-coupling fan-in load
- 2-phase clock generation} 200 -370 0 0 0.2 0.2 {}
T {Data Input Switch:
- (inverting) tri-state driver
- clock low-active (transparent)} 10 -200 0 0 0.2 0.2 {}
T {QN Stage:
- (inverting) tri-state driver
- clock high-active (transparent)} 450 -200 0 0 0.2 0.2 {}
T {Q Stage:
- inverting OR
- asynchronous (high-active) Reset pulls down} 210 -200 0 0 0.2 0.2 {}
N 410 -280 480 -280 {name=clk360 lab=clk360}
N 70 -10 120 -10 {lab=clk180}
N 70 -130 120 -130 {lab=clk360}
N 430 -110 480 -110 {lab=clk180}
N 430 10 480 10 {lab=clk360}
N 40 -70 80 -70 {lab=D}
N 210 -160 210 -70 {lab=qn}
N 140 -260 160 -260 { lab=XN}
N 40 -280 70 -280 { lab=EN1}
N 40 -320 70 -320 { lab=EN0}
N 210 -160 570 -160 { lab=qn}
N 570 -160 570 -50 { lab=qn}
N 380 -70 380 -50 { lab=Q}
N 180 -70 250 -70 { lab=qn}
N 210 -30 250 -30 { lab=R}
N 360 -50 440 -50 { lab=Q}
N 280 -280 310 -280 { lab=clk180}
N 530 -50 570 -50 {}
C {ipin.sym} 140 -260 0 0 {name=p1 lab=XN}
C {lab_wire.sym} 300 -280 0 0 {name=l1 lab=clk180}
C {lab_wire.sym} 470 -280 0 0 {name=l0 lab=clk360}
C {ipin.sym} 40 -70 0 0 {name=p0 lab=D}
C {lab_wire.sym} 110 -130 0 0 {name=l2 lab=clk360}
C {lab_wire.sym} 470 10 0 0 {name=l4 lab=clk360}
C {lab_wire.sym} 470 -110 0 0 {name=l5 lab=clk180}
C {lab_wire.sym} 110 -10 0 0 {name=l6 lab=clk180}
C {opin.sym} 380 -70 3 0 {name=p2 lab=Q}
C {lab_wire.sym} 560 -50 0 0 {name=l3 lab=qn}
C {ipin.sym} 50 -320 0 0 {name=p3 lab=EN0}
C {ipin.sym} 50 -280 0 0 {name=p4 lab=EN1}
C {ipin.sym} 210 -30 0 0 {name=p5 lab=R}
C {../Symbols/AOI21.sym} 130 -300 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 350 -280 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/NOR2.sym} 310 -50 0 0 {name=x4 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 120 -70 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 470 -50 0 0 {name=x5 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}

v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Double Clock Bufferering:
- 2 clock enable (high-active, 'or'ed)
- de-coupling fan-in load
- 2-phase clock generation} 210 -370 0 0 0.2 0.2 {}
T {Data Input Switch:
- (inverting) tri-state driver
- clock high-active (transparent)} 10 -200 0 0 0.2 0.2 {}
T {QN Stage:
- (inverting) tri-state driver
- clock low-active (transparent)} 420 -200 0 0 0.2 0.2 {}
T {Q Stage:
- inverting AND
- asynchronous (low-active) Set pulls up} 210 -200 0 0 0.2 0.2 {}
N 260 -280 320 -280 {name=clk180 lab=clk180}
N 420 -280 490 -280 {name=clk360 lab=clk360}
N 100 -260 140 -260 {lab=X}
N 70 -10 120 -10 {lab=clk360}
N 70 -130 120 -130 {lab=clk180}
N 400 -110 450 -110 {lab=clk360}
N 400 10 450 10 {lab=clk180}
N 40 -70 80 -70 {lab=D}
N 210 -160 210 -70 {lab=qn}
N 210 -160 520 -160 {lab=qn}
N 510 -50 530 -50 {lab=qn}
N 380 -70 380 -50 { lab=Q}
N 520 -160 540 -160 { lab=qn}
N 540 -160 540 -50 { lab=qn}
N 530 -50 540 -50 { lab=qn}
N 200 -30 250 -30 { lab=SN}
N 180 -70 250 -70 { lab=qn}
N 350 -50 410 -50 { lab=Q}
N 30 -320 50 -320 { lab=E0}
N 30 -280 50 -280 { lab=E1}
C {ipin.sym} 110 -260 0 0 {name=p1 lab=X}
C {lab_wire.sym} 310 -280 0 0 {name=l1 lab=clk180}
C {lab_wire.sym} 480 -280 0 0 {name=l0 lab=clk360}
C {ipin.sym} 40 -70 0 0 {name=p0 lab=D}
C {lab_wire.sym} 110 -130 0 0 {name=l2 lab=clk180}
C {lab_wire.sym} 440 10 0 0 {name=l4 lab=clk180}
C {lab_wire.sym} 440 -110 0 0 {name=l5 lab=clk360}
C {lab_wire.sym} 110 -10 0 0 {name=l6 lab=clk360}
C {opin.sym} 380 -70 3 0 {name=p2 lab=Q}
C {lab_wire.sym} 530 -50 0 0 {name=l3 lab=qn}
C {ipin.sym} 40 -320 0 0 {name=p3 lab=E0}
C {ipin.sym} 40 -280 0 0 {name=p4 lab=E1}
C {ipin.sym} 210 -30 0 0 {name=p5 lab=SN}
C {../Symbols/OAI21.sym} 110 -300 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 360 -280 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 120 -70 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 450 -50 0 0 {name=x5 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/NAND2.sym} 310 -50 0 0 {name=x4 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}

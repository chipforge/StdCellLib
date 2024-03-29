v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Double Clock Bufferering:
- de-coupling fan-in load
- 2-phase clock generation} 130 -370 0 0 0.2 0.2 {}
T {Data Input Switch:
- (inverting) tri-state driver
- clock low-active (transparent)} 10 -200 0 0 0.2 0.2 {}
T {QN Stage:
- (inverting) tri-state driver
- clock high-active (transparent)} 430 -200 0 0 0.2 0.2 {}
T {Q Stage:
- inverting AND
- asynchronous (low-active) Set pulls up} 210 -200 0 0 0.2 0.2 {}
N 340 -280 410 -280 {name=clk360 lab=clk360}
N 30 -280 70 -280 {lab=XN}
N 70 -10 120 -10 {lab=clk180}
N 70 -130 120 -130 {lab=clk360}
N 400 -110 450 -110 {lab=clk180}
N 400 10 450 10 {lab=clk360}
N 40 -70 80 -70 {lab=D}
N 180 -70 240 -70 {lab=qn}
N 210 -160 210 -70 {lab=qn}
N 210 -160 520 -160 {lab=qn}
N 510 -50 530 -50 {lab=qn}
N 380 -70 380 -50 { lab=Q}
N 520 -160 540 -160 { lab=qn}
N 540 -160 540 -50 { lab=qn}
N 530 -50 540 -50 { lab=qn}
N 220 -30 240 -30 { lab=SN}
N 170 -280 240 -280 { lab=clk180}
N 350 -50 410 -50 { lab=Q}
C {ipin.sym} 40 -280 0 0 {name=p1 lab=XN}
C {lab_wire.sym} 230 -280 0 0 {name=l1 lab=clk180}
C {lab_wire.sym} 400 -280 0 0 {name=l0 lab=clk360}
C {ipin.sym} 40 -70 0 0 {name=p0 lab=D}
C {lab_wire.sym} 110 -130 0 0 {name=l2 lab=clk360}
C {lab_wire.sym} 440 10 0 0 {name=l4 lab=clk360}
C {lab_wire.sym} 440 -110 0 0 {name=l5 lab=clk180}
C {lab_wire.sym} 110 -10 0 0 {name=l6 lab=clk180}
C {opin.sym} 380 -70 3 0 {name=p2 lab=Q}
C {lab_wire.sym} 530 -50 0 0 {name=l3 lab=qn}
C {ipin.sym} 220 -30 0 0 {name=p3 lab=SN}
C {../Symbols/NAND2.sym} 300 -50 0 0 {name=x4 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 120 -70 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/TRI.sym} 450 -50 0 0 {name=x5 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 110 -280 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 280 -280 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}

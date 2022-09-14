v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {2-phase Select signal:
- reduces fan-in
- involves high-active Enable} 130 -580 0 0 0.2 0.2 {}
T {S = 1 arm/branch
- (inverting) tri-state driver
- high-active transparent} 70 -410 0 0 0.2 0.2 {}
T {S = 0 arm/branch
- (inverting) tri-state driver
- low-active transparent} 450 -410 0 1 0.2 0.2 {}
N 340 -490 410 -490 {name=clk360 lab=s1}
N 170 -490 240 -490 { lab=s0}
N 150 -190 150 -170 { lab=Y}
N 100 -220 110 -220 { lab=A1}
N 100 -220 100 -140 { lab=A1}
N 100 -140 110 -140 { lab=A1}
N 40 -180 100 -180 { lab=A1}
N 150 -220 160 -220 { lab=VDD}
N 150 -140 160 -140 { lab=GND}
N 150 -270 150 -250 { lab=#net1}
N 150 -110 150 -90 { lab=#net2}
N 150 -300 160 -300 { lab=VDD}
N 150 -60 160 -60 { lab=GND}
N 160 -300 160 -220 { lab=VDD}
N 160 -330 160 -300 { lab=VDD}
N 150 -330 160 -330 { lab=VDD}
N 160 -140 160 -60 { lab=GND}
N 160 -60 160 -30 { lab=GND}
N 150 -30 160 -30 { lab=GND}
N 50 -300 110 -300 { lab=s0}
N 50 -60 110 -60 { lab=s1}
N 370 -190 370 -170 { lab=Y}
N 360 -140 370 -140 { lab=GND}
N 420 -180 480 -180 { lab=A0}
N 370 -270 370 -250 { lab=#net3}
N 370 -110 370 -90 { lab=#net4}
N 360 -300 370 -300 { lab=VDD}
N 360 -60 370 -60 { lab=GND}
N 360 -300 360 -220 { lab=VDD}
N 360 -330 360 -300 { lab=VDD}
N 360 -330 370 -330 { lab=VDD}
N 360 -140 360 -60 { lab=GND}
N 360 -60 360 -30 { lab=GND}
N 360 -30 370 -30 { lab=GND}
N 410 -300 470 -300 { lab=s1}
N 410 -60 470 -60 { lab=s0}
N 360 -220 370 -220 { lab=VDD}
N 410 -220 420 -220 { lab=A0}
N 410 -140 420 -140 { lab=A0}
N 420 -220 420 -140 { lab=A0}
N 150 -180 370 -180 { lab=Y}
N 260 -180 260 -160 { lab=Y}
N 30 -510 50 -510 { lab=S}
N 40 -470 50 -470 {}
C {ipin.sym} 40 -510 0 0 {name=p1 lab=S}
C {lab_wire.sym} 230 -490 0 0 {name=l1 lab=s0}
C {lab_wire.sym} 400 -490 0 0 {name=l0 lab=s1}
C {../Symbols/INV.sym} 280 -490 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {nmos4.sym} 130 -140 0 0 {name=m3 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} 130 -220 0 0 {name=m2 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} 40 -180 0 0 {name=p3 lab=A1}
C {vdd.sym} 150 -330 0 0 {name=l7 lab=VDD}
C {gnd.sym} 150 -30 0 0 {name=l8 lab=GND}
C {opin.sym} 260 -160 1 0 {name=p4 lab=Y}
C {nmos4.sym} 130 -60 0 0 {name=m4 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} 130 -300 0 0 {name=m1 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 70 -300 0 0 {name=l2 lab=s0}
C {lab_wire.sym} 70 -60 0 0 {name=l3 lab=s1}
C {nmos4.sym} 390 -140 0 1 {name=m7 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} 390 -220 0 1 {name=m6 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} 480 -180 0 1 {name=p2 lab=A0}
C {vdd.sym} 370 -330 0 1 {name=l4 lab=VDD}
C {gnd.sym} 370 -30 0 1 {name=l5 lab=GND}
C {nmos4.sym} 390 -60 0 1 {name=m8 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} 390 -300 0 1 {name=m5 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 460 -60 0 1 {name=l6 lab=s0}
C {lab_wire.sym} 460 -300 0 1 {name=l9 lab=s1}
C {../Symbols/NAND2.sym} 110 -490 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {ipin.sym} 40 -470 0 0 {name=p5 lab=E}

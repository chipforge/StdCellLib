v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {2-phase Select S0:
- reduces fan-in} 140 -740 0 0 0.2 0.2 {}
T {2-phase Select S1:
- reduces fan-in} 590 -740 0 0 0.2 0.2 {}
T {S[1:0] = 3 arm/branch
- (inverting) tri-state driver} 150 -570 0 0 0.2 0.2 {}
T {S[1:0] = 2 arm/branch
- (inverting) tri-state driver} 370 -570 0 0 0.2 0.2 {}
T {S[1:0] = 1 arm/branch
- (inverting) tri-state driver} 600 -570 0 0 0.2 0.2 {}
T {S[1:0] = 0 arm/branch
- (inverting) tri-state driver} 820 -570 0 0 0.2 0.2 {}
N 350 -650 420 -650 {name=clk360 lab=s01}
N 40 -650 80 -650 {lab=S0}
N 180 -650 250 -650 { lab=s00}
N 800 -650 870 -650 {name=clk360 lab=s11}
N 490 -650 530 -650 {lab=S1}
N 630 -650 700 -650 { lab=s10}
N 230 -270 230 -250 { lab=Y}
N 50 -290 110 -290 { lab=A3}
N 230 -300 240 -300 { lab=VDD}
N 230 -220 240 -220 { lab=GND}
N 230 -350 230 -330 { lab=#net1}
N 230 -60 240 -60 { lab=GND}
N 240 -60 240 -30 { lab=GND}
N 230 -30 240 -30 { lab=GND}
N 130 -60 190 -60 { lab=s11}
N 230 -460 240 -460 { lab=VDD}
N 240 -490 240 -460 { lab=VDD}
N 230 -490 240 -490 { lab=VDD}
N 130 -460 190 -460 { lab=s10}
N 230 -430 230 -410 { lab=#net2}
N 240 -460 240 -300 { lab=VDD}
N 230 -380 240 -380 { lab=VDD}
N 230 -110 230 -90 { lab=#net3}
N 230 -190 230 -170 { lab=#net4}
N 240 -220 240 -60 { lab=GND}
N 230 -140 240 -140 { lab=GND}
N 130 -380 190 -380 { lab=s00}
N 130 -140 190 -140 { lab=s01}
N 130 -300 190 -300 { lab=A3}
N 130 -220 190 -220 { lab=A3}
N 50 -270 110 -270 { lab=A2}
N 50 -250 110 -250 { lab=A1}
N 50 -230 110 -230 { lab=A0}
N 450 -270 450 -250 { lab=Y}
N 450 -300 460 -300 { lab=VDD}
N 450 -220 460 -220 { lab=GND}
N 450 -350 450 -330 { lab=#net5}
N 450 -60 460 -60 { lab=GND}
N 460 -60 460 -30 { lab=GND}
N 450 -30 460 -30 { lab=GND}
N 350 -60 410 -60 { lab=s11}
N 450 -460 460 -460 { lab=VDD}
N 460 -490 460 -460 { lab=VDD}
N 450 -490 460 -490 { lab=VDD}
N 350 -460 410 -460 { lab=s10}
N 450 -430 450 -410 { lab=#net6}
N 460 -460 460 -300 { lab=VDD}
N 450 -380 460 -380 { lab=VDD}
N 450 -110 450 -90 { lab=#net7}
N 450 -190 450 -170 { lab=#net8}
N 460 -220 460 -60 { lab=GND}
N 450 -140 460 -140 { lab=GND}
N 350 -380 410 -380 { lab=s01}
N 350 -140 410 -140 { lab=s00}
N 350 -300 410 -300 { lab=A2}
N 350 -220 410 -220 { lab=A2}
N 680 -270 680 -250 { lab=Y}
N 680 -300 690 -300 { lab=VDD}
N 680 -220 690 -220 { lab=GND}
N 680 -350 680 -330 { lab=#net9}
N 680 -60 690 -60 { lab=GND}
N 690 -60 690 -30 { lab=GND}
N 680 -30 690 -30 { lab=GND}
N 580 -60 640 -60 { lab=s10}
N 680 -460 690 -460 { lab=VDD}
N 690 -490 690 -460 { lab=VDD}
N 680 -490 690 -490 { lab=VDD}
N 580 -460 640 -460 { lab=s11}
N 680 -430 680 -410 { lab=#net10}
N 690 -460 690 -300 { lab=VDD}
N 680 -380 690 -380 { lab=VDD}
N 680 -110 680 -90 { lab=#net11}
N 680 -190 680 -170 { lab=#net12}
N 690 -220 690 -60 { lab=GND}
N 680 -140 690 -140 { lab=GND}
N 580 -380 640 -380 { lab=s00}
N 580 -140 640 -140 { lab=s01}
N 580 -300 640 -300 { lab=A1}
N 580 -220 640 -220 { lab=A1}
N 900 -270 900 -250 { lab=Y}
N 900 -300 910 -300 { lab=VDD}
N 900 -220 910 -220 { lab=GND}
N 900 -350 900 -330 { lab=#net13}
N 900 -60 910 -60 { lab=GND}
N 910 -60 910 -30 { lab=GND}
N 900 -30 910 -30 { lab=GND}
N 800 -60 860 -60 { lab=s10}
N 900 -460 910 -460 { lab=VDD}
N 910 -490 910 -460 { lab=VDD}
N 900 -490 910 -490 { lab=VDD}
N 800 -460 860 -460 { lab=s11}
N 900 -430 900 -410 { lab=#net14}
N 910 -460 910 -300 { lab=VDD}
N 900 -380 910 -380 { lab=VDD}
N 900 -110 900 -90 { lab=#net15}
N 900 -190 900 -170 { lab=#net16}
N 910 -220 910 -60 { lab=GND}
N 900 -140 910 -140 { lab=GND}
N 800 -380 860 -380 { lab=s01}
N 800 -140 860 -140 { lab=s00}
N 800 -300 860 -300 { lab=A0}
N 800 -220 860 -220 { lab=A0}
N 230 -260 450 -260 { lab=Y}
N 450 -260 680 -260 { lab=Y}
N 680 -260 900 -260 { lab=Y}
N 900 -260 1010 -260 { lab=Y}
C {ipin.sym} 50 -650 0 0 {name=p1 lab=S0}
C {lab_wire.sym} 240 -650 0 0 {name=l1 lab=s00}
C {lab_wire.sym} 410 -650 0 0 {name=l0 lab=s01}
C {../Symbols/INV.sym} 120 -650 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 290 -650 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {ipin.sym} 500 -650 0 0 {name=p5 lab=S1}
C {lab_wire.sym} 690 -650 0 0 {name=l10 lab=s10}
C {lab_wire.sym} 860 -650 0 0 {name=l11 lab=s11}
C {../Symbols/INV.sym} 570 -650 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 740 -650 0 0 {name=x4 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {nmos4.sym} 210 -220 0 0 {name=m4 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {pmos4.sym} 210 -300 0 0 {name=m3 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {ipin.sym} 50 -290 0 0 {name=p6 lab=A3}
C {gnd.sym} 230 -30 0 0 {name=l13 lab=GND}
C {nmos4.sym} 210 -60 0 0 {name=m6 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 150 -60 0 0 {name=l15 lab=s11}
C {vdd.sym} 230 -490 0 0 {name=l12 lab=VDD}
C {pmos4.sym} 210 -460 0 0 {name=m1 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 150 -460 0 0 {name=l14 lab=s10}
C {pmos4.sym} 210 -380 0 0 {name=m2 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {nmos4.sym} 210 -140 0 0 {name=m5 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 150 -380 0 0 {name=l16 lab=s00}
C {lab_wire.sym} 150 -140 0 0 {name=l17 lab=s01}
C {opin.sym} 1010 -260 0 0 {name=p4 lab=Y}
C {lab_wire.sym} 150 -300 0 0 {name=l2 lab=A3}
C {lab_wire.sym} 150 -220 0 0 {name=l3 lab=A3}
C {ipin.sym} 50 -270 0 0 {name=p2 lab=A2}
C {ipin.sym} 50 -250 0 0 {name=p3 lab=A1}
C {ipin.sym} 50 -230 0 0 {name=p7 lab=A0}
C {nmos4.sym} 430 -220 0 0 {name=m10 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {pmos4.sym} 430 -300 0 0 {name=m9 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {gnd.sym} 450 -30 0 0 {name=l4 lab=GND}
C {nmos4.sym} 430 -60 0 0 {name=m12 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 370 -60 0 0 {name=l5 lab=s11}
C {vdd.sym} 450 -490 0 0 {name=l6 lab=VDD}
C {pmos4.sym} 430 -460 0 0 {name=m7 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 370 -460 0 0 {name=l7 lab=s10}
C {pmos4.sym} 430 -380 0 0 {name=m8 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {nmos4.sym} 430 -140 0 0 {name=m11 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 370 -380 0 0 {name=l8 lab=s01}
C {lab_wire.sym} 370 -140 0 0 {name=l9 lab=s00}
C {lab_wire.sym} 370 -300 0 0 {name=l18 lab=A2}
C {lab_wire.sym} 370 -220 0 0 {name=l19 lab=A2}
C {nmos4.sym} 660 -220 0 0 {name=m16 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {pmos4.sym} 660 -300 0 0 {name=m15 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {gnd.sym} 680 -30 0 0 {name=l20 lab=GND}
C {nmos4.sym} 660 -60 0 0 {name=m18 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 600 -60 0 0 {name=l21 lab=s10}
C {vdd.sym} 680 -490 0 0 {name=l22 lab=VDD}
C {pmos4.sym} 660 -460 0 0 {name=m13 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 600 -460 0 0 {name=l23 lab=s11}
C {pmos4.sym} 660 -380 0 0 {name=m14 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {nmos4.sym} 660 -140 0 0 {name=m17 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 600 -380 0 0 {name=l24 lab=s00}
C {lab_wire.sym} 600 -140 0 0 {name=l25 lab=s01}
C {lab_wire.sym} 600 -300 0 0 {name=l26 lab=A1}
C {lab_wire.sym} 600 -220 0 0 {name=l27 lab=A1}
C {nmos4.sym} 880 -220 0 0 {name=m22 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {pmos4.sym} 880 -300 0 0 {name=m21 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {gnd.sym} 900 -30 0 0 {name=l28 lab=GND}
C {nmos4.sym} 880 -60 0 0 {name=m24 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 820 -60 0 0 {name=l29 lab=s10}
C {vdd.sym} 900 -490 0 0 {name=l30 lab=VDD}
C {pmos4.sym} 880 -460 0 0 {name=m19 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {lab_wire.sym} 820 -460 0 0 {name=l31 lab=s11}
C {pmos4.sym} 880 -380 0 0 {name=m20 model=pmos4 w='3*g*Wmin' l=Lmin m=m}
C {nmos4.sym} 880 -140 0 0 {name=m23 model=nmos4 w='3*Wmin' l=Lmin m=m}
C {lab_wire.sym} 820 -380 0 0 {name=l32 lab=s01}
C {lab_wire.sym} 820 -140 0 0 {name=l33 lab=s00}
C {lab_wire.sym} 820 -300 0 0 {name=l34 lab=A0}
C {lab_wire.sym} 820 -220 0 0 {name=l35 lab=A0}

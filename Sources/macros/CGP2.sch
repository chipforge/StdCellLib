v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Synchronizing:
- latch high-active enable during low-phase (transparent)} 20 -180 0 0 0.2 0.2 {}
T {Drive:
- skewed clock driver} 450 -40 0 0 0.2 0.2 {}
T {Combine:
- high-active enable signal
- high clock phase} 280 -40 0 0 0.2 0.2 {}
N 40 -120 80 -120 {lab=E}
N 40 -80 80 -80 { lab=XI}
N 60 -80 60 -50 { lab=XI}
N 60 -50 230 -50 { lab=XI}
N 230 -80 230 -50 { lab=XI}
N 190 -120 270 -120 { lab=enable}
N 230 -80 270 -80 { lab=XI}
N 390 -100 430 -100 { lab=#net1}
N 530 -100 570 -100 { lab=XO}
C {ipin.sym} 50 -120 0 0 {name=p1 lab=E}
C {lab_wire.sym} 240 -120 0 0 {name=l1 lab=enable}
C {ipin.sym} 50 -80 0 0 {name=p0 lab=XI}
C {opin.sym} 560 -100 0 0 {name=p2 lab=XO}
C {../Symbols/LATN.sym} 140 -100 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/NAND2.sym} 330 -100 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {../Symbols/INV.sym} 470 -100 0 0 {name=x3 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}

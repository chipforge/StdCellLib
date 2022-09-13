v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Attention:
This gate has higher fan-in} 120 -220 0 0 0.2 0.2 {}
N 30 -70 80 -70 { lab=A}
N 30 -30 80 -30 { lab=A1}
N 50 -160 50 -70 { lab=A}
N 70 -120 70 -30 { lab=A1}
N 50 -160 110 -160 { lab=A}
N 70 -120 110 -120 { lab=A1}
N 200 -100 200 -50 { lab=#net1}
N 320 -120 350 -120 { lab=Z}
C {ipin.sym} 40 -70 0 0 {name=p1 lab=A}
C {ipin.sym} 40 -30 0 0 {name=p0 lab=A1}
C {/home/kubrick/Projects/github.com/StdCellLib/Sources/Symbols/OAI21.sym} 170 -140 0 0 {name=x1 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {/home/kubrick/Projects/github.com/StdCellLib/Sources/Symbols/NAND2.sym} 140 -50 0 0 {name=x2 VDD=VDD GND=GND Wmin=1.5u Lmin=1u g=2 m=1}
C {opin.sym} 350 -120 0 0 {name=p2 lab=Z}

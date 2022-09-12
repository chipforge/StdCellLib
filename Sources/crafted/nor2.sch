v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -80 -10 -80 10 { lab=Y}
N -80 40 -70 40 { lab=GND}
N -90 -120 -80 -120 { lab=VDD}
N 50 40 60 40 { lab=GND}
N -90 -150 -90 -120 { lab=VDD}
N -90 -150 -80 -150 { lab=VDD}
N 50 40 50 70 { lab=GND}
N 50 70 60 70 { lab=GND}
N -130 -40 -120 -40 { lab=A}
N -130 -40 -130 40 { lab=A}
N -130 40 -120 40 { lab=A}
N -190 0 -130 0 { lab=A}
N -80 0 60 -0 { lab=Y}
N 60 -0 60 10 { lab=Y}
N -70 40 -70 70 { lab=GND}
N -80 70 -70 70 { lab=GND}
N 60 -20 60 0 { lab=Y}
N -80 -90 -80 -70 { lab=#net2}
N 100 40 110 40 { lab=A1}
N 110 -0 110 40 { lab=A1}
N 110 -120 140 -120 { lab=A1}
N 110 -120 110 0 { lab=A1}
N -40 -120 110 -120 { lab=A1}
N -80 -40 -60 -40 {}
C {nmos4.sym} -100 40 0 0 {name=m3 model=nmos4 w=Wmin l=Lmin m=m}
C {pmos4.sym} -100 -40 0 0 {name=m1 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} -190 0 0 0 {name=p1 lab=A}
C {vdd.sym} -80 -150 0 1 {name=l1 lab=VDD}
C {gnd.sym} 60 70 0 1 {name=l0 lab=GND}
C {opin.sym} 60 -20 3 0 {name=p0 lab=Y}
C {nmos4.sym} 80 40 0 1 {name=m4 model=nmos4 w=Wmin l=Lmin m=m}
C {pmos4.sym} -60 -120 0 1 {name=m2 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} 130 -120 0 1 {name=p3 lab=A1}
C {gnd.sym} -80 70 0 1 {name=l3 lab=GND}
C {vdd.sym} -60 -40 0 1 {name=l2 lab=VDD}

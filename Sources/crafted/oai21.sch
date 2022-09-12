v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -80 -90 -80 -70 { lab=#net1}
N -80 70 -80 90 { lab=#net2}
N 60 -40 70 -40 { lab=VDD}
N -80 120 -70 120 { lab=GND}
N 70 -70 70 -40 { lab=VDD}
N 60 -70 70 -70 { lab=VDD}
N -70 120 -70 150 { lab=GND}
N -80 150 -70 150 { lab=GND}
N -80 80 80 80 { lab=#net2}
N 80 80 80 90 { lab=#net2}
N 70 120 80 120 { lab=GND}
N 70 120 70 150 { lab=GND}
N 70 150 80 150 { lab=GND}
N -190 40 -130 40 { lab=A}
N -80 -10 -80 0 { lab=Y}
N -80 0 -80 10 { lab=Y}
N -90 40 -80 40 { lab=GND}
N -130 -40 -130 120 { lab=A}
N -130 -40 -120 -40 { lab=A}
N -130 120 -120 120 { lab=A}
N -90 -120 -80 -120 { lab=VDD}
N -90 -150 -90 -120 { lab=VDD}
N -90 -150 -80 -150 { lab=VDD}
N -80 -40 -60 -40 { lab=VDD}
N -40 -120 180 -120 { lab=A1}
N 160 -120 160 120 { lab=A1}
N 120 120 160 120 { lab=A1}
N -80 0 60 -0 { lab=Y}
N 10 -40 20 -40 { lab=A1}
N 10 -40 10 40 { lab=A1}
N -40 40 10 40 { lab=A1}
N 10 40 30 40 { lab=A1}
N 60 -10 60 0 { lab=Y}
N 60 0 110 0 { lab=Y}
C {nmos4.sym} -60 40 0 1 {name=m3 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} -60 -120 0 1 {name=m1 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} 30 40 0 1 {name=p1 lab=B}
C {vdd.sym} 60 -70 0 0 {name=l1 lab=VDD}
C {gnd.sym} -80 150 0 0 {name=l0 lab=GND}
C {opin.sym} 110 0 2 1 {name=p0 lab=Y}
C {nmos4.sym} -100 120 0 0 {name=m4 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} 40 -40 0 0 {name=m2 model=pmos4 w='g*Wmin' l=Lmin m=m}
C {ipin.sym} 180 -120 0 1 {name=p3 lab=A1}
C {vdd.sym} -80 -150 0 0 {name=l2 lab=VDD}
C {gnd.sym} -90 40 0 1 {name=l3 lab=GND}
C {nmos4.sym} 100 120 0 1 {name=m5 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} -100 -40 0 0 {name=m6 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {gnd.sym} 80 150 0 1 {name=l4 lab=GND}
C {ipin.sym} -190 40 0 0 {name=p2 lab=A}
C {vdd.sym} -60 -40 0 1 {name=l5 lab=VDD}

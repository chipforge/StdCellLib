v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 0 -10 0 10 {}
N -50 -40 -40 -40 {}
N -50 -40 -50 40 {}
N -50 40 -40 40 {}
N -110 0 -50 0 {}
N 0 0 100 0 {}
N 0 -70 10 -70 {}
N 10 -70 10 -40 {}
N 0 -40 10 -40 {}
N 0 40 10 40 {}
N 10 40 10 70 {}
N 0 70 10 70 {}
C {nmos4.sym} -20 40 0 0 {name=m2 model=nmos4 w=Wmin l=Lmin m=m}
C {pmos4.sym} -20 -40 0 0 {name=m1 model=pmos4 w='g*Wmin' l=Lmin m=m}
C {ipin.sym} -110 0 0 0 {name=p1 lab=A}
C {vdd.sym} 0 -70 0 0 {name=l1 lab=VDD}
C {gnd.sym} 0 70 0 0 {name=l0 lab=GND}
C {opin.sym} 100 0 0 0 {name=p0 lab=Y}

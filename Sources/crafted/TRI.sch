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
N 0 -40 10 -40 {}
N 0 40 10 40 {}
N -0 -90 -0 -70 {}
N -0 70 -0 90 {}
N 0 -120 10 -120 {}
N -0 120 10 120 {}
N 10 -120 10 -40 {}
N 10 -150 10 -120 {}
N -0 -150 10 -150 {}
N 10 40 10 120 {}
N 10 120 10 150 {}
N -0 150 10 150 {}
N -120 -120 -40 -120 {}
N -110 120 -40 120 {}
C {nmos4.sym} -20 40 0 0 {name=m2 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} -20 -40 0 0 {name=m1 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} -110 0 0 0 {name=p1 lab=A}
C {vdd.sym} 0 -150 0 0 {name=l1 lab=VDD}
C {gnd.sym} 0 150 0 0 {name=l0 lab=GND}
C {iopin.sym} 100 0 0 0 {name=p0 lab=Y}
C {nmos4.sym} -20 120 0 0 {name=m0 model=nmos4 w='2*Wmin' l=Lmin m=m}
C {pmos4.sym} -20 -120 0 0 {name=m3 model=pmos4 w='2*g*Wmin' l=Lmin m=m}
C {ipin.sym} -110 -120 0 0 {name=p2 lab=EN}
C {ipin.sym} -100 120 0 0 {name=p3 lab=E}

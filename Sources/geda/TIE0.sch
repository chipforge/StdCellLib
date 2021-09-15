v 20130925 2
T 7400 100 9 10 1 0 0 0 1
1
T 9000 100 9 10 1 0 0 0 1
1
N 9600 6800 9600 7600 4
N 9700 8500 10700 8500 4
{
T 9800 8600 5 10 1 1 0 0 1
netname=VDD
}
N 10500 8500 10500 8100 4
N 10700 7600 10600 7600 4
N 10700 7600 10700 8500 4
N 10800 2300 11900 2300 4
{
T 11000 2400 5 10 1 1 0 0 1
netname=GND
}
C 9900 7100 1 0 0 asic-pmos-1.sym
{
T 11300 7900 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 10700 7900 5 10 1 1 0 0 1
refdes=M1
T 10700 7700 5 8 1 1 0 0 1
model-name=pmos4
T 10700 7400 5 8 1 0 0 0 1
w='g*Wmin'
T 10700 7200 5 8 1 0 0 0 1
l=1u
}
T 100 400 9 10 1 0 0 0 5
see [KAESLIN, 2008]
Kaeslin, Hubert:
"Digital Integrated Circuit Design. From VLSI Architectures to CMOS Fabrication."
1st Edition, 2008.
Page 427.
B 0 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 6800 0 1 0 0 cvstitleblock-1.sym
{
T 7400 400 5 10 1 1 0 0 1
date=2021-09-15
T 11300 400 5 10 1 1 0 0 1
rev=$Revision$
T 11300 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 7400 700 5 10 1 1 0 0 1
fname=TIE0.sch
T 9100 1100 5 14 1 1 0 4 1
title=TIE0 - pull-down (tie low) cell
}
C 800 7700 1 0 0 spice-model-1.sym
{
T 900 8300 5 10 1 1 0 0 1
refdes=A1
T 2100 8000 5 10 1 1 0 0 1
model-name=nmos4
T 1300 7800 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 800 9000 1 0 0 spice-model-1.sym
{
T 900 9600 5 10 1 1 0 0 1
refdes=A2
T 2100 9300 5 10 1 1 0 0 1
model-name=pmos4
T 1300 9100 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 9900 8800 1 180 0 spice-subcircuit-IO-1.sym
{
T 9900 8800 5 10 1 1 0 0 1
refdes=P2
}
C 11000 2600 1 180 0 spice-subcircuit-IO-1.sym
{
T 11000 2600 5 10 1 1 0 0 1
refdes=P3
}
C 3600 9200 1 0 0 spice-subcircuit-LL-1.sym
{
T 3700 9600 5 10 1 1 0 0 1
refdes=A3
T 3700 9300 5 10 1 1 0 0 1
model-name=TIE0
}
C 6400 9200 1 0 0 spice-directive-1.sym
{
T 6500 9500 5 10 0 1 0 0 1
device=directive
T 6500 9600 5 10 1 1 0 0 1
refdes=A4
T 6500 9300 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 9000 9200 1 0 0 spice-directive-1.sym
{
T 9100 9500 5 10 0 1 0 0 1
device=directive
T 9100 9600 5 10 1 1 0 0 1
refdes=A5
T 9100 9300 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 11100 2700 1 0 0 asic-nmos-1.sym
{
T 12500 3500 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 11900 3500 5 10 1 1 0 0 1
refdes=M2
T 11900 3300 5 8 1 1 0 0 1
model-name=nmos4
T 11900 3000 5 8 1 0 0 0 1
w='Wmin'
T 11900 2800 5 8 1 0 0 0 1
l=1u
}
N 9600 7600 9900 7600 4
N 10500 3200 11100 3200 4
N 11700 2700 11700 2300 4
N 11800 3200 11900 3200 4
N 11900 3200 11900 2300 4
N 10500 3200 10500 7100 4
N 11700 5500 12300 5500 4
{
T 12100 5600 5 10 1 1 0 0 1
netname=Y
}
T 10000 1600 9 10 1 0 0 0 2
Pull-down:
- nMOS (biased w/ pMOS)
C 12100 5200 1 0 0 spice-subcircuit-IO-1.sym
{
T 12600 5800 5 10 1 1 180 0 1
refdes=P1
}
N 9600 6800 10500 6800 4
N 11700 3700 11700 5500 4

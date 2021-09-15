v 20130925 2
T 7400 100 9 10 1 0 0 0 1
1
T 9000 100 9 10 1 0 0 0 1
1
N 10500 8500 12900 8500 4
{
T 10600 8600 5 10 1 1 0 0 1
netname=VDD
}
N 12000 3100 11800 3100 4
N 10500 2200 12000 2200 4
{
T 10700 2300 5 10 1 1 0 0 1
netname=GND
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
fname=TIE1.sch
T 9100 1100 5 14 1 1 0 4 1
title=TIE1 - pull-up (tie high) cell
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
C 10700 8800 1 180 0 spice-subcircuit-IO-1.sym
{
T 10700 8800 5 10 1 1 0 0 1
refdes=P2
}
C 10700 2500 1 180 0 spice-subcircuit-IO-1.sym
{
T 10700 2500 5 10 1 1 0 0 1
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
N 10800 3100 11100 3100 4
N 12700 7600 12900 7600 4
N 12600 5500 13400 5500 4
{
T 13200 5600 5 10 1 1 0 0 1
netname=Y
}
T 10600 1600 9 10 1 0 0 0 2
Pull-up:
- pMOS (biased w/ nMOS)
C 13200 5200 1 0 0 spice-subcircuit-IO-1.sym
{
T 13700 5800 5 10 1 1 180 0 1
refdes=P1
}
N 12000 3100 12000 2200 4
N 11700 2600 11700 2200 4
N 10800 3100 10800 4000 4
N 10800 4000 11700 4000 4
N 11700 3600 11700 7600 4
N 12600 8100 12600 8500 4
N 12900 7600 12900 8500 4
N 12600 7100 12600 5500 4
N 12000 7600 11700 7600 4
C 11100 2600 1 0 0 asic-nmos-1.sym
{
T 12500 3400 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 11900 3400 5 10 1 1 0 0 1
refdes=M2
T 11900 3200 5 8 1 1 0 0 1
model-name=nmos4
T 11900 2900 5 8 1 0 0 0 1
w='Wmin'
T 11900 2700 5 8 1 0 0 0 1
l=1u
}
C 12000 7100 1 0 0 asic-pmos-1.sym
{
T 13400 7900 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 12800 7900 5 10 1 1 0 0 1
refdes=M1
T 12800 7700 5 8 1 1 0 0 1
model-name=pmos4
T 12800 7400 5 8 1 0 0 0 1
w='g*Wmin'
T 12800 7200 5 8 1 0 0 0 1
l=1u
}

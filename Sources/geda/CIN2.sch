v 20130925 2
T 7400 100 9 10 1 0 0 0 1
1
T 9000 100 9 10 1 0 0 0 1
1
N 10800 3200 10800 7700 4
N 10900 8600 11900 8600 4
{
T 11000 8700 5 10 1 1 0 0 1
netname=VDD
}
N 11700 8600 11700 8200 4
N 11900 7700 11800 7700 4
N 11900 7700 11900 8600 4
N 10800 2300 11900 2300 4
{
T 11000 2400 5 10 1 1 0 0 1
netname=GND
}
C 11100 7200 1 0 0 asic-pmos-1.sym
{
T 12500 8000 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 11900 8000 5 10 1 1 0 0 1
refdes=M1
T 11900 7800 5 8 1 1 0 0 1
model-name=pmos4
T 11900 7500 5 8 1 0 0 0 1
w='(drive/skew)*g*Wmin'
T 11900 7300 5 8 1 0 0 0 1
l=1u
}
T 100 1100 9 10 1 0 0 0 1
Reference?
B 0 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 6800 0 1 0 0 cvstitleblock-1.sym
{
T 7400 400 5 10 1 1 0 0 1
date=2021-09-14
T 11300 400 5 10 1 1 0 0 1
rev=$Revision$
T 11300 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 7400 700 5 10 1 1 0 0 1
fname=CIN2.sch
T 10700 1100 5 14 1 1 0 4 1
title=CIN2 - inverting Clock Buffer (Low-skewed), Drive 2x
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
C 10500 5800 1 180 0 spice-subcircuit-IO-1.sym
{
T 10300 5800 5 10 1 1 0 0 1
refdes=P2
}
C 11100 8900 1 180 0 spice-subcircuit-IO-1.sym
{
T 11100 8900 5 10 1 1 0 0 1
refdes=P3
}
C 11000 2600 1 180 0 spice-subcircuit-IO-1.sym
{
T 11000 2600 5 10 1 1 0 0 1
refdes=P4
}
C 3600 9200 1 0 0 spice-subcircuit-LL-1.sym
{
T 3700 9600 5 10 1 1 0 0 1
refdes=A3
T 3700 9300 5 10 1 1 0 0 1
model-name=CIN2
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
w='drive*Wmin'
T 11900 2800 5 8 1 0 0 0 1
l=1u
}
N 10300 5500 10800 5500 4
{
T 10500 5600 5 10 1 1 0 0 1
netname=X
}
N 10800 7700 11100 7700 4
N 10800 3200 11100 3200 4
N 11700 2700 11700 2300 4
N 11800 3200 11900 3200 4
N 11900 3200 11900 2300 4
N 11700 7200 11700 3700 4
N 11700 5500 12300 5500 4
{
T 12100 5600 5 10 1 1 0 0 1
netname=Y
}
T 10000 1500 9 10 1 0 0 0 3
Clock Buffer:
- higher driving strength
- down-sized pMOS (LOW-skewed)
C 11500 9200 1 0 0 spice-directive-1.sym
{
T 11600 9500 5 10 0 1 0 0 1
device=directive
T 11600 9600 5 10 1 1 0 0 1
refdes=A6
T 11600 9300 5 10 1 1 0 0 1
value=.PARAM drive=2
}
C 11500 8600 1 0 0 spice-directive-1.sym
{
T 11600 8900 5 10 0 1 0 0 1
device=directive
T 11600 9000 5 10 1 1 0 0 1
refdes=A7
T 11600 8700 5 10 1 1 0 0 1
value=.PARAM skew=2
}
C 12100 5200 1 0 0 spice-subcircuit-IO-1.sym
{
T 12600 5800 5 10 1 1 180 0 1
refdes=P1
}

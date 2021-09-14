v 20130925 2
T 7500 100 9 10 1 0 0 0 1
1
T 8900 100 9 10 1 0 0 0 1
1
N 11700 3200 11700 7700 4
N 11500 8600 12800 8600 4
{
T 11600 8700 5 10 1 1 0 0 1
netname=VDD
}
N 12600 8600 12600 8200 4
N 12800 7700 12700 7700 4
N 12800 7700 12800 8600 4
N 11400 2300 12800 2300 4
{
T 11600 2400 5 10 1 1 0 0 1
netname=GND
}
C 12000 7200 1 0 0 asic-pmos-1.sym
{
T 13400 8000 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 12800 8000 5 10 1 1 0 0 1
refdes=M1
T 12800 7800 5 8 1 1 0 0 1
model-name=pmos4
T 12800 7500 5 8 1 0 0 0 1
w='drive*g*Wmin'
T 12800 7300 5 8 1 0 0 0 1
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
fname=CIP2.sch
T 10700 1100 5 14 1 1 0 4 1
title=CIP2 - inverting Clock Buffer (High-skewed), Drive 2x
}
C 500 7700 1 0 0 spice-model-1.sym
{
T 600 8300 5 10 1 1 0 0 1
refdes=A1
T 1800 8000 5 10 1 1 0 0 1
model-name=nmos4
T 1000 7800 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 500 9100 1 0 0 spice-model-1.sym
{
T 600 9700 5 10 1 1 0 0 1
refdes=A2
T 1800 9400 5 10 1 1 0 0 1
model-name=pmos4
T 1000 9200 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 11600 5800 1 180 0 spice-subcircuit-IO-1.sym
{
T 11400 5800 5 10 1 1 0 0 1
refdes=P2
}
C 11700 8900 1 180 0 spice-subcircuit-IO-1.sym
{
T 11700 8900 5 10 1 1 0 0 1
refdes=P3
}
C 11600 2600 1 180 0 spice-subcircuit-IO-1.sym
{
T 11600 2600 5 10 1 1 0 0 1
refdes=P4
}
C 3800 9300 1 0 0 spice-subcircuit-LL-1.sym
{
T 3900 9700 5 10 1 1 0 0 1
refdes=A3
T 3900 9400 5 10 1 1 0 0 1
model-name=CGP2
}
C 6900 9300 1 0 0 spice-directive-1.sym
{
T 7000 9600 5 10 0 1 0 0 1
device=directive
T 7000 9700 5 10 1 1 0 0 1
refdes=A4
T 7000 9400 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 9700 9300 1 0 0 spice-directive-1.sym
{
T 9800 9600 5 10 0 1 0 0 1
device=directive
T 9800 9700 5 10 1 1 0 0 1
refdes=A5
T 9800 9400 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 12000 2700 1 0 0 asic-nmos-1.sym
{
T 13400 3500 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 12800 3500 5 10 1 1 0 0 1
refdes=M2
T 12800 3300 5 8 1 1 0 0 1
model-name=nmos4
T 12800 3000 5 8 1 0 0 0 1
w='(drive/skew)*Wmin'
T 12800 2800 5 8 1 0 0 0 1
l=1u
}
N 11400 5500 11700 5500 4
{
T 11400 5600 5 10 1 1 0 0 1
netname=X
}
N 11700 7700 12000 7700 4
N 11700 3200 12000 3200 4
N 12600 2700 12600 2300 4
N 12700 3200 12800 3200 4
N 12800 3200 12800 2300 4
N 12600 7200 12600 3700 4
T 10800 1600 9 10 1 0 0 0 3
Clock Output Buffer:
- higher driving strength
- down-sized nMOS (HIGH-skewed)
C 13000 5200 1 0 0 spice-subcircuit-IO-1.sym
{
T 13400 5700 5 10 1 1 180 0 1
refdes=P1
}
N 12600 5500 13200 5500 4
{
T 12800 5600 5 10 1 1 0 0 1
netname=Y
}
C 12100 9300 1 0 0 spice-directive-1.sym
{
T 12200 9600 5 10 0 1 0 0 1
device=directive
T 12200 9700 5 10 1 1 0 0 1
refdes=A6
T 12200 9400 5 10 1 1 0 0 1
value=.PARAM drive=2
}
C 12100 8700 1 0 0 spice-directive-1.sym
{
T 12200 9000 5 10 0 1 0 0 1
device=directive
T 12200 9100 5 10 1 1 0 0 1
refdes=A7
T 12200 8800 5 10 1 1 0 0 1
value=.PARAM skew=2
}

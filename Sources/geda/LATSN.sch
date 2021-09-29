v 20130925 2
T 7700 100 9 10 1 0 0 0 1
1
T 9300 100 9 10 1 0 0 0 1
1
N 1700 3300 1700 7800 4
N 900 8700 15500 8700 4
{
T 1000 8800 5 10 1 1 0 0 1
netname=VDD
}
N 2600 8700 2600 8300 4
N 2800 7800 2700 7800 4
N 2800 7800 2800 8700 4
N 800 2400 15500 2400 4
{
T 1000 2500 5 10 1 1 0 0 1
netname=GND
}
C 2000 7300 1 0 0 asic-pmos-1.sym
{
T 3400 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 2800 8100 5 10 1 1 0 0 1
refdes=M1
T 2800 7900 5 8 1 1 0 0 1
model-name=pmos4
T 2800 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 2800 7400 5 8 1 0 0 0 1
l=1u
}
T 400 1100 9 10 1 0 0 0 1
set LATN
B 300 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 8600 0 1 0 0 cvstitleblock-1.sym
{
T 9200 400 5 10 1 1 0 0 1
date=2019-09-03
T 13100 400 5 10 1 1 0 0 1
rev=$Revision$
T 13100 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 9200 700 5 10 1 1 0 0 1
fname=LATSN.sch
T 12600 1100 5 14 1 1 0 4 1
title=LATSN - Low-active D-Latch w/ asynchronous low-active Set
}
C 1600 9200 1 0 0 spice-model-1.sym
{
T 1700 9800 5 10 1 1 0 0 1
refdes=A1
T 2900 9500 5 10 1 1 0 0 1
model-name=nmos4
T 2100 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 4900 9200 1 0 0 spice-model-1.sym
{
T 5000 9800 5 10 1 1 0 0 1
refdes=A2
T 6200 9500 5 10 1 1 0 0 1
model-name=pmos4
T 5400 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 13700 5400 1 270 0 spice-subcircuit-IO-1.sym
{
T 14200 5000 5 10 1 1 90 0 1
refdes=P1
}
C 7900 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 7700 5900 5 10 1 1 0 0 1
refdes=P2
}
C 13300 6800 1 0 0 spice-subcircuit-IO-1.sym
{
T 13800 7300 5 10 1 1 180 0 1
refdes=P3
}
C 1600 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 1400 5900 5 10 1 1 0 0 1
refdes=P4
}
C 1100 9000 1 180 0 spice-subcircuit-IO-1.sym
{
T 1100 9000 5 10 1 1 0 0 1
refdes=P5
}
C 1000 2700 1 180 0 spice-subcircuit-IO-1.sym
{
T 1000 2700 5 10 1 1 0 0 1
refdes=P6
}
C 8200 9400 1 0 0 spice-subcircuit-LL-1.sym
{
T 8300 9800 5 10 1 1 0 0 1
refdes=A3
T 8300 9500 5 10 1 1 0 0 1
model-name=LATSN
}
C 11000 9400 1 0 0 spice-directive-1.sym
{
T 11100 9700 5 10 0 1 0 0 1
device=directive
T 11100 9800 5 10 1 1 0 0 1
refdes=A4
T 11100 9500 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 13500 9400 1 0 0 spice-directive-1.sym
{
T 13600 9700 5 10 0 1 0 0 1
device=directive
T 13600 9800 5 10 1 1 0 0 1
refdes=A5
T 13600 9500 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 4000 7300 1 0 0 asic-pmos-1.sym
{
T 5400 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 4800 8100 5 10 1 1 0 0 1
refdes=M3
T 4800 7900 5 8 1 1 0 0 1
model-name=pmos4
T 4800 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 4800 7400 5 8 1 0 0 0 1
l=1u
}
C 4000 2800 1 0 0 asic-nmos-1.sym
{
T 5400 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 4800 3600 5 10 1 1 0 0 1
refdes=M4
T 4800 3400 5 8 1 1 0 0 1
model-name=nmos4
T 4800 3100 5 8 1 0 0 0 1
w='Wmin'
T 4800 2900 5 8 1 0 0 0 1
l=1u
}
C 2000 2800 1 0 0 asic-nmos-1.sym
{
T 3400 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 2800 3600 5 10 1 1 0 0 1
refdes=M2
T 2800 3400 5 8 1 1 0 0 1
model-name=nmos4
T 2800 3100 5 8 1 0 0 0 1
w='Wmin'
T 2800 2900 5 8 1 0 0 0 1
l=1u
}
N 1400 5600 1700 5600 4
{
T 1400 5700 5 10 1 1 0 0 1
netname=XN
}
N 1700 7800 2000 7800 4
N 1700 3300 2000 3300 4
N 2600 2800 2600 2400 4
N 2700 3300 2800 3300 4
N 2800 3300 2800 2400 4
N 2600 7300 2600 3800 4
N 3700 7800 4000 7800 4
N 3700 3300 4000 3300 4
N 3700 7800 3700 3300 4
N 2600 5600 3700 5600 4
{
T 3000 5700 5 10 1 1 0 0 1
netname=clk180
}
N 4600 7300 4600 3800 4
N 4600 8300 4600 8700 4
N 4600 2800 4600 2400 4
N 4700 7800 4800 7800 4
N 4800 7800 4800 8700 4
N 4700 3300 4800 3300 4
N 4800 3300 4800 2400 4
N 4600 5600 5400 5600 4
{
T 4900 5700 5 10 1 1 0 0 1
netname=clk360
}
C 8400 5800 1 0 0 asic-pmos-1.sym
{
T 9800 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9200 6600 5 10 1 1 0 0 1
refdes=M6
T 9200 6400 5 8 1 1 0 0 1
model-name=pmos4
T 9200 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9200 5900 5 8 1 0 0 0 1
l=1u
}
C 8400 4300 1 0 0 asic-nmos-1.sym
{
T 9800 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9200 5100 5 10 1 1 0 0 1
refdes=M7
T 9200 4900 5 8 1 1 0 0 1
model-name=nmos4
T 9200 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 9200 4400 5 8 1 0 0 0 1
l=1u
}
C 8400 2800 1 0 0 asic-nmos-1.sym
{
T 9800 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9200 3600 5 10 1 1 0 0 1
refdes=M8
T 9200 3400 5 8 1 1 0 0 1
model-name=nmos4
T 9200 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 9200 2900 5 8 1 0 0 0 1
l=1u
}
C 8400 7300 1 0 0 asic-pmos-1.sym
{
T 9800 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9200 8100 5 10 1 1 0 0 1
refdes=M5
T 9200 7900 5 8 1 1 0 0 1
model-name=pmos4
T 9200 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9200 7400 5 8 1 0 0 0 1
l=1u
}
N 8400 7800 7500 7800 4
{
T 7800 7900 5 10 1 1 0 0 1
netname=clk360
}
N 8400 3300 7500 3300 4
{
T 7800 3400 5 10 1 1 0 0 1
netname=clk180
}
N 8100 6300 8400 6300 4
N 8400 4800 8100 4800 4
N 8100 4800 8100 6300 4
N 7700 5600 8100 5600 4
{
T 7700 5700 5 10 1 1 0 0 1
netname=D
}
N 9000 8300 9000 8700 4
N 9000 7300 9000 6800 4
N 9000 5800 9000 5300 4
N 9000 4300 9000 3800 4
N 9000 2800 9000 2400 4
T 2600 1700 9 10 1 0 0 0 3
Double Clock Buffering:
- de-coupling high load
- 2-phase clock generation
C 10900 5800 1 0 0 asic-pmos-1.sym
{
T 12300 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 11700 6600 5 10 1 1 0 0 1
refdes=M10
T 11700 6400 5 8 1 1 0 0 1
model-name=pmos4
T 11700 6100 5 8 1 0 0 0 1
w='g*Wmin'
T 11700 5900 5 8 1 0 0 0 1
l=1u
}
C 10900 4300 1 0 0 asic-nmos-1.sym
{
T 12300 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 11700 5100 5 10 1 1 0 0 1
refdes=M11
T 11700 4900 5 8 1 1 0 0 1
model-name=nmos4
T 11700 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 11700 4400 5 8 1 0 0 0 1
l=1u
}
N 10600 6300 10900 6300 4
N 10900 4800 10600 4800 4
N 10600 4800 10600 6300 4
N 11500 5800 11500 5300 4
C 14700 5800 1 0 0 asic-pmos-1.sym
{
T 16100 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 15500 6600 5 10 1 1 0 0 1
refdes=M14
T 15500 6400 5 8 1 1 0 0 1
model-name=pmos4
T 15500 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 15500 5900 5 8 1 0 0 0 1
l=1u
}
C 14700 4300 1 0 0 asic-nmos-1.sym
{
T 16100 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 15500 5100 5 10 1 1 0 0 1
refdes=M15
T 15500 4900 5 8 1 1 0 0 1
model-name=nmos4
T 15500 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 15500 4400 5 8 1 0 0 0 1
l=1u
}
C 14700 2800 1 0 0 asic-nmos-1.sym
{
T 16100 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 15500 3600 5 10 1 1 0 0 1
refdes=M16
T 15500 3400 5 8 1 1 0 0 1
model-name=nmos4
T 15500 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 15500 2900 5 8 1 0 0 0 1
l=1u
}
C 14700 7300 1 0 0 asic-pmos-1.sym
{
T 16100 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 15500 8100 5 10 1 1 0 0 1
refdes=M13
T 15500 7900 5 8 1 1 0 0 1
model-name=pmos4
T 15500 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 15500 7400 5 8 1 0 0 0 1
l=1u
}
N 14700 7800 14000 7800 4
{
T 14100 7900 5 10 1 1 0 0 1
netname=clk180
}
N 14700 3300 14100 3300 4
{
T 14100 3400 5 10 1 1 0 0 1
netname=clk360
}
N 14400 6300 14700 6300 4
N 14700 4800 14400 4800 4
N 14400 4800 14400 6300 4
N 11500 5600 14400 5600 4
{
T 12800 5700 5 10 1 1 0 0 1
netname=Q
}
N 15300 8300 15300 8700 4
N 15300 7300 15300 6800 4
N 15300 5800 15300 5300 4
N 15300 4300 15300 3800 4
N 15300 2800 15300 2400 4
N 14000 5200 14000 5600 4
N 9000 5600 10600 5600 4
N 10100 5600 10100 4200 4
N 10100 4200 16300 4200 4
{
T 12800 4300 5 10 1 1 0 0 1
netname=qn
}
N 15300 5600 16300 5600 4
N 16300 5600 16300 4200 4
T 7700 1700 9 10 1 0 0 0 3
Data input switch:
- (inverting) tri-state driver
- low-active transparent
T 10700 1700 9 10 1 0 0 0 3
Q Stage:
- inverting AND
- asynchronous (low-active) Set pulls up
T 14100 1700 9 10 1 0 0 0 3
QN Stage:
- (inverting) tri-state driver
- high-active transparent
N 9100 7800 9200 7800 4
N 9200 6300 9200 8700 4
N 9100 6300 9200 6300 4
N 15400 7800 15500 7800 4
N 15500 6300 15500 8700 4
N 15400 6300 15500 6300 4
N 15400 3300 15500 3300 4
N 15500 2400 15500 4800 4
N 15400 4800 15500 4800 4
N 11500 6800 11500 8700 4
N 11600 6300 11700 6300 4
N 11700 6300 11700 8700 4
N 11600 4800 11700 4800 4
N 11700 4800 11700 2400 4
N 9100 3300 9200 3300 4
N 9200 2400 9200 4800 4
N 9100 4800 9200 4800 4
C 13200 6600 1 0 1 asic-pmos-1.sym
{
T 11800 7400 5 8 0 0 0 6 1
device=PMOS_TRANSISTOR
T 12400 7400 5 10 1 1 0 6 1
refdes=M9
T 12400 7200 5 8 1 1 0 6 1
model-name=pmos4
T 12400 6900 5 8 1 0 0 6 1
w='g*Wmin'
T 12400 6700 5 8 1 0 0 6 1
l=1u
}
N 12600 7600 12600 8700 4
N 12600 6600 12600 5600 4
N 12500 7100 12400 7100 4
N 12400 7100 12400 8700 4
N 13200 7100 13500 7100 4
{
T 13200 7200 5 10 1 1 0 0 1
netname=SN
}
C 13200 2800 1 0 1 asic-nmos-1.sym
{
T 11800 3600 5 8 0 0 0 6 1
device=NMOS_TRANSISTOR
T 12400 3600 5 10 1 1 0 6 1
refdes=M12
T 12400 3400 5 8 1 1 0 6 1
model-name=nmos4
T 12400 3100 5 8 1 0 0 6 1
w='2*Wmin'
T 12400 2900 5 8 1 0 0 6 1
l=1u
}
N 12500 3300 12400 3300 4
N 12400 3300 12400 2400 4
N 12600 2800 12600 2400 4
N 11500 4300 11500 4000 4
N 11500 4000 12600 4000 4
N 12600 4000 12600 3800 4
N 13400 7100 13400 3300 4
N 13400 3300 13200 3300 4

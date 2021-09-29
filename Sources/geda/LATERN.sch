v 20130925 2
T 11000 100 9 10 1 0 0 0 1
1
T 9500 100 9 10 1 0 0 0 1
1
N 1100 3300 1100 7800 4
N 1100 8700 15700 8700 4
{
T 1200 8800 5 10 1 1 0 0 1
netname=VDD
}
N 2000 8700 2000 8300 4
N 2200 7800 2100 7800 4
N 2200 7800 2200 8700 4
N 1000 2400 15700 2400 4
{
T 1200 2500 5 10 1 1 0 0 1
netname=GND
}
C 1400 7300 1 0 0 asic-pmos-1.sym
{
T 2800 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 2200 8100 5 10 1 1 0 0 1
refdes=M1
T 2200 7900 5 8 1 1 0 0 1
model-name=pmos4
T 2200 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 2200 7400 5 8 1 0 0 0 1
l=1u
}
T 600 1100 9 10 1 0 0 0 1
set LATEN and LATRN
B 500 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 8800 0 1 0 0 cvstitleblock-1.sym
{
T 9400 400 5 10 1 1 0 0 1
date=2019-09-04
T 13300 400 5 10 1 1 0 0 1
rev=$Revision$
T 13300 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 9400 700 5 10 1 1 0 0 1
fname=LATERN.sch
T 12800 1100 5 14 1 1 0 4 1
title=LATERN - Low-active D-Latch w/ clock-enable + async. Reset
}
C 1800 9200 1 0 0 spice-model-1.sym
{
T 1900 9800 5 10 1 1 0 0 1
refdes=A1
T 3100 9500 5 10 1 1 0 0 1
model-name=nmos4
T 2300 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 5100 9200 1 0 0 spice-model-1.sym
{
T 5200 9800 5 10 1 1 0 0 1
refdes=A2
T 6400 9500 5 10 1 1 0 0 1
model-name=pmos4
T 5600 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 13900 5400 1 270 0 spice-subcircuit-IO-1.sym
{
T 14400 5000 5 10 1 1 90 0 1
refdes=P1
}
C 8100 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 7900 5900 5 10 1 1 0 0 1
refdes=P2
}
C 1000 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 800 5900 5 10 1 1 0 0 1
refdes=P5
}
C 1300 9000 1 180 0 spice-subcircuit-IO-1.sym
{
T 1300 9000 5 10 1 1 0 0 1
refdes=P6
}
C 1200 2700 1 180 0 spice-subcircuit-IO-1.sym
{
T 1200 2700 5 10 1 1 0 0 1
refdes=P7
}
C 8300 9400 1 0 0 spice-subcircuit-LL-1.sym
{
T 8400 9800 5 10 1 1 0 0 1
refdes=A3
T 8400 9500 5 10 1 1 0 0 1
model-name=LATERN
}
C 11100 9400 1 0 0 spice-directive-1.sym
{
T 11200 9700 5 10 0 1 0 0 1
device=directive
T 11200 9800 5 10 1 1 0 0 1
refdes=A4
T 11200 9500 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 13700 9400 1 0 0 spice-directive-1.sym
{
T 13800 9700 5 10 0 1 0 0 1
device=directive
T 13800 9800 5 10 1 1 0 0 1
refdes=A5
T 13800 9500 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 4600 7300 1 0 0 asic-pmos-1.sym
{
T 6000 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 5400 8100 5 10 1 1 0 0 1
refdes=M5
T 5400 7900 5 8 1 1 0 0 1
model-name=pmos4
T 5000 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 5400 7400 5 8 1 0 0 0 1
l=1u
}
C 4600 2800 1 0 0 asic-nmos-1.sym
{
T 6000 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 5400 3600 5 10 1 1 0 0 1
refdes=M6
T 5400 3400 5 8 1 1 0 0 1
model-name=nmos4
T 5400 3100 5 8 1 0 0 0 1
w='Wmin'
T 5400 2900 5 8 1 0 0 0 1
l=1u
}
C 1400 2800 1 0 0 asic-nmos-1.sym
{
T 2800 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 2200 3600 5 10 1 1 0 0 1
refdes=M4
T 2200 3400 5 8 1 1 0 0 1
model-name=nmos4
T 2200 3100 5 8 1 0 0 0 1
w='Wmin'
T 2200 2900 5 8 1 0 0 0 1
l=1u
}
N 800 5600 1100 5600 4
{
T 800 5700 5 10 1 1 0 0 1
netname=XN
}
N 1100 7800 1400 7800 4
N 1100 3300 1400 3300 4
N 2000 2800 2000 2400 4
N 2100 3300 2200 3300 4
N 2200 3300 2200 2400 4
N 4300 7800 4600 7800 4
N 4300 3300 4600 3300 4
N 4300 7800 4300 3300 4
N 2000 5600 4300 5600 4
{
T 3100 5700 5 10 1 1 0 0 1
netname=clk180
}
N 5200 7300 5200 3800 4
N 5200 8300 5200 8700 4
N 5200 2800 5200 2400 4
N 5300 7800 5400 7800 4
N 5400 7800 5400 8700 4
N 5300 3300 5400 3300 4
N 5400 3300 5400 2400 4
N 5200 5600 6000 5600 4
{
T 5500 5700 5 10 1 1 0 0 1
netname=clk360
}
C 8600 5800 1 0 0 asic-pmos-1.sym
{
T 10000 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9400 6600 5 10 1 1 0 0 1
refdes=M8
T 9400 6400 5 8 1 1 0 0 1
model-name=pmos4
T 9400 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9400 5900 5 8 1 0 0 0 1
l=1u
}
C 8600 4300 1 0 0 asic-nmos-1.sym
{
T 10000 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9400 5100 5 10 1 1 0 0 1
refdes=M9
T 9400 4900 5 8 1 1 0 0 1
model-name=nmos4
T 9400 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 9400 4400 5 8 1 0 0 0 1
l=1u
}
C 8600 2800 1 0 0 asic-nmos-1.sym
{
T 10000 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9400 3600 5 10 1 1 0 0 1
refdes=M10
T 9400 3400 5 8 1 1 0 0 1
model-name=nmos4
T 9400 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 9400 2900 5 8 1 0 0 0 1
l=1u
}
C 8600 7300 1 0 0 asic-pmos-1.sym
{
T 10000 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9400 8100 5 10 1 1 0 0 1
refdes=M7
T 9400 7900 5 8 1 1 0 0 1
model-name=pmos4
T 9400 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9400 7400 5 8 1 0 0 0 1
l=1u
}
N 8600 7800 7700 7800 4
{
T 8000 7900 5 10 1 1 0 0 1
netname=clk360
}
N 8600 3300 7700 3300 4
{
T 8000 3400 5 10 1 1 0 0 1
netname=clk180
}
N 8300 6300 8600 6300 4
N 8600 4800 8300 4800 4
N 8300 4800 8300 6300 4
N 7900 5600 8300 5600 4
{
T 7900 5700 5 10 1 1 0 0 1
netname=D
}
N 9200 8300 9200 8700 4
N 9200 7300 9200 6800 4
N 9200 5800 9200 5300 4
N 9200 4300 9200 3800 4
N 9200 2800 9200 2400 4
T 2500 1500 9 10 1 0 0 0 4
Double Clock Buffering:
- clock-enable (via NOR)
- de-coupling high load
- 2-phase clock generation
C 11100 5800 1 0 0 asic-pmos-1.sym
{
T 12500 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 11900 6600 5 10 1 1 0 0 1
refdes=M12
T 11900 6400 5 8 1 1 0 0 1
model-name=pmos4
T 11900 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 11900 5900 5 8 1 0 0 0 1
l=1u
}
C 11100 4300 1 0 0 asic-nmos-1.sym
{
T 12500 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 11900 5100 5 10 1 1 0 0 1
refdes=M13
T 11900 4900 5 8 1 1 0 0 1
model-name=nmos4
T 11900 4600 5 8 1 0 0 0 1
w='Wmin'
T 11900 4400 5 8 1 0 0 0 1
l=1u
}
N 10800 6300 11100 6300 4
N 11100 4800 10800 4800 4
N 10800 4800 10800 6300 4
N 11700 5800 11700 5300 4
C 14900 5800 1 0 0 asic-pmos-1.sym
{
T 16300 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 15700 6600 5 10 1 1 0 0 1
refdes=M16
T 15700 6400 5 8 1 1 0 0 1
model-name=pmos4
T 15700 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 15700 5900 5 8 1 0 0 0 1
l=1u
}
C 14900 4300 1 0 0 asic-nmos-1.sym
{
T 16300 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 15700 5100 5 10 1 1 0 0 1
refdes=M17
T 15700 4900 5 8 1 1 0 0 1
model-name=nmos4
T 15700 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 15700 4400 5 8 1 0 0 0 1
l=1u
}
C 14900 2800 1 0 0 asic-nmos-1.sym
{
T 16300 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 15700 3600 5 10 1 1 0 0 1
refdes=M18
T 15700 3400 5 8 1 1 0 0 1
model-name=nmos4
T 15700 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 15700 2900 5 8 1 0 0 0 1
l=1u
}
C 14900 7300 1 0 0 asic-pmos-1.sym
{
T 16300 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 15700 8100 5 10 1 1 0 0 1
refdes=M15
T 15700 7900 5 8 1 1 0 0 1
model-name=pmos4
T 15700 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 15700 7400 5 8 1 0 0 0 1
l=1u
}
N 14900 7800 14200 7800 4
{
T 14300 7900 5 10 1 1 0 0 1
netname=clk180
}
N 14900 3300 14300 3300 4
{
T 14300 3400 5 10 1 1 0 0 1
netname=clk360
}
N 14600 6300 14900 6300 4
N 14900 4800 14600 4800 4
N 14600 4800 14600 6300 4
N 11700 5600 14600 5600 4
{
T 13000 5700 5 10 1 1 0 0 1
netname=Q
}
N 15500 8300 15500 8700 4
N 15500 7300 15500 6800 4
N 15500 5800 15500 5300 4
N 15500 4300 15500 3800 4
N 15500 2800 15500 2400 4
N 14200 5200 14200 5600 4
N 9200 5600 10800 5600 4
N 10300 5600 10300 4200 4
N 10300 4200 16500 4200 4
{
T 13000 4300 5 10 1 1 0 0 1
netname=qn
}
N 15500 5600 16500 5600 4
N 16500 5600 16500 4200 4
T 7900 1700 9 10 1 0 0 0 3
Data input switch:
- (inverting) tri-state driver
- low-active transparent
T 10900 1700 9 10 1 0 0 0 3
Q Stage:
- inverting OR
- asynchronous Reset pulls down
T 14300 1700 9 10 1 0 0 0 3
QN Stage:
- (inverting) tri-state driver
- high-active transparent
N 9300 7800 9400 7800 4
N 9400 6300 9400 8700 4
N 9300 6300 9400 6300 4
N 15600 7800 15700 7800 4
N 15700 6300 15700 8700 4
N 15600 6300 15700 6300 4
N 15600 3300 15700 3300 4
N 15700 2400 15700 4800 4
N 15600 4800 15700 4800 4
N 11800 6300 11900 6300 4
N 11900 6300 11900 8700 4
N 11800 4800 11900 4800 4
N 11900 4800 11900 2400 4
N 9300 3300 9400 3300 4
N 9400 2400 9400 4800 4
N 9300 4800 9400 4800 4
C 13500 6800 1 0 0 spice-subcircuit-IO-1.sym
{
T 14000 7300 5 10 1 1 180 0 1
refdes=P3
}
C 13400 7300 1 0 1 asic-pmos-1.sym
{
T 12000 8100 5 8 0 0 0 6 1
device=PMOS_TRANSISTOR
T 12600 8100 5 10 1 1 0 6 1
refdes=M11
T 12600 7900 5 8 1 1 0 6 1
model-name=pmos4
T 12600 7600 5 8 1 0 0 6 1
w='2*g*Wmin'
T 12600 7400 5 8 1 0 0 6 1
l=1u
}
N 12800 8300 12800 8700 4
N 12700 7800 12600 7800 4
N 12600 7800 12600 8700 4
C 13400 2800 1 0 1 asic-nmos-1.sym
{
T 12000 3600 5 8 0 0 0 6 1
device=NMOS_TRANSISTOR
T 12600 3600 5 10 1 1 0 6 1
refdes=M14
T 12600 3400 5 8 1 1 0 6 1
model-name=nmos4
T 12600 3100 5 8 1 0 0 6 1
w='Wmin'
T 12600 2900 5 8 1 0 0 6 1
l=1u
}
N 12700 3300 12600 3300 4
N 12600 3300 12600 2400 4
N 12800 2800 12800 2400 4
N 11700 4300 11700 2400 4
N 13600 3300 13600 7800 4
{
T 13700 7300 5 10 1 1 0 0 1
netname=R
}
N 13600 3300 13400 3300 4
N 13400 7800 13600 7800 4
N 13600 7100 13700 7100 4
N 11700 6800 11700 7100 4
N 11700 7100 12800 7100 4
N 12800 7100 12800 7300 4
N 12800 3800 12800 5600 4
C 2600 5800 1 0 1 asic-pmos-1.sym
{
T 1200 6600 5 8 0 0 0 6 1
device=PMOS_TRANSISTOR
T 1800 6600 5 10 1 1 0 6 1
refdes=M2
T 1800 6400 5 8 1 1 0 6 1
model-name=pmos4
T 1800 6100 5 8 1 0 0 6 1
w='2*g*Wmin'
T 1800 5900 5 8 1 0 0 6 1
l=1u
}
N 2000 7300 2000 6800 4
N 2000 3800 2000 5800 4
N 1900 6300 1300 6300 4
N 1300 6300 1300 8700 4
C 3400 4300 1 0 1 asic-nmos-1.sym
{
T 2000 5100 5 8 0 0 0 6 1
device=NMOS_TRANSISTOR
T 2600 5100 5 10 1 1 0 6 1
refdes=M3
T 2600 4900 5 8 1 1 0 6 1
model-name=nmos4
T 2600 4600 5 8 1 0 0 6 1
w='Wmin'
T 2600 4400 5 8 1 0 0 6 1
l=1u
}
N 2800 4300 2800 2400 4
N 2700 4800 2600 4800 4
N 2600 4800 2600 2400 4
N 2800 5300 2800 5600 4
N 2600 6300 3700 6300 4
{
T 3300 6400 5 10 1 1 0 0 1
netname=EN
}
N 3700 6300 3700 4800 4
N 3400 4800 3700 4800 4
C 4000 6100 1 90 0 spice-subcircuit-IO-1.sym
{
T 3900 6300 5 10 1 1 270 0 1
refdes=P4
}

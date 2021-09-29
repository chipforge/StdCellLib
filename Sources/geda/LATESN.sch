v 20130925 2
T 11200 100 9 10 1 0 0 0 1
1
T 9800 100 9 10 1 0 0 0 1
1
N 1400 3300 1400 7800 4
N 900 8700 16000 8700 4
{
T 1000 8800 5 10 1 1 0 0 1
netname=VDD
}
N 2300 8700 2300 8300 4
N 2500 7800 2400 7800 4
N 2500 7800 2500 8700 4
N 800 2400 16000 2400 4
{
T 1000 2500 5 10 1 1 0 0 1
netname=GND
}
C 1700 7300 1 0 0 asic-pmos-1.sym
{
T 3100 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 2500 8100 5 10 1 1 0 0 1
refdes=M1
T 2500 7900 5 8 1 1 0 0 1
model-name=pmos4
T 2500 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 2500 7400 5 8 1 0 0 0 1
l=1u
}
T 900 1100 9 10 1 0 0 0 1
set LATEN and LATSN
B 800 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 9100 0 1 0 0 cvstitleblock-1.sym
{
T 9700 400 5 10 1 1 0 0 1
date=2019-09-04
T 13600 400 5 10 1 1 0 0 1
rev=$Revision$
T 13600 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 9700 700 5 10 1 1 0 0 1
fname=LATESN.sch
T 13100 1100 5 14 1 1 0 4 1
title=LATESN - Low-active D-Latch w/ clock-enable + asynchr. SN
}
C 2100 9200 1 0 0 spice-model-1.sym
{
T 2200 9800 5 10 1 1 0 0 1
refdes=A1
T 3400 9500 5 10 1 1 0 0 1
model-name=nmos4
T 2600 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 5400 9200 1 0 0 spice-model-1.sym
{
T 5500 9800 5 10 1 1 0 0 1
refdes=A2
T 6700 9500 5 10 1 1 0 0 1
model-name=pmos4
T 5900 9300 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 14200 5400 1 270 0 spice-subcircuit-IO-1.sym
{
T 14700 5000 5 10 1 1 90 0 1
refdes=P1
}
C 8400 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 8200 5900 5 10 1 1 0 0 1
refdes=P2
}
C 13800 6800 1 0 0 spice-subcircuit-IO-1.sym
{
T 14300 7300 5 10 1 1 180 0 1
refdes=P3
}
C 1300 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 1100 5900 5 10 1 1 0 0 1
refdes=P5
}
C 1100 9000 1 180 0 spice-subcircuit-IO-1.sym
{
T 1100 9000 5 10 1 1 0 0 1
refdes=P6
}
C 1000 2700 1 180 0 spice-subcircuit-IO-1.sym
{
T 1000 2700 5 10 1 1 0 0 1
refdes=P7
}
C 8700 9400 1 0 0 spice-subcircuit-LL-1.sym
{
T 8800 9800 5 10 1 1 0 0 1
refdes=A3
T 8800 9500 5 10 1 1 0 0 1
model-name=LATESN
}
C 11500 9400 1 0 0 spice-directive-1.sym
{
T 11600 9700 5 10 0 1 0 0 1
device=directive
T 11600 9800 5 10 1 1 0 0 1
refdes=A4
T 11600 9500 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 14000 9400 1 0 0 spice-directive-1.sym
{
T 14100 9700 5 10 0 1 0 0 1
device=directive
T 14100 9800 5 10 1 1 0 0 1
refdes=A5
T 14100 9500 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 5000 7300 1 0 0 asic-pmos-1.sym
{
T 6400 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 5800 8100 5 10 1 1 0 0 1
refdes=M5
T 5800 7900 5 8 1 1 0 0 1
model-name=pmos4
T 5800 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 5800 7400 5 8 1 0 0 0 1
l=1u
}
C 5000 2800 1 0 0 asic-nmos-1.sym
{
T 6400 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 5800 3600 5 10 1 1 0 0 1
refdes=M6
T 5800 3400 5 8 1 1 0 0 1
model-name=nmos4
T 5800 3100 5 8 1 0 0 0 1
w='Wmin'
T 5800 2900 5 8 1 0 0 0 1
l=1u
}
C 1700 2800 1 0 0 asic-nmos-1.sym
{
T 3100 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 2500 3600 5 10 1 1 0 0 1
refdes=M4
T 2500 3400 5 8 1 1 0 0 1
model-name=nmos4
T 2500 3100 5 8 1 0 0 0 1
w='Wmin'
T 2500 2900 5 8 1 0 0 0 1
l=1u
}
N 1100 5600 1400 5600 4
{
T 1100 5700 5 10 1 1 0 0 1
netname=XN
}
N 1400 7800 1700 7800 4
N 1400 3300 1700 3300 4
N 2300 2800 2300 2400 4
N 2400 3300 2500 3300 4
N 2500 3300 2500 2400 4
N 4700 7800 5000 7800 4
N 4700 3300 5000 3300 4
N 4700 7800 4700 3300 4
N 2300 5600 4700 5600 4
{
T 3600 5700 5 10 1 1 0 0 1
netname=clk180
}
N 5600 7300 5600 3800 4
N 5600 8300 5600 8700 4
N 5600 2800 5600 2400 4
N 5700 7800 5800 7800 4
N 5800 7800 5800 8700 4
N 5700 3300 5800 3300 4
N 5800 3300 5800 2400 4
N 5600 5600 6400 5600 4
{
T 5900 5700 5 10 1 1 0 0 1
netname=clk360
}
C 8900 5800 1 0 0 asic-pmos-1.sym
{
T 10300 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9700 6600 5 10 1 1 0 0 1
refdes=M8
T 9700 6400 5 8 1 1 0 0 1
model-name=pmos4
T 9700 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9700 5900 5 8 1 0 0 0 1
l=1u
}
C 8900 4300 1 0 0 asic-nmos-1.sym
{
T 10300 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9700 5100 5 10 1 1 0 0 1
refdes=M9
T 9700 4900 5 8 1 1 0 0 1
model-name=nmos4
T 9700 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 9700 4400 5 8 1 0 0 0 1
l=1u
}
C 8900 2800 1 0 0 asic-nmos-1.sym
{
T 10300 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 9700 3600 5 10 1 1 0 0 1
refdes=M10
T 9700 3400 5 8 1 1 0 0 1
model-name=nmos4
T 9700 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 9700 2900 5 8 1 0 0 0 1
l=1u
}
C 8900 7300 1 0 0 asic-pmos-1.sym
{
T 10300 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 9700 8100 5 10 1 1 0 0 1
refdes=M7
T 9700 7900 5 8 1 1 0 0 1
model-name=pmos4
T 9700 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 9700 7400 5 8 1 0 0 0 1
l=1u
}
N 8900 7800 8000 7800 4
{
T 8300 7900 5 10 1 1 0 0 1
netname=clk360
}
N 8900 3300 8000 3300 4
{
T 8300 3400 5 10 1 1 0 0 1
netname=clk180
}
N 8600 6300 8900 6300 4
N 8900 4800 8600 4800 4
N 8600 4800 8600 6300 4
N 8200 5600 8600 5600 4
{
T 8200 5700 5 10 1 1 0 0 1
netname=D
}
N 9500 8300 9500 8700 4
N 9500 7300 9500 6800 4
N 9500 5800 9500 5300 4
N 9500 4300 9500 3800 4
N 9500 2800 9500 2400 4
T 3000 1500 9 10 1 0 0 0 4
Double Clock Buffering:
- clock-enable (via NOR)
- de-coupling high load
- 2-phase clock generation
C 11400 5800 1 0 0 asic-pmos-1.sym
{
T 12800 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 12200 6600 5 10 1 1 0 0 1
refdes=M12
T 12200 6400 5 8 1 1 0 0 1
model-name=pmos4
T 12200 6100 5 8 1 0 0 0 1
w='g*Wmin'
T 12200 5900 5 8 1 0 0 0 1
l=1u
}
C 11400 4300 1 0 0 asic-nmos-1.sym
{
T 12800 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 12200 5100 5 10 1 1 0 0 1
refdes=M13
T 12200 4900 5 8 1 1 0 0 1
model-name=nmos4
T 12200 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 12200 4400 5 8 1 0 0 0 1
l=1u
}
N 11100 6300 11400 6300 4
N 11400 4800 11100 4800 4
N 11100 4800 11100 6300 4
N 12000 5800 12000 5300 4
C 15200 5800 1 0 0 asic-pmos-1.sym
{
T 16600 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 16000 6600 5 10 1 1 0 0 1
refdes=M16
T 16000 6400 5 8 1 1 0 0 1
model-name=pmos4
T 16000 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 16000 5900 5 8 1 0 0 0 1
l=1u
}
C 15200 4300 1 0 0 asic-nmos-1.sym
{
T 16600 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 16000 5100 5 10 1 1 0 0 1
refdes=M17
T 16000 4900 5 8 1 1 0 0 1
model-name=nmos4
T 16000 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 16000 4400 5 8 1 0 0 0 1
l=1u
}
C 15200 2800 1 0 0 asic-nmos-1.sym
{
T 16600 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 16000 3600 5 10 1 1 0 0 1
refdes=M18
T 16000 3400 5 8 1 1 0 0 1
model-name=nmos4
T 16000 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 16000 2900 5 8 1 0 0 0 1
l=1u
}
C 15200 7300 1 0 0 asic-pmos-1.sym
{
T 16600 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 16000 8100 5 10 1 1 0 0 1
refdes=M15
T 16000 7900 5 8 1 1 0 0 1
model-name=pmos4
T 16000 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 16000 7400 5 8 1 0 0 0 1
l=1u
}
N 15200 7800 14500 7800 4
{
T 14600 7900 5 10 1 1 0 0 1
netname=clk180
}
N 15200 3300 14600 3300 4
{
T 14600 3400 5 10 1 1 0 0 1
netname=clk360
}
N 14900 6300 15200 6300 4
N 15200 4800 14900 4800 4
N 14900 4800 14900 6300 4
N 12000 5600 14900 5600 4
{
T 13300 5700 5 10 1 1 0 0 1
netname=Q
}
N 15800 8300 15800 8700 4
N 15800 7300 15800 6800 4
N 15800 5800 15800 5300 4
N 15800 4300 15800 3800 4
N 15800 2800 15800 2400 4
N 14500 5200 14500 5600 4
N 9500 5600 11100 5600 4
N 10600 5600 10600 4200 4
N 10600 4200 16800 4200 4
{
T 13300 4300 5 10 1 1 0 0 1
netname=qn
}
N 15800 5600 16800 5600 4
N 16800 5600 16800 4200 4
T 8200 1700 9 10 1 0 0 0 3
Data input switch:
- (inverting) tri-state driver
- low-active transparent
T 11200 1700 9 10 1 0 0 0 3
Q Stage:
- inverting AND
- asynchronous (low-active) Set pulls up
T 14600 1700 9 10 1 0 0 0 3
QN Stage:
- (inverting) tri-state driver
- high-active transparent
N 9600 7800 9700 7800 4
N 9700 6300 9700 8700 4
N 9600 6300 9700 6300 4
N 15900 7800 16000 7800 4
N 16000 6300 16000 8700 4
N 15900 6300 16000 6300 4
N 15900 3300 16000 3300 4
N 16000 2400 16000 4800 4
N 15900 4800 16000 4800 4
N 12000 6800 12000 8700 4
N 12100 6300 12200 6300 4
N 12200 6300 12200 8700 4
N 12100 4800 12200 4800 4
N 12200 4800 12200 2400 4
N 9600 3300 9700 3300 4
N 9700 2400 9700 4800 4
N 9600 4800 9700 4800 4
C 13700 6600 1 0 1 asic-pmos-1.sym
{
T 12300 7400 5 8 0 0 0 6 1
device=PMOS_TRANSISTOR
T 12900 7400 5 10 1 1 0 6 1
refdes=M11
T 12900 7200 5 8 1 1 0 6 1
model-name=pmos4
T 12900 6900 5 8 1 0 0 6 1
w='g*Wmin'
T 12900 6700 5 8 1 0 0 6 1
l=1u
}
N 13100 7600 13100 8700 4
N 13100 6600 13100 5600 4
N 13000 7100 12900 7100 4
N 12900 7100 12900 8700 4
N 13700 7100 14000 7100 4
{
T 13700 7200 5 10 1 1 0 0 1
netname=SN
}
C 13700 2800 1 0 1 asic-nmos-1.sym
{
T 12300 3600 5 8 0 0 0 6 1
device=NMOS_TRANSISTOR
T 12900 3600 5 10 1 1 0 6 1
refdes=M14
T 12900 3400 5 8 1 1 0 6 1
model-name=nmos4
T 12900 3100 5 8 1 0 0 6 1
w='2*Wmin'
T 12900 2900 5 8 1 0 0 6 1
l=1u
}
N 13000 3300 12900 3300 4
N 12900 3300 12900 2400 4
N 13100 2800 13100 2400 4
N 12000 4300 12000 4000 4
N 12000 4000 13100 4000 4
N 13100 4000 13100 3800 4
N 13900 7100 13900 3300 4
N 13900 3300 13700 3300 4
C 2900 5800 1 0 1 asic-pmos-1.sym
{
T 1500 6600 5 8 0 0 0 6 1
device=PMOS_TRANSISTOR
T 2100 6600 5 10 1 1 0 6 1
refdes=M2
T 2100 6400 5 8 1 1 0 6 1
model-name=pmos4
T 2100 6100 5 8 1 0 0 6 1
w='2*g*Wmin'
T 2100 5900 5 8 1 0 0 6 1
l=1u
}
C 3800 4300 1 0 1 asic-nmos-1.sym
{
T 2400 5100 5 8 0 0 0 6 1
device=NMOS_TRANSISTOR
T 3000 5100 5 10 1 1 0 6 1
refdes=M3
T 3000 4900 5 8 1 1 0 6 1
model-name=nmos4
T 3000 4600 5 8 1 0 0 6 1
w='Wmin'
T 3000 4400 5 8 1 0 0 6 1
l=1u
}
N 2900 6300 4200 6300 4
N 4200 6300 4200 4800 4
{
T 3800 6400 5 10 1 1 0 0 1
netname=EN
}
N 4200 4800 3800 4800 4
N 2300 7300 2300 6800 4
N 2200 6300 1600 6300 4
N 1600 6300 1600 8700 4
N 3200 4300 3200 2400 4
N 2300 5800 2300 3800 4
N 3100 4800 3000 4800 4
N 3000 4800 3000 2400 4
N 3200 5300 3200 5600 4
C 4500 6100 1 90 0 spice-subcircuit-IO-1.sym
{
T 4300 6300 5 10 1 1 270 0 1
refdes=P4
}

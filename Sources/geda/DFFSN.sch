v 20130925 2
T 13900 100 9 10 1 0 0 0 1
1
T 15500 100 9 10 1 0 0 0 1
1
N 900 3300 900 7800 4
N 800 8700 20300 8700 4
{
T 900 8800 5 10 1 1 0 0 1
netname=VDD
}
N 1800 8700 1800 8300 4
N 2000 7800 1900 7800 4
N 2000 7800 2000 8700 4
N 800 2400 20300 2400 4
{
T 1000 2500 5 10 1 1 0 0 1
netname=GND
}
C 1200 7300 1 0 0 asic-pmos-1.sym
{
T 2600 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 2000 8100 5 10 1 1 0 0 1
refdes=M1
T 2000 7900 5 8 1 1 0 0 1
model-name=pmos4
T 2000 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 2000 7400 5 8 1 0 0 0 1
l=1u
}
T 6600 500 9 10 1 0 0 0 1
see ?
B 6500 400 6500 1000 19 10 1 0 -1 -1 0 -1 -1 -1 -1 -1
C 13300 0 1 0 0 cvstitleblock-1.sym
{
T 13900 400 5 10 1 1 0 0 1
date=2021-09-29
T 17800 400 5 10 1 1 0 0 1
rev=$Revision$
T 17800 100 5 10 1 1 0 0 1
auth=<stdcelllib@nospam.chipforge.org>
T 13900 700 5 10 1 1 0 0 1
fname=DFFSN.sch
T 16300 1100 5 14 1 1 0 4 1
title=DFFSN - Negative edge-triggered D-FlipFlop w/ synchronous low-active Set
}
C 4300 8900 1 0 0 spice-model-1.sym
{
T 4400 9500 5 10 1 1 0 0 1
refdes=A1
T 5600 9200 5 10 1 1 0 0 1
model-name=nmos4
T 4800 9000 5 10 1 1 0 0 1
file=Technology/spice/ls1unmos.mod
}
C 7600 8900 1 0 0 spice-model-1.sym
{
T 7700 9500 5 10 1 1 0 0 1
refdes=A2
T 8900 9200 5 10 1 1 0 0 1
model-name=pmos4
T 8100 9000 5 10 1 1 0 0 1
file=Technology/spice/ls1upmos.mod
}
C 6300 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 6100 5900 5 10 1 1 0 0 1
refdes=P2
}
C 1000 5900 1 180 0 spice-subcircuit-IO-1.sym
{
T 800 5900 5 10 1 1 0 0 1
refdes=P3
}
C 1000 9000 1 180 0 spice-subcircuit-IO-1.sym
{
T 1000 9000 5 10 1 1 0 0 1
refdes=P4
}
C 1000 2700 1 180 0 spice-subcircuit-IO-1.sym
{
T 1000 2700 5 10 1 1 0 0 1
refdes=P5
}
C 10900 9100 1 0 0 spice-subcircuit-LL-1.sym
{
T 11000 9500 5 10 1 1 0 0 1
refdes=A3
T 11000 9200 5 10 1 1 0 0 1
model-name=DFFSN
}
C 14200 9100 1 0 0 spice-directive-1.sym
{
T 14300 9400 5 10 0 1 0 0 1
device=directive
T 14300 9500 5 10 1 1 0 0 1
refdes=A4
T 14300 9200 5 10 1 1 0 0 1
value=.PARAM Wmin=1.5u
}
C 17300 9100 1 0 0 spice-directive-1.sym
{
T 17400 9400 5 10 0 1 0 0 1
device=directive
T 17400 9500 5 10 1 1 0 0 1
refdes=A5
T 17400 9200 5 10 1 1 0 0 1
value=.PARAM g=2
}
C 3200 7300 1 0 0 asic-pmos-1.sym
{
T 4600 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 4000 8100 5 10 1 1 0 0 1
refdes=M3
T 4000 7900 5 8 1 1 0 0 1
model-name=pmos4
T 4000 7600 5 8 1 0 0 0 1
w='g*Wmin'
T 4000 7400 5 8 1 0 0 0 1
l=1u
}
C 3200 2800 1 0 0 asic-nmos-1.sym
{
T 4600 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 4000 3600 5 10 1 1 0 0 1
refdes=M4
T 4000 3400 5 8 1 1 0 0 1
model-name=nmos4
T 4000 3100 5 8 1 0 0 0 1
w='Wmin'
T 4000 2900 5 8 1 0 0 0 1
l=1u
}
C 1200 2800 1 0 0 asic-nmos-1.sym
{
T 2600 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 2000 3600 5 10 1 1 0 0 1
refdes=M2
T 2000 3400 5 8 1 1 0 0 1
model-name=nmos4
T 2000 3100 5 8 1 0 0 0 1
w='Wmin'
T 2000 2900 5 8 1 0 0 0 1
l=1u
}
N 800 5600 900 5600 4
{
T 600 5700 5 10 1 1 0 0 1
netname=XN
}
N 900 7800 1200 7800 4
N 900 3300 1200 3300 4
N 1800 2800 1800 2400 4
N 1900 3300 2000 3300 4
N 2000 3300 2000 2400 4
N 1800 7300 1800 3800 4
N 2900 7800 3200 7800 4
N 2900 3300 3200 3300 4
N 2900 7800 2900 3300 4
N 1800 5600 2900 5600 4
{
T 2200 5700 5 10 1 1 0 0 1
netname=clk180
}
N 3800 7300 3800 3800 4
N 3800 8300 3800 8700 4
N 3800 2800 3800 2400 4
N 3900 7800 4000 7800 4
N 4000 7800 4000 8700 4
N 3900 3300 4000 3300 4
N 4000 3300 4000 2400 4
N 3800 5600 4600 5600 4
{
T 4100 5700 5 10 1 1 0 0 1
netname=clk360
}
C 6800 5800 1 0 0 asic-pmos-1.sym
{
T 8200 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 7600 6600 5 10 1 1 0 0 1
refdes=M6
T 7600 6400 5 8 1 1 0 0 1
model-name=pmos4
T 7600 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 7600 5900 5 8 1 0 0 0 1
l=1u
}
C 6800 4300 1 0 0 asic-nmos-1.sym
{
T 8200 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 7600 5100 5 10 1 1 0 0 1
refdes=M7
T 7600 4900 5 8 1 1 0 0 1
model-name=nmos4
T 7600 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 7600 4400 5 8 1 0 0 0 1
l=1u
}
C 6800 2800 1 0 0 asic-nmos-1.sym
{
T 8200 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 7600 3600 5 10 1 1 0 0 1
refdes=M8
T 7600 3400 5 8 1 1 0 0 1
model-name=nmos4
T 7600 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 7600 2900 5 8 1 0 0 0 1
l=1u
}
C 6800 7300 1 0 0 asic-pmos-1.sym
{
T 8200 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 7600 8100 5 10 1 1 0 0 1
refdes=M5
T 7600 7900 5 8 1 1 0 0 1
model-name=pmos4
T 7600 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 7600 7400 5 8 1 0 0 0 1
l=1u
}
N 6800 7800 5900 7800 4
{
T 6200 7900 5 10 1 1 0 0 1
netname=clk180
}
N 6800 3300 5900 3300 4
{
T 6200 3400 5 10 1 1 0 0 1
netname=clk360
}
N 6500 6300 6800 6300 4
N 6800 4800 6500 4800 4
N 6500 4800 6500 6300 4
N 6100 5600 6500 5600 4
{
T 6100 5700 5 10 1 1 0 0 1
netname=D
}
N 7400 8300 7400 8700 4
N 7400 7300 7400 6800 4
N 7400 5800 7400 5300 4
N 7400 4300 7400 3800 4
N 7400 2800 7400 2400 4
T 1800 1700 9 10 1 0 0 0 3
Double Clock Buffering:
- de-coupling high load
- 2-phase clock generation
C 9200 5800 1 0 0 asic-pmos-1.sym
{
T 10600 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 10000 6600 5 10 1 1 0 0 1
refdes=M9
T 10000 6400 5 8 1 1 0 0 1
model-name=pmos4
T 10000 6100 5 8 1 0 0 0 1
w='g*Wmin'
T 10000 5900 5 8 1 0 0 0 1
l=1u
}
C 9200 4300 1 0 0 asic-nmos-1.sym
{
T 10600 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 10000 5100 5 10 1 1 0 0 1
refdes=M10
T 10000 4900 5 8 1 1 0 0 1
model-name=nmos4
T 10000 4600 5 8 1 0 0 0 1
w='Wmin'
T 10000 4400 5 8 1 0 0 0 1
l=1u
}
N 8900 6300 9200 6300 4
N 9200 4800 8900 4800 4
N 8900 4800 8900 6300 4
N 9800 5800 9800 5300 4
C 11600 5800 1 0 0 asic-pmos-1.sym
{
T 13000 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 12400 6600 5 10 1 1 0 0 1
refdes=M12
T 12400 6400 5 8 1 1 0 0 1
model-name=pmos4
T 12400 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 12400 5900 5 8 1 0 0 0 1
l=1u
}
C 11600 4300 1 0 0 asic-nmos-1.sym
{
T 13000 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 12400 5100 5 10 1 1 0 0 1
refdes=M13
T 12400 4900 5 8 1 1 0 0 1
model-name=nmos4
T 12400 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 12400 4400 5 8 1 0 0 0 1
l=1u
}
C 11600 2800 1 0 0 asic-nmos-1.sym
{
T 13000 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 12400 3600 5 10 1 1 0 0 1
refdes=M14
T 12400 3400 5 8 1 1 0 0 1
model-name=nmos4
T 12400 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 12400 2900 5 8 1 0 0 0 1
l=1u
}
C 11600 7300 1 0 0 asic-pmos-1.sym
{
T 13000 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 12400 8100 5 10 1 1 0 0 1
refdes=M11
T 12400 7900 5 8 1 1 0 0 1
model-name=pmos4
T 12400 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 12400 7400 5 8 1 0 0 0 1
l=1u
}
N 11600 7800 10700 7800 4
{
T 11000 7900 5 10 1 1 0 0 1
netname=clk360
}
N 11600 3300 10700 3300 4
{
T 11000 3400 5 10 1 1 0 0 1
netname=clk180
}
N 11300 6300 11600 6300 4
N 11600 4800 11300 4800 4
N 11300 4800 11300 6300 4
N 9800 5600 11300 5600 4
{
T 10800 5700 5 10 1 1 0 0 1
netname=qm
}
N 12200 8300 12200 8700 4
N 12200 7300 12200 6800 4
N 12200 5800 12200 5300 4
N 12200 4300 12200 3800 4
N 12200 2800 12200 2400 4
N 11000 4100 11000 5600 4
N 7400 5600 8900 5600 4
N 8300 5600 8300 7100 4
N 8300 7100 13200 7100 4
{
T 10800 7200 5 10 1 1 0 0 1
netname=\_qm\_
}
N 12200 5600 13200 5600 4
N 13200 5600 13200 7100 4
T 6100 1700 9 10 1 0 0 0 3
Master Latch input switch:
- (inverting) tri-state driver
- high-active transparent
T 9500 1900 9 10 1 0 0 0 2
Master Q Stage:
- inverter
T 10900 1700 9 10 1 0 0 0 3
Master QN Stage:
- (inverting) tri-state driver
- low-active transparent
N 7500 7800 7600 7800 4
N 7600 6300 7600 8700 4
N 7500 6300 7600 6300 4
N 12300 7800 12400 7800 4
N 12400 6300 12400 8700 4
N 12300 6300 12400 6300 4
N 12300 3300 12400 3300 4
N 12400 2400 12400 4800 4
N 12300 4800 12400 4800 4
N 9800 6800 9800 8700 4
N 9900 6300 10000 6300 4
N 10000 6300 10000 8700 4
N 9800 4300 9800 2400 4
N 9900 4800 10000 4800 4
N 10000 4800 10000 2400 4
N 7500 3300 7600 3300 4
N 7600 2400 7600 4800 4
N 7500 4800 7600 4800 4
C 18600 4900 1 270 0 spice-subcircuit-IO-1.sym
{
T 19100 4500 5 10 1 1 90 0 1
refdes=P1
}
C 14700 5800 1 0 0 asic-pmos-1.sym
{
T 16100 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 15500 6600 5 10 1 1 0 0 1
refdes=M16
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
refdes=M17
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
refdes=M18
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
refdes=M15
T 15500 7900 5 8 1 1 0 0 1
model-name=pmos4
T 15500 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 15500 7400 5 8 1 0 0 0 1
l=1u
}
N 14700 7800 13800 7800 4
{
T 14100 7900 5 10 1 1 0 0 1
netname=clk360
}
N 14700 3300 13800 3300 4
{
T 14100 3400 5 10 1 1 0 0 1
netname=clk180
}
N 14400 6300 14700 6300 4
N 14700 4800 14400 4800 4
N 14400 4800 14400 6300 4
N 14000 5600 14400 5600 4
N 15300 8300 15300 8700 4
N 15300 7300 15300 6800 4
N 15300 5800 15300 5300 4
N 15300 4300 15300 3800 4
N 15300 2800 15300 2400 4
C 17100 5800 1 0 0 asic-pmos-1.sym
{
T 18500 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 17900 6600 5 10 1 1 0 0 1
refdes=M19
T 17900 6400 5 8 1 1 0 0 1
model-name=pmos4
T 17900 6100 5 8 1 0 0 0 1
w='g*Wmin'
T 17900 5900 5 8 1 0 0 0 1
l=1u
}
C 17100 4300 1 0 0 asic-nmos-1.sym
{
T 18500 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 17900 5100 5 10 1 1 0 0 1
refdes=M20
T 17900 4900 5 8 1 1 0 0 1
model-name=nmos4
T 17900 4600 5 8 1 0 0 0 1
w='Wmin'
T 17900 4400 5 8 1 0 0 0 1
l=1u
}
N 16800 6300 17100 6300 4
N 17100 4800 16800 4800 4
N 16800 4800 16800 6300 4
N 17700 5800 17700 5300 4
C 19500 5800 1 0 0 asic-pmos-1.sym
{
T 20900 6600 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 20300 6600 5 10 1 1 0 0 1
refdes=M22
T 20300 6400 5 8 1 1 0 0 1
model-name=pmos4
T 20300 6100 5 8 1 0 0 0 1
w='2*g*Wmin'
T 20300 5900 5 8 1 0 0 0 1
l=1u
}
C 19500 4300 1 0 0 asic-nmos-1.sym
{
T 20900 5100 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 20300 5100 5 10 1 1 0 0 1
refdes=M23
T 20300 4900 5 8 1 1 0 0 1
model-name=nmos4
T 20300 4600 5 8 1 0 0 0 1
w='2*Wmin'
T 20300 4400 5 8 1 0 0 0 1
l=1u
}
C 19500 2800 1 0 0 asic-nmos-1.sym
{
T 20900 3600 5 8 0 0 0 0 1
device=NMOS_TRANSISTOR
T 20300 3600 5 10 1 1 0 0 1
refdes=M24
T 20300 3400 5 8 1 1 0 0 1
model-name=nmos4
T 20300 3100 5 8 1 0 0 0 1
w='2*Wmin'
T 20300 2900 5 8 1 0 0 0 1
l=1u
}
C 19500 7300 1 0 0 asic-pmos-1.sym
{
T 20900 8100 5 8 0 0 0 0 1
device=PMOS_TRANSISTOR
T 20300 8100 5 10 1 1 0 0 1
refdes=M21
T 20300 7900 5 8 1 1 0 0 1
model-name=pmos4
T 20300 7600 5 8 1 0 0 0 1
w='2*g*Wmin'
T 20300 7400 5 8 1 0 0 0 1
l=1u
}
N 19500 7800 18600 7800 4
{
T 18900 7900 5 10 1 1 0 0 1
netname=clk180
}
N 19500 3300 18600 3300 4
{
T 18900 3400 5 10 1 1 0 0 1
netname=clk360
}
N 19200 6300 19500 6300 4
N 19500 4800 19200 4800 4
N 19200 4800 19200 6300 4
N 17700 5600 19200 5600 4
{
T 18700 5700 5 10 1 1 0 0 1
netname=Q
}
N 20100 8300 20100 8700 4
N 20100 7300 20100 6800 4
N 20100 5800 20100 5300 4
N 20100 4300 20100 3800 4
N 20100 2800 20100 2400 4
N 18900 4700 18900 5600 4
N 15300 5600 16800 5600 4
N 16200 5600 16200 7100 4
N 16200 7100 21100 7100 4
{
T 18700 7200 5 10 1 1 0 0 1
netname=\_qs\_
}
N 20100 5600 21100 5600 4
N 21100 5600 21100 7100 4
N 15400 7800 15500 7800 4
N 15500 6300 15500 8700 4
N 15400 6300 15500 6300 4
N 20200 7800 20300 7800 4
N 20300 6300 20300 8700 4
N 20200 6300 20300 6300 4
N 20200 3300 20300 3300 4
N 20300 2400 20300 4800 4
N 20200 4800 20300 4800 4
N 17700 6800 17700 8700 4
N 17800 6300 17900 6300 4
N 17900 6300 17900 8700 4
N 17700 4300 17700 2400 4
N 17800 4800 17900 4800 4
N 17900 4800 17900 2400 4
N 15400 3300 15500 3300 4
N 15500 2400 15500 4800 4
N 15400 4800 15500 4800 4
T 14000 1700 9 10 1 0 0 0 3
Slave Latch input switch:
- (inverting) tri-state driver
- low-active transparent
T 17400 1900 9 10 1 0 0 0 2
Slave Q Stage:
- inverter
T 18800 1700 9 10 1 0 0 0 3
Slave QN Stage:
- (inverting) tri-state driver
- high-active transparent
N 14000 4100 14000 5600 4
N 14000 4100 11000 4100 4

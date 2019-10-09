
.tran 100p 30n
.plot tran v(Z) v(A)

* rising edge propagation delay
.measure tran tpdr
+ TRIG v(A) VAL='SUPPLY/2' RISE=1
+ TARG v(Z) VAL='SUPPLY/2' CROSS=1

* falling edge propagation delay
.measure tran tpdf
+ TRIG v(A) VAL='SUPPLY/2' FALL=1
+ TARG v(Z) VAL='SUPPLY/2' FALL=1

* average propagation delay
*.measure tran tpd param='(tpdr+tpdf)/2'

* delta progagation delay
*.measure tran delta param='tpdr-tpdf' goal=0

* measure rise time
.measure tran trise
+ TRIG v(Z) VAL='0.1*SUPPLY' RISE=1
+ TARG v(Z) VAL='0.9*SUPPLY' RISE=1

* measure fall time
.measure tran tfall
+ TRIG v(Z) VAL='0.9*SUPPLY' FALL=1
+ TARG v(Z) VAL='0.1*SUPPLY' FALL=1


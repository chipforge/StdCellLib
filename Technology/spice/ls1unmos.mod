*
* Long channel models from CMOS Circuit Design, Layout, and Simulation,
* Level=3 models VDD=5V, see CMOSedu.com
*
.MODEL NMOS4 NMOS LEVEL  = 3
+ TOX    = 200E-10         NSUB   = 1E17            GAMMA  = 0.5
+ PHI    = 0.7             VTO    = 0.8             DELTA  = 3.0
+ UO     = 650             ETA    = 3.0E-6          THETA  = 0.1
+ KP     = 120E-6          VMAX   = 1E5             KAPPA  = 0.3
+ RSH    = 0               NFS    = 1E12            TPG    = 1
+ XJ     = 500E-9          LD     = 100E-9
+ CGDO   = 200E-12         CGSO   = 200E-12         CGBO   = 1E-10
+ CJ     = 400E-6          PB     = 1               MJ     = 0.5
+ CJSW   = 300E-12         MJSW   = 0.5


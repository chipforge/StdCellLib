*
* Long channel models from CMOS Circuit Design, Layout, and Simulation,
* Level=3 models VDD=5V, see CMOSedu.com
*
.MODEL PMOS4 PMOS LEVEL  = 3
+ TOX    = 200E-10         NSUB   = 1E17            GAMMA  = 0.6
+ PHI    = 0.7             VTO    = -0.9            DELTA  = 0.1
+ UO     = 250             ETA    = 0               THETA  = 0.1
+ KP     = 40E-6           VMAX   = 5E4             KAPPA  = 1
+ RSH    = 0               NFS    = 1E12            TPG    = -1
+ XJ     = 500E-9          LD     = 100E-9
+ CGDO   = 200E-12         CGSO   = 200E-12         CGBO   = 1E-10
+ CJ     = 400E-6          PB     = 1               MJ     = 0.5
+ CJSW   = 300E-12         MJSW   = 0.5

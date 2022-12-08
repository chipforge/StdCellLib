import glob
import gdsfactory as gf


for a in glob.glob("*.gds"):
  print(a)
  b=gf.read.import_gds(a,read_metadata=True)
  b.write_gds(a,unit=1e-07)


#!/usr/bin/python3

import gdspy
import sys

for a in sys.argv:
    gdspy.current_library.read_gds(a)

gdspy.write_gds("library.gds")


#   ************    LibreSilicon's StdCellLibrary   *******************
#
#   Organisation:   Chipforge
#                   Germany / European Union
#
#   Profile:        Chipforge focus on fine System-on-Chip Cores in
#                   Verilog HDL Code which are easy understandable and
#                   adjustable. For further information see
#                           www.chipforge.org
#                   there are projects from small cores up to PCBs, too.
#
#   File:           StdCellLib/layout.mk
#
#   Purpose:        Makefile for Physical Layout stuff
#
#   ************    GNU Make 3.80 Source Code   ***********************
#
#   ///////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2021 by chipforge <stdcelllib@nospam.chipforge.org>
#   All rights reserved.
#
#       This Standard Cell Library is licensed under the Libre Silicon
#       public license; you can redistribute it and/or modify it under
#       the terms of the Libre Silicon public license as published by
#       the Libre Silicon alliance, either version 1 of the License, or
#       (at your option) any later version.
#
#       This design is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#       See the Libre Silicon Public License for more details.
#
#   ///////////////////////////////////////////////////////////////////

#   project root directory, relative, used inside include.mk file
PRD =               .

#   common definitions

include $(PRD)/include.mk

#   3rd party layout tool variables

.PHONY: clean
clean:
	-$(RM) $(RELEASEDIR)/Layout/LEF/*.lef
	-$(RM) $(RELEASEDIR)/Layout/magic/*.mag
	-$(RM) $(RELEASEDIR)/Layout/SVG/*.svg

#   ----------------------------------------------------------------
#                   GENERATE LEF
#   ----------------------------------------------------------------

.PHONY: lef
lef:
	# lef layout generation still not implemented

#   ----------------------------------------------------------------
#                   GENERATE MAGIC
#   ----------------------------------------------------------------

.PHONY: magic
magic:
	# magic layout generation still not implemented

#   ----------------------------------------------------------------
#                   GENERATE SVG
#   ----------------------------------------------------------------

.PHONY: svg
svg:
	# svg layout generation still not implemented

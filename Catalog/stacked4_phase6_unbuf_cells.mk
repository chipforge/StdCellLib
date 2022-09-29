#   ************    LibreSilicon's StdCellLibrary   ****************
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
#   File:           StdCellLib/Catalog/stacked4_phase6_unbuf_cells.mk
#
#   Purpose:        Makefile for Cell Generation with popcorn
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2018, 2019 - 2021 by
#                   chipforge - <popcorn@nospam.chipforge.org>
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
#   ////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#               DESCRIPTION
#   ----------------------------------------------------------------

#   Dependencies for cells with 4 stacked transistors and X phases,
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    six phases      ------------------------------------

CELLS +=        AOAOAOI211111 OAOAOAI211111 \
                AAOAOAOI221111 OOAOAOAI221111 \
                AOAAOAOI211211 OAOOAOAI211211 \
                AOAAOAOI211311 OAOOAOAI211311 \
                AOAOAAOI211112 OAOAOOAI211112 \
                AOAOAAOI211113 \
                AOAOOAOI211121 OAOAAOAI211121 \
                AOOAOAOI212111 OAAOAOAI212111 \
                AAOOAOAOI222111 OOAAOAOAI222111 \
                AAOAAOAOI221211 OOAOOAOAI221211 \
                AAOAAOAOI221311 OOAOOAOAI221311 \
                AOOAAOAOI212211 OAAOOAOAI212211 \
                AOOAAOAOI212311 OAAOOAOAI212311 \
                AAOOAAOAOI222211 OOAAOOAOAI222211 \
                AAOOAAOAOI222311

AOAOAOI211111:  DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR-Invert gate"
AOAOAOI211111:  AOAOAI21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOAI211111:  DESCR = "2-1-1-1-1-1-input OR-AND-OR-AND-OR-AND-Invert gate"
OAOAOAI211111:  OAOAOI21111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOAOI221111: DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND-OR-Invert gate"
AAOAOAOI221111: AAOAOAI22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAOAI221111: DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR-AND-Invert gate"
OOAOAOAI221111: OOAOAOI22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAOI211211: DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND-OR-Invert gate"
AOAAOAOI211211: AOAAOAI21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOAI211211: DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR-AND-Invert gate"
OAOOAOAI211211: OAOOAOI21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAOI211311: DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND-OR-Invert gate"
AOAAOAOI211311: AOAAOAI21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOAI211311: DESCR = "2-1-1-3-1-1-input OR-AND-OR-OR-AND-OR-AND-Invert gate"
OAOOAOAI211311: OAOOAOI21131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAOAAOI211112: DESCR = "2-1-1-1-1-2-input AND-OR-AND-OR-AND-AND-OR-Invert gate"
AOAOAAOI211112: AOAOAOI211111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAOOAI211112: DESCR = "2-1-1-1-1-2-input OR-AND-OR-AND-OR-OR-AND-Invert gate"
OAOAOOAI211112: OAOAOAI211111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAOAAOI211113: DESCR = "2-1-1-1-1-31-input AND-OR-AND-OR-AND-AND-OR-Invert gate"
AOAOAAOI211113: AOAOAAOI211112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAOI211121: DESCR = "2-1-1-1-2-1-input AND-OR-AND-OR-OR-AND-OR-Invert gate"
AOAOOAOI211121: AOAOOAI21112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAAOAI211121: DESCR = "2-1-1-1-2-1-input OR-AND-OR-AND-AND-OR-AND-Invert gate"
OAOAAOAI211121: AOAOOAI21112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOAOI212111: DESCR = "2-1-2-1-1-1-input AND-OR-OR-AND-OR-AND-OR-Invert gate"
AOOAOAOI212111: AOOAOAI21211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOAI212111: DESCR = "2-1-2-1-1-1-input OR-AND-AND-OR-AND-OR-AND-Invert gate"
OAAOAOAI212111: OAAOAOI21211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAOI222111: DESCR = "2-2-2-1-1-1-input AND-AND-OR-OR-AND-OR-AND-OR-Invert gate"
AAOOAOAOI222111: AAOOAOAI22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAOAI222111: DESCR = "2-2-2-1-1-1-input OR-OR-AND-AND-OR-AND-OR-AND-Invert gate"
OOAAOAOAI222111: OOAAOAOI22211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOAOI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-OR-Invert gate"
AAOAAOAOI221211: AAOAAOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAOAI221211: DESCR = "2-2-1-2-1-1-input OR-OR-AND-OR-OR-AND-OR-AND-Invert gate"
OOAOOAOAI221211: OOAOOAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOAOI221311: DESCR = "2-2-1-3-1-1-input AND-AND-OR-AND-AND-OR-AND-OR-Invert gate"
AAOAAOAOI221311: AAOAAOAI22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAOAI221311: DESCR = "2-2-1-3-1-1-input OR-OR-AND-OR-OR-AND-OR-AND-Invert gate"
OOAOOAOAI221311: OOAOOAOI22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOAOI212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-OR-Invert gate"
AOOAAOAOI212211: AOOAAOAI21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAOAI212211: DESCR = "2-1-2-2-1-1-input OR-AND-AND-OR-OR-AND-OR-AND-Invert gate"
OAAOOAOAI212211: OAAOOAOI21221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOAOI212311: DESCR = "2-1-2-3-1-1-input AND-OR-OR-AND-AND-OR-AND-OR-Invert gate"
AOOAAOAOI212311: AOOAAOAI21231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAOAI212311: DESCR = "2-1-2-3-1-1-input OR_AND-AND-OR-OR-AND-OR-AND-Invert gate"
OAAOOAOAI212311: OAAOOAOI21231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOAOI222211: DESCR = "2-2-2-2-1-1-input AND-AND-OR-OR-AND-AND-OR-AND-OR-Invert gate"
AAOOAAOAOI222211: AAOOAAOAI22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOAOAI222211: DESCR = "2-2-2-2-1-1-input OR-OR-AND-AND-OR-OR-AND-OR-AND-Invert gate"
OOAAOOAOAI222211: OOAAOOAOI22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOAOI222311: DESCR = "2-2-2-3-1-1-input AND-AND-OR-OR-AND-AND-OR-AND-OR-Invert gate"
AAOOAAOAOI222311: AAOOAAOAI22231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

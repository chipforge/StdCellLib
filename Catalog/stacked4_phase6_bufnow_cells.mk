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
#   File:           StdCellLib/Catalog/stacked4_phase6_bufnow_cells.mk
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
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

#   --------    six phases      ------------------------------------

CELLS +=        AOAOAO211111 OAOAOA211111 \
                AAOAOAO221111 OOAOAOA221111 \
                AOAAOAO211211 OAOOAOA211211 \
                AOAAOAO211311 \
                AOAOAAO211112 OAOAOOA211112 \
                AOAOAAO211113 \
                AOAOOAO211121 OAOAAOA211121 \
                AOOAOAO212111 OAAOAOA212111 \
                AAOOAOAO222111 \
                AAOAAOAO221211 \
                AOOAAOAO212211

AOAOAO211111:   DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR gate"
AOAOAO211111:   AOAOA21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOA211111:   DESCR = "2-1-1-1-1-1-input OR-AND-OR-AND-OR-AND gate"
OAOAOA211111:   OAOAO21111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOAO221111:  DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND-OR gate"
AAOAOAO221111:  AAOAOA22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAOA221111:  DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR-AND gate"
OOAOAOA221111:  OOAOAO22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAO211211:  DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND-OR gate"
AOAAOAO211211:  AOAAOA21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOA211211:  DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR-AND gate"
OAOOAOA211211:  OAOOAO21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAO211311:  DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND-OR gate"
AOAAOAO211311:  AOAAOA21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOAAO211112:  DESCR = "2-1-1-1-1-2-input AND-OR-AND-OR-AND-AND-OR gate"
AOAOAAO211112:  AOAOAO211111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAOOA211112:  DESCR = "2-1-1-1-1-2-input OR-AND-OR-AND-OR-OR-AND gate"
OAOAOOA211112:  OAOAOA211111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAOAAO211113:  DESCR = "2-1-1-1-1-31-input AND-OR-AND-OR-AND-AND-OR gate"
AOAOAAO211113:  AOAOAAO211112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAO211121:  DESCR = "2-1-1-1-2-1-input AND-OR-AND-OR-OR-AND-OR gate"
AOAOOAO211121:  AOAOOA21112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAAOA211121:  DESCR = "2-1-1-1-2-1-input OR-AND-OR-AND-AND-OR-AND gate"
OAOAAOA211121:  AOAOOA21112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOAO212111:  DESCR = "2-1-2-1-1-1-input AND-OR-OR-AND-OR-AND-OR gate"
AOOAOAO212111:  AOOAOA21211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOA212111:  DESCR = "2-1-2-1-1-1-input OR-AND-AND-OR-AND-OR-AND gate"
OAAOAOA212111:  OAAOAO21211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAO222111: DESCR = "2-2-2-1-1-1-input AND-AND-OR-OR-AND-OR-AND-OR gate"
AAOOAOAO222111: AAOOAOA22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAO221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-OR gate"
AAOAAOAO221211: AAOAAOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAO212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-OR gate"
AOOAAOAO212211: AOOAAOA21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

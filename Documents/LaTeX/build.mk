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
#   File:           StdCellLib/Documents/LaTeX/build.mk
#
#   Purpose:        Documents Makefile
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2018 by chipforge <hsank@nospam.chipforge.org>
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
#   ////////////////////////////////////////////////////////////////////

#   project name

PROJECT ?=      StdCellLib

#   directory pathes

OUTPUTDIR =     ..

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
TAR ?=          tar -zh
DATE :=         $(shell date +%Y%m%d)

LATEX ?=        pdflatex -output-directory $(OUTPUTDIR)

#   ----------------------------------------------------------------
#               DETAILED TARGETS
#   ----------------------------------------------------------------

.PHONY: clean
clean:
	-$(RM) $(OUTPUTDIR)/*.aux $(OUTPUTDIR)/*.log

#   --------    LaTeX -> PDF    ------------------------------------

.PHONY: doc
doc:    $(PROJECT).tex revision.tex cmos_in_a_nutshell.tex
	$(LATEX) $<

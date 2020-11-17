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
#   File:           StdCellLib/include.mk
#
#   Purpose:        include common definitions
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2018 by chipforge <stdcelllib@nospam.chipforge.org>
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

#   ----------------------------------------------------------------
#               DEFINITIONS
#   ----------------------------------------------------------------

#   project name

PROJECT =       StdCellLib

#   directory paths

CATALOGDIR =    Catalog
DOCUMENTSDIR =  Documents
SIMULATIONDIR = Simulation
SOURCESDIR =    Sources
SYNTHESISDIR =  Synthesis
TEMPDIR =       Intermediate
TBENCHDIR =     TBench
TOOLSDIR =      Tools
RELEASEDIR =    Library
TECHDIR = 	Tech

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
TAR ?=          tar -zh
GREP ?=         grep
SED ?=          sed
MKDIR ?=        mkdir -p
DATE :=         $(shell date +%Y%m%d)

#   project tools

POPCORN ?=      $(TOOLSDIR)/popcorn/popcorn # -v
SCHEMATIC ?=    $(TOOLSDIR)/tcl/_schematic -o $(DOCUMENTSDIR)/LaTeX -i $(CATALOGDIR) -g LaTeX
MANUAL ?=       $(TOOLSDIR)/tcl/_manpage -o $(DOCUMENTSDIR)/LaTeX -i $(CATALOGDIR) -g LaTeX
SWITCH ?=       $(TOOLSDIR)/tcl/_switch -o $(SOURCESDIR)/verilog -i $(CATALOGDIR) -f verilog


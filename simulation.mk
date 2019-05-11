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
#   File:           StdCellLib/simulation.mk
#
#   Purpose:        Makefile for Simulation stuff
#
#   ************    GNU Make 3.80 Source Code   ***********************
#
#   ///////////////////////////////////////////////////////////////////
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
#   ///////////////////////////////////////////////////////////////////

#   common definitions

include include.mk

#   simulation tool variables

WORKDIR ?=          $(SIMULATIONDIR)/verilog
SIMULATOR1 ?=       iverilog -g2 # -Wall
SIMULATOR2 ?=       vvp # -v
WAVEVIEWER ?=       gtkwave

.PHONY: clean
clean:
	-$(RM) *.vcd
	-$(RM) $(SIMULATIONDIR)/verilog/*_bench.v
	-$(RM) $(SIMULATIONDIR)/verilog/*.vpp
	-$(RM) $(SIMULATIONDIR)/verilog/*.table

#   ----------------------------------------------------------------
#                   RUN VERILOG SIMULATION
#   ----------------------------------------------------------------

verilog-slm:
	$(POPCORN) -e $@ $(CATALOGDIR)/$(CELL).cell > $(SIMULATIONDIR)/verilog/$(CELL).v

verilog-bench:
	$(POPCORN) -e $@ $(CATALOGDIR)/$(CELL).cell > $(SIMULATIONDIR)/verilog/$(CELL)_bench.v

.PHONY: table-file
table-file: PROJECT_DEFINES += -DDUMPFILE=\"$@.vcd\"
table-file: verilog-slm verilog-bench
	$(MKDIR) $(TEMPDIR)
	$(SIMULATOR1) $(PROJECT_DEFINES) -o $(WORKDIR)/$(CELL)_bench.vpp $(WORKDIR)/$(CELL).v $(WORKDIR)/$(CELL)_bench.v
	$(SIMULATOR2) $(WORKDIR)/$(CELL)_bench.vpp | $(GREP) '^\.' | $(SED) 's/^.//g' > $(TEMPDIR)/$(CELL).table
ifeq ($(MODE), gui)
	$(WAVEVIEWER) -f $@.vcd -a $(SIMULATIONDIR)/verilog/$(CELL).do
endif

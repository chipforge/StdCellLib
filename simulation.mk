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

#   3rd party simulation tool variables

SIMULATOR1 ?=   iverilog -g2 # -Wall
SIMULATOR2 ?=   vvp # -v
WAVEVIEWER ?=   gtkwave

SPICE ?=        ngspice -b -c
#NETLIST ?=     gnetlist -g spice-noqsi -o
#NETLIST ?=      gnetlist -g spice -o
NETLIST ?=      gnetlist -g spice-sdb -o
#NETLIST ?=      lepton-netlist -g spice-sdb -o

#   temporary simulation directory

VERILOGTMP ?=   $(SIMULATIONDIR)/verilog


.PHONY: clean
clean:
	-$(RM) *.vcd
	-$(RM) $(SIMULATIONDIR)/verilog/*_bench.v
	-$(RM) $(SIMULATIONDIR)/verilog/*.vpp
	-$(RM) $(SIMULATIONDIR)/verilog/*.table
	-$(RM) $(SIMULATIONDIR)/spice/*_record.txt
	-$(RM) $(TBENCHDIR)/spice/*_tb.sp
	-$(RM) $(RELEASEDIR)/spice/*.cir

#   ----------------------------------------------------------------
#                   RUN VERILOG SIMULATION
#   ----------------------------------------------------------------

verilog-slm:
	$(POPCORN) -e $@ $(CATALOGDIR)/$(CELL) > $(SIMULATIONDIR)/verilog/$(CELL).v

verilog-bench:
	$(POPCORN) -e $@ $(CATALOGDIR)/$(CELL) > $(SIMULATIONDIR)/verilog/$(CELL)_bench.v

.PHONY: table-file
table-file: PROJECT_DEFINES += -DDUMPFILE=\"$@.vcd\"
table-file: verilog-slm verilog-bench
	$(MKDIR) $(TEMPDIR)
	$(SIMULATOR1) $(PROJECT_DEFINES) -o $(VERILOGTMP)/$(CELL)_bench.vpp $(VERILOGTMP)/$(CELL).v $(VERILOGTMP)/$(CELL)_bench.v
	$(SIMULATOR2) $(VERILOGTMP)/$(CELL)_bench.vpp | $(GREP) '^\.' | $(SED) 's/^.//g' > $(TEMPDIR)/$(CELL).table
ifeq ($(MODE), gui)
	$(WAVEVIEWER) -f $@.vcd -a $(SIMULATIONDIR)/verilog/$(CELL).do
endif

#   ----------------------------------------------------------------
#                   RUN SPICE SIMULATION
#   ----------------------------------------------------------------

record: $(SIMULATIONDIR)/spice/$(CELL)_record.txt

$(SIMULATIONDIR)/spice/$(CELL)_record.txt: $(RELEASEDIR)/spice/$(CELL).cir $(RELEASEDIR)/spice/BUF2.cir $(TBENCHDIR)/spice/$(CELL)_tb.sp
	$(SPICE) $? > $@

$(TBENCHDIR)/spice/$(CELL)_tb.sp: $(TBENCHDIR)/geda/$(CELL)_tb.sch $(TBENCHDIR)/spice/$(CELL)_tb.cmd
	$(NETLIST) $@ $<

$(RELEASEDIR)/spice/$(CELL).cir: $(SOURCESDIR)/geda/$(CELL).sch
	$(NETLIST) $@ $?


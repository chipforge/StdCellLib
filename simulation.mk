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
#   File:           StdCellLib/Simulation/verilog/GNUmakefile
#
#   Purpose:        Makefile for Verilog stuff
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

#   ----------------------------------------------------------------
#                   DEFINITIONS
#   ----------------------------------------------------------------

#   make build system defines

HDL ?=              verilog
MODE ?=             batch

#   directory pathes

SOURCESDIR =        ../../Sources/$(HDL)
TBENCHDIR =         ../../TBench/$(HDL)

#   tool variables

SIMULATOR1 ?=       iverilog -g2 # -Wall
SIMULATOR2 ?=       vvp # -v
INCLUDEDIRS ?=      -I$(SOURCESDIR)
WAVEVIEWER ?=       gtkwave

ECHO ?=             @echo # -e
RM ?=               /bin/rm -f
GREP ?=             grep -e
SED ?=              sed

#   collect all tests

TESTS =             $(patsubst %_stim.v,%,$(notdir $(wildcard $(TBENCHDIR)/*_stim.v)))

#   ----------------------------------------------------------------
#                   DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available targets:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "    help       - print this help screen"
	$(ECHO) ""
	$(ECHO) "    <testcase> - run this specified test case (see list below)"
	$(ECHO) "    [MODE=batch|report|gui] <testcase>"
	$(ECHO) "               - run test in batch | report | gui mode (default: $(MODE))"
	$(ECHO) "    [STEP=rtl|pre|post] <testcase>"
	$(ECHO) "               - run test on rtl | pre-routed | post-routed (default: $(STEP))"
	$(ECHO) "    tests      - run all test cases (see list below)"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available testcases:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "    $(TESTS)"
	$(ECHO) ""

.PHONY: clean
clean:
	-$(RM) *.vcd
	-$(RM) *.vpp
	-$(RM) *.table

#   ----------------------------------------------------------------
#                   RUN TESTCASES
#   ----------------------------------------------------------------

.PHONY: tests
tests: $(TESTS)

%: PROJECT_DEFINES += -DDUMPFILE=\"$@.vcd\"
%: $(TBENCHDIR)/%_stim.v $(SOURCESDIR)/%*_switch.v
	$(SIMULATOR1) $(PROJECT_DEFINES) $(INCLUDEDIRS) -o $@.vpp $^
	$(ECHO) "----    Run Test: $@    ----"
	$(SIMULATOR2) $@.vpp | $(GREP) '^\.' | $(SED) 's/^.//g' > $@.table
ifeq ($(MODE), gui)
	$(WAVEVIEWER) -f $@.vcd -a $@.do
endif

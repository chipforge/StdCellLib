# Popcorn

This Repository contains the Source Code for the Standard Cell Generator, called Popcorn.
Started once as a Tcl Script, Popcorn is now rewritten in R^7RS-Scheme.
The code was developed with *Gauche scheme shell, version 0.9.6* and is still Work-in-Progress.
Please stay tuned.

Do not hesitate to contact the Authors of Popcorn for Patches, Feature additions or Questions.
Any feedback welcome under [Email](mailto://popcorn@nospam.chipforge.org "popcorn@nospam.chipforge.org").

The tool functionality is divided into a couple of files:

- *popcorn-lib.scm*     ; library with essential functionality
- *popcorn-cell.scm*    ; functions regarding cell read-in/write-out
- *popcorn-verilog.scm* ; functions regarding verilog generation
- *popcorn-sch.scm*     ; functions regarding schematic generations
- *popcorn.scm*         ; Popcorn itself
- *README.md*           ; this file

The most basic features are:

1. reading in simplified cell netlists,
2. enhance cells with more transistors to become complex gates,
3. writing out enhanced cell netlist.

In the end, there should be an almost complete catalog of all possible cells, with a dedicated maximum number of stacked transistors in one row between power supply and outputs.
The maximum number of stacked transistors is a core parameter, which depends on the supply voltage and the transistor threshold voltage.
Please check the **-l number** command line option. While to many transistors with their Source to Drain Pathes restrict the LOW and HIGH voltages on outputs, a optional buffer can be set afterwards which revive the output voltages.
With reaching the threshold (regarding the maximum number of stacked transistors) defined by the **-b number** command line option the output buffer will be inserted.

E.g. with **-l 4** and **-b 4** gets an *ADD4* cell into the catalog, but no *NAND4* cell.

Of course, every single cell needs different representations for different purposes (like Simulation, Layout and Documentation).

Hence, Popcorn also:

- generates accurate Simulation Models (as Spice and Verilog)
- generates optimized Cell Layouts (in ALF, Magic and others)
- generates LaTeX documention views, e.g. Schematics, Truth Tables, Formulas and Data Sheets
- etc.

on *STDOUT* by request.
While Popcorn generates one export file format per call, the tool has to be called many times with **-e format** command line option.

For the correct Usage, please make yourself familiar with the command line interface by reading the *Manual Page* and studying the local *GNUmakefile*.


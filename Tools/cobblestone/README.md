# Cobblestone

This Repository contains the Source Code for the Physical Layout Generator, called Cobblestone.
Started once as a Tcl Script inside 'Popcorn' is now written in R^7RS-Scheme.
The code was developed with *Gauche scheme shell, version 0.9.6* and is still Work-in-Progress.
Please stay tuned.

Do not hesitate to contact the Authors of Cobblestone for Patches, Feature additions or Questions.
Any feedback welcome under [Email](mailto://cobblestone@nospam.chipforge.org "cobblestone@nospam.chipforge.org").

The tool functionality is divided into a couple of files:

- *cobblestone.scm*     ; the program itself
- *cobblestone*         ; the program wrapper
- *README.md*           ; this file

The most basic features are:

1. reading in cell description,
2. use the Layout Rules from the mosis-rules.scm file,
3. and writing out a dedicated library layout file.

on *STDOUT* by request.
While Cobblestone generates one export file format per call, the tool has to be called many times for every cell.

For the correct Usage, please make yourself familiar with the command line interface by reading the *Manual Page* and studying the local *GNUmakefile*.


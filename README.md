# StdCellLib

This Repository contains all Sources for LibreSilicons's Standard Cell Library Generator.
The process starts with the PDK from the semiconductor factory as an input.
In the first step you can either use "Popcorn" to grow the netlists for all cells out of a single inverter.
Or you could import the netlists from a given existing standard cell library.
The second step is the automatic generation (layouting, characterization) of all the standard cells.
In the final step, all the files are collected into the library files together that can then be used by e.g. qflow, yosys to go from RTL to GDS.


## Requirements

### Linux (Debian/Ubuntu or derivative)

For Debian/Ubuntu based distributions (with Python >=3.6, e.g. Debian Buster) we are currently offering an installation script that installs all the necessary requirements:

```
wget https://pdk.libresilicon.com/tools.sh
bash tools.sh
```

It will download, build and install all required tools, and at the end try to build a standard cell library.

For other operating systems it is likely quite some work to get it running due to the high number of dependencies. But any ports to other systems are very welcome!

## Usage

Please build and use the Standard Cells (and the cell generator) with the GNUmakefile system.

```
cd StdCellLib/Catalog
make
make catalog
make layout
make docs
```

make alone shows e.g. a help screen with available targets.
make popcorn will prepare Popcorn and generate the very useful Manual Pages about the tool and the formats, Popcorn is using. Please read them.


### Generate Cell Descriptions

Once Popcorn is installed, you might run

```
cd Catalog
make catalog
```

which re-generates the majority of Cell Description Catalog; and overwrites older, already generated cells. Doing so, GNU make sees the new timestamp and redo the following (time-consuming) steps once again. All manual changes on Cells in the Catalog are going lost.

Please re-generate the Catalog only, if you know what you're doing and have strong reasons for that.

Instead of Generating Cell Descriptions you can also import them from qflow:

```
cd Catalog
make importQflow
```

### Generate Cell Layouts

After you have generated and/or imported the cell description netlists, you can generate the layout:
```
make layout
```
In the future you will be able to parallelize it with make -j4 to have several cells being calculated at the same time

While the generation is running you can continuously generate the build-report every 10 seconds by running 
```
bash ../Tools/reporter.sh
```
You can then view the build-report in the file buildreport.html 
An example build report is available here: https://pdk.libresilicon.com/dist/StdCellLib_20200417/Catalog/buildreport.html

### Generate Library Documentation

Once all Cells in all Cell Representations you'll need (Library files, Layout files, Simulation Models, etc.) are complete, you should run

```
make doc
```

and build the holistic Standard Cell Library Documention under

```
./Documents/StdCellLib.pdf
```

with all already generated cells.

### Distribution

Hopefully, you did a great job, did not forget a piece of work, all things went fine..
```
make dist
```

generates a compresses Archive (.tgz) of all important files, named with the current date. If you're sure nothing left, this is the file to ditstribute as Standard Cell Library and to store into your repository (and to tag them as Release).

You can also use
```
make qflow
```
to install the standard cell library into qflow as "libresilicon"

BTW, the Tooling should *not* be part of the Distribution.


Congratulations! You generated a Standard Cell Library :-) There aren't many people who can say they've done that.

# How to help
Please test it and report any issues, or in the respective repositories of the partner-projects.
And please, do not hesitate to contact the Authors of Standard Cell Library for Patches, Feature additions or Questions.
Any feedback welcome under [Email](mailto://stdcelllib@nospam.chipforge.org "stdcelllib@nospam.chipforge.org").

### Partner Tools

We use LibreCell from Thomas Kramer https://codeberg.org/tok/librecell/ for Layouting and Characterization of the standard cells.
We use Magic from Tim Edwards: http://opencircuitdesign.com/magic/ for Popcorn, parasitic extraction and visualisation. Thanks a lot for your help!
We use the great CircDia LaTeX package for drawing circuit diagrams by Dr. Stefan Krause (Saarbr&uuml;cken/Germany). (http://www.taylorgruppe.de/circdia "http://www.taylorgruppe.de/circdia")

### Scheme

Popcorn (as the tool which does the Voodoo stuff and generates the Standard Cells) is written in R^7RS Scheme. While this Standard is already a couple of years old, not so many tools supporting them. Chibi-Scheme as a pre-build package is not available on most systems, so we are using Gauche Scheme (or gosh) in Version 0.9.6 or higher.

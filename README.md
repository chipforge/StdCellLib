# StdCellLib
LibreSilicon's Standard Cell Library

This is still work in progress.

Requirements:
On Debian based system you can install most of the requirements with
```
apt-get install make guile texlive-latex-extra texlive-extra-utils  texlive-latex-recommended 
```
Additionally for drawings with LaTeX you need http://www.taylorgruppe.de/circdia/ , download and unzip it, then run mktexlsr in the directory.

Other software for the Popcorn tool which should be installed before usage, is
```
magic
```
a Open Source Layout tool, maintained on http://opencircuitdesign.com/magic. Magic is not part of all Linux distributions; but for Debian based systems
```
apt-get install magic
```
works.


Usage:
Please build and use the Standard Cells (and the cell generator) with GNU Makefiles.

```
make
```

shows a help screen with available targets.
For details, please check the Document directory,

```
make doc
```

builds the Standard Cell Library Documention under

```
./Documents/StdCellLib.pdf
```


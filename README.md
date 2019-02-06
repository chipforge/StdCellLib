# StdCellLib
LibreSilicon's Standard Cell Library

This is still work in progress.

Requirements:
On Debian based system you can install most of the requirements with
```
apt-get install make tcl texlive-latex-extra texlive-extra-utils  texlive-latex-recommended 
```
Additionally you need http://www.taylorgruppe.de/circdia/ , download and unzip it, then run mktexlsr in the directory.

Please build the whole system with GNU Makefiles.

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


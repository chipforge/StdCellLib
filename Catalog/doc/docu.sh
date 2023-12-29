#!/bin/bash

#cd ..
for a in *.cell
do
  ../Tools/tcl/_schematic -i . -o doc $a
done
cd doc
echo "" >cells.tex
for a in *_schematic.tex
do
  echo \\clearpage >>cells.tex
  echo \\section{Cell ${a//_schematic\.tex/}} >>cells.tex
  echo \\input{$a} >>cells.tex
  #echo "Text below the schematic" >>cells.tex

  echo \\documentclass{article} >${a//_schematic/_svg}
  echo \\usepackage[digital,srcmeas,semicon]{circdia} >>${a//_schematic/_svg}
  echo \\begin{document} >>${a//_schematic/_svg}
  echo \\thispagestyle{empty} >>${a//_schematic/_svg}
  echo \\input {$a} >>${a//_schematic/_svg}
  echo \\end{document} >>${a//_schematic/_svg}
  pdflatex ${a//_schematic/_svg}
  pdfcrop ${a//_schematic.tex/_svg.pdf}
  pdf2svg ${a//_schematic.tex/_svg.pdf} ${a//_schematic.tex/_svg.svg}
  convert -trim ${a//_schematic.tex/_svg.svg} ${a//_schematic.tex/_svg.png}
done
pdflatex StdCellLib.tex
pdflatex StdCellLib.tex
cp StdCellLib.pdf ../../Documents/StdCellLib.pdf
echo "You can view the generated documentation by calling:"
echo "evince doc/StdCellLib.pdf"

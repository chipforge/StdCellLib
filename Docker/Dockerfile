#docker pull ubuntu:20.10

FROM ubuntu:20.10 as build

ENV TZ=Europe/Vienna
ENV LANG=C.UTF-8

RUN apt update --fix-missing
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN apt-get update && apt-get -y install npm blender texlive-full inkscape kicad iverilog gtkwave lsb

RUN apt-get update && apt-get -y install qflow imagemagick libcairo2-dev tcllib tklib make g++ libreadline-dev python3-cairosvg python3 python3-numpy libblas-dev ngspice z3 tcl8.6-dev tk8.6-dev python3-scipy python3-matplotlib texlive-latex-recommended unzip glpk-utils libglpk-dev python3-pulp git wget gauche python3-toml python3-pytoml python3-pip mmv libglu1-mesa-dev libcurl4-gnutls-dev pdf2svg python3-yaml python3-cffi python3-pyparsing python3-certifi tcl magic libsqlite3-dev python3-setuptools python3-networkx python3-sympy
RUN apt-get -y install libngspice0 libngspice0-dev python3-gdspy python3-kiwisolver 
#RUN apt-get -y install klayout libopengl-dev opensta opensta-dev
#RUN apt-get -y install python-z3 
RUN apt-get -y install python3-z3

#RUN apt --fix-broken install
#RUN apt --fix-missing

RUN pip3 install PySpice

RUN git clone https://github.com/KLayout/klayout
WORKDIR klayout
RUN python3 setup.py build --parallel 1
RUN python3 setup.py install
WORKDIR ..

RUN wget -c http://www.taylorgruppe.de/circdia/circdia.zip
RUN mkdir -p /usr/share/texlive/texmf-dist/tex/circdia
RUN unzip -u -o -d /usr/share/texlive/texmf-dist/tex/circdia circdia.zip
RUN mktexlsr

RUN git clone https://codeberg.org/tok/librecell
WORKDIR librecell/librecell-common
RUN python3 setup.py install
WORKDIR ../..
WORKDIR librecell/librecell-meta
RUN python3 setup.py install
WORKDIR ../..
WORKDIR librecell/librecell-lib
RUN python3 setup.py install
WORKDIR ../..
WORKDIR librecell/librecell-layout
RUN python3 setup.py install
WORKDIR ../..

RUN wget -c http://www.taylorgruppe.de/circdia/circdia.zip
RUN mkdir -p /usr/share/texlive/texmf-dist/tex/circdia
RUN unzip -u -o -d /usr/share/texlive/texmf-dist/tex/circdia circdia.zip
RUN mktexlsr

RUN git clone https://github.com/thesourcerer8/StdCellLib
WORKDIR StdCellLib/Catalog
#RUN make catalog
RUN make importQflow

RUN rm /usr/local/lib/python3.8/dist-packages/PySMT-0.9.1.dev86-py3.8.egg/six.py

#echo "Installation of the StdCellLib is finished."
#echo "To build a whole standard cell library you can now run:"
#echo "make layout ; make doc ; perl ../Tools/perl/buildreport.pl ; cd .. ; make dist"
#sudo make qflow

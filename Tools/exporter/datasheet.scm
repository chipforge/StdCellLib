;;  ************    LibreSilicon's StdCellLibrary   *******************
;;
;;  Organisation:   Chipforge
;;                  Germany / European Union
;;
;;  Profile:        Chipforge focus on fine System-on-Chip Cores in
;;                  Verilog HDL Code which are easy understandable and
;;                  adjustable. For further information see
;;                          www.chipforge.org
;;                  there are projects from small cores up to PCBs, too.
;;
;;  File:           StdCellLib/Tools/exporter/datasheet.scm
;;
;;  Purpose:        Scheme Module - export datasheet as library
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c)   2021 by
;;                  chipforge <popcorn@nospam.chipforge.org>
;;
;;  This source file may be used and distributed without restriction
;;  provided that this copyright statement is not removed from the
;;  file and that any derivative work contains the original copyright
;;  notice and the associated disclaimer.
;;
;;  This source is free software; you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation; either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This source is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;  GNU General Public License for more details.
;;
;;   (__)  You should have received a copy of the GNU General Public
;;   oo )  License along with this program; if not, write to the
;;   /_/|  Free Software Foundation Inc., 51 Franklin St., 5th Floor,
;;         Boston, MA 02110-1301, USA
;;
;;  GNU General Public License v3.0 - http://www.gnu.org/licenses/gpl-3.0.html
;;  ///////////////////////////////////////////////////////////////////

(define-library (exporter datasheet)
  (import (scheme base)
          (srfi 78)         ; test suite
          (common lib)
          (common cell)
          (exporter generic)
) (export ; exporter
          exporter:latex-datasheet
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'report) ;(check-set-mode! 'off)

;;  ------------    SYNOPSYS    ---------------------------------------

    (define (SYNOPSYS cell)
        "Generates SYNOPSY paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Synopsys}"
            "\n\\begin{quote}"
            "\n " (id cell) " (" (outputs cell) (inputs cell) (clocks cell)")"
            "\n\\end{quote}"))

;;  ------------    CIRCUITRY   ---------------------------------------

    (define (CIRCUITRY cell)
        "Generates CIRCUITRY paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Circuitry}"
            "\n\\input{" (id cell) "_circuit.tex}"))

;;  ------------    TRUTHTABLE  ---------------------------------------

    (define (TRUTHTABLE cell)
        "Generates TRUTH TABLE paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Truth Table}"
            "\n\\input{" (id cell) "_truthtable.tex}")) ; !! generate here from table file !!

;;  ------------    SCHEMATIC   ---------------------------------------

    (define (SCHEMATIC cell)
        "Generates SCHEMATIC paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Schematic}"
            "\n\\input{" (id cell) "_schematic.tex}"    ; !! take PS file if available
        ))

;;  ------------    LAYOUT  -------------------------------------------

    (define (LAYOUT cell)
        "Generates LAYOUT paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Layout}"
            "\n\\input{" (id cell) "_layout.tex}" ; !!
        ))

;;  ------------    FILES   -------------------------------------------

    (define (FILES cell filelist)
        "Generates FILES paragraph.
        Returns list for (map display (list ..))"
        (list
            "\n\\paragraph{Files}"
            ; generate topics !!
        ))

;;  ------------    page frame  ---------------------------------------

    (define (outer-page-frame cell filelist)
        "Generates datasheet frame.
        Returns list for (map display (list ..))"
        (list
            ; start with subsection header
            "\n\\subsection{" (id cell) " - " (description cell) "} \\label{" (id cell) "}"
            (SYNOPSYS cell)
            ; 2-column section for circuit and truthtabel
            "\n\\twocolumn" (CIRCUITRY cell) (TRUTHTABLE cell) "\n\\onecolumn"
            ; 1-column section for large schematic and layout files
            (SCHEMATIC cell)
            (LAYOUT cell)
            ; 2-column section for file lists
            "\n\\twocolumn" (FILES cell filelist) "\n\\onecolumn"
            ; clear page for next one
            "\n\\clearpage"))

;;  ------------    exporter datasheet in latex -----------------------

    (define (exporter:latex-datasheet cell filelist)
        "Display datasheet template structure.
        Returns list for (map display (list ..))"
        (map rdisplay
            (list
                (generic-fileheader ";;" "Documents/LaTeX/" "Data Sheet")
                (generic-copyleft ";;")
                (generic-license ";;")
                (outer-page-frame cell filelist)
                (generic-filefooter ";;" "Documents/LaTeX/"))))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

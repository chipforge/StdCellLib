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
;;  Copyright (c) 2021 - 2022by
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
    (check-set-mode! 'off)

;;  ------------    naming      ---------------------------------------

    (define (naming cell)
        "Generates cell naming information.
        Returns list for (map display (list ..))"
        (list
            ; start with subsection header
            "\n\\subsection{" (id cell) " - " (description cell) "} \\label{cell:" (id cell) "}"
            "\n"))

;;  ------------    synopsys    ---------------------------------------

    (define (synopsys cell)
        "Generates synopsys information.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{Synopsys:}"
            "\n"
            "\n\\begin{quote}"
            "\n    " (id cell) " (" (outputs cell) " " (inputs cell) (clocks cell)")"
            "\n\\end{quote}"
            "\n"))

;;  ------------    circuit diagram -----------------------------------

    (define (circuit cell)
        "Include circuit diagram.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{Circuitry:}"
            "\n"
            "\n\\begin{figure}[htp!]"
            "\n    \\centering"
            "\n    \\input{./Datasheets/Circuitry/" (id cell) ".tex}"
            "\n\\end{figure}"
            "\n"))

;;  ------------    truth table ---------------------------------------

    (define (truthtable cell)
        "Include truth table.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{Truth Table:}"
            "\n"
            "\n\\begin{table}[htp!]"
            "\n    \\centering"
            "\n    \\input{./Datasheets/Truthtables/" (id cell) ".tex}"
            "\n\\end{table}"
            "\n"))

;;  ------------    schematic   ---------------------------------------

    (define (schematic cell)
        "Include schematic diagram if available.
        Returns list for (map display (list ..))"
        (list
            "\n\\begin{landscape}"
            "\n"
            "\n\\subsubsection*{Schematic:}"
            "\n"
            "\n    \\begin{figure}[htp!]"
            "\n            \\centering"
            "\n        \\begin{minipage}{.9\\textwidth}"
            "\n            \\input{./Datasheets/Schematics/" (id cell) ".tex}"
            "\n        \\end{minipage}"
            "\n    \\end{figure}"
            "\n\\end{landscape}"
            "\n"))

;;  ------------    layout  -------------------------------------------

    (define (layout cell)
        "Include layout picture.
        Returns list for (map display (list ..))"
        (list
            "\n\\begin{landscape}"
            "\n"
            "\n\\subsubsection*{Layout:}"
            "\n"
            "\n    \\begin{figure}[htp!]"
            "\n            \\centering"
            "\n        \\begin{minipage}{.9\\textwidth}"
            "\n            \\input{./Datasheets/Layouts/" (id cell) ".tex}"
            "\n        \\end{minipage}"
            "\n    \\end{figure}"
            "\n\\end{landscape}"
            "\n"))

;;  ------------    loading     ---------------------------------------

    (define (loading cell)
        "Include loading table.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{Logical Effort:}"
            "\n"
            "\n\\begin{figure}[htp!]"
            "\n    \\centering"
            "\n    \\input{./Datasheets/Loading/" (id cell) ".tex}"
            "\n\\end{figure}"
            "\n"))

;;  ------------    file list   ---------------------------------------

    (define (files cell filelist)
        "Generates file list.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{File List:}"
            "\n"
            ; generate topics !!
        ))

;;  ------------    see also    ---------------------------------------

    (define (see-also cell)
        "Generates see-also information.
        Returns list for (map display (list ..))"
        (list
            "\n"
            "\n\\subsubsection*{See also:}" (origin cell)
            "\n"
            ; generate topics !!
        ))

;;  ------------    page frame  ---------------------------------------

    (define (outer-page-frame cell filelist)
        "Generates datasheet frame.
        Returns list for (map display (list ..))"
        (list
            (naming cell)
            "\n\\thispagestyle{myheadings}"
            "\n\\markboth{" (id cell) " \\hfill " (description cell) "}{"
                            (description cell) " \\hfill " (id cell) "}"
            (synopsys cell)
            (circuit cell)
            (truthtable cell)
            (schematic cell)
            (layout cell)
            (loading cell)
            (files cell filelist)
            (see-also cell)))

;;  ------------    exporter datasheet in latex -----------------------

    (define (exporter:latex-datasheet cell filelist)
        "Display datasheet template structure.
        Returns list for (map display (list ..))"
        (map rdisplay
            (list
                (generic-fileheader "%%" (id cell) "Data Sheet")
                (generic-copyleft "%%")
                (generic-license "%%")
                (outer-page-frame cell filelist)
                (generic-filefooter "%%" (id cell) "Data Sheet"))))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

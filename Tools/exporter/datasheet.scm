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

;;  ------------    synopsys    ---------------------------------------

    (define (synopsys cell)
        "Generates synopsys information.
        Returns list for (map display (list ..))"
        (list
            "\n\\begin{quote}"
            "\n    " (id cell) " (" (outputs cell) " " (inputs cell) (clocks cell)")"
            "\n\\end{quote}"
            "\n"))

;;  ------------    circuit diagram -----------------------------------

    (define (circuit cell)
        "Include circuit diagram.
        Returns list for (map display (list ..))"
        (list
            "\n\\begin{figure}[h]"
            "\n    \\centering"
            "\n    \\input{" (id cell) "_circuit.tex}"
            "\n\\end{figure}"
            "\n"))

;;  ------------    truth table ---------------------------------------

    (define (truthtable cell)
        "Include truth table.
        Returns list for (map display (list ..))"
        (list
            ;"\n"   ; ?? frame-ing
            "\n\\input{" (id cell) "_truthtable.tex}")) ; !! generate here from table file !!

;;  ------------    file list   ---------------------------------------

    (define (files cell filelist)
        "Generates file list.
        Returns list for (map display (list ..))"
        (list
            ; generate topics !!
        ))

;;  ------------    schematic   ---------------------------------------

    (define (schematic cell)
        "Include schematic diagram.
        Returns list for (map display (list ..))"
        (list
            "\n\\begin{landscape}"
            "\n    \\fbox{" (description cell) "}"
            "\n    \\begin{figure}[b]"
            "\n        \\centering"

            "\n        \\input{" (id cell) "_schematic.tex}"    ; !! take PS file if available
            "\n    \\end{figure}"
            "\n\\end{landscape}"
            "\n"))

;;  ------------    layout  -------------------------------------------

    (define (layout cell)
        "Include layout picture.
        Returns list for (map display (list ..))"
        (list
            ;"\n"   ; ?? frame-ing
            "\n\\input{" (id cell) "_layout.tex}" ; !!
        ))

;;  ------------    page frame  ---------------------------------------

    (define (outer-page-frame cell filelist)
        "Generates datasheet frame.
        Returns list for (map display (list ..))"
        (list
            ; start with subsection header
            "\n\\subsection{" (id cell) " - " (description cell) "} \\label{cell:" (id cell) "}"
            "\n"
            "\n\\paragraph{Description:}"
            "\n"
            (synopsys cell)
            (circuit cell)
;            (truthtable cell)
;            (files cell filelist)
            (schematic cell)
;            (layout cell)
            ; clear page for next subsection 
            "\n\\clearpage"))

;;  ------------    exporter datasheet in latex -----------------------

    (define (exporter:latex-datasheet cell filelist)
        "Display datasheet template structure.
        Returns list for (map display (list ..))"
        (map rdisplay
            (list
                (generic-fileheader "%%" "Documents/LaTeX/" (id cell) "Data Sheet")
                (generic-copyleft "%%")
                (generic-license "%%")
                (outer-page-frame cell filelist)
                (generic-filefooter "%%" "Documents/LaTeX/"))))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

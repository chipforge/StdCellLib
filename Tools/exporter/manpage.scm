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
;;  File:           StdCellLib/Tools/exporter/manpage.scm
;;
;;  Purpose:        Scheme Module - export manpage as library
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

(define-library (exporter manpage)
  (import (scheme base)
          (srfi 78)         ; test suite
          (common lib)
          (common cell)
) (export ; exporter
          exporter:latex-manpage
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'report) ;(check-set-mode! 'off)

;;  ------------    exporter manpage in latex   -----------------------

    (define (exporter:latex-manpage cell)
        "Generates manpage content. Returns list for (map display (list ..))"
        (list
            ; file header
            "\n%%  ************    LibreSilicon's StdCellLibrary   *******************"
            "\n%%"
            "\n%%  Organisation:   Chipforge"
            "\n%%                  Germany / European Union"
            "\n%%"
            "\n%%  Profile:        Chipforge focus on fine System-on-Chip Cores in"
            "\n%%                  Verilog HDL Code which are easy understandable and"
            "\n%%                  adjustable. For further information see"
            "\n%%                          www.chipforge.org"
            "\n%%                  there are projects from small cores up to PCBs, too."
            "\n%%"
            "\n%%  File:           StdCellLib/Documents/LaTeX/" (id cell) "_manpage.tex"
            "\n%%"
            "\n%%  Purpose:        Auto-generated Manual Page for " (id cell)
            "\n%%"
            "\n%%  ************    LaTeX with circdia.sty package      ***************"
            "\n%%"
            "\n%%  ///////////////////////////////////////////////////////////////////"
            "\n%%"
            "\n%%  Copyright (c) " (copyleft-year) " by"
            "\n%%                  chipforge <stdcelllib@nospam.chipforge.org>"
            "\n%%  All rights reserved."
            "\n%%"
            "\n%%      This Standard Cell Library is licensed under the Libre Silicon"
            "\n%%      public license; you can redistribute it and/or modify it under"
            "\n%%      the terms of the Libre Silicon public license as published by"
            "\n%%      the Libre Silicon alliance, either version 1 of the License, or"
            "\n%%      (at your option) any later version."
            "\n%%"
            "\n%%      This design is distributed in the hope that it will be useful,"
            "\n%%      but WITHOUT ANY WARRANTY; without even the implied warranty of"
            "\n%%      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
            "\n%%      See the Libre Silicon Public License for more details."
            "\n%%"
            "\n%%  ///////////////////////////////////////////////////////////////////"
            ; subsection header
            "\n\\subsection{" (id cell) " - " (description cell) "} \\label{" (id cell) "}"
            ; synopsys
            "\n\\paragraph{Synopsys}"
            "\n\\begin{quote}"
            "\n    " (id cell) "(" (outputs cell) (inputs cell) (clocks cell)")"
            "\n\\end{quote}"
            ; description
            "\n\\paragraph{Description}"
            ; truth table
            "\n\\paragraph{Truth Table}"
            ; layout
            "\n\\paragraph{Layout}"
            ; files
            "\n\\paragraph{Files}"
            "\n\\clearpage"
            ))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

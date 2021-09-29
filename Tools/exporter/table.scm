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
;;  File:           StdCellLib/Tools/exporter/table.scm
;;
;;  Purpose:        Scheme Module - export table dataset as library
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

(define-library (exporter table)
  (import (scheme base)
          (srfi 78)         ; test suite
) (export ; exporter
          exporter:dataset-table
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  ------------    exporter table file -------------------------------

    (define (exporter:dataset-table table)
        "Generates table file content. Returns list for (map display (list ..))"
        (list
            "primitive " (udp-name table) (udp-outputs table) (udp-inputs table)
            "\n  output " (udp-outputs table) ";"
            "\n  input " (udp-inputs table) ";"
            "\n  table "
            "\n  // " (udp-inputs table) " : " (udp-outputs)
            ;; line by line
            "\n  endtable"
            "\nendprimitive"
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

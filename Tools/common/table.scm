;;;;    ************    LibreSilicon's StdCellLibrary   *******************
;;;;
;;;;    Organisation:   Chipforge
;;;;                    Germany / European Union
;;;;
;;;;    Profile:        Chipforge focus on fine System-on-Chip Cores in
;;;;                    Verilog HDL Code which are easy understandable and
;;;;                    adjustable. For further information see
;;;;                            www.chipforge.org
;;;;                    there are projects from small cores up to PCBs, too.
;;;;
;;;;    File:           StdCellLib/Tools/common/table.scm
;;;;
;;;;    Purpose:        Scheme Module - common table functionality as library
;;;;
;;;;    ************    Revised^7 Report on Scheme (R7RS)   ***************
;;;;
;;;;    ///////////////////////////////////////////////////////////////////
;;;;
;;;;    Copyright (c) 2021 - 2022 by
;;;;                    chipforge <popcorn@nospam.chipforge.org>
;;;;
;;;;    This source file may be used and distributed without restriction
;;;;    provided that this copyright statement is not removed from the
;;;;    file and that any derivative work contains the original copyright
;;;;    notice and the associated disclaimer.
;;;;
;;;;    This source is free software; you can redistribute it and/or modify
;;;;    it under the terms of the GNU General Public License as published by
;;;;    the Free Software Foundation; either version 3 of the License, or
;;;;    (at your option) any later version.
;;;;
;;;;    This source is distributed in the hope that it will be useful,
;;;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;;;    GNU General Public License for more details.
;;;;
;;;;     (__)  You should have received a copy of the GNU General Public
;;;;     oo )  License along with this program; if not, write to the
;;;;     /_/|  Free Software Foundation Inc., 51 Franklin St., 5th Floor,
;;;;           Boston, MA 02110-1301, USA
;;;;
;;;;    GNU General Public License v3.0 - http://www.gnu.org/licenses/gpl-3.0.html
;;;;    ///////////////////////////////////////////////////////////////////

(define-library (common table)
  (import (scheme base)
          (srfi 78)         ; test suite
) (export ; node objects
          method-generate-table
          method-pretty-print-table
          ;; ?? method-pretty-print-nodes
          ;; cell read file
          common:dataset-cell
) (begin

;;;     ------------    srfi-78 test suite  -------------------------------

    ;; change this switch during development only
    ;; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'report) ; (check-set-mode! 'off)

;;;     -------------------------------------------------------------------
;;;                     TABLE DATA STRUCTURE
;;;     -------------------------------------------------------------------

    ;;  define a cell as record

    ;;      +---------------+       e.g.:
    ;;      | table id      | ->    "INV"
    ;;      +---------------+
    ;;      | table inputs  | ->    '("A")
    ;;      +---------------+
    ;;      | table outputs | ->    '("Y")
    ;;      +---------------+
    ;;      | table clocks  | ->    '() ; usually for latches
    ;;      +---------------+
    ;;      | table body    | ->    '(<table itself>)
    ;;      +---------------+

    (define-record-type <table>
        ; constructor
        (table table-id table-inputs table-outputs table-clocks table-body)
        ; predicate
        table?
        ; getters & setters (omit the setters from immutable fields)
        (table-id id set-id!)
        (table-inputs inputs set-inputs!)
        (table-outputs outputs set-outputs!)
        (table-clocks clocks set-clocks!)
        (table-body body set-body!))

;;;     ------------    generate empty <table>     -----------------------

    (define (method-generate-table)
        "Generate empty <table> record structure.  Returns <table>."
        (table "" '() '() '() '()))


;;;     ------------    pretty print <table>    ---------------------------

    (define (method-pretty-print-table record)
        "Pretty-Print a <table> record structure.  Returns a list."
        (list
            (id record)
            (method-pretty-print-nodes (inputs record))
            (method-pretty-print-nodes (outputs record))
            (method-pretty-print-nodes (clocks record))
            (method-pretty-print-netlist (netlist record))
            ))

;;;     ------------    read in table file  -------------------------------

    (define (common:dataset-table file-name)
        "Read in table-file.  Returns a <table> structure."
        (let* ([file (open-input-file file-name)]
               [current-table (method-generate-table)])
            (let x ((1stline (read-line file)))
                (if (eof-object? 1stline)
                    '()
                    (begin
                        (set-description! current-table 1stline)
                        (let function ((nextline (read-line file)))
                            (unless (eof-object? nextline)
                                (let ([parsed-line (string-tokenize nextline)])
                                    current-table (read-tagged-line! current-table parsed-line)
                                    (function (read-line file))))))))
        current-table))

;;;     ===================================================================
;;;                     END OF R7RS LIBRARY
;;;     ===================================================================
  )
)

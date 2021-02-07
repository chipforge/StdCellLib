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
;;  File:           StdCellLib/Tools/popcorn/expander.scm
;;
;;  Purpose:        Popcorn Expander functionality
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c) 2019 - 2021 by
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

(define-library (popcorn expander)
  (import (scheme base)
          (srfi 78)             ; test suite
          ; r7rs modules for StdCellLib also
          (common cell)
) (export ; expander methods
          expand-cell
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  -------------------------------------------------------------------
;;                  LOCATION RECORD STRUCTURE
;;              see (import (common cell)) library
;;  -------------------------------------------------------------------

;   handle <location> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <location>

;;  ------------    method rise <location> stacked-number   -----------

    (define (method-rise-location-stacked record)
        "Rise the coodinatates for a <location> on stacked-number.  Returns <location>."
        (begin
            (set-stacked! record (+ (stacked record) 1))
            record))

;;  ------------    method rise <location> on x-axis    ---------------

    (define (method-rise-location-x record)
        "Rise the coodinatates for a <location> on x-axis.  Returns <location>."
        (begin
            (set-x-axis! record (+ (x-axis record) 1))
            record))

;;  ------------    method rise <location> on y-axis    ---------------

    (define (method-rise-location-y record)
        "Rise the coodinatates for a <location> on y-axis.  Returns <location>."
        (begin
            (set-y-axis! record (+ (y-axis record) 1))
            record))

;;  ------------    method reduce <location> on y-axis  ---------------

    (define (method-reduce-location-y record)
        "Fal the coodinatates for a <location> on y-axis.  Returns <location>."
        (begin
            (set-y-axis! record (- (y-axis record) 1))
            record))

;;  ------------    %circuit-location-object    -----------------------

    (define (%circuit-location-object method record)
        "Provide object with a couple of methods for dealing with
        <location> structures.  Returns dedicated values."
        (case method
            [(new) (method-generate-location)]
            [(stacked++) (method-rise-location-stacked record)]
            [(x++) (method-rise-location-x record)]
            [(y++) (method-rise-location-y record)]
            [(y--) (method-reduce-location-y record)]
            [(pretty-print) (method-pretty-print-location record)]
            [else => (location? record)]))

;   Checks:
    (check (%circuit-location-object 'new '()) => #t) ; !!
    (check (%circuit-location-object 'valid? (%circuit-location-object 'new '())) => #t) ; !!
    (check (%circuit-location-object 'valid? (location 1 1 1)) => #t) ; !!
    (check (%circuit-location-object 'valid? '(1 1 1)) => #f)
    (check (%circuit-location-object 'stacked++ (location 0 0 0)) => (location 1 0 0))
    (check (%circuit-location-object 'x++ (location 0 0 0)) => (location 0 1 0))
    (check (%circuit-location-object 'y++ (location 0 0 0)) => (location 0 0 1))
    (check (%circuit-location-object 'y-- (location 0 0 0)) => (location 0 0 -1))

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;              see (import (common cell)) library
;;  -------------------------------------------------------------------

;   handle <mosfet> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <mosfet>

;;  ------------    method-clone-mosfet-w-new-gate  -------------------

    (define (method-clone-mosfet-w-new-gate transistor new-gate)
        "Clone a given mosfet transistor and change the gate node.
        Returns a <mosfet> structure."
        (begin
            (set-gate! transistor new-gate)
            (set-place! transistor (%circuit-location-object 'x++ (place transistor))) ; ?? check me
            transistor))

;;  ------------    %mosfet-object  -----------------------------------

    (define (%mosfet-object method record)
        "Provide object with a couple of methods for dealing with
        <mosfet> structures.  Returns dedicated values."
        (case method
            [(new) (method-generate-mosfet)]
            [(pretty-print) (method-pretty-print-mosfet record)]
            [else => (mosfet? record)]))

;   Checks:
    (check (%mosfet-object 'new '()) => (mosfet "" "" "" "" "" "" (location 0 0 0))) ; !!
    (check (%mosfet-object 'valid? (method-generate-mosfet)) => #t) ; !!

;;  -------------------------------------------------------------------
;;                  NETLIST OPERATIONS
;;  -------------------------------------------------------------------

;   handle netlists as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with netlists

;;  ------------    %netlist-object     -------------------------------

    (define (%netlist-object method netlist)
        "Provide object with a couple of methods for dealing with
        list-of-mosfets, aka netlist.  Returns netlists."
        (case method
            [(empty?) (null? netlist)]
            [else => (list? netlist)]))

;   Checks:
    (check (%netlist-object 'empty? '()) => #t) ; !!
    (check (%netlist-object 'valid? '()) => #t) ; !!

;;  -------------------------------------------------------------------
;;                       FUNCTIONALITY
;;  -------------------------------------------------------------------

;;  ------------    expand-cell     -----------------------------------

    (define (expand-cell cell expansion-method stacked-limit buffer-limit cell-name cell-descr)
        "Expand cell description according parameters to new cell description.  Use named method
        and update current port character with next number.  Returns <cell> structure."
        (let* ([new-cell (method-generate-cell)]
               [current-netlist (netlist cell)])
            (begin
                ; set name + description
                (set-id! new-cell cell-name)
                (set-description! new-cell cell-descr)

                ; !! fixme: add netlist manipulation here
                (set-netlist! new-cell (sort-netlist-normalized current-netlist))

                ; !! fixme: netlist dependencies
                (set-inputs! new-cell (inputs cell))
                (set-outputs! new-cell (outputs cell))
                (set-clocks! new-cell (clocks cell))
                (set-ascii-art! new-cell (ascii-art cell))
            )
            new-cell))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)


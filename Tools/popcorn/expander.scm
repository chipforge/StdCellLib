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
        "Fall the coodinatates for a <location> on y-axis.  Returns <location>."
        (begin
            (set-y-axis! record (- (y-axis record) 1))
            record))

;;  ------------    method nmos <location> on y-axis    ---------------

    (define (method-nmos-location-y record)
        "Rebase the coodinatates for a nmos <location> on y-axis.  Returns <location>."
        (begin
            (set-y-axis! record -1)
            record))

;;  ------------    method pmos <location> on y-axis    ---------------

    (define (method-pmos-location-y record)
        "Rebase the coodinatates for a pmos <location> on y-axis.  Returns <location>."
        (begin
            (set-y-axis! record +1)
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
            [(nmos) (method-nmos-location-y record)]
            [(pmos) (method-pmos-location-y record)]
            [(pretty-print) (method-pretty-print-location record)]
            [else => (location? record)]))

;   Checks:
;   (check (%circuit-location-object 'new '()) => (location 0 0 0)) ; !!
;   (check (%circuit-location-object 'valid? (%circuit-location-object 'new '())) => #t) ; !!
;   (check (%circuit-location-object 'valid? (location 1 1 1)) => #t) ; !!
;   (check (%circuit-location-object 'valid? '(1 1 1)) => #f)
;   (check (%circuit-location-object 'stacked++ (location 0 0 0)) => (location 1 0 0))
;   (check (%circuit-location-object 'x++ (location 0 0 0)) => (location 0 1 0))
;   (check (%circuit-location-object 'y++ (location 0 0 0)) => (location 0 0 1))
;   (check (%circuit-location-object 'y-- (location 0 0 0)) => (location 0 0 -1))
;   (check (%circuit-location-object 'nmos (location 0 0 0)) => (location 0 0 -1))
;   (check (%circuit-location-object 'pmos (location 0 0 0)) => (location 0 0 +1))

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;              see (import (common cell)) library
;;  -------------------------------------------------------------------

;   handle <mosfet> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <mosfet>

;;  ------------    %mosfet-object  -----------------------------------

    (define (%mosfet-object method record)
        "Provide object with a couple of methods for dealing with
        <mosfet> structures.  Returns dedicated values."
        (case method
            [(new) (method-generate-mosfet)]
            [(nmos?) (nmos? record)]
            [(pmos?) (pmos? record)]
            [(pretty-print) (method-pretty-print-mosfet record)]
            [else => (mosfet? record)]))

;   Checks:
;   (check (%mosfet-object 'new '()) => (mosfet "" "" "" "" "" "" (location 0 0 0))) ; !!
;   (check (%mosfet-object 'nmos? (method-generate-mosfet)) => #f)
;   (check (%mosfet-object 'pmos? (method-generate-mosfet)) => #f)
;   (check (%mosfet-object 'valid? (method-generate-mosfet)) => #t) ; !!

;;  ------------    method-expand-mosfet-parallel   -------------------

    (define (method-expand-mosfet-parallel transistor nodes)
        "Clone a given mosfet transistor and change the gate node.
        Returns a <mosfet> structure."
        (let* ([new-gate (car nodes)])
            (set-gate! transistor new-gate)
            (set-place! transistor (%circuit-location-object 'x++ (place transistor)))
            transistor))

;;  ------------    method-expand-mosfet-serial     -------------------

    (define (method-expand-mosfet-serial transistor nodes)
        "Clone a given mosfet transistor and change the gate and drain nodes.
        Returns a <mosfet> structure."
        (let* ([new-gate (car nodes)]
               [new-drain (cadr nodes)]
               [direction (if (nmos? transistor) 'y-- 'y++)])
            (set-gate! transistor new-gate)
            (set-source! transistor new-drain)
            (set-place! transistor (%circuit-location-object direction (place transistor)))
            transistor))

;;  ------------    method-expand-mosfet-pullup     -------------------

    (define (method-expand-mosfet-pullup transistor nodes)
        "Given a mosfet transistor generate a entire pmos as pullup.
        Returns a <mosfet> structure."
        (let* ([new-gate (car nodes)]
               [new-drain (cadr nodes)])
            (set-type! transistor "pmos")
            (set-gate! transistor new-gate)
            (set-source! transistor "vdd")
            (set-drain! transistor new-drain)
            (set-bulk! transistor "vdd")
            (set-size! transistor "g")
            (set-place! transistor (%circuit-location-object 'pmos (%circuit-location-object 'x++ (place transistor))))
            transistor))

;;  ------------    method-expand-mosfet-pulldown   -------------------

    (define (method-expand-mosfet-pulldown transistor nodes)
        "Given a mosfet transistor generate a entire nmos as pulldown.
        Returns a <mosfet> structure."
        (let* ([new-gate (car nodes)]
               [new-drain (cadr nodes)])
            (set-type! transistor "nmos")
            (set-gate! transistor new-gate)
            (set-source! transistor "gnd")
            (set-drain! transistor new-drain)
            (set-bulk! transistor "gnd")
            (set-size! transistor "1")
            (set-place! transistor (%circuit-location-object 'nmos (%circuit-location-object 'x++ (place transistor))))
            transistor))

;;  ------------    %mosfet-expand  -----------------------------------

    (define (%mosfet-expand record nodes)
        "Provide object with a couple of <mosfet> structure expansion.
        Returns a <mosfet> structure."
        (case method
            [(parallel) (method-expand-mosfet-parallel record nodes)]
            [(serial) (method-expand-mosfet-serial record nodes)]
            [(pullup) (method-expand-mosfet-pullup record nodes)]
            [(pulldown) (method-expand-mosfet-pulldown record nodes)]
            [else => (mosfet? record)]))

;   Checks:
    ; !!

;;  -------------------------------------------------------------------
;;                  NETLIST OPERATIONS
;;  -------------------------------------------------------------------

;   handle netlists as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with netlists

;;  ------------    method-add-mosfet-to-netlist    -------------------

    (define (method-add-mosfet-to-netlist transistor netlist)
        "Just add a mosfet to the netlist.  Returns a netlist."
        (cons transistor netlist))

;;  ------------    method-delete-mosfet-from-netlist   ---------------

    (define (method-delete-mosfet-from netlist transistor netlist)
        "Go thrue netlist and remove *all* items identical to transistor.
        Returns a netlist."
        (cond
            [(null? netlist) ’()]
            [(equal? (car netlist) transistor)
                (method-delete-mosfet-from-netlist (cdr netlist) transistor)]
            [else
                (cons (car netlist)
                      (method-delete-mosfet-from-netlist (cdr netlist) transistor))]))

;;  ------------    %netlist-object     -------------------------------

    (define (%netlist-object method transistor netlist)
        "Provide object with a couple of methods for dealing with
        list-of-mosfets, aka netlist.  Returns netlists."
        (case method
            [(empty?) (null? netlist)]
            [(add) (method-add-mosfet-to-netlist transistor netlist)]
            [(delete) (method-delete-mosfet-from netlist transistor netlist)]
            [else => (list? netlist)]))

;   Checks:
;   (check (%netlist-object 'empty? '()) => #t) ; !!
;   (check (%netlist-object 'valid? '()) => #t) ; !!

;;  -------------------------------------------------------------------
;;                       FUNCTIONALITY
;;  -------------------------------------------------------------------

;;  ------------    grep highest pmos anchor    -----------------------

    (define (grep-highest-pmos-anchor netlist)
        "Just grep the pmos with the hightest gate name.  Returns a <mosfet> structure."
        (car (sort-netlist-descending)))

;;  ------------    grep highest nmos anchor    -----------------------

    (define (grep-highest-pmos-anchor netlist)
        "Just grep the nmos with the hightest gate name.  Returns a <mosfet> structure."
        (car (reverse (sort-netlist-descending))))

;;  ------------    grep highest nmos anchor    -----------------------

    (define (grep-highest-pmos-anchor netlist)
        "Just grep the nmos with the hightest gate name.  Returns a <mosfet> structure."
        (car (reverse (sort-netlist-descending))))

;;  ------------    netlist-rename-node     ---------------------------

    (define (netlist-rename-node netlist nodes)
        "Grep through netlist and rename all occurence of one node name by anothers.
        Returns a netlist."
        (if (null? netlist)
            '()
            (let* ([transistor (car netlist)]
                   [old-node (car nodes)]
                   [new-node (cadr nodes)])
                (if (equal? (gate transistor) old-node) (set-gate! transistor new-node))
                (if (equal? (source transistor) old-node) (set-source! transistor new-node))
                (if (equal? (drain transistor) old-node) (set-drain! transistor new-node))
                (if (equal? (bulk transistor) old-node) (set-bulk! transistor new-node))
                (cons transistor (netlist-rename-node (cdr netlist) nodes)))))

;;  ------------    expand-netlist-w-buffer     -----------------------

    (define (expand-netlist-w-buffer netlist buffer-limit)
        "Expand netlist with buffer, when the highest stacked transistor already
        reaches the buffer-limit.  Returns a netlist."
        (if (pair? (method-netlist-buffered? netlist))  ; already buffered
            netlist
            (if (> buffer-limit (grep-highest-stacked-transistor netlist))
                ; buffer-limit still not reached, do not touch netlist
                netlist
                ; buffer-limit already reached, has to be buffered
                (let* ([new-pmos (method-expand-mosfet-pullup (method-generate-mosfet) '("O" "Z"))]
                       [new-nmos (method-expand-mosfet-pulldown (method-generate-mosfet) '("O" "Z"))])
                    (cons new-pmos (cons new-nmos (netlist-rename-node netlist '("Y" "O"))))))))

;;  ------------    expand-netlist  -----------------------------------

    (define (expand-netlist netlist method stacked-limit buffer-limit)
        "Expand netlist description according parameters into new cell netlist.
        Use named method. Returns a netlist.."
        ;(method-netlist-pulldown? netlist)
        ;(method-netlist-pullup? netlist)
        ;(method-netlist-buffered? netlist)
;        (case method
;            [(aoi oai pu pd) (let* ([]))]
;            [(nand nor) (let* ([]))]
;        ))
        (expand-netlist-w-buffer netlist buffer-limit)
    )

;;  ------------    expand-cell     -----------------------------------

    (define (expand-cell cell method stacked-limit buffer-limit cell-name cell-descr)
        "Expand cell description according parameters to new cell description.
        Use named method and update current cell informations.  Returns <cell>
        structure."
        (let* ([new-cell (method-generate-cell)]
               [current-netlist (netlist cell)]
               [new-netlist (expand-netlist current-netlist method stacked-limit buffer-limit)])
            (begin
                ; set name + description
                (set-id! new-cell cell-name)
                (set-description! new-cell cell-descr)

                ; write back netlist into <cell> structure
                (set-netlist! new-cell (sort-netlist-normalized new-netlist))

                ; netlist dependencies
                (set-inputs! new-cell (sort-nodes-descending (remove-doubled-nodes (grep-input-nodes new-netlist))))
                (set-outputs! new-cell (sort-nodes-descending (remove-doubled-nodes (grep-output-nodes new-netlist))))
                (let ([clock-gates (sort-nodes-descending (remove-doubled-nodes (grep-clock-nodes new-netlist)))])
                    (set-clocks! new-cell (if (null? clock-gates) '() clock-gates)))
                (set-ascii-art! new-cell (ascii-art cell)) ; !! fixme
            )
            new-cell))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)


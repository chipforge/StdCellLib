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
    ;(check-set-mode! 'report)

;;  -------------------------------------------------------------------
;;                  LOCATION RECORD STRUCTURE
;;              see (import (common cell)) library
;;  -------------------------------------------------------------------

;   handle <location> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <location>

;;  ------------    method rise <location> stacked-number   -----------

    (define (method-rise-location-stacked record)
        "Rise the coodinatates for a <location> on stacked-number.
        Returns (cloned) <location>."
        (let* ([new-record (method-generate-location+)])
            (set-stacked! new-record (+ (stacked record) 1))
            (set-x-axis!  new-record (x-axis record))
            (set-y-axis!  new-record (y-axis record))
            new-record))

;;  ------------    method rise <location> on x-axis    ---------------

    (define (method-rise-location-x record)
        "Rise the coodinatates for a <location> on x-axis.
        Returns (cloned) <location>."
        (let* ([new-record (method-generate-location+)])
            (set-stacked! new-record (stacked record))
            (set-x-axis!  new-record (+ (x-axis record) 1))
            (set-y-axis!  new-record (y-axis record))
            new-record))

;;  ------------    method rise <location> on y-axis    ---------------

    (define (method-rise-location-y record)
        "Rise the coodinatates for a <location> on y-axis.
        Returns (cloned) <location>."
        (let* ([new-record (method-generate-location+)])
            (set-stacked! new-record (+ (stacked record) 1))
            (set-x-axis!  new-record 1)
            (set-y-axis!  new-record (if (< (y-axis record) 0)
                                        (- (y-axis record) 1)
                                        (+ (y-axis record) 1)))
            new-record))

;;  ------------    method nmos <location> on y-axis    ---------------

    (define (method-nmos-location-y record)
        "Rebase the coodinatates for a nmos <location> on y-axis.
        Returns (cloned) <location>."
        (let* ([new-record (method-generate-location+)])
            (set-stacked! new-record (stacked record))
            (set-x-axis!  new-record (+ (x-axis record) 1))
            (set-y-axis!  new-record -1)
            new-record))

;;  ------------    method pmos <location> on y-axis    ---------------

    (define (method-pmos-location-y record)
        "Rebase the coodinatates for a pmos <location> on y-axis.
        Returns (cloned) <location>."
        (let* ([new-record (method-generate-location+)])
            (set-stacked! new-record (stacked record))
            (set-x-axis!  new-record (+ (x-axis record) 1))
            (set-y-axis!  new-record 1)
            new-record))

;;  ------------    %circuit-location-object    -----------------------

    (define (%circuit-location-object method record)
        "Provide object with a couple of methods for dealing with
        <location> structures.  Returns dedicated values."
        (case method
            [(stacked++) (method-rise-location-stacked record)]
            [(x++)       (method-rise-location-x record)]
            [(y++)       (method-rise-location-y record)]
            [(nmos)      (method-nmos-location-y record)]
            [(pmos)      (method-pmos-location-y record)]
            [(pretty-print) (method-pretty-print-location record)]
            [else =>     (location? record)]))

;   Checks:
;   (check (%circuit-location-object 'valid? (location 1 1 1)) => #t) ; !!
;   (check (%circuit-location-object 'valid? '(1 1 1)) => #f)
    (check (%circuit-location-object 'stacked++ (location 0 0 0)) => (location 1 0 0))
    (check (%circuit-location-object 'x++ (location 0 0 0)) => (location 0 1 0))
    (check (%circuit-location-object 'y++ (location 0 0 0)) => (location 0 0 1))
    (check (%circuit-location-object 'nmos (location 0 1 0)) => (location 0 0 -1))
    (check (%circuit-location-object 'pmos (location 0 1 0)) => (location 0 0 +1))

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
            [(nmos!) (method-generate-nmos)]
            [(pmos!) (method-generate-pmos)]
            [(nmos?) (nmos? record)]
            [(pmos?) (pmos? record)]
            [(pretty-print) (method-pretty-print-mosfet record)]
            [else => (mosfet? record)]))

;   Checks:
    (check (%mosfet-object 'nmos! '()) => (method-generate-nmos)) ; !!
    (check (%mosfet-object 'pmos! '()) => (method-generate-pmos)) ; !!
    (check (%mosfet-object 'nmos? (method-generate-pmos)) => #f)
    (check (%mosfet-object 'pmos? (method-generate-nmos)) => #f)
;   (check (%mosfet-object 'valid? (method-generate-nmos)) => #t) ; !!

;;  ------------    method-expand-mosfet-parallel   -------------------

    (define (method-expand-mosfet-parallel anchor nodes)
        "Clone a given mosfet transistor and change the gate node.
        Returns a <mosfet> structure."
        (let* ([new-gate   (car nodes)]
               [transistor (method-clone-mosfet anchor)])
            (set-gate!   transistor new-gate)
            (set-place!  transistor (%circuit-location-object 'x++ (place anchor)))
            transistor))

;;  ------------    method-expand-mosfet-serial     -------------------

    (define (method-expand-mosfet-serial anchor nodes)
        "Clone a given mosfet transistor and change the gate and drain nodes.
        Returns a <mosfet> structure."
        (let* ([new-gate   (car nodes)]
               [new-node   (cadr nodes)]
               [transistor (method-clone-mosfet anchor)])
            (set-gate!   transistor new-gate)
            (set-source! anchor     new-node)
            (set-drain!  transistor new-node)
            (set-place!  transistor (%circuit-location-object 'y++ (place anchor)))
            transistor))

;;  ------------    method-expand-mosfet-1pu    -----------------------

    (define (method-expand-mosfet-1pu anchor nodes)
        "Given a mosfet transistor generate a single pmos as pullup.
        Returns a <mosfet> structure."
        (let* ([new-gate (car nodes)]
               [new-drain (cadr nodes)]
               [pmos (method-generate-pmos)])
            (set-type!   pmos "pmos")
            (set-gate!   pmos new-gate)
            (set-source! pmos "vdd")
            (set-drain!  pmos new-drain)
            (set-bulk!   pmos "vdd")
            (set-size!   pmos "g")
            (set-place!  pmos (%circuit-location-object 'pmos (place anchor)))
            pmos))

    (check (method-expand-mosfet-1pu (method-generate-pmos) '(A Y)) => (method-generate-pmos))

;;  ------------    method-expand-mosfet-1pd    -----------------------

    (define (method-expand-mosfet-1pd anchor nodes)
        "Given a mosfet transistor generate a single nmos as pulldown.
        Returns a <mosfet> structure."
        (let* ([new-gate  (car nodes)]
               [new-drain (cadr nodes)]
               [nmos      (method-generate-nmos)])
            (set-type!   nmos "nmos")
            (set-gate!   nmos new-gate)
            (set-source! nmos "gnd")
            (set-drain!  nmos new-drain)
            (set-bulk!   nmos "gnd")
            (set-size!   nmos "1")
            (set-place!  nmos (%circuit-location-object 'nmos (place anchor)))
            nmos))

    (check (method-expand-mosfet-1pd (method-generate-nmos) '(A Y)) => (method-generate-nmos))

;;  -------------------------------------------------------------------
;;                  NETLIST OPERATIONS
;;  -------------------------------------------------------------------

;   handle netlists as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with netlists

;;  ------------    method-add-mosfet-to-netlist    -------------------

    (define (method-add-mosfets-to-netlist transistors netlist)
        "Just add a mosfet to the netlist.  Returns a netlist."
        (append transistors netlist))

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

    (define (%netlist-object method transistors netlist)
        "Provide object with a couple of methods for dealing with
        list-of-mosfets, aka netlist.  Returns netlists."
        (case method
            [(empty?) (null? netlist)]
            [(add)    (method-add-mosfets-to-netlist transistors netlist)]
            [(delete) (method-delete-mosfet-from netlist transistors netlist)]
            [else =>  (list? netlist)]))

;   Checks:
;   (check (%netlist-object 'empty? '()) => #t) ; !!
;   (check (%netlist-object 'valid? '()) => #t) ; !!

;;  -------------------------------------------------------------------
;;                       FUNCTIONALITY
;;  -------------------------------------------------------------------

;;  ------------    grep highest pmos anchor    -----------------------

    (define (grep-highest-pmos-anchor netlist)
        "Just grep the pmos with the hightest gate name.  Returns a <mosfet> structure."
        (car (sort-netlist-descending netlist)))

;;  ------------    grep highest nmos anchor    -----------------------

    (define (grep-highest-nmos-anchor netlist)
        "Just grep the nmos with the hightest gate name.  Returns a <mosfet> structure."
        (car (reverse (sort-netlist-ascending netlist))))

;;  ------------    grep most right anchor  ---------------------------

    (define (grep-most-right-anchor netlist)
        "Just grep the transistor with the hightest x-position.
        Returns a <mosfet> structure."
        (if (null? netlist)
            (method-generate-nmos)
            (let* ([current (car netlist)]
                   [others (grep-most-right-anchor (cdr netlist))])
                (if (> (x-axis (place current)) (x-axis (place others)))
                    current
                    others))))

;;  ------------    mosfet-rename-drain     ---------------------------

    (define (mosfet-rename-drain netlist mosfet nodes)
        "Grep through netlist and rename just one given mosfet drain node by another.
        Return a netlist."
;        (if (null? netlist)
netlist;            '()
;            (let* ([candidate (car netlist)]
;            )       [new-node  (car nodes)])
;                (if (equal? mosfet candidate)
;                    (set-drain! candidate new-node))
;                (cons candidate (mosfet-rename-drain netlist mosfet nodes)))))
    )

;;  ------------    netlist-rename-node     ---------------------------

    (define (netlist-rename-node netlist nodes)
        "Grep through netlist and rename all occurence of one node name by anothers.
        Returns a netlist."
        (if (null? netlist)
            '()
            (let* ([transistor (car netlist)]
                   [old-node   (car nodes)]
                   [new-node   (cadr nodes)])
                (if (equal? (gate transistor)   old-node) (set-gate!   transistor new-node))
                (if (equal? (source transistor) old-node) (set-source! transistor new-node))
                (if (equal? (drain transistor)  old-node) (set-drain!  transistor new-node))
                ;(if (equal? (bulk transistor)   old-node) (set-bulk!   transistor new-node))
                (method-add-mosfets-to-netlist (list transistor) (netlist-rename-node (cdr netlist) nodes)))))

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
                (let* ([anchor   (grep-most-right-anchor netlist)]
                       [new-nmos (method-expand-mosfet-1pd anchor (list "O" "Z"))]
                       [new-pmos (method-expand-mosfet-1pu anchor (list "O" "Z"))])
                    (method-add-mosfets-to-netlist (list new-pmos new-nmos) (netlist-rename-node netlist (list "Y" "O")))))))

;;  ------------    expand-netlist-nand     ---------------------------

    (define (expand-netlist-nand netlist)
        "Expand netlist with two transistores, one pmos parallel and one nmos serial to the
        highest named transistor.  Returns a netlist"
        (let* (; check which mosfets are the highest
               [highest-pmos (grep-highest-pmos-anchor netlist)]
               [highest-nmos (grep-highest-nmos-anchor netlist)]
               ; get highest node name and calculate new one
               [highest-node (grep-highest-internal-node netlist)]
               [new-node     (%internal-node-object 'next-number highest-node)]
               ; same with gate name
               [new-gate     (%input-node-object 'next-number (gate highest-pmos))]
               ; generate new mosfet additions
               [new-pmos     (method-expand-mosfet-parallel highest-pmos (list new-gate new-node))]
               [new-nmos     (method-expand-mosfet-serial   highest-nmos (list new-gate new-node))])
            ; enlarge netlist
            (method-add-mosfets-to-netlist (list new-pmos new-nmos) netlist)))

;;  ------------    expand-netlist-nor      ---------------------------

    (define (expand-netlist-nor netlist)
        "Expand netlist with two transistores, one pmos serial and one nmos parallel to the
        highest named transistor.  Returns a netlist"
        (let* (; check which mosfets are the highest
               [highest-pmos (grep-highest-pmos-anchor netlist)]
               [highest-nmos (grep-highest-nmos-anchor netlist)]
               ; get highest node name and calculate new one
               [highest-node (grep-highest-internal-node netlist)]
               [new-node     (%internal-node-object 'next-number highest-node)]
               ; same with gate name
               [new-gate     (%input-node-object 'next-number (gate highest-pmos))]
               ; generate new mosfet additions
               [new-pmos     (method-expand-mosfet-serial   highest-pmos (list new-gate new-node))]
               [new-nmos     (method-expand-mosfet-parallel highest-nmos (list new-gate new-node))])
            ; enlarge netlist
            (method-add-mosfets-to-netlist (list new-pmos new-nmos) netlist)))

;;  ------------    expand-netlist-pu       ---------------------------

    (define (expand-netlist-pu netlist)
        "Expand netlist with two transistores, one pmos parallel and one pmos serial to all
        other transistoros.  Returns a netlist"
        (let* (; check which mosfets are the highest
               [highest-pmos (grep-highest-pmos-anchor netlist)]
               [highest-nmos (grep-highest-nmos-anchor netlist)]
               ; get highest node name and calculate new one
               [highest-node (grep-highest-internal-node netlist)]
               [new-node     (%internal-node-object 'next-number highest-node)]
               ; same with gate name
               [new-gate     (%input-node-object 'next-char (gate highest-pmos))]
               ; generate new mosfet additions
               [new-nmos     (method-expand-mosfet-serial highest-nmos (list new-gate new-node))]
               [new-pmos     (method-expand-mosfet-1pu    highest-pmos (list new-gate new-node))])
            (method-add-mosfets-to-netlist (list new-pmos new-nmos) (netlist-rename-node netlist (list "gnd" new-node)))))

;;  ------------    expand-netlist-pd       ---------------------------

    (define (expand-netlist-pd netlist)
        "Expand netlist with two transistores, one pmos serial and one pmos parallel to all
        other transistoros.  Returns a netlist"
        (let* (; check which mosfets are the highest
               [highest-pmos (grep-highest-pmos-anchor netlist)]
               [highest-nmos (grep-highest-nmos-anchor netlist)]
               ; get highest node name and calculate new one
               [highest-node (grep-highest-internal-node netlist)]
               [new-node     (%internal-node-object 'next-number highest-node)]
               ; same with gate name
               [new-gate     (%input-node-object 'next-char (gate highest-nmos))]
               ; generate new mosfet additions
               [new-nmos     (method-expand-mosfet-1pd    highest-nmos (list new-gate new-node))]
               [new-pmos     (method-expand-mosfet-serial highest-pmos (list new-gate new-node))])
            (method-add-mosfets-to-netlist (list new-pmos new-nmos) (netlist-rename-node netlist (list "vdd" new-node)))))

;;  ------------    expand-cell     -----------------------------------

    (define (expand-cell cell method buffer-limit cell-name cell-descr)
        "Expand cell description according parameters to new cell description.
        Use named method and update current cell informations.  Returns <cell>
        structure."
        (let* ([new-cell (method-generate-cell)]
               [current-netlist (netlist cell)]
               [new-netlist (case method [(nand) (expand-netlist-nand current-netlist)]
                                         [(nor)  (expand-netlist-nor  current-netlist)]
                                         [(pu)   (expand-netlist-pu   current-netlist)]
                                         [(pd)   (expand-netlist-pd   current-netlist)])])
            (begin
                ; set name + description
                (set-id! new-cell cell-name)
                (set-description! new-cell cell-descr)

                ; write back netlist into <cell> structure
                (set-netlist! new-cell (sort-netlist-descending (expand-netlist-w-buffer new-netlist buffer-limit)))

                ; netlist dependencies
                (set-inputs!  new-cell (remove-doubled-nodes (sort-nodes-descending (grep-input-nodes new-netlist))))
                (set-outputs! new-cell (remove-doubled-nodes (sort-nodes-descending (grep-output-nodes new-netlist))))
                (let ([clock-gates (remove-doubled-nodes (sort-nodes-descending (grep-clock-nodes new-netlist)))])
                    (set-clocks! new-cell (if (null? clock-gates) '() clock-gates)))
                (set-ascii-art! new-cell (ascii-art cell))) ; !! fixme
            new-cell))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)


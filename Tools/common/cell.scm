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
;;  File:           StdCellLib/Tools/common/cell.scm
;;
;;  Purpose:        Scheme Module - common cell functionality as library
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

(define-library (common cell)
  (import (scheme base)
          (scheme cxr)      ; caddr & co
          (scheme char)     ; digit-value
          (scheme file)     ; file io
          (scheme read)     ; read
          (scheme write)    ; display
          (scheme sort)     ; list-sort
          (srfi 13)         ; string-tokenize
          (srfi 78)         ; test suite
) (export ; node objects
          %input-node-object
          %clock-node-object
          %output-node-object
          %internal-node-object
          %supply-node-object
          %ground-plane-object
          sort-nodes-descending
          remove-doubled-nodes
          method-pretty-print-nodes
          ; location representations
          location location?
          stacked set-stacked!
          x-axis set-x-axis!
          y-axis set-y-axis!
          method-generate-location+
          method-generate-location-
          method-clone-location
          method-pretty-print-location
          ; mosfet representations
          mosfet mosfet?
          type set-type!
          gate set-gate!
          drain set-drain!
          source set-source!
          bulk set-bulk!
          size set-size!
          place set-place!
          nmos? pmos?
          grounded? powered?
          method-generate-nmos
          method-generate-pmos
          method-clone-mosfet
          method-pretty-print-mosfet
          ; netlist operations
          method-netlist-buffered?
          method-netlist-pullup?
          method-netlist-pulldown?
          sort-netlist-ascending
          sort-netlist-descending
          sort-netlist-normalized
          method-pretty-print-netlist
          grep-input-nodes
          grep-clock-nodes
          grep-output-nodes
          grep-internal-nodes
          grep-supply-nodes
          grep-ground-planes
          grep-highest-internal-node
          grep-highest-stacked-transistor
          ; cell representations
          cell cell?
          id set-id!
          description set-description!
          inputs set-inputs!
          outputs set-outputs!
          clocks set-clocks!
          netlist set-netlist!
          ascii-art set-ascii-art!
          method-generate-cell
          method-pretty-print-cell
          ; cell read file
          common:dataset-cell
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

;   change this switch during development only
;   mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)
    ;(check-set-mode! 'report)

;;  -------------------------------------------------------------------
;;                  NODE OBJECT SPACES
;;  -------------------------------------------------------------------

;   handle nodes as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with nodes

;;  ------------    method-next-char-node   ---------------------------

    (define (method-next-char-node node name-space)
        "Increments the next node character. Returns a string."
        (case (string-length node)
            [(0) (string (car name-space))]
            [else
                (string (cadr (memq (string-ref node 0) name-space)))]))

;;  ------------    method-next-number-node ---------------------------

    (define (method-next-number-node node name-space)
        "Increments the next node number. Returns a string."
        (case (string-length node)
            [(0) (string (car name-space))]
            [(1)
                (string (string-ref node 0) #\1)]
            [else
                (string-append
                    (string (string-ref node 0))
                    (number->string (+ 1 (string->number (string-copy node 1)))))]))

;;  ------------    method-node-valid?  -------------------------------

    (define (method-node-valid? node name-space)
        "Checks, wether node seems to be valid. Returns boolean."
        (pair? (memq (string-ref node 0) name-space)))

;;  ------------    method-node-listed? -------------------------------

;   Usually, SCHEME is case-insensitive but some implementations (and
;   R7RS) are not. Hence, the member compare has a string-ci=? option.

    (define (method-node-listed? node name-space)
        "Checks, wether node occures in name space. Returns boolean."
        (pair? (member node name-space string-ci=?)))

;;  ------------    %input-node-object  -------------------------------

    (define (%input-node-object method node)
        "Deals with input nodes. Returns next or validity"
        (let* ((name-space (list #\A #\B #\C #\D #\E #\F #\H #\I #\K
                                 #\L #\M #\P #\R #\S #\T #\U #\W)))
            (case method
                [(next-char) (method-next-char-node node name-space)]
                [(next-number) (method-next-number-node node name-space)]
                [else (method-node-valid? node name-space)])))

;   Checks:
    (check (%input-node-object 'valid? "A0") => #t) ; !!
    (check (%input-node-object 'valid? "GND") => #f)
    (check (%input-node-object 'valid? "N1") => #f)
    (check (%input-node-object 'valid? "V") => #f)
    (check (%input-node-object 'valid? "X") => #f)
    (check (%input-node-object 'valid? "Z") => #f)

    (check (%input-node-object 'next-char '()) => "A")
    (check (%input-node-object 'next-char "A0") => "B")

    (check (%input-node-object 'next-number '()) => "A")
    (check (%input-node-object 'next-number "A") => "A1")
    (check (%input-node-object 'next-number "A1") => "A2")

;;  ------------    %clock-node-object  -------------------------------

    (define (%clock-node-object method node)
        "Deals with clock nodes. Returns next node or validity"
        (let* ((name-space (list #\X)))
            (case method
                [(next-number) (method-next-number-node node name-space)]
                [else  (method-node-valid? node name-space)])))

;   Checks:
    (check (%clock-node-object 'valid? "A0") => #f)
    (check (%clock-node-object 'valid? "GND") => #f)
    (check (%clock-node-object 'valid? "N1") => #f)
    (check (%clock-node-object 'valid? "V") => #f)
    (check (%clock-node-object 'valid? "X") => #t) ; !!
    (check (%clock-node-object 'valid? "Z") => #f)

    (check (%clock-node-object 'next-number '()) => "X")
    (check (%clock-node-object 'next-number "X") => "X1")
    (check (%clock-node-object 'next-number "X1") => "X2")

;;  ------------    %output-node-object -------------------------------

    (define (%output-node-object method node)
        "Deals with output nodes. Returns next node or validity"
        (let* ((name-space (list #\Y #\Z #\Q)))
            (case method
                [(next-char) (method-next-char-node node name-space)]
                [else (method-node-valid? node name-space)])))

;   Checks:
    (check (%output-node-object 'valid? "Y") => #t) ; !!
    (check (%output-node-object 'valid? "Z") => #t) ; !!
    (check (%output-node-object 'valid? "Q") => #t) ; !!
    (check (%output-node-object 'valid? "V") => #f)
    (check (%output-node-object 'valid? "A") => #f)
    (check (%output-node-object 'valid? "N1") => #f)
    (check (%output-node-object 'valid? "X") => #f)

    (check (%output-node-object 'next-char '()) => "Y")
    (check (%output-node-object 'next-char "Y") => "Z")

;;  ------------    %internal-node-object   ----------------------------

;   provide object with a couple of methods for dealing with nodes, see functions above

    (define (%internal-node-object method node)
        "Deals with internal nodes. Returns next node or validity"
        (let* ((name-space (list #\N #\O)))
            (case method 
                [(next-char) (method-next-char-node node name-space)]
                [(next-number) (method-next-number-node node name-space)]
                [else (method-node-valid? node name-space)])))

;   Checks:
    (check (%internal-node-object 'valid? "Y") => #f)
    (check (%internal-node-object 'valid? "Z") => #f)
    (check (%internal-node-object 'valid? "Q") => #f)
    (check (%internal-node-object 'valid? "V") => #f)
    (check (%internal-node-object 'valid? "A") => #f)
    (check (%internal-node-object 'valid? "N1") => #t) ; !!
    (check (%internal-node-object 'valid? "O1") => #t) ; !!
    (check (%internal-node-object 'valid? "X") => #f)

    (check (%internal-node-object 'next-number "N") => "N1")
    (check (%internal-node-object 'next-number "N2") => "N3")
    (check (%internal-node-object 'next-char "N99") => "O")

;;  ------------    %supply-node-object -------------------------------

;   provide object with a couple of methods for dealing with nodes, see functions above

    (define (%supply-node-object method node)
        "Deals with supply nodes. Returns still validity"
        (let* ((name-space (list "VDD" "VCC")))
            (method-node-listed? node name-space)))

;   Checks:
    (check (%supply-node-object 'valid? "VDD") => #t) ; !!
    (check (%supply-node-object 'valid? "Vdd") => #t) ; !!
    (check (%supply-node-object 'valid? "VCC") => #t) ; !!
    (check (%supply-node-object 'valid? "Vcc") => #t) ; !!
    (check (%supply-node-object 'valid? "GND") => #f)
    (check (%supply-node-object 'valid? "vss") => #f)
    (check (%supply-node-object 'valid? "Q") => #f)
    (check (%supply-node-object 'valid? "A") => #f)
    (check (%supply-node-object 'valid? "N1") => #f)
    (check (%supply-node-object 'valid? "X") => #f)

;;  ------------    %ground-plane-object    ---------------------------

;   provide object with a couple of methods for dealing with nodes, see functions above

    (define (%ground-plane-object method node)
        "Deals with ground planes. Returns still validity"
        (let* ((name-space (list "GND" "VSS")))
            (method-node-listed? node name-space)))

;   Checks:
    (check (%ground-plane-object 'valid? "VDD") => #f)
    (check (%ground-plane-object 'valid? "Vdd") => #f)
    (check (%ground-plane-object 'valid? "VCC") => #f)
    (check (%ground-plane-object 'valid? "Vcc") => #f)
    (check (%ground-plane-object 'valid? "GND") => #t) ; !!
    (check (%ground-plane-object 'valid? "vss") => #t) ; !!
    (check (%ground-plane-object 'valid? "Q") => #f)
    (check (%ground-plane-object 'valid? "A") => #f)
    (check (%ground-plane-object 'valid? "N1") => #f)
    (check (%ground-plane-object 'valid? "X") => #f)

;;  ------------    sort-nodes-descending   ---------------------------

    (define (sort-nodes-descending nodes)
        "Sort list of nodes into descending order.  Returns a list."
        (list-sort string>? nodes))

;   Checks:
    (check (sort-nodes-descending (list "A" "A1" "B")) => (list "B" "A1" "A")) ; !!

;;  ------------    remove doubled nodes    ---------------------------

    (define (remove-doubled-nodes nodes)
        "Remove doublicates from list of nodes.  Returns a list."
        (if (null? nodes)
            '()
            (let* ([node (car nodes)]
                   [tail (cdr nodes)])
                (if (pair? (member node tail string-ci=?))
                    (remove-doubled-nodes tail)
                    (cons node tail)))))

;   Checks:
    (check (remove-doubled-nodes (list "A1" "A1" "B")) => (list "A1" "B")) ; !!

;;  ------------    pretty print nodes  -------------------------------

    (define (method-pretty-print-nodes nodes)
        "Pretty-Print a list of nodes.  Returns a list."
        (if (null? nodes)
            ""
            (list (car nodes) " " (method-pretty-print-nodes (cdr nodes)))))

;;  -------------------------------------------------------------------
;;                  LOCATION RECORD STRUCTURE
;;  -------------------------------------------------------------------

;   define a <location> as record

;       +---------------+       e.g.:
;       | annotation    | ->    1
;       +---------------+
;       | x-axis point  | ->    1
;       +---------------+
;       | y-axis point  | ->    +1
;       +---------------+

    (define-record-type <location>
        ; constructor
        (location stack-annotation x-location y-location)
        ; predicate
        location?
        ; getters & setters (omit the setters from immutable fields)
        (stack-annotation stacked set-stacked!)
        (x-location x-axis set-x-axis!)
        (y-location y-axis set-y-axis!))

;   handle <location> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <location>

;;  ------------    method generate positive <location>     -----------

    (define (method-generate-location+)
        "Generate empty positive <location> structure.  Returns <location>."
        (location 1 1 1))

;;  ------------    method generate negative <location>     -----------

    (define (method-generate-location-)
        "Generate empty negative <location> structure.  Returns <location>."
        (location 1 1 1))

;;  ------------    clone an <location> complete    -------------------

    (define (method-clone-location original)
        "Clone a <location> record structure.  Returns <location>."
        (let* ([clone (method-generate-location-)])
            (set-stacked! clone (stacked original))
            (set-x-axis!  clone (x-axis  original))
            (set-y-axis!  clone (y-axis  original))
            clone))

;;  ------------    pretty print <location>     -----------------------

    (define (method-pretty-print-location record)
        "Pretty-Print a <location> structure.  Returns a list."
        (list
            (stacked record) " "
            (x-axis record) " "
            (y-axis record)))

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define a transistor as record

;       +---------------+       e.g.:
;       | circuit type  | ->    "pmos"
;       +---------------+
;       | gate node     | ->    "A"
;       +---------------+
;       | drain node    | ->    "X"
;       +---------------+
;       | source node   | ->    "VDD"
;       +---------------+
;       | bulk node     | ->    "VDD"
;       +---------------+
;       | size          | ->    "g"
;       +---------------+       +---------------+---------------+---------------+
;       | place         | ->    |  annotation   |  x-location   |  y-location   |
;       +---------------+       +---------------+---------------+---------------+

    (define-record-type <mosfet>
        ; constructor
        (mosfet circuit-type gate-node drain-node source-node bulk-node circuit-size circuit-place)
        ; predicate
        mosfet?
        ; getters & setters (omit the setters from immutable fields)
        (circuit-type type set-type!)
        (gate-node gate set-gate!)
        (drain-node drain set-drain!)
        (source-node source set-source!)
        (bulk-node bulk set-bulk!)
        (circuit-size size set-size!)
        (circuit-place place set-place!))


;   handle <mosfet> as 'object' and encapsulate their functionality, so
;   provide a couple of methods for dealing with <mosfet>

;;  ------------    generate empty nmos <mosfet>    -------------------

    (define (method-generate-nmos)
        "Generate empty nmos <mosfet> record structure.  Returns <mosfet>."
        (mosfet "nmos" "" "" "" "" "" (method-generate-location-)))

;;  ------------    generate empty pmos <mosfet>    -------------------

    (define (method-generate-pmos)
        "Generate empty pmos <mosfet> record structure.  Returns <mosfet>."
        (mosfet "pmos" "" "" "" "" "" (method-generate-location+)))

;;  ------------    clone <mosfet> complete     -----------------------

    (define (method-clone-mosfet original)
        "Clone a <mosfet> record structure.  Returns <mosfet>."
        (let* ([clone (method-generate-pmos)])
            (set-type!   clone (type original))
            (set-gate!   clone (gate original))
            (set-drain!  clone (drain original))
            (set-source! clone (source original))
            (set-bulk!   clone (bulk original))
            (set-size!   clone (size original))
            (set-place!  clone (method-clone-location (place original)))
            clone))

;;  ------------    pmos? predicate     -------------------------------

    (define (pmos? record)
        "Check record for pmos transistor.  As every predicate returns boolean."
        (and (mosfet? record)
             (equal? (type record) "pmos")))

;   Checks:
    (check (pmos? (method-generate-pmos)) => #t) ; !!
    (check (pmos? (method-generate-nmos)) => #f)

;;  ------------    nmos? predicate     -------------------------------

    (define (nmos? record)
        "Check record for nmos transistor.  As every predicate returns boolean."
        (and (mosfet? record)
             (equal? (type record) "nmos")))

;   Checks:
    (check (nmos? (method-generate-pmos)) => #f)
    (check (nmos? (method-generate-nmos)) => #t) ; !!

;;  ------------    grounded? predicate     ---------------------------

    (define (grounded? record)
        "Check record for grounded transistor.  As every predicate returns boolean."
        (and (mosfet? record)
             (%ground-plane-object 'valid? (source record))))

;   Checks:
    (check (grounded? (method-generate-pmos)) => #f)
    (check (grounded? (method-generate-nmos)) => #f)

;;  ------------    powered? predicate  -------------------------------

    (define (powered? record)
        "Check record for powered transistor.  As every predicate returns boolean."
        (and (mosfet? record)
             (%supply-node-object 'valid? (source record))))

;   Checks:
    (check (powered? (method-generate-pmos)) => #f)
    (check (powered? (method-generate-nmos)) => #f)

;;  ------------    pretty print <mosfet>   ---------------------------

    (define (method-pretty-print-mosfet record)
        "Pretty-Print a <mosfet> record structure.  Returns a list."
        (list
            "\n"
            (type record) " "
            (gate record) " "
            (drain record) " "
            (source record) " "
            (bulk record) " "
            (size record) " "
            (method-pretty-print-location (place record))))

;;  -------------------------------------------------------------------
;;                  NETLIST OPERATIONS
;;  -------------------------------------------------------------------

;;  ------------    netlist already buffered?   -----------------------

    (define (method-netlist-buffered? netlist)
        "Guess which transistores form a output buffer and collect them.
        Returns a short netlist."
        (if (null? netlist)
            '()
            (if (and ; 1st indicator: transistor drain is an output node
                    (%output-node-object 'valid? (drain (car netlist)))
                    ; 2nd indicator: transistor gate is an internal node
                    (%internal-node-object 'valid? (gate (car netlist))))
                (cons (car netlist) (method-netlist-buffered? (cdr netlist)))
                (method-netlist-buffered? (cdr netlist)))))

;;  ------------    netlist pull-up network?    -----------------------

    (define (method-netlist-pullup? netlist)
        "Guess which transistores form a pull-up network and collect them.
        Returns a short netlist."
        (if (null? netlist)
            '()
            (if (and ; 1st indicator: transistors are pmos
                    (pmos? (car netlist))
                    ; 2nd indicator: transistor gate is an input node
                    (%input-node-object 'valid? (gate (car netlist))))
                (cons (car netlist) (method-netlist-pullup? (cdr netlist)))
                (method-netlist-pullup? (cdr netlist)))))

;;  ------------    netlist pull-down network?  -----------------------

    (define (method-netlist-pulldown? netlist)
        "Guess which transistores form a pull-down network and collect them.
        Returns a short netlist."
        (if (null? netlist)
            '()
            (if (and ; 1st indicator: transistors are nmos
                    (nmos? (car netlist))
                    ; 2nd indicator: transistor gate is an input node
                    (%input-node-object 'valid? (gate (car netlist))))
                (cons (car netlist) (method-netlist-pulldown? (cdr netlist)))
                (method-netlist-pulldown? (cdr netlist)))))

;;  ------------    sort netlist ascending  ---------------------------

    (define (mosfet<? first second)
        "sort < operatator for sorting mosfets by gate names and types.
        nmos A, B, C; pmos A, B, C.  Returns boolean."
        (if (string-ci=? (type first) (type second))
            ; both mosfet type are equal
            (string-ci<? (gate first) (gate second))
            ; both mosfet types differs, nmos first, pmos second
            (string-ci<? (type first) (type second))))

    (define (sort-netlist-ascending netlist)
        "Sort netlist transistors ascending.
        nmos A, B, C; pmos A, B, C.  Returns boolean."
        (list-sort mosfet<? netlist))

;;  ------------    sort netlist descending     -----------------------

    (define (mosfet>? first second)
        "sort > operatator for sorting mosfets by gate names and types.
        pmos C, B, A; nmos C, B, A.  Returns boolean."
        (if (string-ci=? (type first) (type second))
            ; both mosfet type are equal
            (string-ci>? (gate first) (gate second))
            ; both mosfet types differs, nmos first, pmos second
            (string-ci>? (type first) (type second))))

    (define (sort-netlist-descending netlist)
        "Sort netlist transistors descending.  Returns netlist."
        (list-sort mosfet>? netlist))

;;  ------------    sort netlist normalized     -----------------------

    (define (mosfet><? first second)
        "sort >< operatator for sorting mosfets by position.
        From left -> right, from top -> buttom.  Returns boolean."
        (if (= (x-axis (place first)) (x-axis (place second)))
            ; same position on x
            (> (y-axis (place first)) (y-axis (place second)))
            ; different positions on x
            (> (x-axis (place first)) (x-axis (place second)))))

    (define (sort-netlist-normalized netlist)
        "Sort netlist transistors normalized (by position).
        From left -> right, from top -> buttom.  Returns netlist."
        (list-sort mosfet><? netlist))

;;  ------------    pretty print netlist    ---------------------------

    (define (method-pretty-print-netlist netlist)
        "Pretty-Print a netlist of <mosfet> record structures.  Returns a list."
        (if (null? netlist)
            ""
            (list
                (method-pretty-print-mosfet (car netlist))
                (method-pretty-print-netlist (cdr netlist)))))

;;  ------------    grep input nodes    -------------------------------

    (define (grep-input-nodes netlist)
        "Just grep the netlist for input nodes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([gate-node (gate (car netlist))])
                (if (%input-node-object 'valid? gate-node)
                    (cons gate-node (grep-input-nodes (cdr netlist)))
                    (grep-input-nodes (cdr netlist))))))

;;  ------------    grep clock nodes    -------------------------------

    (define (grep-clock-nodes netlist)
        "Just grep the netlist for clock nodes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([gate-node (gate (car netlist))])
                (if (%clock-node-object 'valid? gate-node)
                    (cons gate-node (grep-clock-nodes (cdr netlist)))
                    (grep-clock-nodes (cdr netlist))))))

;;  ------------    grep output nodes   -------------------------------

    (define (grep-output-nodes netlist)
        "Just grep the netlist for output nodes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([drain-node (drain (car netlist))])
                (if (%output-node-object 'valid? drain-node)
                    (cons drain-node (grep-output-nodes (cdr netlist)))
                    (grep-output-nodes (cdr netlist))))))

;;  ------------    grep internal nodes     ---------------------------

    (define (grep-internal-nodes netlist)
        "Just grep the netlist for internal nodes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([drain-node (drain (car netlist))])
                (if (%internal-node-object 'valid? drain-node)
                    (cons drain-node (grep-internal-nodes (cdr netlist)))
                    (grep-internal-nodes (cdr netlist))))))

;;  ------------    grep supply nodes   -------------------------------

    (define (grep-supply-nodes netlist)
        "Just grep the netlist for supply nodes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([source-node (source (car netlist))])
                (if (%supply-node-object 'valid? source-node)
                    (cons source-node (grep-supply-nodes (cdr netlist)))
                    (grep-supply-nodes (cdr netlist))))))

;;  ------------    grep ground planes  -------------------------------

    (define (grep-ground-planes netlist)
        "Just grep the netlist for ground planes.  Returns a list."
        (if (null? netlist)
            '()
            (let* ([source-node (source (car netlist))])
                (if (%ground-plane-object 'valid? source-node)
                    (cons source-node (grep-ground-planes (cdr netlist)))
                    (grep-ground-planes (cdr netlist))))))

;;  ------------    grep highest internal node  -----------------------

    (define (grep-highest-internal-node netlist)
        "Just grep the netlist for the hightest internal node.  Returns a string."
        (if (null? netlist)
            0
            (let* ([candidates (sort-nodes-descending (grep-internal-nodes netlist))])
                (if (null? candidates)
                    ""
                    (car candidates)))))

;;  ------------    grep highest stacked transistor -------------------

    (define (grep-highest-stacked-transistor netlist)
        "Just grep the netlist for the hightest stacked transistor.  Returns a integer."
        (if (null? netlist)
            0
            (max (stacked (place (car netlist))) (grep-highest-stacked-transistor (cdr netlist)))))

;;  -------------------------------------------------------------------
;;                  CELL DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define a cell as record

;       +---------------+       e.g.:
;       | cell id       | ->    "INV"
;       +---------------+
;       | cell text     | ->    "a Not (or Inverter) gate"
;       +---------------+
;       | cell inputs   | ->    '("A")
;       +---------------+
;       | cell outputs  | ->    '("Y")
;       +---------------+
;       | cell clocks   | ->    '() ; usually for latches
;       +---------------+
;       | cell netlist  | ->    '(<list of mosfets>)
;       +---------------+
;       | cell ascii-art| ->    '(<list of output lines>) :-)
;       +---------------+

    (define-record-type <cell>
        ; constructor
        (cell cell-id cell-text cell-inputs cell-outputs cell-clocks cell-netlist cell-ascii-art)
        ; predicate
        cell?
        ; getters & setters (omit the setters from immutable fields)
        (cell-id id set-id!)
        (cell-text description set-description!)
        (cell-inputs inputs set-inputs!)
        (cell-outputs outputs set-outputs!)
        (cell-clocks clocks set-clocks!)
        (cell-netlist netlist set-netlist!)
        (cell-ascii-art ascii-art set-ascii-art!))

;;  ------------    generate empty <mosfet>     -----------------------

    (define (method-generate-cell)
        "Generate empty <cell> record structure.  Returns <cell>."
        (cell "" "" '() '() '() '() '()))

;;  ------------    pretty print <cell>     ---------------------------

    (define (method-pretty-print-cell record)
        "Pretty-Print a <cell> record structure.  Returns a list."
        (list
            (id record)
            (description record)
            (method-pretty-print-nodes (inputs record))
            (method-pretty-print-nodes (outputs record))
            (method-pretty-print-nodes (clocks record))
            (method-pretty-print-netlist (netlist record))
;           (ascii-art record)
            ))

;;  -------------------------------------------------------------------
;;                  READ CELL STRUCTURE
;;  -------------------------------------------------------------------

;;  ------------    read location arguments ---------------------------

    (define (read-location arguments)
        "Read arguments for circuits and feed the corresponding fields
        inside <location> structures.  Returns <location> structure."
        (let* ([place  (method-generate-location+)])
            (set-stacked! place (string->number (list-ref arguments 5)))
            (set-x-axis! place (string->number (list-ref arguments 6)))
            (set-y-axis! place (string->number (list-ref arguments 7)))
            place))

;;  ------------    read one pmos line  -------------------------------

    (define (read-pmos-line! arguments)
        "Read arguments for pmos circuits and feed the corresponding
        field inside the <mosfet> structure.  Returns <mosfet> structure."
        (let* ([pmos (method-generate-pmos)])
            (set-gate! pmos (list-ref arguments 0))
            (set-drain! pmos (list-ref arguments 1))
            (set-source! pmos (list-ref arguments 2))
            (set-bulk! pmos (list-ref arguments 3))
            (set-size! pmos (list-ref arguments 4))
            (set-place! pmos (read-location arguments))
            pmos))

;;  ------------    read one nmos line  -------------------------------

    (define (read-nmos-line! arguments)
        "Read arguments for nmos circuits and feed the corresponding
        field inside the <mosfet> structure.  Returns <mosfet> structure."
        (let* ([nmos (method-generate-nmos)])
            (set-gate! nmos (list-ref arguments 0))
            (set-drain! nmos (list-ref arguments 1))
            (set-source! nmos (list-ref arguments 2))
            (set-bulk! nmos (list-ref arguments 3))
            (set-size! nmos (list-ref arguments 4))
            (set-place! nmos (read-location arguments))
            nmos))

;;  ------------    read one tagged line    ---------------------------

    (define (read-tagged-line! current-cell textline)
        "Check the textline for known tags and feed the corresponding
        field inside the <cell> record.  Returns <cell> structure."
        (cond
            ; emtpy list?
            [(null? textline) current-cell]

            [(equal? (string->symbol (car textline)) '|.cell|)
                (set-id! current-cell (cadr textline))]
            [(equal? (string->symbol (car textline)) '|.inputs|)
                (set-inputs! current-cell (cdr textline))]
            [(equal? (string->symbol (car textline)) '|.outputs|)
                (set-outputs! current-cell (cdr textline))]
            [(equal? (string->symbol (car textline)) '|.clocks|)
                (set-clocks! current-cell (cdr textline))]
            [(equal? (string->symbol (car textline)) 'pmos)
                (set-netlist! current-cell (cons (read-pmos-line! (cdr textline)) (netlist current-cell)))]
            [(equal? (string->symbol (car textline)) 'nmos)
                (set-netlist! current-cell (cons (read-nmos-line! (cdr textline)) (netlist current-cell)))]
            [else ;(equal? (car textline) '|.end|)
                current-cell]))

;;  ------------    read in cell file   -------------------------------

    (define (common:dataset-cell file-name)
        "Read in cell-file.  Returns a <cell> structure."
        (let* ([file (open-input-file file-name)]
               [current-cell (method-generate-cell)])
            (let x ((1stline (read-line file)))
                (if (eof-object? 1stline)
                    '()
                    (begin
                        (set-description! current-cell 1stline)
                        (let function ((nextline (read-line file)))
                            (unless (eof-object? nextline)
                                (let ([parsed-line (string-tokenize nextline)])
                                    current-cell (read-tagged-line! current-cell parsed-line)
                                    (function (read-line file))))))))
        current-cell))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

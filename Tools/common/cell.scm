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
;;  Copyright (c)   2019 - 2021 by
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
          (srfi 13)         ; string-tokenize
          (srfi 78)         ; test suite
) (export ; node objects
          %input-node-object
          %clock-node-object
          %output-node-object
          %internal-node-object
          %supply-node-object
          %ground-plane-object
          ; location representations
          location location?
          stacked set-stacked!
          x-axis set-x-axis!
          y-axis set-y-axis!
          generate-location
          pretty-print-location
          ; mosfet representations
          mosfet mosfet?
          type set-type!
          gate set-gate!
          drain set-drain!
          source set-source!
          bulk set-bulk!
          size set-size!
          place set-place!
          generate-mosfet
          pretty-print-mosfet
          pretty-print-netlist
          ; cell representations
          cell cell?
          id set-id!
          description set-description!
          inputs set-inputs!
          outputs set-outputs!
          clocks set-clocks!
          netlist set-netlist!
          ascii-art set-ascii-art!
          generate-cell
          pretty-print-cell
          ; cell read file
          common:dataset-cell
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

;   change this switch during development only
;   mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  -------------------------------------------------------------------
;;                  NODE OBJECT SPACES
;;  -------------------------------------------------------------------

;   handle nodes as 'objects' and encapsulate their functionality, so
;   provide a couple of methods for dealing with nodes

;;  ------------    method-next-char-node   ---------------------------

    (define (method-next-char-node node name-space)
        "Increments the next node character. Returns a string."
        (cond
            [(null? node) (string (car name-space))]
            [else
                (string (car (cdr (memq (string-ref node 0) name-space))))]))

;;  ------------    method-next-number-node ---------------------------

    (define (method-next-number-node node name-space)
        "Increments the next node number. Returns a string."
        (cond
            [(null? node) (string (car name-space))]
            [(= (string-length node) 1)
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
        (let* ((name-space '(#\A #\B #\C #\D #\E #\F #\H #\I #\K
                             #\L #\M #\P #\R #\S #\T #\U #\W)))
            (cond
                [(equal? method 'next-char) ; => "node"
                    (method-next-char-node node name-space)]
                [(equal? method 'next-number) ; => "node
                    (method-next-number-node node name-space)]
                [else ; => boolean
                    (method-node-valid? node name-space)])))

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
        (let* ((name-space '(#\X)))
            (cond
                [(equal? method 'next-number) ; => "node
                    (method-next-number-node node name-space)]
                [else ; => boolean
                    (method-node-valid? node name-space)])))

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
        (let* ((name-space '(#\Y #\Z #\Q)))
            (cond
                [(equal? method 'next-char) ; => "node"
                    (method-next-char-node node name-space)]
                [else ; => boolean
                    (method-node-valid? node name-space)])))

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
        (let* ((name-space '(#\N)))
            (cond
                [(equal? method 'next-number) ; => "node"
                    (method-next-number-node node name-space)]
                [else ; => boolean
                    (method-node-valid? node name-space)])))

;   Checks:
    (check (%internal-node-object 'valid? "Y") => #f)
    (check (%internal-node-object 'valid? "Z") => #f)
    (check (%internal-node-object 'valid? "Q") => #f)
    (check (%internal-node-object 'valid? "V") => #f)
    (check (%internal-node-object 'valid? "A") => #f)
    (check (%internal-node-object 'valid? "N1") => #t) ; !!
    (check (%internal-node-object 'valid? "X") => #f)

    (check (%internal-node-object 'next-number "N") => "N1")
    (check (%internal-node-object 'next-number "N2") => "N3")

;;  ------------    %supply-node-object -------------------------------

;   provide object with a couple of methods for dealing with nodes, see functions above

    (define (%supply-node-object method node)
        "Deals with supply nodes. Returns still validity"
        (let* ((name-space '("VDD" "VCC")))
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
        (let* ((name-space '("GND" "VSS")))
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

;;  -------------------------------------------------------------------
;;                  LOCATION RECORD STRUCTURE
;;  -------------------------------------------------------------------

;   define a 'location' as record

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

;;  ------------    generate empty <location>   -----------------------

    (define (generate-location)
        "Generate empty <location> record structure.  Returns <location>."
        (location 0 0 0))

;;  ------------    pretty print <location>     -----------------------

    (define (pretty-print-location record)
        "Pretty-Print a <location> record structure.  Returns a list."
        (list
            (stacked record) " "
            (x-axis record) " "
            (y-axis record)))
            ;0 0 0))

    (check (pretty-print-location (generate-location)) => '(0 0 0))

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

;;  ------------    generate empty <mosfet>     -----------------------

    (define (generate-mosfet)
        "Generate empty <mosfet> record structure.  Returns <mosfet>."
        (mosfet "" "" "" "" "" "" (generate-location)))

;;  ------------    pretty print <mosfet>   ---------------------------

    (define (pretty-print-mosfet record)
        "Pretty-Print a <mosfet> record structure.  Returns a list."
        (list
            "\n"
            (type record) " "
            (gate record) " "
            (drain record) " "
            (source record) " "
            (bulk record) " "
            (size record) " "
            (pretty-print-location (place record))))

    (check (pretty-print-mosfet (generate-location)) => '("" "" "" "" "" "" (0 0 0)))

;;  ------------    pretty print netlist    ---------------------------

    (define (pretty-print-netlist netlist)
        "Pretty-Print a netlist of <mosfet> record structures.  Returns a list."
        (list
            (pretty-print-mosfet (car netlist))
            (if (null? (cdr netlist))
                '()
                (pretty-print-netlist (cdr netlist)))))

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

    (define (generate-cell)
        "Generate empty <cell> record structure.  Returns <cell>."
        (cell "" "" '() '() '() '() '()))

;;  ------------    pretty print <cell>     ---------------------------

    (define (pretty-print-cell record)
        "Pretty-Print a <cell> record structure.  Returns a list."
        (list
            (id record)
            (description record)
            (inputs record)
            (outputs record)
            (clocks record)
            (pretty-print-netlist (netlist record))
;           (ascii-art record)
            ))

;;  -------------------------------------------------------------------
;;                  READ CELL STRUCTURE
;;  -------------------------------------------------------------------

;;  ------------    read one pmos line  -------------------------------

    (define (read-pmos-line! arguments)
        "Read arguments for pmos circuits and feed the corresponding
        field inside the <mosfet> structure.  Returns <mosfet> structure."
        (let* ([pmos (generate-mosfet)])
            (set-type! pmos "pmos")
            (set-gate! pmos (car arguments))
            (set-drain! pmos (cadr arguments))
            (set-source! pmos (caddr arguments))
            (set-bulk! pmos (cadddr arguments))
            (set-size! pmos (car (cddddr arguments)))
;            (set-place! pmos (car (cdr (cddddr arguments))))
            pmos
;            (display (pretty-print-mosfet pmos)) (newline)
            ))

;;  ------------    read one nmos line  -------------------------------

    (define (read-nmos-line! arguments)
        "Read arguments for nmos circuits and feed the corresponding
        field inside the <mosfet> structure.  Returns <mosfet> structure."
        (let* ([nmos (generate-mosfet)])
            (set-type! nmos "nmos")
            (set-gate! nmos (car arguments))
            (set-drain! nmos (cadr arguments))
            (set-source! nmos (caddr arguments))
            (set-bulk! nmos (cadddr arguments))
            (set-size! nmos (car (cddddr arguments)))
;            (set-place! nmos (car (cdr (cddddr arguments))))
            nmos
;            (display (pretty-print-mosfet nmos)) (newline)
            ))

;;  ------------    read one tagged line    ---------------------------

    (define (read-tagged-line! current-cell textline)
        "Check the textline for known tags and feed the corresponding
        field inside the <cell> record.  Returns <cell> structure."
        (cond
            ; emtpy list?
            [(null? textline) current-cell]

            [(equal? (car textline) '|.cell|)
                (set-id! current-cell (cadr textline))]
            [(equal? (car textline) '|.inputs|)
                (set-inputs! current-cell (cdr textline))]
            [(equal? (car textline) '|.outputs|)
                (set-outputs! current-cell (cdr textline))]
            [(equal? (car textline) '|.clocks|)
                (set-clocks! current-cell (cdr textline))]
            [(equal? (car textline) 'pmos)
                (set-netlist! current-cell (cons (read-pmos-line! (cdr textline)) (netlist current-cell)))]
            [(equal? (car textline) 'nmos)
                (set-netlist! current-cell (cons (read-nmos-line! (cdr textline)) (netlist current-cell)))]
            [else ;(equal? (car textline) '|.end|)
                current-cell]))

;;  ------------    read in cell file   -------------------------------

    (define (common:dataset-cell file-name)
        "Read in cell-file.  Returns a <cell> structure."
        (let* ([file (open-input-file file-name)]
               [current-cell (generate-cell)])
            (let x ((1stline (read-line file)))
                (if (eof-object? 1stline)
                    '()
                    (begin
                        (set-description! current-cell 1stline)
                        (let function ((nextline (read-line file)))
                            (unless (eof-object? nextline)
                                (let ([parsed-line (map string->symbol (string-tokenize nextline))])
                                    current-cell (read-tagged-line! current-cell parsed-line)
                                    (function (read-line file))))))))
        current-cell))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

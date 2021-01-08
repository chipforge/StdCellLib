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
          x-axis set-x-axis!
          y-axis set-y-axis!
          stacked set-stacked!
          ; mosfet representations
          mosfet mosfet?
          type set-type!
          gate set-gate!
          drain set-drain!
          source set-source!
          buld set-bulk!
          place set-place!
          size set-size!
          ; cell representations
          cell cell?
          id set-id!
          description set-description!
          inputs set-inputs!
          outputs set-outputs!
          clocks set-clocks!
          netlist set-netlist!
          ascii-art set-ascii-art!
          ; cell read file
          current-cell common:dataset-cell
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
;       | x-axis point  | ->    1
;       +---------------+
;       | y-axis point  | ->    1
;       +---------------+
;       | annotation    | ->    1
;       +---------------+

    (define-record-type <location>
        ; constructor
        (location x-location y-location stack-annotation)
        ; predicate
        location?
        ; getters & setters (omit the setters from immutable fields)
        (x-location x-axis set-x-axis!)
        (y-location y-axis set-y-axis!)
        (stack-annotation stacked set-stacked!))

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
;       +---------------+       +---------------+---------------+---------------+
;       | place         | ->    |  x-location   |  y-location   |  annotation   |
;       +---------------+       +---------------+---------------+---------------+
;       | size          | ->    "gamma"
;       +---------------+

    (define-record-type <mosfet>
        ; constructor
        (mosfet circuit-type gate-node drain-node source-node bulk-node circuit-place circuit-size)
        ; predicate
        mosfet?
        ; getters & setters (omit the setters from immutable fields)
        (circuit-type type set-type!)
        (gate-node gate set-gate!)
        (drain-node drain set-drain!)
        (source-node source set-source!)
        (bulk-node bulk set-bulk!)
        (circuit-place place set-place!)
        (circuit-size size set-size!))

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

;;  -------------------------------------------------------------------
;;                  READ CELL STRUCTURE
;;  -------------------------------------------------------------------

;   current cell

    (define current-cell (cell "" "" "" "" "" "" ""))

;;  ------------    comment syntax rule -------------------------------

    (define-syntax //
        (syntax-rules ()
            ((_ ) ())
            ((_ a) ())
            ((_ a ... ) ())
            ))

;;  ------------    .cell syntax rule   -------------------------------

    (define-syntax |.cell|
        (syntax-rules ()
            ((_ id) (set-id! current-cell id))
            ))

;;  ------------    .inputs syntax rule -------------------------------

    (define-syntax |.inputs|
        (syntax-rules ()
            ((_ a) (set-inputs! current-cell (list a)))
            ((_ a b) (set-inputs! current-cell (list a b)))
            ((_ a b ...) (set-inputs! current-cell (list a b ...)))
            ))

;;  ------------    .outputs syntax rule    ---------------------------

    (define-syntax |.outputs|
        (syntax-rules ()
            ((_ y) (set-outputs! current-cell (list y)))
            ((_ y z) (set-outputs! current-cell (list y z)))
            ((_ y z ...) (set-outputs! current-cell (list y z ...)))
            ))

;;  ------------    pmos transistor rule    ---------------------------

    (define-syntax pmos
        (syntax-rules ()
            ((_ ) ())
            ((_ a) ())
            ((_ a ... ) ())
            ))

;;  ------------    .end syntax rule    -------------------------------

    (define-syntax |.end|
        (syntax-rules ()
            ((_ ) ())
            ((_ a) ())
            ((_ a ... ) ())
            ))

;;  ------------    read in cell file   -------------------------------

    (define (common:dataset-cell file-name)
        "Read in cell-file. Returns a <cell> structure."
        (let ((file (open-input-file file-name))
              (current-netlist '()))
            (let x ((1stline (read-line file)))
                (if (eof-object? 1stline)
                    '()
                    (begin
                        (set-description! current-cell 1stline)
                        (let function ((nextline (read-line file)))
                            (unless (eof-object? nextline)
(begin
                                (map string->symbol (string-tokenize nextline))
                                (function (read-line file))
    )
                            )
                        )
                    )
                )
            )
        )
        current-cell
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

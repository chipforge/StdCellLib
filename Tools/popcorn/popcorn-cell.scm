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
;;  File:           StdCellLib/Tools/popcorn/popcorn-cell.scm
;;
;;  Purpose:        Scheme Module - cell description read-in / write-out
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c)   2019 by
;;                  chipforge - <popcorn@nospam.chipforge.org>
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

(define-library (popcorn-cell)
  (import (scheme base)
          (scheme write)            ; display
          (scheme process-context)  ; exit
          (scheme char)             ; string-upcase, string-downcase
          (scheme file)             ; file io
          (srfi 28)                 ; format
          (srfi 152)                ; string-split, string-join
          ; popcorn lib also
          (popcorn-lib))
  (export  read-cell-file
           write-cell-file
           expand-cell-nand
           expand-cell-nor
           expand-cell-aoi
           expand-cell-oai
           expand-cell-buffer)
  (begin

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development only
    (define build-in-self-test? #t)

;;  ------------    build-in sanity checks  ---------------------------

    ; use this switch during development only
    (define build-in-sanity-checks? #t)

;;  -------------------------------------------------------------------
;;                  DESCRIPTION
;;  -------------------------------------------------------------------

;   In principle every combinatorial cell (in CMOS technology) contains
;   two functional complementary networks. The pull-up network - build
;   with pmos transistors - as well as the pull-down network - build
;   with nmos transistors.

;   so every netlist becomes, well, a list of transistors

;;  -------------------------------------------------------------------
;;                  READ CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    read in cell file   -------------------------------

;   Contract:
;   read-cell-file : filehandler -> cell

;   Purpose:
;   read in cell file as vector for further usage

;   Example:
;   (read-cell-file file) => INV-cell

;   Definition:
    (define (read-cell-file file-name)
        (let ((file (open-input-file file-name))
              (return (generate-cell))
              (netlist '()))
            (let x ((line (read-line file)))
                (if (eof-object? line)
                    '()
                    (begin
                        (cell-text! return line)
                        (let function ((line (read-line file)))
                            (unless (eof-object? line)
                                (cond
                                    ; ignore comment lines, read further
                                    [(equal? (string-ref line 0) #\#)
                                        (function (read-line file))
                                    ]

                                    ; .cell annotated line, get name
                                    [(equal? (substring line 0 4) ".cel")
                                        (begin
                                            (cell-id! return (string-upcase (string-copy line 6)))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .clocks annotated line, get list
                                    [(equal? (substring line 0 4) ".clo")
                                        (begin
                                            (cell-clocks! return (string-split (string-upcase (string-copy line 7)) #[ ]))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .inputs annotated line, get list
                                    [(equal? (substring line 0 4) ".inp")
                                        (begin
                                            (cell-inputs! return (string-split (string-upcase (string-copy line 8)) #[ ]))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .outputs annotated line, get list
                                    [(equal? (substring line 0 4) ".out")
                                        (begin
                                            (cell-outputs! return (string-split (string-upcase (string-copy line 9)) #[ ]))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .end annotated line, clean up
                                    [(equal? (substring line 0 4) ".end")
                                        (begin
                                            (cell-netlist! return netlist)
                                            (eof-object)
                                        )
                                    ]

                                    ; collect netlist lines
                                    [else
                                        (begin
                                            (set! netlist (append netlist (list (stringlist->mosfet (string-split line #[ ])))))
;                                            (set! netlist (cons (stringlist->mosfet (string-split line #[ ])) netlist))
                                            (function (read-line file))
                                        )
                                    ]
                                )
                            )
                        )
                    )
                )
            ; done, close file
            (close-input-port file)
            (sanity-cell? return)
            return
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  WRITE CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    convert mosfet into string  -----------------------

;   Contract:
;   mosfet->string : mosfet -> string

;   Purpose:
;   convert mosfet vector into one long string

;   Example:
;   (mosfet->string '#("nmos" "A" "Y" "GND" "GND" 1 1 -1)) => "nmos A Y GND GND 1 1 -1"

;   Definition:
    (define mosfet->string
        (lambda (mosfet)
            (string-join
                (list
                    (mosfet-type mosfet)
                    (mosfet-gate mosfet)
                    (mosfet-drain mosfet)
                    (mosfet-source mosfet)
                    (mosfet-bulk mosfet)
                    (number->string (mosfet-stacked mosfet))
                    (number->string (mosfet-xaxis mosfet))
                    (number->string (mosfet-yaxis mosfet))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet->string '#("nmos" "A" "Y" "GND" "GND" 1 1 -1)) "nmos A Y GND GND 1 1 -1")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet->string test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    format netlist  -----------------------------------

;   Contract:
;   netlist->string : netlist -> string

;   Purpose:
;   take netlist and format them into string

;   Example
;   (netlist->string (cell-netlist INV-cell)) => "pmos A" Y VDD VDD" 1 1 1\nnmos A Y GND GND 1 1 -1)

;   Definition:
    (define netlist->string
        (lambda (netlist)
            (cond
                [(null? netlist) ""]
                [else
                    (string-join (list (mosfet->string (car netlist)) (netlist->string (cdr netlist))) "\n")]
            )
        )
    )

#|
;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (netlist->string (cell-netlist INV-cell)) "pmos A Y VDD VDD 1 1 1\nnmos A Y GND GND 1 1 -1")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " netlist->string test" (current-error-port))
            (newline (current-error-port))
        )
    )
|#  ; !! expected value has to have newline

;;  ------------    write description line  ---------------------------

;   Contract:
;   write-cell-file : cell -> --

;   Purpose:
;   write cell description to STDOUT

;   Example:
;   (write-cell-file INV-cell) => --

;   Definition:
    (define write-cell-file
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    ; first line header
                    (if (null? (cell-text cell))
                        (format (at-port)
"proudly AUTOGENERATED by \"Popcorn\" R7RS Scheme tool
"                       )
                        (format (at-port)
"~a
"                           (cell-text cell)))
                    ; next mandantory lines
                    (format (at-port)
".cell ~a
.inputs ~a
.outputs ~a
"                       (cell-id cell)
                        (string-join (cell-inputs cell))
                        (string-join (cell-outputs cell)))
                    ; optional clock line
                    (if (null? (cell-clocks cell))
                        '()
                        (format (at-port)
".clocks ~a
"                           (string-join (cell-clocks cell)))
                    )
                    ; additional, e.g. schematic
                    (if (null? (cell-additional cell))
                        '()
                        (format (at-port)
"~a
"                           (string-join (cell-additional cell) "\n"))
                    )
                    ; netlist
                    (format (at-port)
"~a"                    (netlist->string (cell-netlist cell)))
                    ; done
                    (format (at-port)
".end
"                   )
                )
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  EXPAND CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    calculate next free node number     ---------------

;   Congtract:
;   next-node-number : node-list -> node

;   Purpose:
;   search for highest used node in network, calculate next

;   Example:
;   (next-node-number "") => N1

;   Definition:
    (define next-node-number
        (lambda (node-list)
            (let ((sorted-list (sort-nodes-descending node-list)))
                (cond
                    [(null? sorted-list)
                        (string-append (string (car node-space)) (number->string 1))] ; "N1"
                    [else
                        (string-append (string (car node-space)) (number->string (+ (string->number (substring (car sorted-list) 1 (string-length (car sorted-list)))) 1)))]
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (next-node-number '("N1" "N2")) "N3")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-node-number test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    calculate next input character node ---------------

;   Congtract:
;   next-input-char-node: node-list -> node

;   Purpose:
;   search for highest used input node, calculate next

;   Example:
;   (next-input-char-node "A1") => "B"

;   Definition:
    (define next-input-char-node
        (lambda (node-list)
            (let ((sorted-list (sort-nodes-descending node-list)))
                (cond
                    [(null? sorted-list)
                        "A"]
                    [else
                        (string (car (cdr (memq (string-ref (car sorted-list) 0) input-space))))]
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (next-input-char-node '("A1")) "B")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-input-char-node test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    calculate next input number node    ---------------

;   Congtract:
;   next-input-num-node: node-list -> node

;   Purpose:
;   search for highest used input node, calculate next

;   Example:
;   (next-input-num-node "A1") => "A2"

;   Definition:
    (define next-input-num-node
        (lambda (node-list)
            (let ((sorted-list (sort-nodes-descending node-list)))
                (cond
                    [(null? sorted-list)
                        "A"]
                    [else
;                        (string (car (cdr (memq (string-ref (car sorted-list) 0) input-space))))]
                        (string (string-ref (car sorted-list) 0) (integer->char (+ 1 (char->integer (string-ref (car sorted-list) 1)))))]
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (next-input-num-node '("A2")) "A3")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-input-num-node test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    find mosfet to expand   ---------------------------

;   Contract:
;   find-mosfet-anchor : cell -> mosfet

;   Purpose:
;   crawl through network and find transistor to expand

;   Example:
;   (find-mosfet-anchor (pullup-network (cell-netlist INV-cell))) => #("nmos" "A" "Y" "GND" "GND" 1 1 -1)

;   Definition:
    (define find-mosfet-anchor
        (lambda (netlist limit)
            (if (null? netlist)
                '()
                (let ((network (sort-mosfet-descending netlist)))
                    (let ((candidate (car network)))
                        (if (< (mosfet-stacked candidate) limit)
                            ; got it - candidate on path is below limit
                            candidate
                            ; waste path away, check next
                            (find-mosfet-anchor (filter-mosfet-remove network (mosfet-gate candidate)) limit)
                        )
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (find-mosfet-anchor (pulldown-network (cell-netlist INV-cell)) 2)
                        #("nmos" "A" "Y" "GND" "GND" 1 1 -1))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " find-mosfet-anchor test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand netlist serial   ---------------------------

;   Contract:
;   expand-netlist-serial : netlist new-node new-gate mosfet -> netlist

;   Purpose:
;   expand network by mosfet in serial

;   Example:
;   (expand-netlist-serial (pulldown-network (cell-netlist INV-cell)) "N2" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1)) =>
;       (#("nmos" "A" "Y" "N2" "GND" 1 1 -1) #("nmos" "B" "N2" "GND" "GND" 2 1 -2))

;   Definition:
    (define expand-netlist-serial
        (lambda (netlist new-node new-gate mosfet)
            (cond
                ; netlist empty?
                [(null? netlist)]
                ; handle anchor transistor
                [(equal? (car netlist) mosfet)
                    (let ((new-mosfet (generate-mosfet))
                          (org-mosfet mosfet))
                        (begin
                            ; use same type as original
                            (mosfet-type! new-mosfet (mosfet-type org-mosfet))
                            ; use new generated gate node
                            (mosfet-gate! new-mosfet new-gate)
                            ; use same source as original (hopefully a power rail)
                            (mosfet-source! new-mosfet (mosfet-source org-mosfet))
                            ; use new generated node number between original and new mosfet
                            (mosfet-source! org-mosfet new-node)
                            (mosfet-drain! new-mosfet new-node)
                            ; use same bulk as original
                            (mosfet-bulk! new-mosfet (mosfet-bulk org-mosfet))
                            ; increment stacked transistor number
                            (mosfet-stacked! new-mosfet (+ (mosfet-stacked org-mosfet) 1))
                            ; use same xasis as original
                            (mosfet-xaxis! new-mosfet (mosfet-xaxis org-mosfet))
                            ; increment yaxis number
                            (if (< (mosfet-yaxis org-mosfet) 0)
                                ; negative, pulldown network
                                (mosfet-yaxis! new-mosfet (- (mosfet-yaxis org-mosfet) 1))
                                ; positive, pullup network
                                (mosfet-yaxis! new-mosfet (+ (mosfet-yaxis org-mosfet) 1))
                            )
                            ; return
                            (cons org-mosfet (cons new-mosfet '()))
                        )
                    )]
                [else
                    (cons (car netlist) (expand-netlist-serial (cdr netlist) new-node new-gate mosfet))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-netlist-serial (pulldown-network (cell-netlist INV-cell)) "N2" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1))
                    '(#("nmos" "A" "Y"  "N2"  "GND" 1 1 -1)
                      #("nmos" "B" "N2" "GND" "GND" 2 1 -2)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-netlist-serial test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand netlist parallel ---------------------------

;   Contract:
;   expand-netlist-parallel : netlist new-gate mosfet -> netlist

;   Purpose:
;   expand network by mosfet in parallel

;   Example:
;   (expand-netlist-parallel (pulldown-down (cell-netlist INV-cell)) "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1)) =>
;       (#("nmos" "A" "Y" "GND" "GND" 1 1 -1) #("nmos" "B" "Y" "GND" "GND" 1 2 -1))

;   Definition:
    (define expand-netlist-parallel
        (lambda (netlist new-gate org-mosfet)
            (let ((new-mosfet (generate-mosfet))
                  (xaxis (mosfet-xaxis org-mosfet)))
                (begin
                    ; use same type as original
                    (mosfet-type! new-mosfet (mosfet-type org-mosfet))
                    ; use new generated gate node
                    (mosfet-gate! new-mosfet new-gate)
                    ; use same source as original
                    (mosfet-source! new-mosfet (mosfet-source org-mosfet))
                    ; use same drain as original
                    (mosfet-drain! new-mosfet (mosfet-drain org-mosfet))
                    ; use same bulk as original
                    (mosfet-bulk! new-mosfet (mosfet-bulk org-mosfet))
                    ; use same stacked transistor number
                    (mosfet-stacked! new-mosfet (mosfet-stacked org-mosfet))
                    ; increment xasis number !! fixme - others transistors has to be shifted?
                    (if (< xaxis 0)
                        ; negative, pulldown network
                        (mosfet-xaxis! new-mosfet (- xaxis 1))
                        ; positive, pullup network
                        (mosfet-xaxis! new-mosfet (+ xaxis 1))
                    )
                    ; use same yaxis number
                    (mosfet-yaxis! new-mosfet (mosfet-yaxis org-mosfet))
                    ; return
                    (cons new-mosfet netlist)
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-netlist-parallel (pulldown-network (cell-netlist INV-cell)) "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1))
                         '(#("nmos" "B" "Y"  "GND" "GND" 1 2 -1)
                           #("nmos" "A" "Y"  "GND" "GND" 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-netlist-parallel test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand cell nand-wise   ---------------------------

;   Contract:
;   expand-cell-nand : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet nand-like

;   Example:
;   (expand-cell-nand INV-cell 2) => NAND2-cell

;   Definition:
    (define expand-cell-nand
        (lambda (cell limit)
            (let ((netlist (cell-netlist cell)))
                (let ((anchor (find-mosfet-anchor (pulldown-network netlist) limit)))
                    (let ((complementary (complementary-mosfets netlist anchor))
                          (new-node (next-node-number (intermediate-nodes netlist)))
                          (new-gate (next-input-char-node (input-nodes netlist))))
                        (begin
                            ; set new cell-id
                            (cell-id! cell "dummy")
                            ; set new cell description
                            (cell-text! cell "dummy")
                            ; set input nodes
                            (cell-inputs! cell (cons new-gate (input-nodes netlist)))
                            ; set output nodes
                            (cell-outputs! cell (output-nodes netlist))
                            ; set clock nodes
                            (cell-clocks! cell (clock-nodes netlist))
                            ; set netlist
                            (cell-netlist! cell (expand-netlist-parallel (expand-netlist-serial netlist new-node new-gate anchor) new-gate complementary))
                            ; set additionals
                            (cell-additional! cell '("#"))
                        )
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-cell-nand INV-cell 2) NAND2-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-cell-nand test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand cell nor-wise    ---------------------------

;   Contract:
;   expand-cell-nor : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet nor-like

;   Example:
;   (expand-cell-nor INV-cell) => NOR2-cell

;   Definition:
    (define expand-cell-nor
        (lambda (cell limit)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-cell-nor INV-cell 2) NOR2-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-cell-nor test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand cell oai-wise    ---------------------------

;   Contract:
;   expand-cell-oai : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet oai-like

;   Example:
;   (expand-cell-oai NAND2-cell) => OAI21-cell

;   Definition:
    (define expand-cell-oai
        (lambda (cell limit)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-cell-oai NAND2-cell 2) OAI21-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-cell-oai test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    expand cell aoi-wise    ---------------------------

;   Contract:
;   expand-cell-aoi : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet aoi-like

;   Example:
;   (expand-cell-aoi NOR2-cell) => AOI21-cell

;   Definition:
    (define expand-cell-aoi
        (lambda (cell limit)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (expand-cell-aoi NOR2-cell 2) AOI21-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-cell-aoi test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

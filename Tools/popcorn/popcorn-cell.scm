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
  (export  cell:read-file
           cell:write-file
           cell:expand-nand
           cell:expand-nor
           cell:expand-oai
           cell:expand-aoi
           cell:expand-pu
           cell:expand-pd)
  (begin

;;  ------------    built-in self test  -------------------------------

    ; use this switch during development only
    (define built-in-self-test? #t)

;;  ------------    built-in sanity checks  ---------------------------

    ; use this switch during development only
    (define built-in-sanity-checks? #t)

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
;   cell:read-file : filehandler -> cell

;   Purpose:
;   read in cell file as vector for further usage

;   Example:
;   (cell:read-file file)
;       => INV-cell

;   Definition:
    (define (cell:read-file file-name)
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
                                        (function (read-line file))]

                                    ; .cell annotated line, get name
                                    [(equal? (substring line 0 4) ".cel")
                                        (begin
                                            (cell-id! return (string-upcase (string-copy line 6)))
                                            (function (read-line file)))]

                                    ; .clocks annotated line, get list
                                    [(equal? (substring line 0 4) ".clo")
                                        (begin
                                            (cell-clocks! return (string-split (string-upcase (string-copy line 7)) #[ ]))
                                            (function (read-line file)))]

                                    ; .inputs annotated line, get list
                                    [(equal? (substring line 0 4) ".inp")
                                        (begin
                                            (cell-inputs! return (string-split (string-upcase (string-copy line 8)) #[ ]))
                                            (function (read-line file)))]

                                    ; .outputs annotated line, get list
                                    [(equal? (substring line 0 4) ".out")
                                        (begin
                                            (cell-outputs! return (string-split (string-upcase (string-copy line 9)) #[ ]))
                                            (function (read-line file)))]

                                    ; .end annotated line, clean up
                                    [(equal? (substring line 0 4) ".end")
                                        (begin
                                            (cell-netlist! return netlist)
                                            (eof-object))]

                                    ; collect netlist lines
                                    [else
                                        (begin
                                            (set! netlist (append netlist (list (stringlist->mosfet (string-split line #[ ])))))
;                                            (set! netlist (cons (stringlist->mosfet (string-split line #[ ])) netlist))
                                            (function (read-line file)))])))))
            ; done, close file
            (close-input-port file)
            (sanity-cell? return)
            return)))

;;  -------------------------------------------------------------------
;;                  WRITE CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    convert mosfet into string  -----------------------

;   Contract:
;   mosfet->string : mosfet -> string

;   Purpose:
;   convert mosfet vector into one long string

;   Example:
;   (mosfet->string '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
;       => "nmos A Y GND GND 1 1 -1 1"

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
                    (mosfet-size mosfet)))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (mosfet->string '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                                           "nmos A Y GND GND 1 1 -1 1")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet->string test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    format netlist  -----------------------------------

;   Contract:
;   netlist->string : netlist -> string

;   Purpose:
;   take netlist and format them into string

;   Example
;   (netlist->string (cell-netlist INV-cell))
;       => "pmos A Y VDD VDD 1 1 1 g\nnmos A Y GND GND 1 1 -1 1"

;   Definition:
    (define netlist->string
        (lambda (netlist)
            (cond
                [(null? netlist) '()]
                [else
                    (cons (mosfet->string (car netlist)) (netlist->string (cdr netlist)))])))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (netlist->string (cell-netlist INV-cell))
                        '("pmos A Y VDD VDD 1 1 1 g" "nmos A Y GND GND 1 1 -1 1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " netlist->string test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    multiline format    -------------------------------

;   Contract:
;   multiline-format : list-of-string -> -

;   Purpose:
;   take list-of-string and feed format instruction

;   Example:
;   (multiline-format (current-output-port) (netlist->string (cell-netlist INV-cell)))
;       => ("pmos A Y VDD VDD 1 1 1 g" "nmos A Y GND GND 1 1 -1 1")

;   Definitimn:
    (define multiline-format
        (lambda (at-port stringlist)
            (if (null? stringlist)
                ""
                (begin
                    (format (at-port)
"~a
"                       (car stringlist))
                    (multiline-format at-port (cdr stringlist))))))
#|
;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (multiline-formast (current-output-port) (cell-netlist INV-cell))
                        '("pmos A Y VDD VDD 1 1 1 g" "nmos A Y GND GND 1 1 -1 1")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " netlist->string test" (current-error-port))
            (newline (current-error-port))))
|#
;;  ------------    write cell description  ---------------------------

;   Contract:
;   cell:write-file : cell -> --

;   Purpose:
;   write cell description to STDOUT

;   Example:
;   (cell:write-file INV-cell)
;       => --

;   Definition:
    (define cell:write-file
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    ; first line header
                    (if (null? (cell-text cell))
                        (format (at-port)
".AUTOGENERATED by \'Popcorn\' R7RS Scheme tool
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
                        ""
                        (format (at-port)
".clocks ~a
"                           (string-join (cell-clocks cell))))
                    ; additional, e.g. schematic
                    (if (null? (cell-additional cell))
                        ""
                        (multiline-format at-port (cell-additional cell)))
                    ; netlist
                    (multiline-format at-port (netlist->string (cell-netlist cell)))
                    ; done
                    (format (at-port)
".end
"                   )))))

;;  -------------------------------------------------------------------
;;                  DRAW NETLIST SCHEMATIC
;;  -------------------------------------------------------------------

;;  ------------    format node name    -------------------------------

;   Contract:
;   format-node: node -> string

;   Purpose:
;   format fix-length string out ouf node name

;   Example:
;   (format-node "A")
;       => "A  "

;   Definition:
    (define format-node
        (lambda (node)
            (let ((len (string-length node)))
                (cond
                    [(eq? len 0) (string-append node "   ")]
                    [(eq? len 1) (string-append node "  ")]
                    [(eq? len 2) (string-append node " ")]
                    [else (string-copy node 0 3)]))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (format-node "A")
                        "A  ")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " format-node test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    netlist->sprites    -------------------------------

;   Contract:
;   netlist->sprites: list-of-sprite -> hierarchichal list-of-strings

;   Purpose:
;   return all strings, representing the netlist as schematic of mosfet circuit

;   Example:
;   (netlist->sprites ('#("nmos" "A" "Y" "GND" "GND" 1 1 -1 1)))
;       => '("           | GND    "
;            "       | +--        "
;            " A  ---| |  1       "
;            "       | +--        "
;            "           | Y      "))

;   Definition:
    (define mosfet->sprites
        (lambda (netlist xpos)
            (if (null? netlist)
                '()
                (let ((mosfet (car netlist))
                      (empty-sprite (list "                  "
                                          "                  "
                                          "                  "
                                          "                  "
                                          "                  ")))
                    (if (equal? (mosfet-xaxis mosfet) xpos)
                        ; mosfet found for this coordinates
                        (cond
                            [(mosfet-nmos? mosfet)
                                (cons
                                    (list   (string-append "          | " (format-node (mosfet-source mosfet)) "   ")
                                                           "      | +--       "
                                            (string-append (format-node (mosfet-gate mosfet))      "---| |  " (format-node (mosfet-size mosfet)) "    ")
                                                           "      | +--       "
                                            (string-append "          | " (format-node (mosfet-drain mosfet))  "   "))
                                    (mosfet->sprites (cdr netlist) (+ xpos 1)))]
                            [(mosfet-pmos? mosfet)
                                (cons
                                    (list   (string-append "          | " (format-node (mosfet-drain mosfet))  "   ")
                                                           "      | +--       "
                                            (string-append (format-node (mosfet-gate mosfet))      "--o| |  " (format-node (mosfet-size mosfet)) "    ")
                                                           "      | +--       "
                                            (string-append "          | " (format-node (mosfet-source mosfet)) "   "))
                                    (mosfet->sprites (cdr netlist) (+ xpos 1)))]
                            [else
                                (cons empty-sprite (mosfet->sprites (cdr netlist) (+ xpos 1)))])
                        ; position (coordinates) is empty
                        (cons empty-sprite (mosfet->sprites netlist (+ xpos 1))))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (mosfet->sprites '(#("nmos" "A" "Y" "GND" "GND" 1 2 -1 "1")) 1)
                        '(("                  "
                           "                  "
                           "                  "
                           "                  "
                           "                  ")
                           ("          | GND   "
                           "      | +--       "
                           "A  ---| |  1      "
                           "      | +--       "
                           "          | Y     ")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet->sprites test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    get one sprite line     ---------------------------

;   Contract:
;   get-one-sprite-line : list-of-sprites -> string

;   Purpose:
;   return dedicated line of given sprites as string

;   Example:
;   (get-one-sprite-line (mosfet->sprites ('#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) 1) 3)
;       => "---| |  1"

;   Definition:
    (define get-one-sprite-line
        (lambda (sprites line)
            (if (or (null? sprites) (= line 0))
                ""
                (string-append (list-ref (car sprites) (- line 1)) (get-one-sprite-line (cdr sprites) line)))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (get-one-sprite-line (mosfet->sprites '(#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")
                                                                #("nmos" "B" "Y" "GND" "GND" 1 2 -1 "1")) 1) 3)
                        "A  ---| |  1      B  ---| |  1      ")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-one-sprite-line test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    get one row of sprites  ---------------------------

;   Contract:
;   get-one-sprite-row: list-of-sprites -> list-of-string

;   Purpose:
;   return all lines of given sprites as strings

;   Example:
;   (get-one-sprite-row (mosfet->sprites ('#("nmos" "A" "Y" "GND" "GND" 1 1 -1)) 1) 5)
;       => ?

;   Definition:
    (define get-one-sprite-row
        (lambda (sprites lines)
            (if (or (null? sprites) (= lines 0))
                '()
                (cons (string-append "# " (get-one-sprite-line sprites lines)) (get-one-sprite-row sprites (- lines 1))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (get-one-sprite-row (mosfet->sprites '(#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")
                                                               #("nmos" "B" "Y" "GND" "GND" 1 2 -1 "1")) 1) 5) 
                        '("#           | Y               | Y     "
                          "#       | +--             | +--       "
                          "# A  ---| |  1      B  ---| |  1      "
                          "#       | +--             | +--       "
                          "#           | GND             | GND   "))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-one-sprite-row test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    get-all-rows    -----------------------------------

;   Contract:
;   get-all-rows : netlist highest-row -> list-of-string

;   Purpose:
;   crawl netlist and generate ascci-art line by line

;   Example:
;   (get-all-rows (cell-netlist INV-cell))
;       => ?

;   Definition:
    (define get-all-rows
        (lambda (netlist row)
            (cond 
                [(= row 0)
                    ; !! connectivity
                    ; no row zero, go down
                    (get-all-rows netlist (- row 1))]
                ; pullup network
                [(> row 0)
                    (let ((mosfets-on-row (sort-mosfet-ascending (filter-mosfet-row netlist row))))
                        (if (null? mosfets-on-row)
                            '()
                            (append
                                (get-one-sprite-row (mosfet->sprites mosfets-on-row 1) 5)
                                ; !! connectivity
                                (get-all-rows netlist (- row 1)))))]
                ; pulldown network
                [(< row 0)
                    (let ((mosfets-on-row (sort-mosfet-ascending (filter-mosfet-row netlist row))))
                        (if (null? mosfets-on-row)
                            '()
                            (append
                                (get-one-sprite-row (mosfet->sprites mosfets-on-row 1) 5)
                                ; !! connectivity
                                (get-all-rows netlist (- row 1)))))])))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (get-all-rows (cell-netlist INV-cell) 1)
                        '("#           | VDD   "
                          "#       | +--       "
                          "# A  --o| |  g      "
                          "#       | +--       "
                          "#           | Y     "
                          ; !! connectivity
                          "#           | Y     "
                          "#       | +--       "
                          "# A  ---| |  1      "
                          "#       | +--       "
                          "#           | GND   "))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-all-rows test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    ascii-art schematic -------------------------------

;   Contract:
;   ascii-art-schematic : netlist -> list-of-string

;   Purpose:
;   crawl netlist and generate ascii-art line by line

;   Example:
;   (ascii-art-schematic (cell-netlist INV-cell))
;       => ?

;   Definition:
    (define ascii-art-schematic
        (lambda (netlist)
            (let ((yaxis (metric-highest-yaxis netlist)))
                (get-all-rows netlist yaxis))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (ascii-art-schematic (cell-netlist INV-cell))
                        (cell-additional INV-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " ascii-art-schematic test" (current-error-port))
            (newline (current-error-port))))


;;  -------------------------------------------------------------------
;;                  EXPAND CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    calculate next free node number     ---------------

;   Contract:
;   next-node-number : node-list -> node

;   Purpose:
;   search for highest used node in network, calculate next

;   Example:
;   (next-node-number "")
;       => N1

;   Definition:
    (define next-node-number
        (lambda (node-list)
            (let ((sorted-list (sort-nodes-descending node-list)))
                (cond
                    [(null? sorted-list)
                        (string-append (string (car node-space)) (number->string 1))] ; "N1"
                    [else
                        (string-append (string (car node-space)) (number->string (+ (string->number (substring (car sorted-list) 1 (string-length (car sorted-list)))) 1)))]))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (next-node-number '("N1" "N2"))
                        "N3")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-node-number test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    calculate next input character node ---------------

;   Contract:
;   next-input-char-node: mosfet -> node

;   Purpose:
;   check mosfet input node, calculate next

;   Example:
;   (next-input-char-node '#("pmos" "A1 "Y" "GND" "GND" 1 1 -1 "g"))
;       => "B"

;   Definition:
    (define next-input-char-node
        (lambda (mosfet)
            (let ((node (mosfet-gate mosfet)))
                (cond
                    [(null? node) "A1"]
                    [else
                        (string (car (cdr (memq (string-ref node 0) input-space))))]))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (next-input-char-node '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "g"))
                        "B")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-input-char-node test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    calculate next input number node    ---------------

;   Contract:
;   next-input-num-node: mosfet -> node

;   Purpose:
;   check mosfet input node, calculate next

;   Example:
;   (next-input-num-node '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "g"))
;       => "A1"

;   Definition:
    (define next-input-num-node
        (lambda (mosfet)
            (let ((node (mosfet-gate mosfet)))
                (cond
                    [(null? node) "A"]
                    [(eqv? (string-length node) 1)
                        (string (string-ref node 0)
                                #\1)]
                    [else
                        (string (string-ref node 0)
                                (integer->char (+ 1 (char->integer (string-ref node 1)))))]))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (next-input-num-node '#("pmos" "A1" "Y" "GND" "GND" 1 1 -1 "g"))
                        "A2")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-input-num-node test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    combine next input number node      ---------------

;   Contract:
;   combine-input-num-node: node number -> node

;   Purpose:
;   combine node and number into new node

;   Example:
;   (combine-input-num-node "A" 1)
;       => "A1"

;   Definition:
    (define combine-input-num-node
        (lambda (node num)
            (let ((character (string (string-ref node 0)))
                  (number (number->string num)))
                (if (= num 0)
                    character
                    (string-append character number)))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (combine-input-num-node "A1" 2)
                        "A2")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " combine-input-num-node test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    calculate next output node  -----------------------

;   Contract:
;   next-output-node: node-list -> node

;   Purpose:
;   search for highest used output node, calculate next

;   Example:
;   (next-output-node "Y")
;       => "Z"

;   Definition:
    (define next-output-node
        (lambda (node-list)
            (let ((sorted-list (sort-nodes-descending node-list)))
                (cond
                    [(null? sorted-list) "Y"]
                    [else
                        (string (car (cdr (memq (string-ref (car sorted-list) 0) output-space))))]))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (next-output-node '("Y"))
                        "Z")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " next-output-node test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    find mosfet to expand   ---------------------------

;   Contract:
;   find-mosfet-anchor : cell -> mosfet

;   Purpose:
;   crawl through network and find transistor to expand

;   Example:
;   (find-mosfet-anchor (pullup-network (cell-netlist INV-cell)))
;       => #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

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
                            (find-mosfet-anchor (filter-mosfet-remove (cdr network) (mosfet-gate candidate)) limit)))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (find-mosfet-anchor (pulldown-network (cell-netlist INV-cell)) 2)
                        #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " find-mosfet-anchor test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand netlist serial   ---------------------------

;   Contract:
;   expand-netlist-serial : netlist new-node org-gate new-gate mosfet -> netlist

;   Purpose:
;   expand network by mosfet in serial

;   Example:
;   (expand-netlist-serial (pulldown-network (cell-netlist INV-cell)) "N2" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "0"))
;       => (#("nmos" "A" "Y" "N2" "GND" 1 1 -1 "1") #("nmos" "B" "N2" "GND" "GND" 2 1 -2 "0"))

;   Definition:
    (define expand-netlist-serial
        (lambda (netlist new-node org-gate new-gate anchor)
            (cond
                ; netlist empty?
                [(null? netlist)]
                ; handle anchor transistor
                [(equal? (car netlist) anchor)
                    (let*  ((new-mosfet (generate-mosfet))
                            (org-mosfet (generate-mosfet))
                            ; increment yaxis regarding network
                            (new-yaxis (if (< (mosfet-yaxis anchor) 0)
                                        ; negative, pulldown network
                                        (- (mosfet-yaxis anchor) 1)
                                        ; positive, pullup network
                                        (+ (mosfet-yaxis anchor) 1))))
                        (begin
                            ; clone anchor
                            (mosfet-type! new-mosfet (mosfet-type anchor))
                            (mosfet-type! org-mosfet (mosfet-type anchor))
                            ; use orginal and new generated gate node
                            (mosfet-gate! new-mosfet new-gate)
                            (mosfet-gate! org-mosfet org-gate) ; eventually renamed by AOI and OAI
                            ; use different sources
                            (mosfet-source! new-mosfet (mosfet-source anchor)) ;  hopefully a power rail
                            (mosfet-source! org-mosfet new-node) ; new connected
                            ; use different drains
                            (mosfet-drain! new-mosfet new-node) ; new connected
                            (mosfet-drain! org-mosfet (mosfet-drain anchor))
                            ; use same bulk as original
                            (mosfet-bulk! new-mosfet (mosfet-bulk anchor))
                            (mosfet-bulk! org-mosfet (mosfet-bulk anchor))
                            ; increment stacked transistor number
                            (mosfet-stacked! new-mosfet (+ (mosfet-stacked anchor) 1))
                            (mosfet-stacked! org-mosfet (mosfet-stacked anchor))
                            ; use same xasis as original
                            (mosfet-xaxis! new-mosfet (mosfet-xaxis anchor))
                            (mosfet-xaxis! org-mosfet (mosfet-xaxis anchor))
                            ; assign free row
                            (mosfet-yaxis! new-mosfet new-yaxis)
                            (mosfet-yaxis! org-mosfet (mosfet-yaxis anchor))
                            ; transistor sizing
                            (mosfet-size! new-mosfet (mosfet-size anchor)) ; !! no size yet
                            (mosfet-size! org-mosfet (mosfet-size anchor)) ; !! no size yet
                            ; return
                            (append (list new-mosfet org-mosfet) (cdr netlist))))]
                [else
                    (cons (car netlist) (expand-netlist-serial (cdr netlist) new-node org-gate new-gate anchor))])))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (expand-netlist-serial (pulldown-network (cell-netlist INV-cell)) "N1" "A" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                        '(#("nmos" "B" "N1" "GND" "GND" 2 1 -2 "1")
                          #("nmos" "A" "Y"  "N1"  "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-netlist-serial test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand netlist parallel ---------------------------

;   Contract:
;   expand-netlist-parallel : netlist new-gate mosfet -> netlist

;   Purpose:
;   expand network by mosfet in parallel

;   Example:
;   (expand-netlist-parallel (pulldown-down (cell-netlist INV-cell)) "A" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
;       => (#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1") #("nmos" "B" "Y" "GND" "GND" 1 2 -1 "1"))

;   Definition:
    (define expand-netlist-parallel
        (lambda (netlist org-gate new-gate anchor)
            (cond
                ; netlist empty?
                [(null? netlist)]
                ; handle anchor transistor
                [(equal? (car netlist) anchor)
                    (let*  ((new-mosfet (generate-mosfet))
                            (org-mosfet (generate-mosfet))
                            ; increment xasis number
                            (new-xaxis (+ (mosfet-xaxis anchor) 1)))
                        (begin
                            ; clone anchor for orginal
                            (mosfet-type! new-mosfet (mosfet-type anchor))
                            (mosfet-type! org-mosfet (mosfet-type anchor))
                            ; use new generated gate node
                            (mosfet-gate! new-mosfet new-gate)
                            (mosfet-gate! org-mosfet org-gate) ; eventually renamed for AOI, OAI
                            ; use same source as anchor
                            (mosfet-source! new-mosfet (mosfet-source anchor))
                            (mosfet-source! org-mosfet (mosfet-source anchor))
                            ; use same drain as anchor
                            (mosfet-drain! new-mosfet (mosfet-drain anchor))
                            (mosfet-drain! org-mosfet (mosfet-drain anchor))
                            ; use same bulk as anchor
                            (mosfet-bulk! new-mosfet (mosfet-bulk anchor))
                            (mosfet-bulk! org-mosfet (mosfet-bulk anchor))
                            ; use same stacked transistor number
                            (mosfet-stacked! new-mosfet (mosfet-stacked anchor))
                            (mosfet-stacked! org-mosfet (mosfet-stacked anchor))
                            ; assign free column
                            (mosfet-xaxis! new-mosfet new-xaxis)
                            (mosfet-xaxis! org-mosfet (mosfet-xaxis anchor))
                            ; use same yaxis number
                            (mosfet-yaxis! new-mosfet (mosfet-yaxis anchor))
                            (mosfet-yaxis! org-mosfet (mosfet-yaxis anchor))
                            ; transistor sizing
                            (mosfet-size! new-mosfet (mosfet-size anchor)) ; always same size
                            (mosfet-size! org-mosfet (mosfet-size anchor)) ; always same size
                            ; return
                            (append (list new-mosfet org-mosfet) (cdr netlist))))]
                [else
                    (cons (car netlist) (expand-netlist-parallel (cdr netlist) org-gate new-gate anchor))])))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (expand-netlist-parallel (pulldown-network (cell-netlist INV-cell)) "A" "B" #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                        '(#("nmos" "B" "Y"  "GND" "GND" 1 2 -1 "1")
                          #("nmos" "A" "Y"  "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-netlist-parallel test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand netlist w/ buffer    -----------------------

;   Contract:
;   expand-netlist-buffer : netlist old-output -> netlist

;   Purpose:
;   expand network by adding buffer

;   Example:
;   (expand-netlist-buffer (cell-netlist INV-cell) "Y" 1)
;       => (cell-netlist BUF-cell)

;   Definition:
    (define expand-netlist-buffer
        (lambda (netlist old-output)
            (let ((nmos-mosfet (generate-mosfet))
                  (pmos-mosfet (generate-mosfet))
                  (xaxis (metric-highest-xaxis netlist)))
                (begin
                    ; use pMOS and nMOS as types
                    (mosfet-type! pmos-mosfet "pmos")
                    (mosfet-type! nmos-mosfet "nmos")
                    ; use old output node as gate
                    (mosfet-gate! pmos-mosfet old-output)
                    (mosfet-gate! nmos-mosfet old-output)
                    ; use power rails for source
                    (mosfet-source! pmos-mosfet (car supply-space))
                    (mosfet-source! nmos-mosfet (car ground-space))
                    ; use next output symbol
                    (mosfet-drain! pmos-mosfet "Z") ;;(string (cadr output-space)))
                    (mosfet-drain! nmos-mosfet "Z") ;;((string (cadr output-space)))
                    ; use same bulk as source
                    (mosfet-bulk! pmos-mosfet (car supply-space))
                    (mosfet-bulk! nmos-mosfet (car ground-space))
                    ; use same stacked transistor always one
                    (mosfet-stacked! pmos-mosfet 1)
                    (mosfet-stacked! nmos-mosfet 1)
                    ; increment xasis number
                    (mosfet-xaxis! pmos-mosfet (+ xaxis 1))
                    (mosfet-xaxis! nmos-mosfet (+ xaxis 1))
                    ; use default yaxis numbers
                    (mosfet-yaxis! pmos-mosfet 1)
                    (mosfet-yaxis! nmos-mosfet -1)
                    ; transistor sizing
                    (mosfet-size! pmos-mosfet "g")
                    (mosfet-size! nmos-mosfet "1")
                    ; return
                    (cons pmos-mosfet (cons nmos-mosfet netlist))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (expand-netlist-buffer (cell-netlist INV-cell) "Y")
                        (cell-netlist BUF-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " expand-netlist-buffer test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand cell nand-wise   ---------------------------

;   Contract:
;   cell:expand-nand : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet nand-like

;   Example:
;   (cell:expand-nand INV-cell 2)
;       => NAND2-cell

;   Definition:
    (define cell:expand-nand
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (let*  (; generate new emtpy cell
                    (return (generate-cell))
                    ; shortend netlist call
                    (netlist (cell-netlist cell))
                    ; search anchor mosfet
                    (anchor (find-mosfet-anchor (pulldown-network netlist) stacked-limit))
                    ; get complementary mosfet regarding anchor
                    (complementary (complementary-mosfets netlist anchor))
                    ; get free node number
                    (1st-node (next-node-number (intermediate-nodes netlist)))
                    ; calculate new gate name for additional mosfet
                    (2nd-gate (next-input-num-node anchor))
                    ; expand original netlist with new mosfets
                    (new-netlist (expand-netlist-parallel (expand-netlist-serial netlist 1st-node (mosfet-gate anchor) 2nd-gate anchor) (mosfet-gate anchor) 2nd-gate complementary)))
                (begin
                    ; check netlist regading buffer limit
                    (if (and (null? (buffer-network new-netlist)) (>= (metric-highest-stacked new-netlist) buffer-limit))
                        ; netlist is yet still not buffered but already on level
                        (cell-netlist! return (sort-netlist (expand-netlist-buffer new-netlist (car (cell-outputs cell)))))
                        ; already bufferd, set netlist only
                        (cell-netlist! return (sort-netlist new-netlist)))
                    ; set new cell-id
                    (cell-id! return cell-name)
                    ; set new cell description
                    (cell-text! return cell-descr)
                    ; set input nodes
                    (cell-inputs! return (sort-ports-descending (input-nodes (cell-netlist return))))
                    ; set output nodes
                    (cell-outputs! return (sort-ports-descending (output-nodes (cell-netlist return))))
                    ; set clock nodes
                    (cell-clocks! return (sort-ports-ascending (clock-nodes (cell-netlist return))))
                    ; set additionals
                    (cell-additional! return (ascii-art-schematic (cell-netlist return)))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (cell:expand-nand INV-cell 4 4 "NAND2" "a 2-input Not-AND (or NAND) gate")
                        NAND2-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell:expand-nand test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand cell nor-wise    ---------------------------

;   Contract:
;   cell:expand-nor : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet nor-like

;   Example:
;   (cell:expand-nor INV-cell 4 4)
;       => NOR2-cell

;   Definition:
    (define cell:expand-nor
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (let*  (; generate new emtpy cell
                    (return (generate-cell))
                    ; shortend netlist call
                    (netlist (cell-netlist cell))
                    ; search anchor mosfet
                    (anchor (find-mosfet-anchor (pullup-network netlist) stacked-limit))
                    ; get complementary mosfet regarding anchor
                    (complementary (complementary-mosfets netlist anchor))
                    ; get free node number
                    (1st-node (next-node-number (intermediate-nodes netlist)))
                    ; calculate new gate name for additional mosfet
                    (2nd-gate (next-input-num-node anchor))
                    ; expand original netlist with new mosfets
                    (new-netlist (expand-netlist-parallel (expand-netlist-serial netlist 1st-node (mosfet-gate anchor) 2nd-gate anchor) (mosfet-gate anchor) 2nd-gate complementary)))
                (begin
                    ; check netlist regading buffer limit
                    (if (and (null? (buffer-network new-netlist)) (>= (metric-highest-stacked new-netlist) buffer-limit))
                        ; netlist is yet still not buffered but already on level
                        (cell-netlist! return (sort-netlist (expand-netlist-buffer new-netlist (car (cell-outputs cell)))))
                        ; already bufferd, set netlist only
                        (cell-netlist! return (sort-netlist new-netlist)))
                    ; set new cell-id
                    (cell-id! return cell-name)
                    ; set new cell description
                    (cell-text! return cell-descr)
                    ; set input nodes
                    (cell-inputs! return (sort-ports-descending (input-nodes (cell-netlist return))))
                    ; set output nodes
                    (cell-outputs! return (sort-ports-descending (output-nodes (cell-netlist return))))
                    ; set clock nodes
                    (cell-clocks! return (sort-ports-ascending (clock-nodes (cell-netlist return))))
                    ; set additionals
                    (cell-additional! return (ascii-art-schematic (cell-netlist return)))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (cell:expand-nor INV-cell 4 4 "NOR2" "a 2-input Not-OR (or NOR) gate")
                        NOR2-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell:expand-nor test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand cell oai-wise    ---------------------------

;   Contract:
;   cell:expand-oai : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet oai-like

;   Example:
;   (cell:expand-oai NAND2-cell)
;       => OAI21-cell

;   Definition:
    (define cell:expand-oai
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (let*  (; generate new emtpy cell
                    (return (generate-cell))
                    ; shortend netlist call
                    (netlist (cell-netlist cell))
                    ; search anchor mosfet
                    (anchor (find-mosfet-anchor (pullup-network netlist) stacked-limit))
                    ; get complementary mosfet regarding anchor
                    (complementary (complementary-mosfets netlist anchor))
                    ; get free node number
                    (1st-node (next-node-number (intermediate-nodes netlist)))
                    ; calculate replacement name for anchor mosfet
                    (1st-gate (next-input-char-node anchor))
                    ; get gate name with index for additional mosfet
                    (2nd-gate (string-append 1st-gate (number->string 1)))
                    ; expand original netlist with new mosfets
                    (new-netlist (expand-netlist-parallel (expand-netlist-serial netlist 1st-node 1st-gate 2nd-gate anchor) 1st-gate 2nd-gate complementary)))
                (begin
                    ; check netlist regading buffer limit
                    (if (and (null? (buffer-network new-netlist)) (>= (metric-highest-stacked new-netlist) buffer-limit))
                        ; netlist is yet still not buffered but already on level
                        (cell-netlist! return (sort-netlist (expand-netlist-buffer new-netlist (car (cell-outputs cell)))))
                        ; already bufferd, set netlist only
                        (cell-netlist! return (sort-netlist new-netlist)))
                    ; set new cell-id
                    (cell-id! return cell-name)
                    ; set new cell description
                    (cell-text! return cell-descr)
                    ; set input nodes
                    (cell-inputs! return (sort-ports-descending (input-nodes (cell-netlist return))))
                    ; set output nodes
                    (cell-outputs! return (sort-ports-descending (output-nodes (cell-netlist return))))
                    ; set clock nodes
                    (cell-clocks! return (sort-ports-ascending (clock-nodes (cell-netlist return))))
                    ; set additionals
                    (cell-additional! return (ascii-art-schematic (cell-netlist cell)))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (cell:expand-oai NAND2-cell 4 4 "OAI21" "a 2-1-input OR-AND-Invert (or OAI) gate")
                        OAI21-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell:expand-oai test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand cell aoi-wise    ---------------------------

;   Contract:
;   cell:expand-aoi : cell -> cell

;   Purpose:
;   expand cell description by adding mosfet aoi-like

;   Example:
;   (cell:expand-aoi NOR2-cell)
;       => AOI21-cell

;   Definition:
    (define cell:expand-aoi
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (let*  (; generate new emtpy cell
                    (return (generate-cell))
                    ; shortend netlist call
                    (netlist (cell-netlist cell))
                    ; search anchor mosfet
                    (anchor (find-mosfet-anchor (pulldown-network netlist) stacked-limit))
                    ; get complementary mosfet regarding anchor
                    (complementary (complementary-mosfets netlist anchor))
                    ; get free node number
                    (1st-node (next-node-number (intermediate-nodes netlist)))
                    ; calculate replacement name for anchor mosfet
                    (1st-gate (next-input-char-node anchor))
                    ; get gate name with index for additional mosfet
                    (2nd-gate (string-append 1st-gate (number->string 1)))
                    ; expand original netlist with new mosfets
                    (new-netlist (expand-netlist-parallel (expand-netlist-serial netlist 1st-node 1st-gate 2nd-gate anchor) 1st-gate 2nd-gate complementary)))
                (begin
                    ; check netlist regading buffer limit
                    (if (and (null? (buffer-network new-netlist)) (>= (metric-highest-stacked new-netlist) buffer-limit))
                        ; netlist is yet still not buffered but already on level
                        (cell-netlist! return (sort-netlist (expand-netlist-buffer new-netlist (car (cell-outputs cell)))))
                        ; already bufferd, set netlist only
                        (cell-netlist! return (sort-netlist new-netlist)))
                    ; set new cell-id
                    (cell-id! return cell-name)
                    ; set new cell description
                    (cell-text! return cell-descr)
                    ; set input nodes
                    (cell-inputs! return (sort-ports-descending (input-nodes (cell-netlist return))))
                    ; set output nodes
                    (cell-outputs! return (sort-ports-descending (output-nodes (cell-netlist return))))
                    ; set clock nodes
                    (cell-clocks! return (sort-ports-ascending (clock-nodes (cell-netlist return))))
                    ; set additionals
                    (cell-additional! return (ascii-art-schematic (cell-netlist return)))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (cell:expand-aoi NOR2-cell 4 4 "AOI21" "a 2-1-input AND-OR-Invert (or AOI) gate")
                        AOI21-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell:expand-aoi test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    generate netlist row    ---------------------------

;   Contract:
;   generate-netlist-row : new-gate mosfet number -> netlist

;   Purpose:
;   clone anchor many times, return network as one row of mosfets

;   Example:
;   (generate-netlist-row "B" "N1" #("pmos" "A" "Y" "VDD" "VDD" 1 1 1 "g") 2)
;       => (pullup (cell-netlist AOI21-cell))

;   Definition:
    (define generate-netlist-row
        (lambda (new-gate new-node anchor stacked-limit)
            (if (equal? stacked-limit 0)
                '()
                (let   ((new-xaxis stacked-limit)
                        ; increment yaxis regarding network
                        (new-yaxis (if (< (mosfet-yaxis anchor) 0)
                                        ; negative, pulldown network
                                        (- (mosfet-yaxis anchor) 1)
                                        ; positive, pullup network
                                        (+ (mosfet-yaxis anchor) 1)))
                        (new-mosfet (generate-mosfet)))
                    (begin
                        ; use same type as anchor
                        (mosfet-type! new-mosfet (mosfet-type anchor))
                        ; use new-gate node
                        (mosfet-gate! new-mosfet (string-append (combine-input-num-node (string (string-ref new-gate 0)) (- stacked-limit 1))))
                        ; use same source as anchor (hopefully a power rail)
                        (mosfet-source! new-mosfet (mosfet-source anchor))
                        ; use new-node number between original and new mosfet
                        (mosfet-drain! new-mosfet new-node)
                        ; use same bulk as anchor
                        (mosfet-bulk! new-mosfet (mosfet-bulk anchor))
                        ; increment stacked transistor number
                        (mosfet-stacked! new-mosfet (+ (mosfet-stacked anchor) 1))
                        ; set xaxis regarding decrementing limit
                        (mosfet-xaxis! new-mosfet stacked-limit)
                        ; assign free row number
                        (mosfet-yaxis! new-mosfet new-yaxis)
                        ; transistor sizing
                        (mosfet-size! new-mosfet (mosfet-size anchor)) ; !! no size yet
                        ; go down for other mosfets in this row, append return values
                        (cons new-mosfet (generate-netlist-row new-gate new-node anchor (- stacked-limit 1))))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (generate-netlist-row "B" "N3" #("pmos" "A1" "Y" "VDD" "VDD" 1 2 1 "2g") 2)
                          '(#("pmos" "B1" "N3" "VDD" "VDD" 2 2  2 "2g")
                            #("pmos" "B"  "N3" "VDD" "VDD" 2 1  2 "2g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " generate-netlist-row test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand netlist by column    -----------------------

;   Contract:
;   generate-netlist-column : new-gate new-node mosfet limit -> netlist

;   Purpose:
;   expand network by one column of mosfets

;   Example:
;   (generate-netlist-column "B" "N1" #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1") 2)
;       => (pulldown-network (cell-netlist AOI21-cell))

;   Definition:
    (define generate-netlist-column
        (lambda (new-gate new-source new-node anchor stacked-limit)
            (if (equal? stacked-limit 0)
                '()
                (let   ((; increment xaxis related to anchor
                         new-xaxis (+ (mosfet-xaxis anchor) 1))
                        ; increment yaxis regarding network
                        (new-yaxis (if (< (mosfet-yaxis anchor) 0)
                                        ; negative, pulldown network
                                        (- 0 stacked-limit)
                                        ; positive, pullup network
                                        stacked-limit))
                        ; calculate next intermediate node
                        (next-drain (if (= stacked-limit 1)
                                        ; use output node
                                        "Y"
                                        ; use new-node
                                        new-node))
                        ; generate new transistor
                        (new-mosfet (generate-mosfet)))
                    (begin
                        ; use same type as anchor
                        (mosfet-type! new-mosfet (mosfet-type anchor))
                        ; new-gate node
                        (mosfet-gate! new-mosfet (string-append (combine-input-num-node (string (string-ref new-gate 0)) (- stacked-limit 1))))
                        ; new-source
                        (mosfet-source! new-mosfet new-source)
                        ; new-drain
                        (mosfet-drain! new-mosfet next-drain)
                        ; use same bulk as anchor
                        (mosfet-bulk! new-mosfet (mosfet-bulk anchor))
                        ; set stacked-limit
                        (mosfet-stacked! new-mosfet stacked-limit)
                        ; set xaxis regarding calculation
                        (mosfet-xaxis! new-mosfet new-xaxis)
                        ; set yaxis regarding calculation
                        (mosfet-yaxis! new-mosfet new-yaxis)
                        ; transistor sizing
                        (mosfet-size! new-mosfet (mosfet-size anchor)) ; !! no size yet
                        ; go down for other mosfets in this column, append return values
                        (cons new-mosfet (generate-netlist-column new-gate next-drain (next-node-number (list new-node)) anchor (- stacked-limit 1))))))))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (generate-netlist-column "B1" "VDD" "N2" #("pmos" "A1" "N1" "VDD" "VDD" 2 1 2 "2g") 2)
                        '(#("pmos" "B1" "N2" "VDD" "VDD" 2 2  2 "2g")
                          #("pmos" "B"  "Y"  "N2"  "VDD" 1 2  1 "2g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " generate-netlist-column test" (current-error-port))
            (newline (current-error-port))))

;;  ------------    expand cell pu-wise     ---------------------------

;   Contract:
;   cell:expand-pu : cell -> cell

;   Purpose:
;   expand cell description by adding transistor chain in parallel to pull-up

;   Example:
;   (cell:expand-pu INV-cell)
;       => OAI21-cell

;   Definition:
    (define cell:expand-pu
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (let*  (; generate new emtpy cell
                    (return (generate-cell))
                    ; shortend netlist call
                    (org-netlist (cell-netlist cell))
                    ; search anchor mosfet
                    (anchor (find-mosfet-anchor (pulldown-network org-netlist) stacked-limit))
                    ; get complementary mosfet regarding anchor
                    (complementary (complementary-mosfets org-netlist anchor))
                    ; get next gate node
                    (1st-gate (next-input-char-node anchor))
                    ; get free node numbers
                    (1st-node (next-node-number (intermediate-nodes org-netlist)))
                    ; expand original netlist with pullup
                    (pu-netlist (append (generate-netlist-column 1st-gate (car supply-space) 1st-node anchor stacked-limit)))
                    ; get next free node
                    (2nd-node (next-node-number (intermediate-nodes pu-netlist)))
                    ; expand netlist with pulldown also and glue together
                    (new-netlist (append org-netlist pu-netlist (generate-netlist-row 1st-gate 2nd-node complementary stacked-limit))))
                (begin
                    ; check netlist regading buffer limit
                    (if (and (null? (buffer-network new-netlist)) (>= (metric-highest-stacked new-netlist) buffer-limit))
                        ; netlist is yet still not buffered but already on level
                        (cell-netlist! return (sort-netlist (expand-netlist-buffer new-netlist (car (cell-outputs cell)))))
                        ; already bufferd, set netlist only
                        (cell-netlist! return (sort-netlist new-netlist)))
                    ; set new cell-id
                    (cell-id! return cell-name)
                    ; set new cell description
                    (cell-text! return cell-descr)
                    ; set input nodes
                    (cell-inputs! return (sort-ports-descending (input-nodes (cell-netlist return))))
                    ; set output nodes
                    (cell-outputs! return (sort-ports-descending (output-nodes (cell-netlist return))))
                    ; set clock nodes
                    (cell-clocks! return (sort-ports-ascending (clock-nodes (cell-netlist return))))
                    ; set additionals
                    (cell-additional! return (ascii-art-schematic (cell-netlist return)))
                    ))))

;;  ------------    expand cell pd-wise     ---------------------------

;   Contract:
;   cell:expand-pd : cell -> cell

;   Purpose:
;   expand cell description by adding transistor chain in parallel to pull-down

;   Example:
;   (cell:expand-pd INV-cell)
;       => AOI21-cell

;   Definition:
    (define cell:expand-pd
        (lambda (cell stacked-limit buffer-limit cell-name cell-descr)
            (begin
                cell    ; !! FIXME
            )))

;   Test:   !! replace code by a portable SRFI test environemt
    (if built-in-self-test?
        (begin
            (if (equal? (cell:expand-pd INV-cell 2 3 "AOI21" "a 2-1-input AND-OR-Invert gate")
                        AOI21-cell)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell:expand-pd test" (current-error-port))
            (newline (current-error-port))))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

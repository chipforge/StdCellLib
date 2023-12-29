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
;;  File:           StdCellLib/Tools/popcorn/popcorn-lib.scm
;;
;;  Purpose:        Scheme Module - popcorn functional library
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

(define-library (popcorn-lib)
  (import (scheme base)
          (scheme char)     ; digit-value
          (scheme sort)     ; list-sort
          (scheme char)     ; string-upcase, string-downcase
          (scheme write)    ; display
          (scheme time)     ; current-second
          (srfi 152))       ; string-split
  (export  ; node spaces
           input-space      input-space?
           output-space     output-space?
           clock-space      clock-space?
           node-space       node-space?
           supply-space     supply-space?
           ground-space     ground-space?
           ; mosfet descriptions
           generate-mosfet
           mosfet-type      mosfet-type!
           mosfet-nmos?     mosfet-nmos!
           mosfet-pmos?     mosfet-pmos!
           mosfet-gate      mosfet-gate!
           mosfet-drain     mosfet-drain!
           mosfet-source    mosfet-source!
           mosfet-bulk      mosfet-bulk!
           mosfet-stacked   mosfet-stacked!
           mosfet-xaxis     mosfet-xaxis!
           mosfet-yaxis     mosfet-yaxis!
           mosfet-size      mosfet-size!
           sanity-mosfet?
           ; example cells
           INV-cell
           BUF-cell
           NAND2-cell
           NOR2-cell
           OAI21-cell
           AOI21-cell
           ; cell descriptions
           generate-cell
           cell-id          cell-id!
           cell-text        cell-text!
           cell-inputs      cell-inputs!
           cell-outputs     cell-outputs!
           cell-clocks      cell-clocks!
           cell-netlist     cell-netlist!
           cell-additional  cell-additional!
           sanity-cell?
           ; functions on netlists
           buffer-network
           pullup-network
           pulldown-network
           vdd-mosfets
           gnd-mosfets
           input-mosfets
           complementary-mosfets
           sort-mosfet-ascending
           sort-mosfet-descending
           sort-netlist
           filter-mosfet-char
           filter-mosfet-remove
           filter-mosfet-column
           filter-mosfet-row
           input-nodes
           clock-nodes
           output-nodes
           replace-nodes
           intermediate-nodes
           sort-nodes-ascending
           sort-nodes-descending
           ; metrics on netlists
           metric-tp-stacked
           metric-tn-stacked
           metric-highest-stacked
           metric-highest-xaxis
           metric-highest-yaxis
           metric-lowest-yaxis
           ; auxilary stuff
           copyleft-year
           stringlist->csv
           stringlist->mosfet)
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

;;  In principle every combinatorial cell (in CMOS technology) contains
;;  two functional complementary networks. The pull-up network - build
;;  with pmos transistors - as well as the pull-down network - build
;;  with nmos transistors.

;;  so every netlist becomes, well, a list of transistors

;;  -------------------------------------------------------------------
;;                  NODE SPACES
;;  -------------------------------------------------------------------

;;  ------------    input node names    -------------------------------

    (define input-space '(#\A #\B #\C #\D #\E #\F #\H #\I #\K #\L #\M #\P #\R #\S #\T #\U #\W))

;   Contract:
;   input-space? : list-of-ports -> boolean

;   Purpose:
;   check whether node is in defined input space for cells

;   Example:
;   (input-space? "A0") => #t
;   (input-space? "Z") => #f

;   Definition:
    (define input-space?
        (lambda (node)
            (if (memq (string-ref node 0) input-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (and (input-space? "A0") (not (input-space? "Z")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " input-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    output node names   -------------------------------

    (define output-space '(#\Q #\Y #\Z))

;   Contract:
;   output-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined output space for cells

;   Example:
;   (output-space? "A0") => #f
;   (output-space? "Z") => #t

;   Definition:
    (define output-space?
        (lambda (node)
            (if (memq (string-ref node 0) output-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (and (output-space? "Z") (not (output-space? "A0")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " output-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    clock node names    -------------------------------

    (define clock-space '(#\X))

;   Contract:
;   clock-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined clock space for cells

;   Example:
;   (clock-space? "X0") => #t

;   Definition:
    (define clock-space?
        (lambda (node)
            (if (memq (string-ref node 0) clock-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (clock-space? "X0")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " clock-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    internal node names -------------------------------

    (define node-space '(#\N))

;   Contract:
;   node-space? list-of-nodes -> boolean

;   Purpose:
;   check wether node is in defined node space for cells

;   Example:
;   (node-space? "N2") => #t

;   Definition:
    (define node-space?
        (lambda (node)
            (if (member (string-ref node 0) node-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (node-space? "N2")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " node-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    supply symbol node name space   -------------------

;   Usually, SCHEME is case-insensitive but some implementations (and R7RS) are not.
;   Hence, the member compare has a string-ci=? option.

;   Definition:
    (define supply-space (list "VDD" "VCC"))

;   Contract:
;   sypply-symbol-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined list for sypply symbols

;   Example:
;   (supply-space? "Vdd") => #t
;   (supply-space? "GND") => #f

;   Definition:
    (define supply-space?
        (lambda (node)
            (if (member node supply-space string-ci=?) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (and (supply-space? "Vdd") (not (supply-space? "gnd")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " supply-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    ground plane node name space    -------------------

;   Usually, SCHEME is case-insensitive but some implementations are not.
;   Hence, the member compare has a string-ci=? option.

;   Definition:
    (define ground-space (list "GND" "VSS"))

;   Contract:
;   ground-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined list for ground symbols

;   Example:
;   (ground-space? "gnd") => #t
;   (ground-space? "vdd") => #f

;   Definition:
    (define ground-space?
        (lambda (node)
            (if (member node ground-space string-ci=?) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (and (ground-space? "gnd") (not (ground-space? "vdd")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " ground-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define transistor as vector:        Example:
;       +---------------+
;    #0 |  circuit type |               "nmos"
;       +---------------+
;    #1 |  gate node    |               "A"
;       +---------------+
;    #2 |  drain node   |               "X"
;       +---------------+
;    #3 |  source node  |               "VDD"
;       +---------------+
;    #4 |  bulk node    |               "VDD"
;       +---------------+
;    #5 |  stacked      |               1
;       +---------------+
;    #6 |  x-axis point |               1
;       +---------------+
;    #7 |  y-axis point |               1
;       +---------------+
;    #7 |  size         |               "g"
;       +---------------+

;   define constants for vector indices
    (define |circuit-type#| 0)
    (define |gate-node#| 1)
    (define |drain-node#| 2)
    (define |source-node#| 3)
    (define |bulk-node#| 4)
    (define |stacked#| 5)
    (define |xaxis-point#| 6)
    (define |yaxis-point#| 7)
    (define |size#| 8)

;;  ------------    generate empty mosfet   ---------------------------

;   Contract:
;   generate-mosfet : -> mosfet

;   Purpose:
;   generate new and empty mosfet vector structure

;   Example:
;   (generate-mosfet) => '#()

;   Definition
    (define generate-mosfet
        (lambda ()
            (make-vector 9 "")
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (generate-mosfet) #("" "" "" "" "" "" "" "" ""))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " generate-mosfet test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-type   -------------------

;   Contract:
;   mosfet-type : mosfet -> node

;   Purpose:
;   get the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-type '#("nmos" "A" "Y" "GND" "GND" 1 1 -1)) => "nmos"

;   Definition:
    (define mosfet-type
        (lambda (mosfet)
            (vector-ref mosfet |circuit-type#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-type '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "nmos")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-type test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-type!  -------------------

;   Contract:
;   mosfet-type! : mosfet string -> mosfet

;   Purpose:
;   set the mosfet type in a mosfet description vector

;   Example:
;   (mosfet-type! '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "1") "nmos") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-type!
        (lambda (mosfet type)
            (vector-set! mosfet |circuit-type#| type)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-type! '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "1") "nmos")
                                      '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-type! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-nmos?  -------------------

;   Contract:
;   mosfet-nmos? : mosfet -> boolean

;   Purpose:
;   check the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-nmos? '#("nmos" "A" "Y" "GND" "GND" 1 1 -1)) => #t

;   Definition:
    (define mosfet-nmos?
        (lambda (mosfet)
            (equal? (vector-ref mosfet |circuit-type#|) "nmos")
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (mosfet-nmos? '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-nmos? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-nmos!  -------------------

;   Contract:
;   mosfet-nmos! : mosfet -> mosfet

;   Purpose:
;   set the mosfet type in a mosfet description vector to nmos

;   Example:
;   (mosfet-nmos! '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-nmos!
        (lambda (mosfet)
            (vector-set! mosfet |circuit-type#| "nmos")
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-nmos! '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                                      '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-nmos! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-pmos?  -------------------

;   Contract:
;   mosfet-pmos? : mosfet -> boolean

;   Purpose:
;   check the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-pmos? '#("pmos" "A" "Y" "VDD" "VDD" 1 1 -1)) => #t

;   Definition:
    (define mosfet-pmos?
        (lambda (mosfet)
            (equal? (vector-ref mosfet |circuit-type#|) "pmos")
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (mosfet-pmos? '#("pmos" "A" "Y" "VDD" "VDD" 1 1 1 "g"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-pmos? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-pmos!  -------------------

;   Contract:
;   mosfet-pmos! : mosfet -> mosfet

;   Purpose:
;   set the mosfet type in a mosfet description vector to pmos

;   Example:
;   (mosfet-pmos! '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "g")) => '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "g")

;   Definition:
    (define mosfet-pmos!
        (lambda (mosfet)
            (vector-set! mosfet |circuit-type#| "pmos")
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-pmos! '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "g"))
                                      '#("pmos" "A" "Y" "GND" "GND" 1 1 -1 "g"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-pmos! test" (current-error-port))
            (newline (current-error-port))
        )
    )
;;  ------------    getter function : mosfet-gate   -------------------

;   Contract:
;   mosfet-gate : mosfet -> node

;   Purpose:
;   get the mosfet gate node out of mosfet transistor vector

;   Example:
;   (mosfet-gate '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => "A"

;   Definition:
    (define mosfet-gate
        (lambda (mosfet)
            (vector-ref mosfet |gate-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-gate '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "A")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-gate test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-gate!  -------------------

;   Contract:
;   mosfet-gate! : mosfet string -> mosfet

;   Purpose:
;   set the mosfet gate in a mosfet description vector

;   Example:
;   (mosfet-gate! '#("nmos" "B" "Y" "GND" "GND" 1 1 -1 "1") "A") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-gate!
        (lambda (mosfet gate)
            (vector-set! mosfet |gate-node#| gate)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-gate! '#("nmos" "B" "Y" "GND" "GND" 1 1 -1 "1") "A")
                                      '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-gate! test" (current-error-port))
            (newline (current-error-port))
        )
    )
;;  ------------    getter function : mosfet-drain  -------------------

;   Contract:
;   mosfet-drain : mosfet -> node

;   Purpose:
;   get the mosfet drain node out of mosfet transistor vector

;   Example:
;   (mosfet-drain '#("nmos" "A" "Y" "VDD" "VDD" 1 1 -1 "1")) => "Y"

;   Definition:
    (define mosfet-drain
        (lambda (mosfet)
            (vector-ref mosfet |drain-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-drain '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "Y")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-drain test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-drain! -------------------

;   Contract:
;   mosfet-drain! : mosfet string -> mosfet

;   Purpose:
;   set the mosfet drain in a mosfet description vector

;   Example:
;   (mosfet-drain! '#("nmos" "A" "Z" "GND" "GND" 1 1 -1 "1") "Y") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-drain!
        (lambda (mosfet drain)
            (vector-set! mosfet |drain-node#| drain)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-drain! '#("nmos" "A" "Z" "GND" "GND" 1 1 -1 "1") "Y")
                                       '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-drain! test" (current-error-port))
            (newline (current-error-port))
        )
    )
;;  ------------    getter function : mosfet-source -------------------

;   Contract:
;   mosfet-source : mosfet -> node

;   Purpose:
;   get the mosfet source node out of mosfet transistor vector

;   Example:
;   (mosfet-source '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => "GND"

;   Definition:
    (define mosfet-source
        (lambda (mosfet)
            (vector-ref mosfet |source-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-source '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "GND")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-source test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-source!    ---------------

;   Contract:
;   mosfet-source! : mosfet string -> mosfet

;   Purpose:
;   set the mosfet source in a mosfet description vector

;   Example:
;   (mosfet-source! '#("nmos" "A" "Y" "VDD" "GND" 1 1 -1 "1") "GND") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-source!
        (lambda (mosfet source)
            (vector-set! mosfet |source-node#| source)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-source! '#("nmos" "A" "Y" "VDD" "GND" 1 1 -1 "1") "GND")
                                        '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-source! test" (current-error-port))
            (newline (current-error-port))
        )
    )
;;  ------------    getter function : mosfet-bulk   -------------------

;   Contract:
;   mosfet-bulk : mosfet -> node

;   Purpose:
;   get the mosfet bulk node out of mosfet transistor vector

;   Example:
;   (mosfet-bulk '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => "GND"

;   Definition:
    (define mosfet-bulk
        (lambda (mosfet)
            (vector-ref mosfet |bulk-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-bulk '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "GND")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-bulk test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-bulk!  -------------------

;   Contract:
;   mosfet-bulk! : mosfet string -> mosfet

;   Purpose:
;   set the mosfet bulk in a mosfet description vector

;   Example:
;   (mosfet-bulk! '#("nmos" "A" "Y" "GND" "VDD" 1 1 -1 "1") "GND") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-bulk!
        (lambda (mosfet bulk)
            (vector-set! mosfet |bulk-node#| bulk)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-bulk! '#("nmos" "A" "Y" "GND" "VDD" 1 1 -1 "1") "GND")
                                      '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-bulk! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-stacked    ---------------

;   Contract:
;   mosfet-stacked : mosfet -> number

;   Purpose:
;   get the mosfet number of stacked transistors out of mosfet transistor vector

;   Example:
;   (mosfet-stacked '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => 1

;   Definition:
    (define mosfet-stacked
        (lambda (mosfet)
            (vector-ref mosfet |stacked#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-stacked '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) 1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-stacked test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-stacked!   ---------------

;   Contract:
;   mosfet-stacked! : mosfet number -> mosfet

;   Purpose:
;   set the number of stacked transistors in a mosfet description vector

;   Example:
;   (mosfet-stacked! '#("nmos" "A" "Y" "GND" "GND" 0 1 -1 "1") 1) => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-stacked!
        (lambda (mosfet stacked)
            (vector-set! mosfet |stacked#| stacked)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-stacked! '#("nmos" "A" "Y" "GND" "GND" 0 1 -1 "1") 1)
                                         '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-stacked! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-xaxis  -------------------

;   Contract:
;   mosfet-xaxis : mosfet -> number

;   Purpose:
;   get the mosfet x-axis coordinate out of mosfet transistor vector

;   Example:
;   (mosfet-xaxis '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => 1

;   Definition:
    (define mosfet-xaxis
        (lambda (mosfet)
            (vector-ref mosfet |xaxis-point#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-xaxis '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) 1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-xaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-xaxis!     ---------------

;   Contract:
;   mosfet-xaxis! : mosfet number -> mosfet

;   Purpose:
;   set the mosfet xaxis in a mosfet description vector

;   Example:
;   (mosfet-xaxis! '#("nmos" "A" "Y" "GND" "GND" 1 0 -1 "1") 1) => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-xaxis!
        (lambda (mosfet xaxis)
            (vector-set! mosfet |xaxis-point#| xaxis)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-xaxis! '#("nmos" "A" "Y" "GND" "GND" 1 0 -1 "1") 1)
                                       '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-xaxis! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-yaxis  -------------------

;   Contract:
;   mosfet-yaxis : mosfet -> number

;   Purpose:
;   get the mosfet y-axis coordinate out of mosfet transistor vector

;   Example:
;   (mosfet-yaxis '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => -1

;   Definition:
    (define mosfet-yaxis
        (lambda (mosfet)
            (vector-ref mosfet |yaxis-point#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-yaxis '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) -1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-yaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-yaxis!     ---------------

;   Contract:
;   mosfet-yaxis! : mosfet number -> mosfet

;   Purpose:
;   set the mosfet yaxis in a mosfet description vector

;   Example:
;   (mosfet-yaxis! '#("nmos" "A" "Y" "GND" "GND" 1 0 -1 "1") 1) => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define mosfet-yaxis!
        (lambda (mosfet yaxis)
            (vector-set! mosfet |yaxis-point#| yaxis)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-yaxis! '#("nmos" "A" "Y" "GND" "GND" 1 1  0 "1") -1)
                                       '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-yaxis! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-size   -------------------

;   Contract:
;   mosfet-size: mosfet -> number

;   Purpose:
;   get the mosfet size (as multiple of standard size) out of mosfet transistor vector

;   Example:
;   (mosfet-size '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) => 1

;   Definition:
    (define mosfet-size
        (lambda (mosfet)
            (vector-ref mosfet |size#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-size '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")) "1")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-size test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : mosfet-size!      ---------------

;   Contract:
;   mosfet-size! : mosfet number -> mosfet

;   Purpose:
;   set the mosfet size in a mosfet description vector

;   Example:
;   (mosfet-size! '#("nmos" "A" "Y" "GND" "GND" 1 0 -1 0) "g") => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "g")

;   Definition:
    (define mosfet-size!
        (lambda (mosfet size)
            (vector-set! mosfet |size#| size)
            mosfet
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-size! '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "0") "g")
                                      '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "g"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-size! test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    sanity check for mosfet ---------------------------

;   Contract:
;   sanity-mosfet? : mosfet -> boolean

;   Purpose:
;   check type / sanity for well-formed transistor descriptions

;   Example:
;   (sanity-mosfet? mosfet) => #t

;   Definition
    (define sanity-mosfet?
        (lambda (mosfet)
            (if build-in-sanity-checks?
                (begin
                    ; circuit type
                    (let ((type (mosfet-type mosfet)))
                        (if (and (string? type)
                                (or (equal? type "pmos")
                                    (equal? type "nmos")))
                            #t
                            (begin
                                (display "!! insane mosfet-type check " (current-error-port))
                                (display type (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; gate nodes
                    (let ((gate (mosfet-gate mosfet)))
                        (if (and (string? gate)
                                 (or
                                    (input-space? gate)
                                    (node-space? gate)))
                            #t
                            (begin
                                (display "!! insane mosfet-gate check " (current-error-port))
                                (display gate (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; drain nodes
                    (let ((drain (mosfet-drain mosfet)))
                        (if (and (string? drain)
                                 (or (node-space? drain)
                                     (output-space? drain)))
                            #t
                            (begin
                                (display "!! insane mosfet-drain check " (current-error-port))
                                (display drain (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; source nodes
                    (let ((source (mosfet-source mosfet)))
                        (if (and (string? source)
                                 (or (node-space? source)
                                     (ground-space? source)
                                     (supply-space? source)))
                            #t
                            (begin
                                (display "!! insane mosfet-source check " (current-error-port))
                                (display source (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; bulk nodes
                    (let ((bulk (mosfet-bulk mosfet)))
                        (if (and (string? bulk)
                                 (or ;(node-space? bulk) !! we do not expect shifted bulks
                                     (ground-space? bulk)
                                     (supply-space? bulk)))
                            #t
                            (begin
                                (display "!! insane mosfet-bulk check " (current-error-port))
                                (display bulk (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; stacked transistors
                    (let ((stacked (mosfet-stacked mosfet)))
                        (if (and (integer? stacked)
                                 (> stacked 0)) ; positive
                            #t
                            (begin
                                (display "!! insane mosfet-stacked check " (current-error-port))
                                (display stacked (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; xaxis coordinates
                    (let ((xaxis (mosfet-xaxis mosfet)))
                        (if (and (integer? xaxis)
                                 (> xaxis 0)) ; positive
                            #t
                            (begin
                                (display "!! insane mosfet-xaxis check " (current-error-port))
                                (display xaxis (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; yaxis coordinates
                    (let ((yaxis (mosfet-yaxis mosfet)))
                        (if (integer? yaxis) ; positive as well as negative
                            #t
                            (begin
                                (display "!! insane mosfet-yaxis check " (current-error-port))
                                (display yaxis (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; transistor size
                    (let ((size (mosfet-size mosfet)))
                        (if (string? size)
                            #t
                            (begin
                                (display "!! insane mosfet-size check " (current-error-port))
                                (display size (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                )
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  EXAMPLE CELLS
;;  -------------------------------------------------------------------

;;  ------------    Example : INV-cell  -------------------------------

;               ^ Vdd
;               |
;           | --+
;      A --o| |   g
;           | --+
;               |
;               *---- Y
;               |
;           | --+
;      A ---| |   1
;           | --+
;               |
;              _|_ Gnd

    (define INV-cell '#("INV" "a Not (or Inverter) gate"
                        ("A") ("Y") ()
                        (#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
                         #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                        ())
    )

;;  ------------    Example : BUF-cell  -------------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A --o| |   g         +--o| |   g
;           | --+           |   | --+
;               |           |       |
;               *-----------*       *---- Z
;               |           |       |
;           | --+           |   | --+
;      A ---| |   1         +---| |   1
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define BUF-cell '#("BUF" "a non-inverting Buffer gate"
                        ("A") ("Z") ()
                        (#("pmos" "N1" "Z" "VDD" "VDD" 1 2  1 "g")
                         #("nmos" "N1" "Z" "GND" "GND" 1 2 -1 "1")
                         #("pmos" "A" "N1" "VDD" "VDD" 1 1  1 "g")
                         #("nmos" "A" "N1" "GND" "GND" 1 1 -1 "1"))
                        ())
    )

;;  ------------    Example : NAND2-cell    ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A --o| |   g        B --o| |   g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |
;           | --+
;      A ---| |   2
;           | --+
;               | N2
;               |
;           | --+
;      B ---| |   2
;           | --+
;               |
;              _|_ Gnd

    (define NAND2-cell '#("NAND2" "a 2-input Not-AND (or NAND) gate"
                          ("B" "A") ("Y") ()
                          (#("pmos" "B" "Y"  "VDD" "VDD" 1 2  1 "g")
                           #("pmos" "A" "Y"  "VDD" "VDD" 1 1  1 "g")
                           #("nmos" "A" "Y"  "N2"  "GND" 1 1 -1 "2")
                           #("nmos" "B" "N2" "GND" "GND" 2 1 -2 "2"))
                          ())
    )

;;  ------------    Example : NOR2-cell     ---------------------------

;               ^ Vdd
;               |
;           | --+
;      B --o| |   2g
;           | --+
;               |
;               | N1
;           | --+
;      A --o| |   2g
;           | --+
;               |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   1        B ---| |   1
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define NOR2-cell '#("NOR2" "a 2-input Not-OR (or NOR) gate"
                         ("B" "A") ("Y") ()
                         (#("pmos" "B" "N1" "VDD" "VDD" 2 1  2 "2g")
                          #("pmos" "A" "Z"  "N1"  "VDD" 1 1  1 "2g")
                          #("nmos" "A" "Y"  "GND" "GND" 1 1 -1 "1")
                          #("nmos" "B" "Y"  "GND" "GND" 1 2 -1 "1"))
                         ())
    )

;;  ------------    Example : OAI21-cell    ---------------------------

;                                   ^ Vdd
;                                   |
;                               | --+
;                         B1 --o| |   2g
;                               | --+
;               ^ Vdd               |
;               |                   | N1
;           | --+               | --+
;      A --o| |   g       B0 --o| |   2g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |
;           | --+
;      A ---| |   2
;           | --+
;               | N2
;               *-------------------*
;               |                   |
;           | --+               | --+
;     B0 ---| |   2       B1 ---| |   2
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define OAI21-cell '#("OAI21" "a 2-1-input OR-AND-Invert (or OAI) gate"
                          ("B1" "B0" "A") ("Y") ()
                          (#("pmos" "B1" "N1" "VDD" "VDD" 2 2  2 "2g")
                           #("pmos" "B0" "Y"  "N1"  "VDD" 1 2  1 "2g")
                           #("pmos" "A" "Y"   "VDD" "VDD" 1 1  1 "g")
                           #("nmos" "A" "Y"   "N2"  "GND" 1 1 -1 "2")
                           #("nmos" "B0" "N2" "GND" "GND" 2 1 -2 "2")
                           #("nmos" "B1" "N2" "GND" "GND" 2 2 -2 "2"))
                          ())
    )

;;  ------------    Example : AOI21-cell    ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;     B0 --o| |   2g      B1 --o| |   2g
;           | --+               | --+
;               | N1                |
;               *-------------------*
;               |
;           | --+
;      A --o| |   2g
;           | --+
;               |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   1       B0 ---| |   2
;           | --+               | --+
;               |                   |
;              _|_ Gnd              | N2
;                               | --+
;                         B1 ---| |   2
;                               | --+
;                                   |
;                                  _|_ Gnd

    (define AOI21-cell '#("AOI21" "a 2-1-input AND-OR-Invert (or AOI) gate"
                          ("B1" "B0" "A") ("Y") ()
                          (#("pmos" "B1" "N1" "VDD" "VDD" 2 2  2 "2g")
                           #("pmos" "B0" "Y"  "N1"  "VDD" 2 1  2 "2g")
                           #("pmos" "A"  "Y"  "VDD" "VDD" 1 1  1 "2g")
                           #("nmos" "A"  "Y"  "GND" "GND" 1 1 -1 "1")
                           #("nmos" "B0" "Y"  "N2"  "GND" 2 2 -1 "2")
                           #("nmos" "B1" "N2" "GND" "GND" 2 2 -2 "2"))
                          ())
    )

;;  -------------------------------------------------------------------
;;                  CELL DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define cell as vector:
;       +---------------+
;    #0 |  cell id      |               "INV"
;       +---------------+
;    #1 |  cell text    |               "a Not (or Inverter) gate"
;       +---------------+
;    #2 |  cell inputs  |               '("A")
;       +---------------+
;    #3 |  cell outputs |               '("Y")
;       +---------------+
;    #4 |  cell clocks  |               '() ; for latches
;       +---------------+
;    #5 |  netlist      |               '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
;       +---------------+                 #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
;    #6 |  additional   |               '() ; e.g. handover ASCII-Art
;       +---------------+

;   define constants for vector indices
    (define |cell-id#| 0)
    (define |cell-text#| 1)
    (define |cell-inputs#| 2)
    (define |cell-outputs#| 3)
    (define |cell-clocks#| 4)
    (define |cell-netlist#| 5)
    (define |cell-additional#| 6)

;;  ------------    generate empty cell     ---------------------------

;   Contract:
;   generate-cell : -> cell

;   Purpose:
;   generate new and empty cell vector structure

;   Example:
;   (generate-cell) => '#()

;   Definition
    (define generate-cell
        (lambda ()
            (make-vector 7 '())
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (generate-cell) #(() () () () () () ()))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " generate-cell test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : cell-id   -----------------------

;   Contract:
;   cell-id : cell -> string

;   Purpose:
;   get the cell ID out of a cell description vector

;   Example:
;   (cell-id INV-cell) => "INV"

;   Definitions:
    (define cell-id
        (lambda (cell)
            (vector-ref cell |cell-id#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-id INV-cell) "INV")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-id test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-id!  -----------------------

;   Contract:
;   cell-id! : cell string -> cell

;   Purpose:
;   set the cell ID in a cell description vector

;   Example:
;   (cell-id! INV-cell "INV") => INV-cell

;   Definitions:
    (define cell-id!
        (lambda (cell id)
            (vector-set! cell |cell-id#| id)
            cell
        )
    )

;;  ------------    getter function : cell-text     -------------------

;   Contract:
;   cell-text : cell -> string

;   Purpose:
;   get the cell description out of a cell description vector

;   Example:
;   (cell-text INV-cell) => "a Not (or Inverter) gate"

;   Definition:
    (define cell-text
        (lambda (cell)
            (vector-ref cell |cell-text#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-text INV-cell) "a Not (or Inverter) gate")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-text test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-text!    -------------------

;   Contract:
;   cell-text! : cell string -> cell

;   Purpose:
;   set the cell description in a cell description vector

;   Example:
;   (cell-text! INV-cell "a Not (or Inverter) gate") => INV-cell

;   Definition:
    (define cell-text!
        (lambda (cell text)
            (vector-set! cell |cell-text#| text)
            cell
        )
    )

;;  ------------    getter function : cell-inputs   -------------------

;   Contract:
;   cell-inputs : cell -> list-of-strings

;   Purpose:
;   get the cell input list out of a cell description vector

;   Example:
;   (cell-inputs INV-cell) => '("A")

;   Definition:
    (define cell-inputs
        (lambda (cell)
            (vector-ref cell |cell-inputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-inputs INV-cell) '("A"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-inputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-inputs!  -------------------

;   Contract:
;   cell-inputs! : cell list-of-strings -> cell

;   Purpose:
;   set the cell input list in a cell description vector

;   Example:
;   (cell-inputs! INV-cell '("A")) => INV-cell

;   Definition:
    (define cell-inputs!
        (lambda (cell list-of-inputs)
            (vector-set! cell |cell-inputs#| list-of-inputs)
            cell
        )
    )

;;  ------------    getter function : cell-outputs  -------------------

;   Contract:
;   cell-outputs : cell -> list-of-strings

;   Purpose:
;   get the cell output list out of a cell description vector

;   Example:
;   (cell-outputs INV-cell) => '("Y")

;   Definition:
    (define cell-outputs
        (lambda (cell)
            (vector-ref cell |cell-outputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-outputs INV-cell) '("Y"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-outputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-outputs! -------------------

;   Contract:
;   cell-outputs! : cell list-of-strings -> cell

;   Purpose:
;   set the cell output list of a cell description vector

;   Example:
;   (cell-outputs! INV-cell '("Y")) => INV-cell

;   Definition:
    (define cell-outputs!
        (lambda (cell list-of-strings)
            (vector-set! cell |cell-outputs#| list-of-strings)
            cell
        )
    )

;;  ------------    getter function : cell-clocks   -------------------

;   Contract:
;   cell-clocks : cell -> list-of-strings

;   Purpose:
;   get the cell clock list out of a cell description vector

;   Example:
;   (cell-clocks INV-cell) => '()

;   Definition:
    (define cell-clocks
        (lambda (cell)
            (vector-ref cell |cell-clocks#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-clocks INV-cell) '())
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-clocks test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-clocks!  -------------------

;   Contract:
;   cell-clocks! : cell list-of-symbols -> cell

;   Purpose:
;   set the cell clock in a cell description vector

;   Example:
;   (cell-clocks! INV-cell '()) => INV-cell

;   Definition:
    (define cell-clocks!
        (lambda (cell list-of-symbols)
            (vector-set! cell |cell-clocks#| list-of-symbols)
            cell
        )
    )

;;  ------------    getter function : cell-netlist  -------------------

;   Contract:
;   cell-netlist : cell -> netlist

;   Purpose:
;   get the netlist out of a cell description vector

;   Example:
;   (cell-netlist INV-cell) => '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))

;   Definition:
    (define cell-netlist
        (lambda (cell)
            (vector-ref cell |cell-netlist#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-netlist INV-cell) '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
                                                  #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-netlist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-netlist!     ---------------

;   Contract:
;   cell-netlist! : cell netlist -> cell

;   Purpose:
;   set the netlist in a cell description vector

;   Example:
;   (cell-netlist! INV-cell '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
;                             #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))) => INV-cell

;   Definition:
    (define cell-netlist!
        (lambda (cell netlist)
            (vector-set! cell |cell-netlist#| netlist)
            cell
        )
    )

;;  ------------    getter function : cell-additional   ---------------

;   Contract:
;   cell-additional : cell -> list-of-strings

;   Purpose:
;   get additional informations for the cell out of a cell description vector

;   Example:
;   (cell-additional INV-cell) => '()

;   Definition:
    (define cell-additional
        (lambda (cell)
            (vector-ref cell |cell-additional#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (cell-additional INV-cell) '())
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-additional test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-additional!  ---------------

;   Contract:
;   cell-additional! : cell list-of-strings -> cell

;   Purpose:
;   set additional informations in a cell description vector

;   Example:
;   (cell-additional! INV-cell '()) => INV-cell

;   Definition:
    (define cell-additional!
        (lambda (cell list-of-symbols)
            (vector-set! cell |cell-additional#| list-of-symbols)
            cell
        )
    )

;;  ------------    sanity check for netlist    -----------------------

;   Contract:
;   sanity-netlist? : netlist -> boolean

;   Purpose:
;   check sanity for well-formed netlist

;   Example:
;   (sanity-netlist? (cell-netlist INV-cell)) => #t

;   Definition
    (define sanity-netlist?
        (lambda (netlist)
            (if build-in-sanity-checks?
                (if (and (list? netlist)
                        ; at least one list member
                        (> (length netlist) 0)
                        ; (every) member has to be a mosfet
                        (sanity-mosfet? (car netlist)))
                    #t
                    (begin
                        (display "!! insane cell-netlist check " (current-error-port))
                        (display netlist (current-error-port))
                        (newline (current-error-port))
                        #f
                    )
                )
            )
        )
    )

;;  ------------    sanity check for cell   ---------------------------

;   Contract:
;   sanity-cell? : cell -> boolean

;   Purpose:
;   check type / sanity for well-formed cell vector descriptions

;   Example:
;   (sanity-cell? INV-cell) => #t

;   Definition
    (define sanity-cell?
        (lambda (cell)
            (if build-in-sanity-checks?
                (begin
                    ; cell-id
                    (let ((id (cell-id cell)))
                        (if (and (string? id)
                                 ; one word only
                                 (= (length (string-split id #[ ])) 1))
                            #t
                            (begin
                                (display "!! insane cell-id check " (current-error-port))
                                (display id (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; cell-text
                    (let ((text (cell-text cell)))
                        (if (and (string? text)
                                 ; at least one word
                                 (> (length (string-split text #[ ])) 0))
                            #t
                            (begin
                                (display "!! insane cell-text check " (current-error-port))
                                (display text (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; cell-inputs
                    (let ((inputs (cell-inputs cell)))
                        (if (and (list? inputs)
                                 ; at least one list member
                                 (> (length inputs) 0) ; !! filler-cells w/o inputs !!
                                 ; (every) member has to be string
                                 (string? (car inputs)))
                            #t
                            (begin
                                (display "!! insane cell-inputs check " (current-error-port))
                                (display inputs (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; cell-outputs
                    (let ((outputs (cell-outputs cell)))
                        (if (and (list? outputs)
                                 ; at least one list member
                                 (> (length outputs) 0) ; !! filler-cells w/o outputs !!
                                 ; (every) member has to be string
                                 (string? (car outputs)))
                            #t
                            (begin
                                (display "!! insane cell-outputs check " (current-error-port))
                                (display outputs (current-error-port))
                                (newline (current-error-port))
                                #f
                            )
                        )
                    )
                    ; cell-clocks
                    (let ((clocks (cell-clocks cell)))
                        (if (list? clocks)
                            ; at least one list member
                            (if (null? clocks)
                                #t
                                (if (string? (car clocks)) ; (every) member has to be string
                                    #t
                                    (begin
                                        (display "!! insane cell-clocks check " (current-error-port))
                                        (display clocks (current-error-port))
                                        (newline (current-error-port))
                                        #f
                                    )
                                )
                            )
                        )
                    )
                    ; cell-netlist
                    (sanity-netlist? (cell-netlist cell))
                    ; cell-additional
                )
            )
        )
    )

    (sanity-cell? INV-cell)
    (sanity-cell? NAND2-cell)
    (sanity-cell? NOR2-cell)
    (sanity-cell? OAI21-cell)
    (sanity-cell? AOI21-cell)

;;  -------------------------------------------------------------------
;;                  FUNCTIONS on NETLISTs
;;  -------------------------------------------------------------------

;;  ------------    filter network for output buffer    ---------------

;   Contract:
;   buffer-network : netlist -> netlist

;   Purpose:
;   get network with buffering transistors only

;   Example:
;   (buffer-network (cell-netlist BUF-cell)) => '(#("pmos" "N1" "Z" "VDD" "VDD" 1 2  1 "g")
;                                                 #("nmos" "N1" "Z" "GND" "GND" 1 2 -1 "1"))
;   Definition:
    (define buffer-network
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; mosfet belongs to output, append
                [(equal? (mosfet-drain (car netlist)) "Z")
                    (cons (car netlist) (buffer-network (cdr netlist)))]

                ; mosfet does not drive output, go down
                [else
                    (buffer-network (cdr netlist))]
            )
        )
    )

    ;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (buffer-network (cell-netlist BUF-cell)) '(#("pmos" "N1" "Z" "VDD" "VDD" 1 2  1 "g") #("nmos" "N1" "Z" "GND" "GND" 1 2 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " buffer-network test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter network for pull-up      -------------------

;   Contract:
;   pullup-network : netlist -> netlist

;   Purpose:
;   get network with pull-up transistors only

;   Example
;   (pullup-network (cell-netlist INV-cell)) => #('pmos "A" "Y" "VDD" 'VDD" 1 1 1 "g")

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define pullup-network
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; exclude mosfet which buffers output, go down
                [(eqv? (mosfet-drain (car netlist)) "Z")
                    (pullup-network (cdr netlist))]

                ; if pMOS than add mosfet to netlist, go down recursive
                [(mosfet-pmos? (car netlist))
                    (cons (car netlist) (pullup-network (cdr netlist)))]

                ; just go down
                [else (pullup-network (cdr netlist))]
            )
        )
    )

    ;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (pullup-network (cell-netlist INV-cell)) '(#("pmos" "A" "Y" "VDD" "VDD" 1 1 1 "g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " pullup-network test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter network for pull-down    -------------------

;   Contract:
;   pulldown-network : netlist -> netlist

;   Purpose:
;   get network with pull-down transistors only

;   Example:
;   (pulldown-network (cell-netlist INV-cell)) => #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define pulldown-network
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; exclude mosfet which buffers output, go down
                [(eqv? (mosfet-drain (car netlist)) "Z")
                    (pullup-network (cdr netlist))]

                ; if nMOS than add mosfet to netlist, go down recursive
                [(mosfet-nmos? (car netlist))
                    (cons (car netlist) (pulldown-network (cdr netlist)))]

                ; just go down
                [else (pulldown-network (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (pulldown-network (cell-netlist INV-cell)) '(#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " pulldown-network test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for VDD connected transistors    -----------

;   Contract:
;   vdd-mosfets : netlist -> netlist

;   Purpose:
;   get all transistors which are connected to VDD

;   Example:
;   (vdd-mosfets (cell-netlist INV-cell)) => #("pmos" "A" "Y" "VDD" "VDD" 1 1 1 "g")

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define vdd-mosfets
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to supply power symbol, add them to netlist and go down recursive
                [(supply-space? (mosfet-source (car netlist)))
                    (cons (car netlist) (vdd-mosfets (cdr netlist)))]

                ; just go down
                [else (vdd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (vdd-mosfets (cell-netlist INV-cell)) '(#("pmos" "A" "Y" "VDD" "VDD" 1 1 1 "g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " vdd-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for GND connected transistors    -----------

;   Contract:
;   gnd-mosfets : netlist -> netlist

;   Purpose:
;   get all transistors which are connected to GND

;   Example:
;   (gnd-mosfets (cell-netlist INV-cell)) => #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define gnd-mosfets
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to ground plane symbol, add them to netlist and go down recursive
                [(ground-space? (mosfet-source (car netlist)))
                    (cons (car netlist) (gnd-mosfets (cdr netlist)))]

                ; just go down
                [else (gnd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (gnd-mosfets (cell-netlist INV-cell)) '(#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " gnd-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for input connected transistors  -----------

;   Contract:
;   input-mosfets : netlist node -> netlist

;   Purpose:
;   get all transistors which are connected to input

;   Example:
;   (input-mosfets (cell-netlist INV-cell) "A") => INV-cell

;   Note
;   Implementation with (map) or (filter) are better?

;   Definitions:
    (define input-mosfets
        (lambda (netlist node)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to input node, add them to netlist and go down recursive
                [(equal? (mosfet-gate (car netlist)) node)
                    (cons (car netlist) (input-mosfets (cdr netlist) node))]

                ; just go down
                [else (input-mosfets (cdr netlist) node)]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (input-mosfets (cell-netlist INV-cell) "A") (cell-netlist INV-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " input-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for node connected transistors   -----------

;   Contract:
;   complementary-mosfets : netlist transtistor -> netlist

;   Purpose:
;   get complementary transistors which is connected to the same input

;   Example:
;   (complementary-mosfets (cell-netlist INV-cell) #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")) => #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")

;   Definition:
    (define complementary-mosfets
        (lambda (netlist mosfet)
            (let ((input (mosfet-gate mosfet)))
                (cond
                    ; pmos? get first transistor out-of-list
                    [(mosfet-pmos? mosfet)
                        (car (input-mosfets (pulldown-network netlist) input))]

                    ; nmos? get first transistor out-of-list
                    [(mosfet-nmos? mosfet)
                        (car (input-mosfets (pullup-network netlist) input))]

                    ; unknown circuit
                    [else #f]
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (complementary-mosfets (cell-netlist INV-cell) #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")) #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " complementary-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    mosfets<? operator  -------------------------------

;   Purpose:
;   sort-operator for sort-mosfet-ascending

    (define mosfet<?
        (lambda (kar kdr)
            (string-ci<? (mosfet-gate kar) (mosfet-gate kdr))
        )
    )

;;  ------------    mosfets>? operator  -------------------------------

;   Purpose:
;   sort-operator for sort-mosfet-descending

    (define mosfet>?
        (lambda (kar kdr)
            (string-ci>? (mosfet-gate kar) (mosfet-gate kdr))
        )
    )

;;  ------------    sort mosfets ascending  ---------------------------

;   Contract:
;   sort-mosfet-ascending : netlist -> netlist

;   Purpose:
;   sort all transistors regarding their names

;   Example:
;   (sort-mosfet-ascending '(#("nmos" "B" "N2" "GND" "GND" 2 1 -2 "2") #("nmos" "A" "Y"  "N2" GND 1 1 -1 "2"))) => (pulldown-network (cell-netlist NAND2-cell))

;   Definition:
    (define sort-mosfet-ascending
        (lambda (netlist)
            (list-sort mosfet<? netlist)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (sort-mosfet-ascending '(#("nmos" "B" "N2" "GND" "GND" 2 1 -2 "2") #("nmos" "A" "Y" "N2" "GND" 1 1 -1 "2"))) (pulldown-network (cell-netlist NAND2-cell)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-mosfet-ascending test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    sort mosfets descending     -----------------------

;   Contract:
;   sort-mosfets-desscending : netlist -> netlist

;   Purpose:
;   sort all transistors regarding their names

;   Example:
;   (sort-mosfet-descending '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g"))) => (pullup-network (cell-netlist NAND2-cell))

;   Definition:
    (define sort-mosfet-descending
        (lambda (netlist)
            (list-sort mosfet>? netlist)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (sort-mosfet-descending '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g"))) (pullup-network (cell-netlist NAND2-cell)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-mosfet-descending test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    sort netlist    -----------------------------------

;   Contract:
;   sort-netlist : netlist -> netlist

;   Purpose:
;   sort pullup network descending, pulldown network ascending

;   Example:
;   (sort-netlist '(#())) => (cell-netlist NAND2-cell)

;   Definition;
    (define sort-netlist
        (lambda (netlist)
            (let ((pullup (sort-mosfet-descending (pullup-network netlist)))
                  (pulldown (sort-mosfet-ascending (pulldown-network netlist))))
                (append pullup pulldown)
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (sort-netlist '(#("pmos" "B" "Y"  "VDD" "VDD" 1 2  1 "g")
                                        #("pmos" "A" "Y"  "VDD" "VDD" 1 1  1 "g")
                                        #("nmos" "A" "Y"  "N2"  "GND" 1 1 -1 "2")
                                        #("nmos" "B" "N2" "GND" "GND" 2 1 -2 "2"))) (cell-netlist NAND2-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-netlist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter mosfets with char-group nodes    -----------

;   Contract:
;   filter-mosfet-char : netlist node -> netlist

;   Purpose:
;   filter all transistors regarding one char group

;   Example:
;   (filter-mosfet-char '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g")) "A") => '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("nmos" "A" "Y" "N2" "GND" 1 1 -1 "2"))

;   Definition:
    (define filter-mosfet-char
        (lambda (netlist node)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ; if mosfet connected to node group, add them to netlist and go down recursive
                [(equal? (string-ref (mosfet-gate (car netlist)) 0) (string-ref node 0))
                    (cons (car netlist) (filter-mosfet-char (cdr netlist) node))]

                ; just go down
                [else (filter-mosfet-char (cdr netlist) node)]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (filter-mosfet-char (cell-netlist NAND2-cell) "A") '(#("pmos" "A" "Y"  "VDD" "VDD" 1 1  1 "g") #("nmos" "A" "Y"  "N2"  "GND" 1 1 -1 "2")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " filter-mosfet-char" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter mosfet out with char-group nodes -----------

;   Contract:
;   filter-mosfet-remove : netlist node -> netlist

;   Purpose:
;   filter all transistors out with similiar node group

;   Example:
;   (filter-mosfet-remove '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g")) "B") => '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g"))

;   Definition:
    (define filter-mosfet-remove
        (lambda (netlist node)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ; if mosfet connected to input node, ignore and go down recursive
                [(equal? (string-ref (mosfet-gate (car netlist)) 0) (string-ref node 0))
                    (filter-mosfet-remove (cdr netlist) node)]

                ; add mosfet to netlist, and go down
                [else (cons (car netlist) (filter-mosfet-remove (cdr netlist) node))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (filter-mosfet-remove (cell-netlist AOI21-cell) "B1") '(#("pmos" "A" "Y"  "VDD" "VDD" 1 1  1 "2g") #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " filter-mosfet-remove" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter mosfet regarding column number   -----------

;   Contract:
;   filter-mosfet-column : netlist column -> netlist

;   Purpose:
;   return all transistors in one column

;   Example:
;   (filter-mosfet-column '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 1) #("pmos" "B" "Y" "VDD" "VDD" 1 1  2 "g")) 2) => '(#("pmos" "B" "Y" "VDD" "VDD" 1 1  2 "g"))

;   Definition:
    (define filter-mosfet-column
        (lambda (netlist column)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ; if mosfet placed on this column, add them to netlist and go down recursive
                [(= (mosfet-xaxis (car netlist)) column)
                    (cons (car netlist) (filter-mosfet-column (cdr netlist) column))]

                ; just go down
                [else (filter-mosfet-column (cdr netlist) column)]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (filter-mosfet-column (cell-netlist NAND2-cell) 2) '(#("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " filter-mosfet-column" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter mosfet regarding row number  ---------------

;   Contract:
;   filter-mosfet-row : netlist row -> netlist

;   Purpose:
;   return all transistors in one row

;   Example:
;   (filter-mosfet-row '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g")) 1) => '(#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g") #("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g"))

;   Definition:
    (define filter-mosfet-row
        (lambda (netlist row)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ; if mosfet placed on this row, add them to netlist and go down recursive
                [(= (mosfet-yaxis (car netlist)) row)
                    (cons (car netlist) (filter-mosfet-row (cdr netlist) row))]

                ; just go down
                [else (filter-mosfet-row (cdr netlist) row)]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (filter-mosfet-row (cell-netlist NAND2-cell) 1) '(#("pmos" "B" "Y" "VDD" "VDD" 1 2  1 "g") #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " filter-mosfet-row" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for input nodes  ---------------------------

;   Contract:
;   input-nodes : netlist -> list-of-nodes

;   Purpose:
;   filter all input nodes from network into one list

;   Example:
;   (input-nodes (cell-netlist INV-Cell)) => '("A")

;   Definition:
    (define input-nodes
        (lambda (netlist)
            (if (null? netlist)
                ; emtpy list?
                netlist
                (let ((node (mosfet-gate (car netlist)))
                      (feedback (input-nodes (cdr netlist))))
                    (cond
                        ; node on gate in input-space?
                        [(and (input-space? node) (not (member node feedback)))
                                (cons node feedback)
                        ]

                        ; just go down
                        [else (input-nodes (cdr netlist))]
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (input-nodes (cell-netlist NOR2-cell)) '("A" "B"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " input-nodes test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    replace node on all occurrencies    ---------------

;   Contract:
;   replace-nodes : netlist node node -> netlist

;   Purpose:
;   crawl netlist for nodes and replace them by another name

;   Example:
;   (replace-nodes (cell-netlist INV-cell) "Y" "Z") => '(#("pmos" "A" "Z" "VDD" "VDD" 1 1  1 "g")
;                                                        #("nmos" "A" "Z" "GND" "GND" 1 1 -1 "1"))

;   Definition:
    (define replace-nodes
        (lambda (netlist old-node new-node)
            (if (null? netlist)
                netlist
                (let ((original (car netlist))
                      (mosfet (generate-mosfet)))
                    (begin
                        (mosfet-type! mosfet (mosfet-type original))
                        (if (equal? (mosfet-gate original) old-node)
                            (mosfet-gate! mosfet new-node)
                            (mosfet-gate! mosfet (mosfet-gate original)))
                        (if (equal? (mosfet-source original) old-node)
                            (mosfet-source! mosfet new-node)
                            (mosfet-source! mosfet (mosfet-source original)))
                        (if (equal? (mosfet-drain original) old-node)
                            (mosfet-drain! mosfet new-node)
                            (mosfet-drain! mosfet (mosfet-drain original)))
                        (if (equal? (mosfet-bulk original) old-node)
                            (mosfet-bulk! mosfet new-node)
                            (mosfet-bulk! mosfet (mosfet-bulk original)))
                        (mosfet-stacked! mosfet (mosfet-stacked original))
                        (mosfet-xaxis! mosfet (mosfet-xaxis original))
                        (mosfet-yaxis! mosfet (mosfet-yaxis original))
                        (mosfet-size! mosfet (mosfet-size original))
                        (cons mosfet (replace-nodes (cdr netlist) old-node new-node))
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (replace-nodes (cell-netlist INV-cell)  "Y" "Z") '(#("pmos" "A" "Z" "VDD" "VDD" 1 1  1 "g")
                                                                           #("nmos" "A" "Z" "GND" "GND" 1 1 -1 "1")))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " replace-nodes test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for intermediate nodes   -------------------

;   Contract:
;   intermediate-nodes : netlist -> list-of-nodes

;   Purpose:
;   filter all internal / intermediate nodes from network into one list

;   Example:
;   (intermediate-nodes (cell-netlist INV-Cell)) => '()
;   (intermediate-nodes (cell-netlist NOR2-Cell)) => '("N1")

;   Definition:
    (define intermediate-nodes
        (lambda (netlist)
            (if (null? netlist)
                ; emtpy list?
                netlist
                (let ((node (mosfet-drain (car netlist)))
                      (feedback (intermediate-nodes (cdr netlist))))
                    (cond
                        ; node on drain in node-space?
                        [(and (node-space? node) (not (member node feedback)))
                                (cons node feedback)
                        ]

                        ; just go down
                        [else (intermediate-nodes (cdr netlist))]
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (intermediate-nodes (cell-netlist NOR2-cell)) '("N1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " intermediate-nodes test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for clock nodes  ---------------------------

;   Contract:
;   clock-node : netlist -> list-of-nodes

;   Purpose:
;   filter all clock nodes from network into one list

;   Example:
;   (clock-nodes (cell-netlist INV-Cell)) => '()

;   Definition:
    (define clock-nodes
        (lambda (netlist)
            (if (null? netlist)
                ; emtpy list?
                netlist
                (let ((node (mosfet-drain (car netlist)))
                      (feedback (clock-nodes (cdr netlist))))
                    (cond
                        ; node on input in clock-space?
                        [(and (clock-space? node) (not (member node feedback)))
                                (cons node feedback)
                        ]

                        ; just go down
                        [else (clock-nodes (cdr netlist))]
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (clock-nodes (cell-netlist INV-cell)) '())
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " clock-nodes test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for output nodes ---------------------------

;   Contract:
;   output-node : netlist -> list-of-nodes

;   Purpose:
;   filter all output nodes from network into one list

;   Example:
;   (output-nodes (cell-netlist INV-Cell)) => '("Y")

;   Definition:
    (define output-nodes
        (lambda (netlist)
            (if (null? netlist)
                ; emtpy list?
                netlist
                (let ((node (mosfet-drain (car netlist)))
                      (feedback (output-nodes (cdr netlist))))
                    (cond
                        ; node on input in output-space?
                        [(and (output-space? node) (not (member node feedback)))
                                (cons node feedback)
                        ]

                        ; just go down
                        [else (output-nodes (cdr netlist))]
                    )
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (output-nodes (cell-netlist INV-cell)) '("Y"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " output-nodes test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    <node operator  -----------------------------------

    (define <node
        (lambda (kar kdr)
            (let ((length-1st (string-length kar))
                  (length-2nd (string-length kdr)))
                (cond
                    ; 1st name is shorter than 2nd
                    [(< length-1st length-2nd) #t]
                    ; 1st name is longer than 2nd
                    [(> length-1st length-2nd) #f]
                    ; character of 1st name is smaller than 2nd
                    [(< (char->integer (string-ref kar 0)) (char->integer (string-ref kdr 0))) #t]
                    [else
                        (if (> length-1st 1)
                            ; check numbers
                            (< (string->number (substring kar 1 length-1st)) (string->number (substring kdr 1 length-2nd)))
                            ; otherwise false
                            #f)
                    ]
                )
            )
        )
    )

;;  ------------    >node operator  -----------------------------------

    (define >node
        (lambda (kar kdr)
            (let ((length-1st (string-length kar))
                  (length-2nd (string-length kdr)))
                (cond
                    ; 1st name is longer than 2nd
                    [(> length-1st length-2nd) #t]
                    ; 1st name is shorter than 2nd
                    [(< length-1st length-2nd) #f]
                    ; character of 1st name is bigger than 2nd
                    [(> (char->integer (string-ref kar 0)) (char->integer (string-ref kdr 0))) #t]
                    [else
                        (if (> length-1st 1)
                            ; check numbers
                            (> (string->number (substring kar 1 length-1st)) (string->number (substring kdr 1 length-2nd)))
                            ; otherwise false
                            #f)
                    ]
                )
            )
        )
    )

;;  ------------    sort nodes descending   ---------------------------

;   Contract:
;   sort-nodes-desscending : node-list -> node-list

;   Purpose:
;   sort all nodes regarding their names

;   Example:
;   (sort-nodes-descending '("N1" "N2" "N3")) => '("N3" "N2" "N1")

;   Definition:
    (define sort-nodes-descending
        (lambda (nodelist)
            (list-sort >node nodelist)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (sort-nodes-descending '("N1" "N2" "N3")) '("N3" "N2" "N1"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-nodes-descending test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    sort nodes ascending    ---------------------------

;   Contract:
;   sort-nodes-ascending : node-list -> node-list

;   Purpose:
;   sort all nodes regarding their names

;   Example:
;   (sort-nodes-ascending '("N3" "N2" "N1")) => '("N1" "N2" "N3")

;   Definition:
    (define sort-nodes-ascending
        (lambda (nodelist)
            (list-sort <node nodelist)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (sort-nodes-ascending '("N3" "N2" "N1")) '("N1" "N2" "N3"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-nodes-ascending test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  METRICS ON NETLISTS
;;  -------------------------------------------------------------------

;;  ------------    stacked pmos transistors    -----------------------

;   Contract:
;   metric-tp-stacked : netlist -> number

;   Purpose:
;   crawl netlist and get highest number of stacked pmos transistors

;   Example:
;   (metric-tp-stacked (cell-netlist OAI21-cell)) => 2

;   Definition:
    (define metric-tp-stacked
        (lambda (netlist)
            (cond
                [(null? netlist) 0]
                [(mosfet-nmos? (car netlist))
                    ; do not check nmos transistors for tp
                    (metric-tp-stacked (cdr netlist))]
                [else
                    (let ((stacked (mosfet-stacked (car netlist))))
                        (max stacked (metric-tp-stacked (cdr netlist)))
                    )
                ]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-tp-stacked (cell-netlist OAI21-cell)) 2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-tp-stacked test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    stacked nmos transistors    -----------------------

;   Contract:
;   metric-tn-stacked : netlist -> number

;   Purpose:
;   crawl netlist and get highest number of stacked nmos transistors

;   Example:
;   (metric-tn-stacked (cell-netlist OAI21-cell)) => 2

;   Definition:
    (define metric-tn-stacked
        (lambda (netlist)
            (cond
                [(null? netlist) 0]
                [(mosfet-pmos? (car netlist))
                    ; do not check pmos transistors for tn
                    (metric-tn-stacked (cdr netlist))]
                [else
                    (let ((stacked (mosfet-stacked (car netlist))))
                        (max stacked (metric-tn-stacked (cdr netlist)))
                    )
                ]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-tn-stacked (cell-netlist OAI21-cell)) 2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-tn-stacked test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    stacked both transistors    -----------------------

;   Contract:
;   metric-highest-stacked : netlist -> number

;   Purpose:
;   take highest number from pullup / pulldown network

;   Example:
;   (metric-highest-stacked (cell-netlist NAND2-cell) => 2

;   Definition:
    (define metric-highest-stacked
        (lambda (netlist)
            (max (metric-tp-stacked netlist) (metric-tn-stacked netlist))
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-highest-stacked (cell-netlist NAND2-cell)) 2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-highest-stacked test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    find highest xaxis number   -----------------------

;   Contract:
;   metric-highest-xaxis : netlist -> number

;   Purpose:
;   crawl netlist and find highest xaxis number

;   Example:
;   (metric-highest-xaxis (cell-netlist OAI21-cell)) => 2

;   Definition:
    (define metric-highest-xaxis
        (lambda (netlist)
            (if (null? netlist)
                0
                (let ((xaxis (mosfet-xaxis (car netlist))))
                    (max xaxis (metric-highest-xaxis (cdr netlist)))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-highest-xaxis (cell-netlist OAI21-cell)) 2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-highest-xaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    find highest yaxis number   -----------------------

;   Contract:
;   metric-highest-yaxis : netlist -> number

;   Purpose:
;   crawl netlist and find highest yaxis number

;   Example:
;   (metric-highest-yaxis (cell-netlist AOI21-cell)) => 2

;   Definition:
    (define metric-highest-yaxis
        (lambda (netlist)
            (if (null? netlist)
                0
                (let ((yaxis (mosfet-yaxis (car netlist))))
                    (max yaxis (metric-highest-yaxis (cdr netlist)))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-highest-yaxis (cell-netlist AOI21-cell)) 2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-highest-yaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    find lowest yaxis number    -----------------------

;   Contract:
;   metric-lowest-yaxis : netlist -> number

;   Purpose:
;   crawl netlist and find lowest yaxis number

;   Example:
;   (metric-lowest-yaxis (cell-netlist AOI21-cell)) => -2

;   Definition:
    (define metric-lowest-yaxis
        (lambda (netlist)
            (if (null? netlist)
                0
                (let ((yaxis (mosfet-yaxis (car netlist))))
                    (min yaxis (metric-lowest-yaxis (cdr netlist)))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (metric-lowest-yaxis (cell-netlist AOI21-cell)) -2)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " metric-lowest-yaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    find mosfet by position     -----------------------

;   Purpose:
;   mosfet-by-position : netlist -> mosfet

;   Purpose:
;   crawl netlist and find mosfet by positon coordinates

;   Example:
;   (mosfet-by-position (cell-netlist INV-cell) 1 1) => #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")

;   Definition:
    (define mosfet-by-position
        (lambda (netlist xaxis yaxis)
            (if (null? netlist)
                netlist
                (let ((mosfet (car netlist)))
                    ; check coordinates
                    (if (and (equal? (mosfet-xaxis mosfet) xaxis)
                             (equal? (mosfet-yaxis mosfet) yaxis))
                        mosfet
                        (mosfet-by-position netlist xaxis yaxis))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (mosfet-by-position (cell-netlist INV-cell) 1 1) #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-by-position test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  AUXILARY STUFF
;;  -------------------------------------------------------------------

;;  ------------    calculate (c) Copyleft year -----------------------

;   Contract:
;   copyleft-year : -> number

;   Purpose:
;   use current epoche time to calculate the year inside Copyleft lines

;   Example:
;   (copyleft-year) => 2019

;   Definition:
    (define second 1)
    (define minute (* 60 second))
    (define hour (* 60 minute))
    (define day (* 24 hour))
    (define calendar-year (* 365 day))
    (define copyleft-year
        (lambda ()
            (let ((tropical-year (+ calendar-year (* 5 hour) (* 48 minute) (* 45 second)))) ; !!
                ; This is estimated! There is a delta around new-year regarding leap years.
                ; Do you like to use Popcorn around New Year? Really??
                (+ 1970 (exact (floor (/ (current-second) tropical-year))))
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (> (copyleft-year) 2018)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " copyleft-year test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    list of strings into comma-separated values -------

;   Contract:
;   stringlist->csv : list-of-strings -> string

;   Purpose:
;   transfer a list of strings into a string with comma-seperated values

;   Example
;   (stringlist->csv ("A" "B" "C")) => "A, B, C"

;   Definition:
    (define stringlist->csv
        (lambda (string-list)
            (if (equal? (length string-list) 1)
                (car string-list)   ; last value in list
                (string-append (car string-list) ", " (stringlist->csv (cdr string-list)))
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (stringlist->csv '("C2" "B1" "A0")) "C2, B1, A0")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " stringlist->csv test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    convert string into mosfet  -----------------------

;   Contract:
;   stringlist->mosfet : list-of-strings -> mosfet

;   Purpose:
;   convert list of strings into mosfet vector

;   Example:
;   (stringlist->mosfet ("nmos" "A" "Y" "GND" "GND" "1" "1" "-1" "0" "0")) => '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 0 0)

;   Definition:
    (define stringlist->mosfet
        (lambda (stringlist)
            (let ((mosfet (generate-mosfet)))
                (mosfet-type! mosfet (string-downcase (list-ref stringlist |circuit-type#|)))
                (mosfet-gate! mosfet (string-upcase (list-ref stringlist |gate-node#|)))
                (mosfet-drain! mosfet (string-upcase (list-ref stringlist |drain-node#|)))
                (mosfet-source! mosfet (string-upcase (list-ref stringlist |source-node#|)))
                (mosfet-bulk! mosfet (string-upcase (list-ref stringlist |bulk-node#|)))
                (mosfet-stacked! mosfet (string->number (list-ref stringlist |stacked#|)))
                (mosfet-xaxis! mosfet (string->number (list-ref stringlist |xaxis-point#|)))
                (mosfet-yaxis! mosfet (string->number (list-ref stringlist |yaxis-point#|)))
                (mosfet-size! mosfet (string-downcase (list-ref stringlist |size#|))) ; !! use strings
                mosfet
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test?
        (begin
            (if (equal? (stringlist->mosfet '("nmos" "A" "Y" "GND" "GND" "1" "1" "-1" "0")) '#("nmos" "A" "Y" "GND" "GND" 1 1 -1 "0"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " stringlist->mosfet test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

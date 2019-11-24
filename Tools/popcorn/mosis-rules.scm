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
;;  File:           StdCellLib/Tools/popcorn/mosis-rules.scm
;;
;;  Purpose:        vendor-independet, scalable design rules
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

;;  -------------------------------------------------------------------
;;                  DESCRIPTION
;;  -------------------------------------------------------------------

;;  Please make yourself familiar with:
;;
;;      "MOSIS Scalable CMOS (SCMOS) Design Rules, Rev. 8.00"
;;      Updated: May 11, 2009, provided by mosis.org
;;      https://www.mosis.com/files/scmos/scmos.pdf

;;  All rules here are numbered according to the document above.

;;  NOTE: Rules are still implemented for a 3-Metal Process only.

(define-library (mosis-rules)
  (import (scheme base)
          (scheme char)     ; digit-value
          (scheme sort)     ; list-sort
          (scheme char)     ; string-upcase, string-downcase
          (scheme write)    ; display
          (srfi 152))       ; string-split
  (export   ; scmos rules in [λ]
            ; well
            mosis:rule-1.1      mosis:rule-1.2      mosis:rule-1.3
            mosis:rule-1.4
            ; active
            mosis:rule-2.1      mosis:rule-2.2      mosis:rule-2.3
            mosis:rule-2.4      mosis:rule-2.5
            ; poly
            mosis:rule-3.1      mosis:rule-3.2      mosis:rule-3.2.a
            mosis:rule-3.3      mosis:rule-3.4      mosis:rule-3.5
            ; select
            mosis:rule-4.1      mosis:rule-4.2      mosis:rule-4.3
            mosis:rule-4.4
            ; contact to poly
            mosis:rule-5.1      mosis:rule-5.2      mosis:rule-5.3
            mosis:rule-5.4      mosis:rule-5.2.b    mosis:rule-5.5.b
            mosis:rule-5.6.b    mosis:rule-5.7.b
            ; contact to active
            mosis:rule-6.1      mosis:rule-6.2      mosis:rule-6.3
            mosis:rule-6.4      mosis:rule-6.2.b    mosis:rule-6.5.b
            mosis:rule-6.6.b    mosis:rule-6.7.b    mosis:rule-6.8.b
            ; metal1
            mosis:rule-7.1      mosis:rule-7.2      mosis:rule-7.3
            mosis:rule-7.4
            ; via
            mosis:rule-8.1      mosis:rule-8.2      mosis:rule-8.3
            mosis:rule-8.4      mosis:rule-8.5
            ; metal2
            mosis:rule-9.1      mosis:rule-9.2      mosis:rule-9.3
            mosis:rule-9.4
            ; overglass
            mosis:rule-10.1     mosis:rule-10.2     mosis:rule-10.3
            mosis:rule-10.4     mosis:rule-10.5
            ; poly2 for capacitor
            mosis:rule-11.1     mosis:rule-11.2     mosis:rule-11.3
            mosis:rule-11.4     mosis:rule-11.5     mosis:rule-11.6
            ; poly2 for transistor
            mosis:rule-12.1     mosis:rule-12.2     mosis:rule-12.3
            mosis:rule-12.4     mosis:rule-12.5     mosis:rule-12.6
            ; poly2 contact
            mosis:rule-13.1     mosis:rule-13.2     mosis:rule-13.3
            mosis:rule-13.4     mosis:rule-13.5
            ; via2
            mosis:rule-14.1     mosis:rule-14.2     mosis:rule-14.3
            mosis:rule-14.4     mosis:rule-14.5
            ; metal3
            mosis:rule-15.1     mosis:rule-15.2     mosis:rule-15.3
            mosis:rule-15.4
            ; pbase (analog option)
            mosis:rule-16.1     mosis:rule-16.2     mosis:rule-16.3
            mosis:rule-16.4     mosis:rule-16.5     mosis:rule-16.6
            mosis:rule-16.7     mosis:rule-16.8     mosis:rule-16.9
            mosis:rule-16.10    mosis:rule-16.11
            ; capacitor well
            mosis:rule-17.1     mosis:rule-17.2     mosis:rule-17.3
            mosis:rule-17.4
            ; linear capacitor
            mosis:rule-18.1     mosis:rule-18.2     mosis:rule-18.3
            mosis:rule-18.4     mosis:rule-18.5
            ; silicide block
            mosis:rule-20.1     mosis:rule-20.2     mosis:rule-20.3
            mosis:rule-20.4     mosis:rule-20.5   ;;mosis:rule-20.6
            mosis:rule-20.7     mosis:rule-20.8     mosis:rule-20.9
            mosis:rule-20.10    mosis:rule-20.11
            ; via3
            mosis:rule-21.1     mosis:rule-21.2     mosis:rule-21.3
            ; metal4
            mosis:rule-22.1     mosis:rule-22.2     mosis:rule-22.3
            mosis:rule-22.4
            ; poly cap
            mosis:rule-23.1     mosis:rule-23.2     mosis:rule-23.3
            mosis:rule-23.4     mosis:rule-23.5     mosis:rule-23.6
            mosis:rule-23.7     mosis:rule-23.8     mosis:rule-23.9
            ; thick active
            mosis:rule-24.1     mosis:rule-24.2     mosis:rule-24.3
            mosis:rule-24.4     mosis:rule-24.5   ;;mosis:rule-24.6
            ; via4
            mosis:rule-25.1     mosis:rule-25.2     mosis:rule-25.3
            ; metal5
            mosis:rule-26.1     mosis:rule-26.2     mosis:rule-26.3
            mosis:rule-26.4
            ; high res
            mosis:rule-27.1     mosis:rule-27.2     mosis:rule-27.3
            mosis:rule-27.4     mosis:rule-27.5     mosis:rule-27.6
            mosis:rule-27.7     mosis:rule-27.8     mosis:rule-27.9
            ; CAP_TOP_METAL
            mosis:rule-28.1     mosis:rule-28.2     mosis:rule-28.3
            mosis:rule-28.4     mosis:rule-28.5     mosis:rule-28.6
            mosis:rule-28.7     mosis:rule-28.8     mosis:rule-28.9
            mosis:rule-28.10    mosis:rule-28.11    mosis:rule-28.12
            mosis:rule-28.13    mosis:rule-28.14    mosis:rule-28.15
            ; via5
            mosis:rule-29.1     mosis:rule-29.2     mosis:rule-29.3
            ; metal6
            mosis:rule-30.1     mosis:rule-30.2     mosis:rule-30.3
            mosis:rule-30.4
            ; DEEP_N_WELL
            mosis:rule-31.1     mosis:rule-31.2     mosis:rule-31.3
            mosis:rule-31.4     mosis:rule-31.5     mosis:rule-31.6
            mosis:rule-31.7     mosis:rule-31.8)
  (begin

;;  -------------------------------------------------------------------
;;                  DATA FIELD STRUCTURE
;;  -------------------------------------------------------------------

;   define values as look-up table (vector)
;       +-----------+
;    #0 |  SCMOS    |   scalable CMOS technology
;       +-----------+
;    #1 |  SUBM     |   sub-micron CMOS technology
;       +-----------+
;    #2 |  DEEP     |   deep sub-micron CMOS technology
;       +-----------+
;    #3 |  USER     |   user-defined, e.g. LibreSilicon
;       +-----------+

;   define constants for vector indices
    (define |SCMOS#| 0)
    (define |SUBM#| 1)
    (define |DEEP#| 2)
    (define |USER#| 3)

;;  ------------    getter function     -------------------------------

;   Contract:
;   look-up : tech table -> lambda

;   Purpose:
;   get right number out of look-up table, regarding choosen technology

;   Example:
;   (look-up "SCMOS" '#(12 13 13 -1) => 12

;   Definition:
    (define look-up
        (lambda (tech table)
            (cond
                [(equal? tech "SUBM") (vector-ref table |SUBM#|)]
                [(equal? tech "DEEP") (vector-ref table |DEEP#|)]
                [(equal? tech "USER") (vector-ref table |USER#|)]
                [else (vector-ref table |SCMOS#|)])))

;;  -------------------------------------------------------------------
;;                  WELL
;;  -------------------------------------------------------------------

;       cross section:

;       _______________________________________________________
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-1.1      -------------------------------

;       Minimum nwell/pwell width

;           +------------------+       +------------------+     ----
;           |       nwell      |       |       pwell      |       ^
;           |                  |       |                  |       |
;           |                  |       |                  |       | rule-1.1
;           |                  |       |                  |       |
;           |                  |       |                  |       v
;           +------------------+       +------------------+     ----
;
;           |<--------------->|        |<---------------->|
;                rule-1.1                    rule-1.1

;   Contract:
;   mosis:rule-1.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-1.1 "SUBM") => 12

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       10          12          12          -1
    (define table-1.1 '#(10 12 12 -1))

;   Definition:
    (define mosis:rule-1.1
        (lambda (tech)
            (look-up tech table-1.1)))

;;  ------------    mosis:rule-1.2      -------------------------------

;       Minimum spacing between wells at different potential

;           +------------------+       +------------------+
;           |       nwell      |       |       nwell      |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           +------------------+       +------------------+

;                             >|-------|<
;                              rule-1.2

;   Contract:
;   mosis:rule-1.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-1.2 "SUBM") => 18

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       9           18          18          -1
    (define table-1.2 '#(9 18 18 -1))

;   Definition:
    (define mosis:rule-1.2
        (lambda (tech)
            (look-up tech table-1.2)))

;;  ------------    mosis:rule-1.3      -------------------------------

;       Minimum spacing between wells at same potential

;           +------------------+       +------------------+
;           |       nwell      |       |       nwell      |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           +------------------+       +------------------+

;                             >|-------|<
;                              rule-1.3

;   Contract:
;   mosis:rule-1.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-1.3 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           6           6           -1
    (define table-1.3 '#(6 6 6 -1))

;   Definition:
    (define mosis:rule-1.3
        (lambda (tech)
            (look-up tech table-1.3)))

;;  ------------    mosis:rule-1.4      -------------------------------

;       Minimum spacing between wells of different type (if both are drawn)

;           +------------------+       +------------------+
;           |       nwell      |       |       pwell      |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           +------------------+       +------------------+

;                             >|-------|<
;                              rule-1.4

;   Contract:
;   mosis:rule-1.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-1.4 "SUBM") => 0

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       0           0           0           -1
    (define table-1.4 '#(0 0 0 -1)) ;   !!

;   Definition:
    (define mosis:rule-1.4
        (lambda (tech)
            (look-up tech table-1.4)))

;;  -------------------------------------------------------------------
;;                  ACTIVE
;;  -------------------------------------------------------------------

;       cross section:

;       _______________________________________________________
;       /// |  \p+ active p+/  | ///// |  \n+ active n+/  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-2.1      -------------------------------

;       Minimum active width

;              +------------+             +------------+    ----
;              |   active   |             |   active   |      ^
;              |            |             |            |      |
;              |            |             |            |      | rule-2.1
;              |            |             |            |      |
;              |            |             |            |      v
;              +------------+             +------------+    ----
;
;              |<---------->|             |<---------->|
;                 rule-2.1                   rule-2.1

;   Contract:
;   mosis:rule-2.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-2.1 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-2.1 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-2.1
        (lambda (tech)
            (look-up tech table-2.1)))

;;  ------------    mosis:rule-2.2      -------------------------------

;       Minimum spacing

;              +------------+             +------------+
;              |   active   |             |   active   |
;              |            |             |            |
;              |            |             |            |
;              |            |             |            |
;              |            |             |            |
;              +------------+             +------------+

;                           |<---------->|
;                              rule-2.2

;   Contract:
;   mosis:rule-2.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-2.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-2.2 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-2.2
        (lambda (tech)
            (look-up tech table-2.2)))

;;  ------------    mosis:rule-2.3      -------------------------------

;       Source / Drain active to well edge

;                              nwell|   |pwell
;              +------------+    ///|   |///    +------------+
;              | p+ active  |    ///|   |///    | n+ active  |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              +------------+    ///|   |///    +------------+

;                           |<----->|   |<----->|
;                           rule-2.3    rule-2.3

;   Contract:
;   mosis:rule-2.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-2.3 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       5           6           6           -1
    (define table-2.3 '#(5 6 6 -1))

;   Definition:
    (define mosis:rule-2.3
        (lambda (tech)
            (look-up tech table-2.3)))

;;  ------------    mosis:rule-2.4      -------------------------------

;       Substrate / well contact active to well edge

;                              nwell|   |pwell
;              +------------+    ///|   |///    +------------+
;              | n+ active  |    ///|   |///    | p+ active  |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              +------------+    ///|   |///    +------------+

;                           |<----->|   |<----->|
;                           rule-2.3    rule-2.3

;   Contract:
;   mosis:rule-2.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-2.4 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-2.4 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-2.4
        (lambda (tech)
            (look-up tech table-2.4)))

;;  ------------    mosis:rule-2.5      -------------------------------

;       Minimum spacing between non-abutting active of different implant.
;       Abutting active ("split-active") is illustrated under Selected
;       Layout Rules.

;                                ///|   |///
;              +------------+    ///|   |///    +------------+
;              | n+ active  |    ///|   |///    | p+ active  |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              |            |    ///|   |///    |            |
;              +------------+    ///|   |///    +------------+

;                           |<----------------->|
;                                  rule-2.3

;   Contract:
;   mosis:rule-2.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-2.5 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-2.5 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-2.5
        (lambda (tech)
            (look-up tech table-2.5)))

;;  -------------------------------------------------------------------
;;                  POLY
;;  -------------------------------------------------------------------

;       cross section:
;                   ____                       ____
;       ------     |poly|     -----------     |poly|     ------
;       ______\____======____/___________\___ ======____/______
;       /// |  \p+/      \p+/  | ///// |  \n+/      \n+/  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-3.1      -------------------------------

;       Minimum poly width

;       ___________      ________poly_________      ________
;                  |    |                     |    |
;              +---|----|---+             +---|----|---+
;              |   |    |   |             |   |    |   |
;              |   |    |   |             |   |    |   |
;              |   |    |   |             |   |    |   |
;              +---|----|---+             +---|----|---+
;                  |____|                     |____|

;                 >|----|<                   >|----|<
;                 rule-3.1                   rule-3.1

;   Contract:
;   mosis:rule-3.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-3.1 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-3.1
        (lambda (tech)
            (look-up tech table-3.1)))

;;  ------------    mosis:rule-3.2      -------------------------------

;       Minimum spacing over field

;       ___________      ___poly__      ________
;                  |    |         |    |
;                  |    |         |    |
;                  |    |         |    |
;                  |    |         |    |
;                  |    |         |    |
;                  |    |         |    |
;                  |____|         |____|

;                       |<------->|
;                        rule-3.2

;   Contract:
;   mosis:rule-3.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           3           -1
    (define table-3.2 '#(2 3 3 -1))

;   Definition:
    (define mosis:rule-3.2
        (lambda (tech)
            (look-up tech table-3.2)))

;;  ------------    mosis:rule-3.2.a    -------------------------------

;       Minimum spacing over active

;       ___________      ___poly__      ________
;                  |    |         |    |
;              +---|----|---------|----|---+
;              |   |    | active  |    |   |
;              |   |    |         |    |   |
;              |   |    |         |    |   |
;              +---|----|---------|----|---+
;                  |____|         |____|

;                       |<------->|
;                        rule-3.2.a

;   Contract:
;   mosis:rule-3.2.a : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.2.a "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           4           -1
    (define table-3.2.a '#(2 3 4 -1))

;   Definition:
    (define mosis:rule-3.2.a
        (lambda (tech)
            (look-up tech table-3.2.a)))

;;  ------------    mosis:rule-3.3      -------------------------------

;       Minimum gate extension of active

;       ___________      ___poly__      ________
;                  |    |         |    |
;              +---|----|---------|----|---+
;              |   |    | active  |    |   |
;              |   |    |         |    |   |
;              |   |    |         |    |   |   v
;              +---|----|---------|----|---+ -----
;                  |____|         |____|       | rule-3.5
;                                            -----
;                                              ^
;   Contract:
;   mosis:rule-3.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2.5         -1
    (define table-3.3 '#(2 2 3 -1)) ; !! round-up 2.5 -> 3

;   Definition:
    (define mosis:rule-3.3
        (lambda (tech)
            (look-up tech table-3.3)))

;;  ------------    mosis:rule-3.4      -------------------------------

;       Minimum active extension of poly

;       ___________      ___poly__      ________
;                  |    |         |    |
;              +---|----|---------|----|---+
;              |   |    | active  |    |   |
;              |   |    |         |    |   |
;              |   |    |         |    |   |
;              +---|----|---------|----|---+
;                  |____|         |____|

;             >|---|<                 >|---|<
;            rule-3.4                rule-3.4

;   Contract:
;   mosis:rule-3.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.4 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           4           -1
    (define table-3.4 '#(3 3 4 -1))

;   Definition:
    (define mosis:rule-3.4
        (lambda (tech)
            (look-up tech table-3.4)))

;;  ------------    mosis:rule-3.5      -------------------------------

;       Minimum field poly to active
;                                                 v
;       ___________      ___poly__      ______  -----
;                  |    |         |    |          | rule-3.5
;              +---|----|---------|----|---+    -----
;              |   |    | active  |    |   |      ^
;              |   |    |         |    |   |
;              |   |    |         |    |   |
;              +---|----|---------|----|---+
;                  |____|         |____|

;   Contract:
;   mosis:rule-3.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-3.5 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-3.5 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-3.5
        (lambda (tech)
            (look-up tech table-3.5)))

;;  -------------------------------------------------------------------
;;                  SELECT
;;  -------------------------------------------------------------------

;;  ------------    mosis:rule-4.1      -------------------------------

;       Minimum selected spacing to channel of transistor to ensure
;       adequate source/drain width

;               +---------------+
;               |p+/n+          |
;               |               |
;               |               |
;               |               |
;               |               |     v
;               +---------------+   -----
;                                     | rule-4.1
;       -------------------------   -----
;       poly                          ^
;
;       -------------------------

;   Contract:
;   mosis:rule-4.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-4.1 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-4.1 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-4.1
        (lambda (tech)
            (look-up tech table-3.5)))

;;  ------------    mosis:rule-4.2      -------------------------------

;       Minimum select overlap of active

;               +-----------------------+
;               |n+/p+                  |
;               |                       |
;               |       +-------+       |
;               |       | active|       |
;               |       |       |       |      v
;               |       +-------+       |   -----
;               |                       |      | rule-4.2
;               +-----------------------+   -----
;                                              ^
;               |<----->|
;               rule-4.2

;   Contract:
;   mosis:rule-4.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-4.2 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-4.2 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-4.2
        (lambda (tech)
            (look-up tech table-4.2)))

;;  ------------    mosis:rule-4.3      -------------------------------

;       Minimum select overlap of contact

;                               |p+/n+
;           +-------------------|-------------------+
;           |active             |                   |
;           |       +-------+   |   +-------+       |
;           |       |       |   |   |       |       |
;           |       |contact|   |   |contact|       |
;           |       |       |   |   |       |       |
;           |       +-------+   |   +-------+       |
;           |                   |                   |
;                          >|---|---|<
;                       rule-4.3 rule-4.3

;   Contract:
;   mosis:rule-4.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-4.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1.5         -1
    (define table-4.3 '#(1 1 2 -1)) ; !! round-up from 1.5 -> 2

;   Definition:
    (define mosis:rule-4.3
        (lambda (tech)
            (look-up tech table-4.3)))

;;  ------------    mosis:rule-4.4      -------------------------------

;       Minimum select width and spacing
;                                                 v
;                   +-------+       +-------+   -----
;                   |       |       |       |     |
;                   |  p+   |       |  n+   |     | rule-4.4
;                   |       |       |       |     |
;                   +-------+       +-------+   -----
;                                                 ^
;                   |<----->|       |<----->|
;                    rule-4.4        rule-4.4

;   Contract:
;   mosis:rule-4.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-4.4 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           4           -1
    (define table-4.4 '#(2 2 4 -1))

;   Definition:
    (define mosis:rule-4.4
        (lambda (tech)
            (look-up tech table-4.4)))

;;  -------------------------------------------------------------------
;;                  CONTACT
;;  -------------------------------------------------------------------

;       cross section:

;       --------------------------------
;       poly           \ contact / poly \
;       ----------------\......./------------------------------

;;  ------------    mosis:rule-5.1      -------------------------------

;       Exact contact size to poly

;               +-----------------------+
;               |poly                   |
;               |                       |
;       --------+       +-------+       |   -----
;                       |       |       |     ^
;                       |contact|       |     | rule-5.1
;                       |       |       |     v
;       --------+       +-------+       |   -----
;               |                       |
;               |                       |
;               +-----------------------+

;                       |<----->|
;                       rule-5.1

;   Contract:
;   mosis:rule-5.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-5.1 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-5.1
        (lambda (tech)
            (look-up tech table-5.1)))

;;  ------------    mosis:rule-5.2      -------------------------------

;       Minimum poly overlap

;               +-----------------------+
;               |poly                   |
;               |                       |
;       --------+       +-------+       |
;                       |       |       |
;                       |contact|       |
;                       |       |       |     v
;       --------+       +-------+       |   -----
;               |                       |     | rule-5.2
;               |                       |     |
;               +-----------------------+   -----
;                                             ^
;                       |<----->|
;                       rule-5.2

;   Contract:
;   mosis:rule-5.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.2 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1.5         1.5         1.5         -1
    (define table-5.2 '#(2 2 2 -1)) ; round-up 1.5 -> 2

;   Definition:
    (define mosis:rule-5.2
        (lambda (tech)
            (look-up tech table-5.2)))

;;  ------------    mosis:rule-5.2.b    -------------------------------

;       Alternative: Minimum poly overlap

;               +-----------------------+
;               |poly                   |
;               |                       |
;       --------+       +-------+       |
;                       |       |       |
;                       |contact|       |
;                       |       |       |     v
;       --------+       +-------+       |   -----
;               |                       |     | rule-5.2.b
;               |                       |     |
;               +-----------------------+   -----
;                                             ^
;                       |<----->|
;                       rule-5.2.b

;   Contract:
;   mosis:rule-5.2.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.2.b "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-5.2.b '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-5.2.b
        (lambda (tech)
            (look-up tech table-5.2.b)))

;;  ------------    mosis:rule-5.3      -------------------------------

;       Minimum contact spacing

;       ----------------------------------------
;       poly
;               +-------+       +-------+
;               |       |       |       |
;               |contact|       |contact|
;               |       |       |       |
;               +-------+       +-------+
;
;       ----------------------------------------

;                       |<----->|
;                       rule-5.3

;   Contract:
;   mosis:rule-5.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           4           -1
    (define table-5.3 '#(2 3 4 -1))

;   Definition:
    (define mosis:rule-5.3
        (lambda (tech)
            (look-up tech table-5.3)))

;;  ------------    mosis:rule-5.4      -------------------------------

;       Minimum spacing to gate of transistor

;           |       |
;       ----------------------------------------
;           :       :                       poly
;           :       :   +-------+
;           :       :   |       |
;           :       :   |contact|
;           :       :   |       |
;           :       :   +-------+
;           :      >|---|< rule-5.4
;       ----------------------------------------
;           |active |

;   Contract:
;   mosis:rule-5.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-5.4 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-5.4
        (lambda (tech)
            (look-up tech table-5.4)))

;;  ------------    mosis:rule-5.5.b    -------------------------------

;       Alternative: Minimum spacing to other poly

;                   |           poly|           |poly       |
;               +---+               +---+       |           |
;               |poly                   |       |           |
;               |                       |       |           |
;               |       +-------+       |       |           |
;               |       |       |       |       |           |
;               |       |contact|       |       |           |
;               |       |       |       |       |           |
;               |       +-------+       |       |           |
;               |                       |       |           |
;               |                       |       |           |
;               +-----------------------+       |           |
;
;                               |<------------->|
;                                  rule-5.5.b

;   Contract:
;   mosis:rule-5.5.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.5.b "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           5           5           -1
    (define table-5.5.b '#(4 5 5 -1))

;   Definition:
    (define mosis:rule-5.5.b
        (lambda (tech)
            (look-up tech table-5.5.b)))

;;  ------------    mosis:rule-5.6.b    -------------------------------

;       Minimum spacing to active (one contact)

;       -----------------------------------------
;       active
;
;
;       -----------------------------------------   -----
;                                                     ^
;       -----------------------------------------     | rule-5.6.b
;                                                     v
;               +-------+                           -----
;               |       |
;               |contact|
;               |       |
;               +-------+

;   Contract:
;   mosis:rule-5.6.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.6.b "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-5.6.b '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-5.6.b
        (lambda (tech)
            (look-up tech table-5.6.b)))

;;  ------------    mosis:rule-5.7.b    -------------------------------

;       Minimum spacing to active (many contacts)

;       ----------------------------------------
;       active
;
;
;       ----------------------------------------    -----
;                                                     ^
;       ----------------------------------------      | rule-5.7.b
;       poly                                          v
;               +-------+       +-------+           -----
;               |       |       |       |
;               |contact|       |contact|
;               |       |       |       |
;               +-------+       +-------+

;   Contract:
;   mosis:rule-5.7.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-5.7.b "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-5.7.b '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-5.7.b
        (lambda (tech)
            (look-up tech table-5.7.b)))

;;  -------------------------------------------------------------------
;;                  CONTACT TO ACTIVE
;;  -------------------------------------------------------------------

;       cross section:

;       -------              -------------              -------
;              \   contact  /             \   contact  /
;       --------\........../---------------\........../--------
;       /// |  \p+ active p+/  | ///// |  \n+ active n+/  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-6.1      -------------------------------

;       Exact contact size

;       -------------------------------------------------------
;       active
;               +----------+               +----------+  -----
;               |          |               |          |    ^
;               | contact  |               | contact  |    | rule-6.1
;               |          |               |          |    v
;               +----------+               +----------+  -----
;
;       -------------------------------------------------------

;               |<-------->|               |<-------->|
;                 rule-6.1                   rule-6.1

;   Contract:
;   mosis:rule-6.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-6.1 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-6.1
        (lambda (tech)
            (look-up tech table-6.1)))

;;  ------------    mosis:rule-6.2      -------------------------------

;       Minimum active overlap

;           ------------------------+
;           active                  |
;                                   |
;                   +-------+       |
;                   |       |       |
;                   |contact|       |
;                   |       |       |     v
;                   +-------+       |   -----
;                                   |     | rule-6.2
;                                   |     |
;           ------------------------+   -----
;                                         ^
;                           |<----->|
;                           rule-6.2

;   Contract:
;   mosis:rule-6.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.2 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1.5         1.5         1.5         -1
    (define table-6.2 '#(2 2 2 -1)) ; round-up 1.5 -> 2

;   Definition:
    (define mosis:rule-6.2
        (lambda (tech)
            (look-up tech table-6.2)))

;;  ------------    mosis:rule-6.2.b    -------------------------------

;       Minimum active overlap

;           ------------------------+
;           active                  |
;                                   |
;                   +-------+       |
;                   |       |       |
;                   |contact|       |
;                   |       |       |     v
;                   +-------+       |   -----
;                                   |     | rule-6.2.b
;                                   |     |
;           ------------------------+   -----
;                                         ^
;                           |<----->|
;                           rule-6.2.b

;   Contract:
;   mosis:rule-6.2.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.2.b "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-6.2.b '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-6.2.b
        (lambda (tech)
            (look-up tech table-6.2.b)))

;;  ------------    mosis:rule-6.3      -------------------------------

;       Minimum contact spacing

;               +----------+               +----------+  -----
;               |          |               |          |    ^
;               | contact  |               | contact  |    | rule-6.1
;               |          |               |          |    v
;               +----------+               +----------+  -----

;                          |<------------->|
;                              rule-6.3

;   Contract:
;   mosis:rule-6.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.3 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           4           -1
    (define table-6.3 '#(2 3 4 -1))

;   Definition:
    (define mosis:rule-6.3
        (lambda (tech)
            (look-up tech table-6.3)))

;;  ------------    mosis:rule-6.4      -------------------------------

;       Minimum spacing to gate of transistor

;                                   |poly   |
;           ------------------------|       |
;           active                  |       |
;                                   |       |
;                   +-------+       |       |
;                   |       |       |       |
;                   |contact|       |       |
;                   |       |       |       |
;                   +-------+       |       |
;                           |<----->|       |
;                           rule-6.4|       |
;           ------------------------|       |
;                                   |       |

;   Contract:
;   mosis:rule-6.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-6.4 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-6.4
        (lambda (tech)
            (look-up tech table-6.4)))

;;  ------------    mosis:rule-6.5.b    -------------------------------

;       Minimum spacing to diffusion active

;                     active|       |active
;           +-------+       |       |       +-------+
;           |       |       |       |       |       |
;           |contact|       |       |       |contact|
;           |       |       |       |       |       |
;           +-------+       |       |       +-------+
;
;                           |<------------->|
;                               rule-6.5.b

;   Contract:
;   mosis:rule-6.5.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.5.b "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       5           5           5           -1
    (define table-6.5.b '#(5 5 5 -1))

;   Definition:
    (define mosis:rule-6.5.b
        (lambda (tech)
            (look-up tech table-6.5.b)))

;;  ------------    mosis:rule-6.6.b    -------------------------------

;       Minimum spacing to field poly (one contact)

;                                   |poly
;           ------------------------|
;           active                  |
;                                   |
;                   +-------+       |
;                   |       |       |
;                   |contact|       |
;                   |       |       |
;                   +-------+       |
;                           |<----->|
;                         rule-6.6.b|
;           ------------------------|
;                                   |

;   Contract:
;   mosis:rule-6.6.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.6.b "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-6.6.b '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-6.6.b
        (lambda (tech)
            (look-up tech table-6.6.b)))

;;  ------------    mosis:rule-6.7.b    -------------------------------

;       Minimum spacing to field poly (many contact)

;                                   |poly
;           ------------------------|
;           active                  |
;                                   |
;                   +-------+       |
;                   |       |       |
;                   |contact|       |
;                   |       |       |
;                   +-------+       |
;                                   |
;                                   |
;                   +-------+       |
;                   |       |       |
;                   |contact|       |
;                   |       |       |
;                   +-------+       |
;                           |<----->|
;                         rule-6.6.b|
;           ------------------------|
;                                   |

;   Contract:
;   mosis:rule-6.7.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.7.b "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-6.7.b '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-6.7.b
        (lambda (tech)
            (look-up tech table-6.7.b)))

;;  ------------    mosis:rule-6.8.b    -------------------------------

;       Minimum spacing to poly contact

;                     active|       |poly
;           +-------+       |       |       +-------+
;           |       |       |       |       |       |
;           |contact|       |       |       |contact|
;           |       |       |       |       |       |
;           +-------+       |       |       +-------+
;
;                   |<-------------------->|
;                          rule-6.8.b

;   Contract:
;   mosis:rule-6.8.b : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-6.8.b "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-6.8.b '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-6.8.b
        (lambda (tech)
            (look-up tech table-6.8.b)))

;;  -------------------------------------------------------------------
;;                  METAL1
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal1      \       /               \       / metal1\
;   =========================\...../======================oxide

;;  ------------    mosis:rule-7.1      -------------------------------

;       Minimum metal1 width

;                            rule-7.1            rule-7.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal1|           | metal1|           | metal1|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |       |       |
;               |       |   |contact|   |       |       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |       |       |
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-7.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-7.1 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-7.1 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-7.1
        (lambda (tech)
            (look-up tech table-7.1)))

;;  ------------    mosis:rule-7.2      -------------------------------

;       Minimal spacing between metal1

;   ------------+           +-------+           +-------+
;         metal1|           | metal1|           | metal1|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |       |       |
;               |       |   |contact|   |       |       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |       |       |
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                        rule-7.2

;   Contract:
;   mosis:rule-7.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-7.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           3           -1
    (define table-7.2 '#(2 3 3 -1))

;   Definition:
    (define mosis:rule-7.2
        (lambda (tech)
            (look-up tech table-7.2)))

;;  ------------    mosis:rule-7.3      -------------------------------

;       Minimal overlap of any contact

;   ------------+           +-------+           +-------+
;         metal1|           | metal1|           | metal1|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |       |       |
;               |       |   |contact|   |       |       |
;               |       |   |       |   |  v    |       |
;   "big metal" |       |   +-------+   | ----  |       |
;   > 10 lambda |       |               |  | rule-7.3   |
;   ------------+       +---------------+ ----  +-------+
;                                          ^
;                      >|---|<     >|---|<
;                     rule-7.3    rule-7.3

;   Contract:
;   mosis:rule-7.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-7.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-7.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-7.3
        (lambda (tech)
            (look-up tech table-7.3)))

;;  ------------    mosis:rule-7.4      -------------------------------

;       Minimum spacing when either metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal1|           | metal1|           | metal1|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |       |       |
;               |       |   |contact|   |       |       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |       |       |
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;                rule-7.4

;   Contract:
;   mosis:rule-7.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-7.4 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           6           6           -1
    (define table-7.4 '#(4 6 6 -1))

;   Definition:
    (define mosis:rule-7.4
        (lambda (tech)
            (look-up tech table-7.4)))

;;  -------------------------------------------------------------------
;;                  VIA
;;  -------------------------------------------------------------------

;       cross section:

;       ----.......-----.......--------------------------
;           | via |     | via |               field oxide
;       ----.......-----.......--------------------------
;       metal1
;       ============================================oxide

;;  ------------    mosis:rule-8.1      -------------------------------

;       Exact via size

;   -------------------------------------
;   metal1                            v
;           +-----+     +-----+     -----
;           | via |     | via |       | rule-8.1
;           +-----+     +-----+     -----
;                                     ^
;           |<--->|     |<--->|
;          rule-8.1    rule-8.1
;   -------------------------------------

;   Contract:
;   mosis:rule-8.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-8.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           3           -1
    (define table-8.1 '#(2 2 3 -1))

;   Definition:
    (define mosis:rule-8.1
        (lambda (tech)
            (look-up tech table-8.1)))

;;  ------------    mosis:rule-8.2      -------------------------------

;       Mimimum via1 spacing

;   -------------------------------------
;   metal1
;           +-----+     +-----+
;           | via |     | via |
;           +-----+     +-----+
;                 |<--->|
;                rule-8.2
;   -------------------------------------

;   Contract:
;   mosis:rule-8.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-8.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-8.2 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-8.2
        (lambda (tech)
            (look-up tech table-8.2)))

;;  ------------    mosis:rule-8.3      -------------------------------

;       Mimimum overlap by metal1

;   -----------------------------
;   metal1
;           +-----+     +-----+
;           | via |     | via |       v
;           +-----+     +-----+     -----
;                                     | rule-8.3
;   ------------------------------  -----
;                                     ^
;   Contract:
;   mosis:rule-8.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-8.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-8.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-8.3
        (lambda (tech)
            (look-up tech table-8.3)))

;;  ------------    mosis:rule-8.4      -------------------------------

;       Minimum spacing to contact for processes that do not allow
;       stacked via

;   -------------------------------------
;   metal1
;           +-----+     +-----+
;           | via |     | con |
;           +-----+     +-----+
;                 |<--->|
;                rule-8.4
;   -------------------------------------

;   Contract:
;   mosis:rule-8.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-8.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-8.4 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-8.4
        (lambda (tech)
            (look-up tech table-8.4)))

;;  ------------    mosis:rule-8.5      -------------------------------

;       Minimum spacing to poly or active edge for processes that do
;       allow stacked via
;                                 //// active ////
;   --------------------        --------------------
;   metal1                      metal1
;           +-----+                     +-----+
;           | via |       v             | via |       V
;           +-----+     -----           +-----+     -----
;                         |                           |
;   -------------------   | rule-8.5 --------------   | rule-8.5
;                         |       //// active ////    |
;   ------------------- -----   ------------------- -----
;    ////  active  ////   ^                           ^

;   Contract:
;   mosis:rule-8.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-8.5 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-8.5 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-8.5
        (lambda (tech)
            (look-up tech table-8.5)))

;;  -------------------------------------------------------------------
;;                  METAL2
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal2      \       /               \       / metal2\
;   -------------------------.......-------------------------
;   oxide                    | via |                    oxide
;                        ----.......-------------------------
;                       /                              metal1
;   ====================================================oxide

;;  ------------    mosis:rule-9.1      -------------------------------

;       Minimum metal2 width

;                            rule-9.1            rule-9.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal2|           | metal2|           | metal2|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via  |   | metal1|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-9.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-9.1 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-9.1 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-9.1
        (lambda (tech)
            (look-up tech table-9.1)))

;;  ------------    mosis:rule-9.2      -------------------------------

;       Minimal spacing between metal2


;                            rule-9.1            rule-9.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal2|           | metal2|           | metal2|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via  |   | metal1|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                       rule-9.2

;   Contract:
;   mosis:rule-9.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-9.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           4           -1
    (define table-9.2 '#(3 3 4 -1))

;   Definition:
    (define mosis:rule-9.2
        (lambda (tech)
            (look-up tech table-9.2)))

;;  ------------    mosis:rule-9.3      -------------------------------

;       Minimum overlap of via1

;                                 rule-9.3
;                                  >|---|<

;   ------------+           +-------+           +-------+
;         metal2|           | metal2|           | metal2|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via  |   | metal1|       |
;               |       |   |       |   |  v    |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |  | rule-9.3   |
;   ------------+       +---------------+ ----  +-------+
;                                          ^
;                      >|---|<     >|---|<
;                     rule-9.3    rule-9.3

;   Contract:
;   mosis:rule-9.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-9.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-9.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-9.3
        (lambda (tech)
            (look-up tech table-9.3)))

;;  ------------    mosis:rule-9.4      -------------------------------

;       Minimum spacing when ether metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal2|           | metal2|           | metal2|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via  |   | metal1|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;                rule-9.4

;   Contract:
;   mosis:rule-9.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-9.4 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           6           8           -1
    (define table-9.4 '#(6 6 8 -1))

;   Definition:
    (define mosis:rule-9.4
        (lambda (tech)
            (look-up tech table-9.4)))

;;  -------------------------------------------------------------------
;;                  OVERGLASS
;;  -------------------------------------------------------------------

;       --------.                                   .--------
;   passivation |                                   | passivation
;               \                                   /
;       -----------------------------------------------------
;       metal                                           metal
;       -----------------------------------------------------

;;  NOTE: This Rules are measured in microns, not lambda

;;  ------------    mosis:rule-10.1     -------------------------------

;       Minimum bonding passivation opening

;       +---------------------------------------------------+
;       |metal                                              |
;       |                                                   |
;       |       +-----------------------------------+       |   -----
;       |       |glass                              |       |     ^
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     | rule-10.1
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     v
;       |       +-----------------------------------+       |   -----
;       |                                                   |
;       |                                                   |
;       +---------------------------------------------------+

;               |<--------------------------------->|
;                           rule-10.1

;   Contract:
;   mosis:rule-10.1 : tech -> micron

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-10.1 "SUBM") => 60

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       60          60          60          -1
    (define table-10.1 '#(60 60 60 -1))

;   Definition:
    (define mosis:rule-10.1
        (lambda (tech)
            (look-up tech table-10.1)))

;;  ------------    mosis:rule-10.2     -------------------------------

;       Minimum probe passivation opening

;       +---------------------------------------------------+
;       |metal                                              |
;       |                                                   |
;       |       +-----------------------------------+       |   -----
;       |       |glass                              |       |     ^
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     | rule-10.2
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     |
;       |       |                                   |       |     v
;       |       +-----------------------------------+       |   -----
;       |                                                   |
;       |                                                   |
;       +---------------------------------------------------+

;               |<--------------------------------->|
;                           rule-10.2

;   Contract:
;   mosis:rule-10.2 : tech -> micron

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-10.2 "SUBM") => 20

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       20          20          20          -1
    (define table-10.2 '#(20 20 20 -1))

;   Definition:
    (define mosis:rule-10.2
        (lambda (tech)
            (look-up tech table-10.2)))

;;  ------------    mosis:rule-10.3     -------------------------------

;       Pad metal overlap of passivation

;       +---------------------------------------------------+
;       |metal                                              |
;       |                                                   |
;       |       +-----------------------------------+       |
;       |       |glass                              |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |
;       |       |                                   |       |     v
;       |       +-----------------------------------+       |   -----
;       |                                                   |     | rule-10.3
;       |                                                   |     |
;       +---------------------------------------------------+   -----
;                                                                 ^
;       |<----->|
;       rule-10.3

;   Contract:
;   mosis:rule-10.3 : tech -> micron

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-10.3 "SUBM") => 20

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           6           6           -1
    (define table-10.3 '#(6 6 6 -1))

;   Definition:
    (define mosis:rule-10.3
        (lambda (tech)
            (look-up tech table-10.3)))

;;  ------------    mosis:rule-10.4     -------------------------------

;       Minimum pad spacing to unrelated metal

;       ------------------------+           +------------------------
;                          metal|           |metal
;                               |           |
;       ----------------+       |           |       +----------------
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;                       |       |           |       |
;       ----------------+       |           |       +----------------
;                               |           |
;                               |           |
;       ------------------------+           +------------------------

;                               |<--------->|
;                                 rule-10.4

;   Contract:
;   mosis:rule-10.4 : tech -> micron

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-10.4 "SUBM") => 30

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       30          30          30          -1
    (define table-10.4 '#(30 30 30 -1))

;   Definition:
    (define mosis:rule-10.4
        (lambda (tech)
            (look-up tech table-10.4)))

;;  ------------    mosis:rule-10.5     -------------------------------

;       Minimum pad spacing to active, poly or poly2

;       ------------------------+           |
;                          metal|           |active/poly/poly2
;                               |           |
;       ----------------+       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;                       |       |           |
;       ----------------+       |           |
;                               |           |
;                               |           |
;       ------------------------+           |

;                               |<--------->|
;                                 rule-10.5

;   Contract:
;   mosis:rule-10.5 : tech -> micron

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-10.5 "SUBM") => 15

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       15          15          15          -1
    (define table-10.5 '#(15 15 15 -1))

;   Definition:
    (define mosis:rule-10.5
        (lambda (tech)
            (look-up tech table-10.5)))

;;  -------------------------------------------------------------------
;;                  POLY2 FOR CAPACITOR
;;  -------------------------------------------------------------------

;       cross section:

;       -------------------------------------------------
;                                                   oxide
;                         ==== poly2 ====================
;       oxide                                       oxide
;       ====================== poly ====
;       oxide
;       -------------------------------------------------

;;  ------------    mosis:rule-11.1     -------------------------------

;       Minimum width

;       +------------------------------------------------------------
;       |poly
;       |       +---------------+               +---------------+   -----
;       |       |poly2          |               |poly2          |     ^
;       |       |               |               |               |     |
;       |       |               |               |               |     | rule-11.1
;       |       |               |               |               |     |
;       |       |               |               |               |     v
;       |       +---------------+               +---------------+   -----
;       |
;       +------------------------------------------------------------
;               |<------------->|               |<------------->|
;                   rule-11.1                       rule-11.1

;   Contract:
;   mosis:rule-11.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.1 "SUBM") => 7

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           7           -1          -1
    (define table-11.1 '#(3 7 -1 -1))

;   Definition:
    (define mosis:rule-11.1
        (lambda (tech)
            (look-up tech table-11.1)))

;;  ------------    mosis:rule-11.2     -------------------------------

;       Minimum spacing

;       +------------------------------------------------------------
;       |poly
;       |       +---------------+               +---------------+
;       |       |poly2          |               |poly2          |
;       |       |               |               |               |
;       |       |               |               |               |
;       |       |               |               |               |
;       |       |               |               |               |
;       |       +---------------+               +---------------+
;       |
;       +------------------------------------------------------------
;                               |<------------->|
;                                   rule-11.2

;   Contract:
;   mosis:rule-11.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           -1          -1
    (define table-11.2 '#(3 3 -1 -1))

;   Definition:
    (define mosis:rule-11.2
        (lambda (tech)
            (look-up tech table-11.2)))

;;  ------------    mosis:rule-11.3     -------------------------------

;       Minimum poly overlap
;                                         v
;       +----------------------------   -----
;       |poly                             | rule-11.3
;       |       +---------------+       -----
;       |       |poly2          |         ^
;       |       |               |
;       |       |               |
;       |       |               |
;       |       |               |         v
;       |       +---------------+       -----
;       |                                 | rule-11.3
;       +----------------------------   -----
;       |<----->|                         ^
;       rule-11.3

;   Contract:
;   mosis:rule-11.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.3 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           5           -1          -1
    (define table-11.3 '#(2 5 -1 -1))

;   Definition:
    (define mosis:rule-11.3
        (lambda (tech)
            (look-up tech table-11.3)))

;;  ------------    mosis:rule-11.4     -------------------------------

;       Minimum spacing to active or well edge

;                                       |active/well
;           +---------------+           |
;           |poly2          |           |
;           |               |           |
;           |               |           |
;           |               |           |
;           |               |           |
;           +---------------+           |
;                           |<--------->|
;                             rule-11.4

;   Contract:
;   mosis:rule-11.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-11.4 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-11.4
        (lambda (tech)
            (look-up tech table-11.4)))

;;  ------------    mosis:rule-11.5     -------------------------------

;       Minimum spacing to poly contact

;
;           +---------------+           |
;           |poly2          |           |metal1
;           |               |           |   +-------+
;           |               |           |   |contact|
;           |               |           |   |       |
;           |               |           |   +-------+
;           +---------------+
;                           |<------------->|
;                               rule-11.5

;   Contract:
;   mosis:rule-11.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.5 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           6           -1          -1
    (define table-11.5 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-11.5
        (lambda (tech)
            (look-up tech table-11.5)))

;;  ------------    mosis:rule-11.6     -------------------------------

;       Minimum spacing to unrelated metal

;
;           +---------------+           |
;           |poly2          |           |metal1
;           |               |           |
;           |               |           |
;           |               |           |
;           |               |           |
;           +---------------+
;                           |<--------->|
;                             rule-11.6

;   Contract:
;   mosis:rule-11.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-11.6 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-11.6 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-11.6
        (lambda (tech)
            (look-up tech table-11.6)))

;;  -------------------------------------------------------------------
;;                  POLY2 FOR TRANSISTOR
;;  -------------------------------------------------------------------

;       cross section:

;       ------     |poly|     -----------     |poly|     ------
;       ______\____======____/___________\___ ======____/______
;       /// |  \p+/      \p+/  | ///// |  \n+/      \n+/  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-12.1     -------------------------------

;       Minimum width

;       |poly2  |       +--------------------------------   -----
;       |       |       |poly2                                ^
;       |       |       |   +-------+       +-------+         |
;       |       |       |   |       |       |       |         |
;       |       |       |   |contact|       |contact|         | rule-12.1
;       |       |       |   |       |       |       |         |
;       |       |       |   +-------+       +-------+         |
;       |       |       |                                     v
;       |       |       +--------------------------------   -----
;
;       |<----->|
;       rule-12.1

;   Contract:
;   mosis:rule-12.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-12.1 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-12.1
        (lambda (tech)
            (look-up tech table-12.1)))

;;  ------------    mosis:rule-12.2     -------------------------------

;       Minimum spacing

;       |poly2  |       +--------------------------------
;       |       |       |poly2
;       |       |       |   +-------+       +-------+
;       |       |       |   |       |       |       |
;       |       |       |   |contact|       |contact|
;       |       |       |   |       |       |       |
;       |       |       |   +-------+       +-------+
;       |       |       |
;       |       |       +--------------------------------
;
;               |<----->|
;               rule-12.2

;   Contract:
;   mosis:rule-12.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           -1          -1
    (define table-12.2 '#(3 3 -1 -1))

;   Definition:
    (define mosis:rule-12.2
        (lambda (tech)
            (look-up tech table-12.2)))

;;  ------------    mosis:rule-12.3     -------------------------------

;       Minimum electrode gate overlap of active

;       |poly2  |       +--------------------------------
;       |       |       |active
;       |       |       |   +-------+       +-------+
;       |       |       |   |       |       |       |
;       |       |       |   |contact|       |contact|
;       |       |       |   |       |       |       |         v
;       |       |       |   +-------+       +-------+       -----
;       |       |       |                                     | rule-12.3
;       |       |       +--------------------------------   -----
;                                                             ^
;                      >|---|<
;                     rule-12.3

;   Contract:
;   mosis:rule-12.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-12.3 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-12.3
        (lambda (tech)
            (look-up tech table-12.3)))

;;  ------------    mosis:rule-12.4     -------------------------------

;       Minimum spacing to active

;       | active|       +--------------------------------
;       |       |       |poly2
;       |       |       |   +-------+       +-------+
;       |       |       |   |       |       |       |
;       |       |       |   |contact|       |contact|
;       |       |       |   |       |       |       |
;       |       |       |   +-------+       +-------+
;       |       |       |
;       |       |       +--------------------------------
;
;               |<----->|
;               rule-12.4

;   Contract:
;   mosis:rule-12.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.4 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           -1          -1
    (define table-12.4 '#(1 1 -1 -1))

;   Definition:
    (define mosis:rule-12.4
        (lambda (tech)
            (look-up tech table-12.4)))

;;  ------------    mosis:rule-12.5     -------------------------------

;       Minimum spacing or overlap of poly

;               +--------------------------------
;               |poly
;               |                                     v
;       +-------|................................   -----
;       |       |                                     | rule-12.5
;       |       |                                     |
;       |       +--------------------------------   -----
;       |                                             ^
;       |poly2
;       +----------------------------------------
;

;   Contract:
;   mosis:rule-12.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.5 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-12.5 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-12.5
        (lambda (tech)
            (look-up tech table-12.5)))

;;  ------------    mosis:rule-12.6     -------------------------------

;       Minimum spacing to poly or active contact

;               +--------------------------------
;               |poly
;               |
;       +-------|................................
;       |       |
;       |       |
;       |       +--------------------------------
;       |
;       |poly2
;       +----------------------------------------   -----
;                                                     ^
;               +--------------------------------     | rule-12.6
;               |active                               v
;               |   +-------+       +-------+       -----
;               |   |       |       |       |
;               |   |contact|       |contact|
;               |   |       |       |       |
;               |   +-------+       +-------+
;               |
;               +--------------------------------

;   Contract:
;   mosis:rule-12.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-12.6 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           -1          -1
    (define table-12.6 '#(3 3 -1 -1))

;   Definition:
    (define mosis:rule-12.6
        (lambda (tech)
            (look-up tech table-12.6)))

;;  -------------------------------------------------------------------
;;                  POLY2 CONTACT
;;  -------------------------------------------------------------------

;       cross section:

;       --------------------------------
;       poly           \ contact / poly \
;       ----------------\......./------------------------------

;;  ------------    mosis:rule-13.1     -------------------------------

;       Exact contact size to poly2

;               +-----------------------+
;               |poly2                  |
;               |                       |
;       --------+       +-------+       |   -----
;                       |       |       |     ^
;                       |contact|       |     | rule-13.1
;                       |       |       |     v
;       --------+       +-------+       |   -----
;               |                       |
;               |                       |
;               +-----------------------+

;                       |<----->|
;                       rule-13.1

;   Contract:
;   mosis:rule-13.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-13.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      2            2           -1          -1
    (define table-13.1 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-13.1
        (lambda (tech)
            (look-up tech table-13.1)))

;;  ------------    mosis:rule-13.2     -------------------------------

;       Minimum contact spacing

;       ----------------------------------------
;       poly
;               +-------+       +-------+
;               |       |       |       |
;               |contact|       |contact|
;               |       |       |       |
;               +-------+       +-------+
;
;       ----------------------------------------

;                       |<----->|
;                       rule-13.2

;   Contract:
;   mosis:rule-13.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-13.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           3           -1          -1
    (define table-13.2 '#(2 3 -1 -1))

;   Definition:
    (define mosis:rule-13.2
        (lambda (tech)
            (look-up tech table-13.2)))

;;  ------------    mosis:rule-13.3     -------------------------------

;       Minimum electrode overlap (on capacitor)

;                               |       |
;       +-----------------------+       |
;       |                           poly|     v
;       |   +-----------------------+   |   -----
;       |   |                  poly2|   |     | rule-13.3
;       |   |       +-------+       |   |   -----
;       |   |       |contact|       |   |     ^
;       |   |       |       |       |   |
;       |   |       +-------+       |   |
;       |   |                       |   |
;       |   +-----------------------+   |
;       |                               |
;       |       +-----------------------+
;       |       |
;                           |<----->|
;                           rule-13.3

;   Contract:
;   mosis:rule-13.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-13.3 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           -1          -1
    (define table-13.3 '#(3 3 -1 -1))

;   Definition:
    (define mosis:rule-13.3
        (lambda (tech)
            (look-up tech table-13.3)))

;;  ------------    mosis:rule-13.4     -------------------------------

;       Minimum electrode overlap (not on capacitor)
;                                         v
;           +-----------------------+   -----
;           |                  poly2|     | rule-13.4
;           |       +-------+       |   -----
;           |       |contact|       |     ^
;           |       |       |       |
;           |       +-------+       |
;           |                       |
;           +-----------------------+

;                           |<----->|
;                           rule-13.4

;   Contract:
;   mosis:rule-13.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-13.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           -1          -1
    (define table-13.4 '#(2 2 -1 -1))

;   Definition:
    (define mosis:rule-13.4
        (lambda (tech)
            (look-up tech table-13.4)))

;;  ------------    mosis:rule-13.5     -------------------------------

;       Minimum spacing to poly or active

;       --------+                       +--------
;         active|                       |poly
;               |   +---------------+   |
;               |   |          poly2|   |
;               |   |   +-------+   |   |
;               |   |   |contact|   |   |
;               |   |   |       |   |   |
;               |   |   +-------+   |   |
;               |   |               |   |
;               |   +---------------+   |
;               |                       |
;       --------+                       +--------

;               |<----->|       |<----->|
;               rule-13.5       rule-13.5

;   Contract:
;   mosis:rule-13.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-13.5 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           -1          -1
    (define table-13.5 '#(3 3 -1 -1))

;   Definition:
    (define mosis:rule-13.5
        (lambda (tech)
            (look-up tech table-13.5)))

;;  -------------------------------------------------------------------
;;                  VIA2
;;  -------------------------------------------------------------------

;       cross section:

;       ----.......-----.......--------------------------
;           | via2|     | via2|               field oxide
;       ----.......-----.......--------------------------
;       metal2
;       -------------------------------------------------

;;  ------------    mosis:rule-14.1     -------------------------------

;       Exact via2 size

;          rule-14.1           rule-14.1
;           |<--->|             |<--->|

;   -----------------------------------------
;   metal2                                  v
;           +-----+             +-----+   -----
;           | via2|             | via2|     | rule-14.1
;           +-----+             +-----+   -----
;                                           ^
;   ------------------------------------------

;   Contract:
;   mosis:rule-14.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-14.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           3           -1
    (define table-14.1 '#(2 2 3 -1))

;   Definition:
    (define mosis:rule-14.1
        (lambda (tech)
            (look-up tech table-14.1)))

;;  ------------    mosis:rule-14.2     -------------------------------

;       Mimimum via2 spacing

;   -------------------------------------
;   metal2
;           +-----+     +-----+
;           | via2|     | via2|
;           +-----+     +-----+
;                 |<--->|
;                rule-14.2
;   -------------------------------------

;   Contract:
;   mosis:rule-14.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-14.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-14.2 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-14.2
        (lambda (tech)
            (look-up tech table-14.2)))

;;  ------------    mosis:rule-14.3     -------------------------------

;       Mimimum overlap by metal2

;   -----------------------------
;   metal2
;           +-----+     +-----+
;           | via2|     | via2|       v
;           +-----+     +-----+     -----
;                                     | rule-14.3
;   ------------------------------  -----
;                                     ^
;   Contract:
;   mosis:rule-14.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-14.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-14.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-14.3
        (lambda (tech)
            (look-up tech table-14.3)))

;;  ------------    mosis:rule-14.4     -------------------------------

;       Via2 may be placed over via1

;   Contract:
;   mosis:rule-14.4 : tech -> boolean

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-14.4 "SUBM") => #f

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       #f          #f          #f          -1
    (define table-14.4 '#(#f #f #f -1))

;   Definition:
    (define mosis:rule-14.4
        (lambda (tech)
            (look-up tech table-14.4)))

;;  ------------    mosis:rule-14.5     -------------------------------

;       Via2 may be placed over contact

;   Contract:
;   mosis:rule-14.5 : tech -> boolean

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-14.5 "SUBM") => #t

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       #t          #t          #t          -1
    (define table-14.5 '#(#t #t #t -1))

;   Definition:
    (define mosis:rule-14.5
        (lambda (tech)
            (look-up tech table-14.5)))

;;  -------------------------------------------------------------------
;;                  METAL3
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal3      \       /               \       / metal3\
;   -------------------------.......---------------------
;   oxide                    | via2|                oxide
;                        ----.......---------------------
;                       /                          metal2
;   -----------------------------------------------------

;;  NOTE: Rules are yet implemented for a 3-Metal Process only.

;;  ------------    mosis:rule-15.1     -------------------------------

;       Minimum metal3 width

;                           rule-15.1           rule-15.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal3|           | metal3|           | metal3|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via2 |   | metal2|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-15.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-15.1 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           5           3           -1
;   (define table-15.1 '#(6 5 -1 -1)) ; 3 metal
;   (define table-15.1 '#(3 3 3 -1)) ; 4+ metal
    (define table-15.1 '#(6 5 3 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-15.1
        (lambda (tech)
            (look-up tech table-15.1)))

;;  ------------    mosis:rule-15.2     -------------------------------

;       Minimal spacing between metal3

;   ------------+           +-------+           +-------+
;         metal3|           | metal3|           | metal3|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via2 |   | metal2|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                       rule-15.2

;   Contract:
;   mosis:rule-15.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-15.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           3           4           -1
;   (define table-15.2 '#(4 3 -1 -1)) ; 3 metal
;   (define table-15.2 '#(3 3 4 -1)) ; 4+ metal
    (define table-15.2 '#(4 3 4 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-15.2
        (lambda (tech)
            (look-up tech table-15.2)))

;;  ------------    mosis:rule-15.3     -------------------------------

;       Minimum overlap of via2

;                                 rule-15.3
;                                  >|---|<

;   ------------+           +-------+           +-------+
;         metal3|           | metal3|           | metal3|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via2 |   | metal2|       |
;               |       |   |       |   |   v   |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |   | rule-15.3 |
;   ------------+       +---------------+ ----- +-------+
;                                           ^
;                      >|---|<     >|---|<
;                     rule-15.3   rule-15.3

;   Contract:
;   mosis:rule-15.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-15.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           1           -1
;   (define table-15.3 '#(2 2 -1 -1)) ; 3 metal
;   (define table-15.3 '#(1 1 1 -1)) ; 4+ metal
    (define table-15.3 '#(2 2 1 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-15.3
        (lambda (tech)
            (look-up tech table-15.3)))

;;  ------------    mosis:rule-15.4     -------------------------------

;       Minimum spacing when either metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal3|           | metal3|           | metal3|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via2 |   | metal2|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;                rule-15.4

;   Contract:
;   mosis:rule-15.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-15.4 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       8           6           8           -1
;   (define table-15.4 '#(8 6 -1 -1)) ; 3 metal
;   (define table-15.4 '#(6 6 8 -1)) ; 4+ metal
    (define table-15.4 '#(8 6 8 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-15.4
        (lambda (tech)
            (look-up tech table-15.4)))

;;  -------------------------------------------------------------------
;;                  PBASE
;;  -------------------------------------------------------------------

;       cross section:

;                    contact                 contact
;   ----------------\......./---------------\......./----------------
;   /// |   |   \_____emitter_n+/       \base_p+________/   |   | ///
;   /// |   |                                               |   | ///
;   /// |   \____________________pbase______________________/   | ///
;   /// |                                                       | ///
;   /// \________________________nwell__________________________/ ///
;   ////                                                         ////
;   ////////////////////////// substrate ////////////////////////////

;;  ------------    mosis:rule-16.1     -------------------------------

;       All active contact

;       |nwell                                                  |
;       |   +-----------------------------------------------+   |
;       |   |pbase                                          |   |
;       |   |   +---------------+       +---------------+   |   |
;       |   |   |     emitter n+|       |base p+        |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |   -----
;       |   |   |   |       |   |       |   |       |   |   |   |     ^
;       |   |   |   |contact|   |       |   |contact|   |   |   |     | rule-16.1
;       |   |   |   |       |   |       |   |       |   |   |   |     v
;       |   |   |   +-------+   |       |   +-------+   |   |   |   -----
;       |   |   |               |       |               |   |   |
;       |   |   +---------------+       +---------------+   |   |
;       |   |                                               |   |
;       |   +-----------------------------------------------+   |
;                   |<----->|               |<----->|
;                   rule-16.1               rule-16.1

;   Contract:
;   mosis:rule-16.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.1 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.1
        (lambda (tech)
            (look-up tech table-16.1)))

;;  ------------    mosis:rule-16.2     -------------------------------

;       Minimum emitter select overlap of contact

;       |nwell                                                  |
;       |   +-----------------------------------------------+   |
;       |   |pbase                                          |   |    v
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |   |     emitter n+|       |base p+        |   |   |    | rule-16.2
;       |   |   |   +-------+   |       |   +-------+   |   |   |  -----
;       |   |   |   |       |   |       |   |       |   |   |   |    ^
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |    v
;       |   |   |   +-------+   |       |   +-------+   |   |   |  -----
;       |   |   |               |       |               |   |   |    | rule-16.2
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |                                               |   |    ^
;       |   +-----------------------------------------------+   |
;              >|---|<     >|---|<
;             rule-16.2   rule-16.2

;   Contract:
;   mosis:rule-16.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           -1          -1          -1
    (define table-16.2 '#(3 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.2
        (lambda (tech)
            (look-up tech table-16.2)))

;;  ------------    mosis:rule-16.3     -------------------------------

;       Minimum pbase overlap of emitter select

;       |nwell                                                  |    v
;       |   +-----------------------------------------------+   |  -----
;       |   |pbase                                          |   |    | rule-16.3
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |   |     emitter n+|       |base p+        |   |   |    ^
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |               |       |               |   |   |    v
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |pbase                                          |   |    | rule-16.3
;       |   +-----------------------------------------------+   |  -----
;          >|---|<                                                   ^
;         rule-16.3

;   Contract:
;   mosis:rule-16.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.3 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.3
        (lambda (tech)
            (look-up tech table-16.3)))

;;  ------------    mosis:rule-16.4     -------------------------------

;       Minimum spacing between emitter select and base select

;       |nwell                                                  |
;       |   +-----------------------------------------------+   |
;       |   |pbase                                          |   |
;       |   |   +---------------+       +---------------+   |   |
;       |   |   |     emitter n+|       |base p+        |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |               |       |               |   |   |
;       |   |   +---------------+       +---------------+   |   |
;       |   |pbase                                          |   |
;       |   +-----------------------------------------------+   |
;                               |<---->|
;                              rule-16.4

;   Contract:
;   mosis:rule-16.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           -1          -1          -1
    (define table-16.4 '#(4 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.4
        (lambda (tech)
            (look-up tech table-16.4)))

;;  ------------    mosis:rule-16.5     -------------------------------

;       Minimum pbase overlap of base select

;       |nwell                                                  |    v
;       |   +-----------------------------------------------+   |  -----
;       |   |pbase                                          |   |    | rule-16.5
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |   |     emitter n+|       |base p+        |   |   |    ^
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |               |       |               |   |   |    v
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |pbase                                          |   |    | rule-16.5
;       |   +-----------------------------------------------+   |  -----
;                                                      >|---|<       ^
;                                                     rule-16.5

;   Contract:
;   mosis:rule-16.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.5 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.5
        (lambda (tech)
            (look-up tech table-16.5)))

;;  ------------    mosis:rule-16.6     -------------------------------

;       Minimum base select overlap of contact

;       |nwell                                                  |
;       |   +-----------------------------------------------+   |
;       |   |pbase                                          |   |    v
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |   |     emitter n+|       |base p+        |   |   |    | rule-16.6
;       |   |   |   +-------+   |       |   +-------+   |   |   |  ----
;       |   |   |   |       |   |       |   |       |   |   |   |    ^
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |    v
;       |   |   |   +-------+   |       |   +-------+   |   |   |  -----
;       |   |   |               |       |               |   |   |    | rule-16.6
;       |   |   +---------------+       +---------------+   |   |  -----
;       |   |pbase                                          |   |    ^
;       |   +-----------------------------------------------+   |
;                                                  >|---|<
;                                                 rule-16.6

;   Contract:
;   mosis:rule-16.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.6 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.6 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.6
        (lambda (tech)
            (look-up tech table-16.6)))

;;  ------------    mosis:rule-16.7     -------------------------------

;       Minimum nwell overlap of pbase

;                                                                    v
;       +-------------------------------------------------------+  -----
;       |nwell                                                  |    | rule-16.7
;       |   +-----------------------------------------------+   |  -----
;       |   |pbase                                          |   |    ^
;       |   |   +---------------+       +---------------+   |   |
;       |   |   |     emitter n+|       |base p+        |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   |contact|   |       |   |contact|   |   |   |
;       |   |   |   |       |   |       |   |       |   |   |   |
;       |   |   |   +-------+   |       |   +-------+   |   |   |
;       |   |   |               |       |               |   |   |
;       |   |   +---------------+       +---------------+   |   |
;       |   |pbase                                          |   |
;       |   +-----------------------------------------------+   |
;                                                          >|---|<
;                                                         rule-16.7

;   Contract:
;   mosis:rule-16.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.7 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           -1          -1          -1
    (define table-16.7 '#(6 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.7
        (lambda (tech)
            (look-up tech table-16.7)))

;;  ------------    mosis:rule-16.8     -------------------------------

;       Minimum spacing between pbase and collector active

;   +-----------------------------------------------------------+
;   |nwell                                                      |
;   |    ........................   +-----------------------+   |
;   |    :select                :   |pbase                  |   |
;   |    :  +----------------+  :   |   +---------------+   |   |
;   |    :  |collector active|  :   |   |base p+        |   |   |
;   |    :  |   +-------+    |  :   |   |   +-------+   |   |   |
;   |    :  |   |       |    |  :   |   |   |       |   |   |   |
;   |    :  |   |contact|    |  :   |   |   |contact|   |   |   |
;   |    :  |   |       |    |  :   |   |   |       |   |   |   |
;   |    :  |   +-------+    |  :   |   |   +-------+   |   |   |
;   |    :  |                |  :   |   |               |   |   |
;   |    :  +----------------+  :   |   +---------------+   |   |
;   |    :......................:   |                       |   |
;   |                               +-----------------------+   |
;   |                                                           |
;   +-----------------------------------------------------------+
;                            |<---->|
;                           rule-16.8

;   Contract:
;   mosis:rule-16.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.8 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           -1          -1          -1
    (define table-16.8 '#(4 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.8
        (lambda (tech)
            (look-up tech table-16.8)))

;;  ------------    mosis:rule-16.9     -------------------------------

;       Minimum collector active overlap of contact

;   +-----------------------------------------------------------+
;   |nwell                                                      |
;   |    ........................   +-----------------------+   |
;   |    :select                :   |pbase                  |   |
;   |    :  +----------------+  :   |   +---------------+   |   |
;   |    :  |collector active|  :   |   |base p+        |   |   |
;   |    :  |   +-------+    |  :   |   |   +-------+   |   |   |
;   |    :  |   |       |    |  :   |   |   |       |   |   |   |
;   |    :  |   |contact|    |  :   |   |   |contact|   |   |   |
;   |    :  |   |       |    |  :   |   |   |       |   |   |   |
;   |    :  |   +-------+    |  :   |   |   +-------+   |   |   |
;   |    :  |                |  :   |   |               |   |   |
;   |    :  +----------------+  :   |   +---------------+   |   |
;   |    :......................:   |                       |   |
;   |                               +-----------------------+   |
;   |                                                           |
;   +-----------------------------------------------------------+
;                      >|----|<
;                      rule-16.9

;   Contract:
;   mosis:rule-16.9 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.9 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.9 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.9
        (lambda (tech)
            (look-up tech table-16.9)))

;;  ------------    mosis:rule-16.10    -------------------------------

;       Minimum nwell overlap of collector active

;   +-----------------------------------------------------------
;   |nwell                            ^
;   |    ........................     | rule-16.10
;   |    :select                :     v
;   |    :  +----------------+  :   -----
;   |    :  |collector active|  :
;   |    :  |   +-------+    |  :
;   |    :  |   |       |    |  :
;   |    :  |   |contact|    |  :
;   |    :  |   |       |    |  :
;   |    :  |   +-------+    |  :
;   |    :  |                |  :
;   |    :  +----------------+  :   -----
;   |    :......................:     ^
;   |                                 | rule-16.10
;   |                                 v
;   +-----------------------------------------------------------

;   Contract:
;   mosis:rule-16.10 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.10 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           -1          -1          -1
    (define table-16.10 '#(3 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.10
        (lambda (tech)
            (look-up tech table-16.10)))

;;  ------------    mosis:rule-16.11    -------------------------------

;       Minimum select overlap of collector active

;   +-----------------------------------------------------------
;   |nwell                            v
;   |    ........................   -----
;   |    :select                :     | rule-16.11
;   |    :  +----------------+  :   -----
;   |    :  |collector active|  :     ^
;   |    :  |   +-------+    |  :
;   |    :  |   |       |    |  :
;   |    :  |   |contact|    |  :
;   |    :  |   |       |    |  :
;   |    :  |   +-------+    |  :
;   |    :  |                |  :     v
;   |    :  +----------------+  :   -----
;   |    :                      :     | rule-16.11
;   |    :......................:   -----
;   |                                 ^
;   +-----------------------------------------------------------
;       >|--|<
;    rule-16.11

;   Contract:
;   mosis:rule-16.11 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-16.11 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           -1          -1          -1
    (define table-16.11 '#(2 -1 -1 -1))

;   Definition:
    (define mosis:rule-16.11
        (lambda (tech)
            (look-up tech table-16.11)))

;;  -------------------------------------------------------------------
;;                  CAPACITOR WELL
;;  -------------------------------------------------------------------

;       cross section:

;       _______________________________________________________
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \______capwell_____/ ///// \______capwell_____/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-17.1     -------------------------------

;       Minimum width

;           +------------------+       +------------------+  -----
;           |      capwell     |       |      capwell     |    ^
;           |                  |       |                  |    |
;           |                  |       |                  |    |
;           |                  |       |                  |    | rule-17.1
;           |                  |       |                  |    |
;           |                  |       |                  |    |
;           |                  |       |                  |    v
;           +------------------+       +------------------+  -----
;
;           |<---------------->|       |<--------------->|
;                 rule-17.1                 rule-17.1

;   Contract:
;   mosis:rule-17.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-17.1 "SUBM") => 12

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       10          12          -1          -1
    (define table-17.1 '#(10 12 -1 -1))

;   Definition:
    (define mosis:rule-17.1
        (lambda (tech)
            (look-up tech table-17.1)))

;;  ------------    mosis:rule-17.2     -------------------------------

;       Minimum spacing

;           +------------------+       +------------------+
;           |      capwell     |       |      capwell     |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           |                  |       |                  |
;           +------------------+       +------------------+
;
;                              |<----->|
;                              rule-17.2

;   Contract:
;   mosis:rule-17.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-17.2 "SUBM") => 18

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       9           18          -1          -1
    (define table-17.2 '#(9 18 -1 -1))

;   Definition:
    (define mosis:rule-17.2
        (lambda (tech)
            (look-up tech table-17.2)))

;;  ------------    mosis:rule-17.3     -------------------------------

;       Minimum spacing to external active

;           +------------------+
;           |      capwell     |
;           |   +----------+   |           +----------+
;           |   |    active|   |           |active    |
;           |   |          |   |           |          |
;           |   |          |   |           |          |
;           |   +----------+   |           +----------+
;           |                  |
;           +------------------+
;
;                              |<--------->|
;                                rule-17.3

;   Contract:
;   mosis:rule-17.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-17.3 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       5           6           -1          -1
    (define table-17.3 '#(5 6 -1 -1))

;   Definition:
    (define mosis:rule-17.3
        (lambda (tech)
            (look-up tech table-17.3)))

;;  ------------    mosis:rule-17.4     -------------------------------

;       Minimum overlap to active

;                                   V
;           +------------------+  -----
;           |      capwell     |    | rule-17.4
;           |   +----------+   |  -----
;           |   |    active|   |    ^
;           |   |          |   |
;           |   |          |   |    v
;           |   +----------+   |  -----
;           |                  |    | rule-17.4
;           +------------------+  -----
;                                   ^
;          >|---|<        >|---|<
;         rule-17.4      rule-17.4

;   Contract:
;   mosis:rule-17.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-17.4 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       5           6           -1          -1
    (define table-17.4 '#(5 6 -1 -1))

;   Definition:
    (define mosis:rule-17.4
        (lambda (tech)
            (look-up tech table-17.4)))

;;  -------------------------------------------------------------------
;;                  LINEAR CAPACITOR
;;  -------------------------------------------------------------------

;       NOT IMPLEMENTED YET

;;  ------------    mosis:rule-18.1     -------------------------------

;   Contract:
;   mosis:rule-18.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-18.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-18.1 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-18.1
        (lambda (tech)
            (look-up tech table-18.1)))

;;  ------------    mosis:rule-18.2     -------------------------------

;   Contract:
;   mosis:rule-18.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-18.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-18.2 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-18.2
        (lambda (tech)
            (look-up tech table-18.2)))

;;  ------------    mosis:rule-18.3     -------------------------------

;   Contract:
;   mosis:rule-18.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-18.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-18.3 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-18.3
        (lambda (tech)
            (look-up tech table-18.3)))

;;  ------------    mosis:rule-18.4     -------------------------------

;   Contract:
;   mosis:rule-18.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-18.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-18.4 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-18.4
        (lambda (tech)
            (look-up tech table-18.4)))

;;  ------------    mosis:rule-18.5     -------------------------------

;   Contract:
;   mosis:rule-18.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-18.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-18.5 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-18.5
        (lambda (tech)
            (look-up tech table-18.5)))

;;  -------------------------------------------------------------------
;;                  SILICIDE BLOCK
;;  -------------------------------------------------------------------

;;  ------------    mosis:rule-20.1     -------------------------------

;       Minimum Silicide Block width

;                             v
;           .............   -----
;           :silicide   :     | rule-20.1
;           :block      :     |
;           :...........:   -----
;                             ^
;           .............                       |       |
;           :silicide   :                       |poly   |
;       +---:block------:-----------------------|       |---+
;       |   :           :                active |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :       |contact|       |       |   |
;       |   :           :       |       |       |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :                       |       |   |
;       +---:-----------:-----------------------|       |---+
;           :           :                       |       |
;           :...........:                       |       |
;
;           |<--------->|
;             rule-20.1

;   Contract:
;   mosis:rule-20.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.1 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-20.1 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-20.1
        (lambda (tech)
            (look-up tech table-20.1)))

;;  ------------    mosis:rule-20.2     -------------------------------

;       Minimum Silicide Block spacing

;           .............
;           :silicide   :
;           :block      :     v
;           :...........:   -----
;                             | rule-20.2
;           .............   -----               |       |
;           :silicide   :     ^                 |poly   |
;       +---:block------:-----------------------|       |---+
;       |   :           :                active |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :       |contact|       |       |   |
;       |   :           :       |       |       |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :                       |       |   |
;       +---:-----------:-----------------------|       |---+
;           :           :                       |       |
;           :...........:                       |       |

;   Contract:
;   mosis:rule-20.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.2 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-20.2 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-20.2
        (lambda (tech)
            (look-up tech table-20.2)))

;;  ------------    mosis:rule-20.3     -------------------------------

;       Minimum spacing, Silicide Block to contact
;       (no contact allowed inside Silicide Block)

;           .............                       |       |
;           :silicide   :                       |poly   |
;       +---:block------:-----------------------|       |---+
;       |   :           :                active |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :       |contact|       |       |   |
;       |   :           :       |       |       |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :                       |       |   |
;       +---:-----------:-----------------------|       |---+
;           :           :<---->|                |       |
;           :...........: rule-20.3             |       |

;   Contract:
;   mosis:rule-20.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-20.3 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-20.3
        (lambda (tech)
            (look-up tech table-20.3)))

;;  ------------    mosis:rule-20.4     -------------------------------

;       Minimum spacing, Silicide Block to external active

;           .............                       |       |       .......
;           :silicide   :                       |poly   |       :silicide
;       +---:block------:-----------------------|       |---+   :block
;       |   :           :                active |       |   |   :
;       |   :           :       +-------+       |       |   |   :
;       |   :           :       |contact|       |       |   |   :
;       |   :           :       |       |       |       |   |   :
;       |   :           :       +-------+       |       |   |   :
;       |   :           :                       |       |   |   :
;       +---:-----------:-----------------------|       |---+   :
;           :           :                       |       |       :
;           :...........:                       |       |       :.......
;                                                          >|---|<
;                                                         rule-20.4
;   Contract:
;   mosis:rule-20.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.4 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-20.4 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-20.4
        (lambda (tech)
            (look-up tech table-20.4)))

;;  ------------    mosis:rule-20.5     -------------------------------

;       Minimum spacing, Silicide Block to external poly

;           .............                       |       |       .......
;           :silicide   :                       |poly   |       :silicide
;       +---:block------:-----------------------|       |---+   :block
;       |   :           :                active |       |   |   :
;       |   :           :       +-------+       |       |   |   :
;       |   :           :       |contact|       |       |   |   :
;       |   :           :       |       |       |       |   |   :
;       |   :           :       +-------+       |       |   |   :
;       |   :           :                       |       |   |   :
;       +---:-----------:-----------------------|       |---+   :
;           :           :                       |       |       :
;           .............                       |       |       .......
;
;                                                      >|-------|<
;                                                       rule-20.5

;   Contract:
;   mosis:rule-20.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.5 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-20.5 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-20.5
        (lambda (tech)
            (look-up tech table-20.5)))

;;  ------------    mosis:rule-20.6     -------------------------------

;       Resistor is poly inside Silicde Block; poly ends stick out for
;       contacts the entire resistor must be outside well and over field.

;;  ------------    mosis:rule-20.7     -------------------------------

;       Minimum poly width in resistor

;                   |           poly|       |poly           |
;       .............................................................
;       :silicide   |               |       |               |       :
;       :block      |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :...........................................................:
;                   |   +-------+   |       |               |
;                   |   |contact|   |       |               |
;                   |   |       |   |       +---------------+
;                   |   +-------+   |
;                   |               |       |<------------->|
;                   +---------------+           rule-20.7
;
;                   |<------------->|
;                       rule-20.7

;   Contract:
;   mosis:rule-20.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.7 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       5           5           5           -1
    (define table-20.7 '#(5 5 5 -1))

;   Definition:
    (define mosis:rule-20.7
        (lambda (tech)
            (look-up tech table-20.7)))

;;  ------------    mosis:rule-20.8     -------------------------------

;       Minimum spacing of poly resistors
;       (in a single Silicide Block region)

;                   |           poly|       |poly           |
;       .............................................................
;       :silicide   |               |       |               |       :
;       :block      |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :...........................................................:
;                   |   +-------+   |       |               |
;                   |   |contact|   |       |               |
;                   |   |       |   |       +---------------+
;                   |   +-------+   |
;                   |               |
;                   +---------------+

;                                  >|-------|<
;                                   rule-20.8

;   Contract:
;   mosis:rule-20.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.8 "SUBM") => 7

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       7           7           7           -1
    (define table-20.8 '#(7 7 7 -1))

;   Definition:
    (define mosis:rule-20.8
        (lambda (tech)
            (look-up tech table-20.8)))

;;  ------------    mosis:rule-20.9     -------------------------------

;       Minimum Silicide Block overlap of poly or active

;                   |           poly|       |poly           |
;       .............................................................
;       :silicide   |               |       |               |       :
;       :block      |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :...........................................................:
;                   |   +-------+   |       |               |
;                   |   |contact|   |       |               |
;                   |   |       |   |       +---------------+
;                   |   +-------+   |
;       |<--------->|               |                       |<----->|
;         rule-20.9 +---------------+                       rule-20.9

;   Contract:
;   mosis:rule-20.9 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.9 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           2           -1
    (define table-20.9 '#(2 2 2 -1))

;   Definition:
    (define mosis:rule-20.9
        (lambda (tech)
            (look-up tech table-20.9)))

;;  ------------    mosis:rule-20.10    -------------------------------

;       Minimum poly or active overlap of Silicide Block

;                   |           poly|       |poly           |
;       .............................................................
;       :silicide   |               |       |               |       :
;       :block      |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :           |               |       |               |       :
;       :...........................................................:
;             ^     |   +-------+   |       |               |    ^
;             |     |   |contact|   |       |               |    | rule-20.10
;  rule-20.10 |     |   |       |   |       |               |    v
;             |     |   +-------+   |       +---------------+  -----
;             v     |               |
;           -----   +---------------+

;   Contract:
;   mosis:rule-20.10 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.10 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-20.10 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-20.10
        (lambda (tech)
            (look-up tech table-20.10)))

;;  ------------    mosis:rule-20.11    -------------------------------

;       Minimum spacing, Silicide Block to poly
;       (in a single active region)

;           .............                       |       |
;           :silicide   :                       |poly   |
;       +---:block------:-----------------------|       |---+
;       |   :           :                active |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :       |contact|       |       |   |
;       |   :           :       |       |       |       |   |
;       |   :           :       +-------+       |       |   |
;       |   :           :                       |       |   |
;       +---:-----------:-----------------------|       |---+
;           :           :                       |       |
;           .............                       |       |
;
;                       |<--------------------->|
;                              rule-20.11

;   Contract:
;   mosis:rule-20.11 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-20.11 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           5           5           -1
    (define table-20.11 '#(3 5 5 -1))

;   Definition:
    (define mosis:rule-20.11
        (lambda (tech)
            (look-up tech table-20.11)))

;;  -------------------------------------------------------------------
;;                  VIA3
;;  -------------------------------------------------------------------

;       cross section:

;       ----.......-----.......--------------------------
;           | via3|     | via3|               field oxide
;       ----.......-----.......--------------------------
;       metal3
;       -------------------------------------------------

;;  ------------    mosis:rule-21.1     -------------------------------

;       Exact via3 size

;       -------------------------------------------------
;       metal3                        v
;           +-----+     +-----+     -----
;           | via3|     | via3|       | rule-21.1
;           +-----+     +-----+     -----
;                                     ^
;       -------------------------------------------------

;           |<--->|     |<--->|
;          rule-21.1    rule-21.1

;   Contract:
;   mosis:rule-21.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-21.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           3           -1
    (define table-21.1 '#(2 2 3 -1))

;   Definition:
    (define mosis:rule-21.1
        (lambda (tech)
            (look-up tech table-21.1)))

;;  ------------    mosis:rule-21.2     -------------------------------

;       Mimimum via3 spacing

;       -------------------------------------------------
;       metal3
;           +-----+     +-----+
;           | via3|     | via3|
;           +-----+     +-----+
;
;       -------------------------------------------------

;                 |<--->|
;                rule-21.2

;   Contract:
;   mosis:rule-21.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-21.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-21.2 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-21.2
        (lambda (tech)
            (look-up tech table-21.2)))

;;  ------------    mosis:rule-21.3     -------------------------------

;       Mimimum overlap by metal3

;       -------------------------------------------------
;       metal3
;           +-----+     +-----+
;           | via3|     | via3|       v
;           +-----+     +-----+     -----
;                                     | rule-21.3
;       -------------------------------------------------
;                                     ^

;   Contract:
;   mosis:rule-21.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-21.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-21.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-21.3
        (lambda (tech)
            (look-up tech table-21.3)))

;;  -------------------------------------------------------------------
;;                  METAL4
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal4      \       /               \       / metal4\
;   -------------------------.......---------------------
;   oxide                    | via3|                oxide
;                        ----.......---------------------
;                       /                          metal3
;   -----------------------------------------------------

;;  ------------    mosis:rule-22.1     -------------------------------

;       Minimum metal4 width

;                           rule-22.1           rule-22.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal4|           | metal4|           | metal4|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via3 |   | metal3|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-22.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-22.1 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           6           3           -1
;   (define table-22.1 '#(6 6 -1 -1)) ; 4 metal
;   (define table-22.1 '#(-1 3 3 -1)) ; 5+ metal
    (define table-22.1 '#(6 6 3 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-22.1
        (lambda (tech)
            (look-up tech table-22.1)))

;;  ------------    mosis:rule-22.2     -------------------------------

;       Minimal spacing between metal4

;   ------------+           +-------+           +-------+
;         metal4|           | metal4|           | metal4|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via3 |   | metal3|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                       rule-22.2

;   Contract:
;   mosis:rule-22.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-22.2 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       6           6           4           -1
;   (define table-22.2 '#(6 6 -1 -1)) ; 4 metal
;   (define table-22.2 '#(-1 3 4 -1)) ; 5+ metal
    (define table-22.2 '#(6 6 4 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-22.2
        (lambda (tech)
            (look-up tech table-22.2)))

;;  ------------    mosis:rule-22.3     -------------------------------

;       Minimum overlap of via3

;                                 rule-22.3
;                                  >|---|<

;   ------------+           +-------+           +-------+
;         metal4|           | metal4|           | metal4|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via3 |   | metal3|       |
;               |       |   |       |   |   v   |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |   | rule-22.3 |
;   ------------+       +---------------+ ----- +-------+
;                                           ^
;                      >|---|<     >|---|<
;                     rule-22.3   rule-22.3

;   Contract:
;   mosis:rule-22.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-22.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       2           2           1           -1
;   (define table-22.3 '#(2 2 -1 -1)) ; 4 metal
;   (define table-22.3 '#(-1 1 1 -1)) ; 5+ metal
    (define table-22.3 '#(2 2 1 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-22.3
        (lambda (tech)
            (look-up tech table-22.3)))

;;  ------------    mosis:rule-22.4     -------------------------------

;       Minimum spacing when either metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal4|           | metal4|           | metal4|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via3 |   | metal3|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;               rule-22.4

;   Contract:
;   mosis:rule-22.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-22.4 "SUBM") => 12

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       12          12          8           -1
;   (define table-22.4 '#(12 12 -1 -1)) ; 4 metal
;   (define table-22.4 '#(-1 6 8 -1)) ; 5+ metal
    (define table-22.4 '#(12 12 8 -1)) ; mixed-up !!

;   Definition:
    (define mosis:rule-22.4
        (lambda (tech)
            (look-up tech table-22.4)))

;;  -------------------------------------------------------------------
;;                  POLY_CAP
;;  -------------------------------------------------------------------

;       NOT IMPLEMENTED YET

;;  ------------    mosis:rule-23.1     -------------------------------

;   Contract:
;   mosis:rule-23.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.1 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.1
        (lambda (tech)
            (look-up tech table-23.1)))

;;  ------------    mosis:rule-23.2     -------------------------------

;   Contract:
;   mosis:rule-23.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.2 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.2
        (lambda (tech)
            (look-up tech table-23.2)))

;;  ------------    mosis:rule-23.3     -------------------------------

;   Contract:
;   mosis:rule-23.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.3 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.3
        (lambda (tech)
            (look-up tech table-23.3)))

;;  ------------    mosis:rule-23.4     -------------------------------

;   Contract:
;   mosis:rule-23.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.4 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.4
        (lambda (tech)
            (look-up tech table-23.4)))

;;  ------------    mosis:rule-23.5     -------------------------------

;   Contract:
;   mosis:rule-23.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.5 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.5
        (lambda (tech)
            (look-up tech table-23.5)))

;;  ------------    mosis:rule-23.6     -------------------------------

;   Contract:
;   mosis:rule-23.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.6 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.6 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.6
        (lambda (tech)
            (look-up tech table-23.6)))

;;  ------------    mosis:rule-23.7     -------------------------------

;   Contract:
;   mosis:rule-23.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.7 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.7 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.7
        (lambda (tech)
            (look-up tech table-23.7)))

;;  ------------    mosis:rule-23.8     -------------------------------

;   Contract:
;   mosis:rule-23.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.8 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.8 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.8
        (lambda (tech)
            (look-up tech table-23.8)))

;;  ------------    mosis:rule-23.9     -------------------------------

;   Contract:
;   mosis:rule-23.9 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-23.9 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-23.9 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-23.9
        (lambda (tech)
            (look-up tech table-23.9)))

;;  -------------------------------------------------------------------
;;                  THICK ACTIVE
;;  -------------------------------------------------------------------

;       cross section:

;       _______________________________________________________
;       /// |  \p+ active p+/  | ///// |  \n+ active n+/  | ///
;       /// |                  | ///// |                  | ///
;       /// |                  | ///// |                  | ///
;       /// \_______nwell______/ ///// \_______pwell______/ ///
;       ////                    ///////                    ////
;       ////////////////////// substrate //////////////////////

;;  ------------    mosis:rule-24.1     -------------------------------

;       Minimum thick-active width

;              +------------+             +------------+    ----
;              |   active   |             |   active   |      ^
;              |            |             |            |      |
;              |            |             |            |      | rule-24.1
;              |            |             |            |      |
;              |            |             |            |      v
;              +------------+             +------------+    ----
;
;              |<---------->|             |<---------->|
;                 rule-24.1                 rule-24.1

;   Contract:
;   mosis:rule-24.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-24.1 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-24.1 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-24.1
        (lambda (tech)
            (look-up tech table-24.1)))

;;  ------------    mosis:rule-24.2     -------------------------------

;       Minimum thick-active spacing

;              +------------+             +------------+
;              |   active   |             |   active   |
;              |            |             |            |
;              |            |             |            |
;              |            |             |            |
;              |            |             |            |
;              +------------+             +------------+

;                           |<---------->|
;                              rule-24.2

;   Contract:
;   mosis:rule-24.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-24.2 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-24.2 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-24.2
        (lambda (tech)
            (look-up tech table-24.2)))

;;  ------------    mosis:rule-24.3     -------------------------------

;       Minimum thick-active overlap

;   Contract:
;   mosis:rule-24.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-24.3 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-24.3 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-24.3
        (lambda (tech)
            (look-up tech table-24.3)))

;;  ------------    mosis:rule-24.4     -------------------------------

;       Minimum space to external active

;   Contract:
;   mosis:rule-24.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-24.4 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       4           4           4           -1
    (define table-24.4 '#(4 4 4 -1))

;   Definition:
    (define mosis:rule-24.4
        (lambda (tech)
            (look-up tech table-24.4)))

;;  ------------    mosis:rule-24.5     -------------------------------

;       Minimum poly width in a thick-active gate

;       ___________      ________poly_________      ________
;                  |    |                     |    |
;              +---|----|---+             +---|----|---+
;              |   |    |   |             |   |    |   |
;              |   |    |   |             |   |    |   |
;              |   |    |   |             |   |    |   |
;              +---|----|---+             +---|----|---+
;                  |____|                     |____|

;                 >|----|<                   >|----|<
;                rule-24.5                  rule-24.5

;   Contract:
;   mosis:rule-24.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-24.5 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-24.5 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-24.5
        (lambda (tech)
            (look-up tech table-24.5)))

;;  -------------------------------------------------------------------
;;                  VIA4
;;  -------------------------------------------------------------------

;       cross section:

;       ----.......-----.......--------------------------
;           | via4|     | via4|               field oxide
;       ----.......-----.......--------------------------
;       metal4

;;  ------------    mosis:rule-25.1     -------------------------------

;       Exact via4 size

;       -------------------------------------------------
;       metal4                        v
;           +-----+     +-----+     -----
;           | via4|     | via4|       | rule-25.1
;           +-----+     +-----+     -----
;                                     ^
;       -------------------------------------------------

;           |<--->|     |<--->|
;          rule-25.1    rule-25.1

;   Contract:
;   mosis:rule-25.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-25.1 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           2           3           -1
    (define table-25.1 '#(-1 2 3 -1))

;   Definition:
    (define mosis:rule-25.1
        (lambda (tech)
            (look-up tech table-25.1)))

;;  ------------    mosis:rule-25.2     -------------------------------

;       Mimimum via4 spacing

;       -------------------------------------------------
;       metal4
;           +-----+     +-----+
;           | via4|     | via4|
;           +-----+     +-----+
;
;       -------------------------------------------------

;                 |<--->|
;                rule-25.2

;   Contract:
;   mosis:rule-25.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-25.2 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       3           3           3           -1
    (define table-25.2 '#(3 3 3 -1))

;   Definition:
    (define mosis:rule-25.2
        (lambda (tech)
            (look-up tech table-25.2)))

;;  ------------    mosis:rule-25.3     -------------------------------

;       Mimimum overlap by metal4

;       -------------------------------------------------
;       metal4
;           +-----+     +-----+
;           | via4|     | via4|       v
;           +-----+     +-----+     -----
;                                     | rule-25.3
;       -------------------------------------------------
;                                     ^

;   Contract:
;   mosis:rule-25.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-25.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;       1           1           1           -1
    (define table-25.3 '#(1 1 1 -1))

;   Definition:
    (define mosis:rule-25.3
        (lambda (tech)
            (look-up tech table-25.3)))

;;  -------------------------------------------------------------------
;;                  METAL5
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal5      \       /               \       / metal5\
;   -------------------------.......---------------------
;   oxide                    | via4|                oxide
;                        ----.......---------------------
;                       /                          metal4
;   -----------------------------------------------------

;;  ------------    mosis:rule-26.1     -------------------------------

;       Minimum metal5 width

;                           rule-26.1           rule-26.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal5|           | metal5|           | metal5|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via4 |   | metal4|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-26.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-26.1 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           4           3           -1
    (define table-26.1 '#(-1 4 4 1)) ; 5 metal
;   (define table-26.1 '#(-1 3 3 -1)) ; 6+ metal

;   Definition:
    (define mosis:rule-26.1
        (lambda (tech)
            (look-up tech table-26.1)))

;;  ------------    mosis:rule-26.2     -------------------------------

;       Minimal spacing between metal5

;   ------------+           +-------+           +-------+
;         metal5|           | metal5|           | metal5|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via4 |   | metal4|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                       rule-26.2

;   Contract:
;   mosis:rule-26.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-26.2 "SUBM") => 6

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           4           4           -1
    (define table-26.2 '#(-1 4 4 -1)) ; 5 metal
;   (define table-26.2 '#(-1 3 3 -1)) ; 6+ metal

;   Definition:
    (define mosis:rule-26.2
        (lambda (tech)
            (look-up tech table-26.2)))

;;  ------------    mosis:rule-26.3     -------------------------------

;       Minimum overlap of via4

;                                 rule-26.3
;                                  >|---|<

;   ------------+           +-------+           +-------+
;         metal5|           | metal5|           | metal5|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via4 |   | metal4|       |
;               |       |   |       |   |   v   |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |   | rule-26.3 |
;   ------------+       +---------------+ ----- +-------+
;                                           ^
;                      >|---|<     >|---|<
;                     rule-26.3   rule-26.3

;   Contract:
;   mosis:rule-26.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-26.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           1           1           -1
    (define table-26.3 '#(-1 1 2 -1)) ; 5 metal
;   (define table-26.3 '#(-1 1 1 -1)) ; 6+ metal

;   Definition:
    (define mosis:rule-26.3
        (lambda (tech)
            (look-up tech table-26.3)))

;;  ------------    mosis:rule-26.4     -------------------------------

;       Minimum spacing when either metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal5|           | metal5|           | metal5|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via4 |   | metal4|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;               rule-26.4

;   Contract:
;   mosis:rule-26.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-26.4 "SUBM") => 8

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           8           8           -1
    (define table-26.4 '#(-1 8 8 -1)) ; 5 metal
;   (define table-26.4 '#(-1 6 8 -1)) ; 6+ metal

;   Definition:
    (define mosis:rule-26.4
        (lambda (tech)
            (look-up tech table-26.4)))

;;  -------------------------------------------------------------------
;;                  HIGH RES
;;  -------------------------------------------------------------------

;       NOT IMPLEMENTED YET

;;  ------------    mosis:rule-27.1     -------------------------------

;   Contract:
;   mosis:rule-27.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.1 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.1
        (lambda (tech)
            (look-up tech table-27.1)))

;;  ------------    mosis:rule-27.2     -------------------------------

;   Contract:
;   mosis:rule-27.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.2 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.2
        (lambda (tech)
            (look-up tech table-27.2)))

;;  ------------    mosis:rule-27.3     -------------------------------

;   Contract:
;   mosis:rule-27.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.3 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.3
        (lambda (tech)
            (look-up tech table-27.3)))

;;  ------------    mosis:rule-27.4     -------------------------------

;   Contract:
;   mosis:rule-27.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.4 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.4
        (lambda (tech)
            (look-up tech table-27.4)))

;;  ------------    mosis:rule-27.5     -------------------------------

;   Contract:
;   mosis:rule-27.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.5 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.5
        (lambda (tech)
            (look-up tech table-27.5)))

;;  ------------    mosis:rule-27.6     -------------------------------

;   Contract:
;   mosis:rule-27.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.6 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.6 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.6
        (lambda (tech)
            (look-up tech table-27.6)))

;;  ------------    mosis:rule-27.7     -------------------------------

;   Contract:
;   mosis:rule-27.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.7 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.7 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.7
        (lambda (tech)
            (look-up tech table-27.7)))

;;  ------------    mosis:rule-27.8     -------------------------------

;   Contract:
;   mosis:rule-27.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.8 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.8 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.8
        (lambda (tech)
            (look-up tech table-27.8)))

;;  ------------    mosis:rule-27.9     -------------------------------

;   Contract:
;   mosis:rule-27.9 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-27.9 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-27.9 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-27.9
        (lambda (tech)
            (look-up tech table-27.9)))

;;  -------------------------------------------------------------------
;;                  CAP_TOP_METAL
;;  -------------------------------------------------------------------

;       NOT IMPLEMENTED YET

;;  ------------    mosis:rule-28.1     -------------------------------

;   Contract:
;   mosis:rule-28.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.1 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.1
        (lambda (tech)
            (look-up tech table-28.1)))

;;  ------------    mosis:rule-28.2     -------------------------------

;   Contract:
;   mosis:rule-28.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.2 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.2
        (lambda (tech)
            (look-up tech table-28.2)))

;;  ------------    mosis:rule-28.3     -------------------------------

;   Contract:
;   mosis:rule-28.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.3 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.3
        (lambda (tech)
            (look-up tech table-28.3)))

;;  ------------    mosis:rule-28.4     -------------------------------

;   Contract:
;   mosis:rule-28.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.4 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.4
        (lambda (tech)
            (look-up tech table-28.4)))

;;  ------------    mosis:rule-28.5     -------------------------------

;   Contract:
;   mosis:rule-28.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.5 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.5
        (lambda (tech)
            (look-up tech table-28.5)))

;;  ------------    mosis:rule-28.6     -------------------------------

;   Contract:
;   mosis:rule-28.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.6 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.6 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.6
        (lambda (tech)
            (look-up tech table-28.6)))

;;  ------------    mosis:rule-28.7     -------------------------------

;   Contract:
;   mosis:rule-28.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.7 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.7 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.7
        (lambda (tech)
            (look-up tech table-28.7)))

;;  ------------    mosis:rule-28.8     -------------------------------

;   Contract:
;   mosis:rule-28.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.8 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.8 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.8
        (lambda (tech)
            (look-up tech table-28.8)))

;;  ------------    mosis:rule-28.9     -------------------------------

;   Contract:
;   mosis:rule-28.9 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.9 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.9 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.9
        (lambda (tech)
            (look-up tech table-28.9)))

;;  ------------    mosis:rule-28.10    -------------------------------

;   Contract:
;   mosis:rule-28.10 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.10 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.10 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.10
        (lambda (tech)
            (look-up tech table-28.10)))

;;  ------------    mosis:rule-28.11    -------------------------------

;   Contract:
;   mosis:rule-28.11 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.11 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.11 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.11
        (lambda (tech)
            (look-up tech table-28.11)))

;;  ------------    mosis:rule-28.12    -------------------------------

;   Contract:
;   mosis:rule-28.12 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.12 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.12 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.12
        (lambda (tech)
            (look-up tech table-28.12)))

;;  ------------    mosis:rule-28.13    -------------------------------

;   Contract:
;   mosis:rule-28.13 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.13 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.13 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.13
        (lambda (tech)
            (look-up tech table-28.13)))

;;  ------------    mosis:rule-28.14    -------------------------------

;   Contract:
;   mosis:rule-28.14 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.14 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.14 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.14
        (lambda (tech)
            (look-up tech table-28.14)))

;;  ------------    mosis:rule-28.15    -------------------------------

;   Contract:
;   mosis:rule-28.15 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-28.15 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-28.15 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-28.15
        (lambda (tech)
            (look-up tech table-28.15)))

;;  -------------------------------------------------------------------
;;                  VIA5
;;  -------------------------------------------------------------------

;       cross section:

;       ----.......-----.......--------------------------
;           | via5|     | via5|               field oxide
;       ----.......-----.......--------------------------
;       metal5

;;  ------------    mosis:rule-29.1     -------------------------------

;       Exact via5 size

;       -------------------------------------------------
;       metal5                        v
;           +-----+     +-----+     -----
;           | via5|     | via5|       | rule-29.1
;           +-----+     +-----+     -----
;                                     ^
;       -------------------------------------------------

;           |<--->|     |<--->|
;          rule-29.1    rule-29.1

;   Contract:
;   mosis:rule-29.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-29.1 "SUBM") => 3

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           3           4           -1
    (define table-29.1 '#(-1 3 4 -1))

;   Definition:
    (define mosis:rule-29.1
        (lambda (tech)
            (look-up tech table-29.1)))

;;  ------------    mosis:rule-29.2     -------------------------------

;       Mimimum via5 spacing

;       -------------------------------------------------
;       metal5
;           +-----+     +-----+
;           | via5|     | via5|
;           +-----+     +-----+
;
;       -------------------------------------------------

;                 |<--->|
;                rule-29.2

;   Contract:
;   mosis:rule-29.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-29.2 "SUBM") => 4

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           4           4           -1
    (define table-29.2 '#(-1 4 4 -1))

;   Definition:
    (define mosis:rule-29.2
        (lambda (tech)
            (look-up tech table-29.2)))

;;  ------------    mosis:rule-29.3     -------------------------------

;       Mimimum overlap by metal5

;       -------------------------------------------------
;       metal5
;           +-----+     +-----+
;           | via5|     | via5|       v
;           +-----+     +-----+     -----
;                                     | rule-29.3
;       -------------------------------------------------
;                                     ^

;   Contract:
;   mosis:rule-29.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-29.3 "SUBM") => 1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           1           1           -1
    (define table-29.3 '#(-1 1 1 -1))

;   Definition:
    (define mosis:rule-29.3
        (lambda (tech)
            (look-up tech table-29.3)))

;;  -------------------------------------------------------------------
;;                  METAL6
;;  -------------------------------------------------------------------

;       cross section:

;   ------------         ---------------         -------
;   metal6      \       /               \       / metal6\
;   -------------------------.......---------------------
;   oxide                    | via5|                oxide
;                        ----.......---------------------
;                       /                          metal5
;   -----------------------------------------------------

;;  ------------    mosis:rule-30.1     -------------------------------

;       Minimum metal5 width

;                           rule-30.1           rule-30.1
;                           |<----->|           |<----->|

;   ------------+           +-------+           +-------+
;         metal6|           | metal6|           | metal6|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via5 |   | metal5|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;   Contract:
;   mosis:rule-30.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-30.1 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           5           5           -1
    (define table-30.1 '#(-1 5 5 1)) ; 6 metal

;   Definition:
    (define mosis:rule-30.1
        (lambda (tech)
            (look-up tech table-30.1)))

;;  ------------    mosis:rule-30.2     -------------------------------

;       Minimal spacing between metal5

;   ------------+           +-------+           +-------+
;         metal6|           | metal6|           | metal6|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via5 |   | metal5|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;                                       |<----->|
;                                       rule-23.2

;   Contract:
;   mosis:rule-30.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-30.2 "SUBM") => 5

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           5           5           -1
    (define table-30.2 '#(-1 5 5 -1)) ; 6 metal

;   Definition:
    (define mosis:rule-30.2
        (lambda (tech)
            (look-up tech table-30.2)))

;;  ------------    mosis:rule-30.3     -------------------------------

;       Minimum overlap of via5

;                                 rule-30.3
;                                  >|---|<

;   ------------+           +-------+           +-------+
;         metal6|           | metal6|           | metal6|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via5 |   | metal5|       |
;               |       |   |       |   |   v   |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |   | rule-30.3 |
;   ------------+       +---------------+ ----- +-------+
;                                           ^
;                      >|---|<     >|---|<
;                     rule-30.3   rule-30.3

;   Contract:
;   mosis:rule-30.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-30.3 "SUBM") => 2

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           1           2           -1
    (define table-30.3 '#(-1 1 2 -1)) ; 6 metal

;   Definition:
    (define mosis:rule-30.3
        (lambda (tech)
            (look-up tech table-30.3)))

;;  ------------    mosis:rule-30.4     -------------------------------

;       Minimum spacing when either metal line is wider than 10 lambda
;       ("Big metal").

;   ------------+           +-------+           +-------+
;         metal6|           | metal6|           | metal6|
;               |           |       |           |       |
;               |           |       |           |       |
;               |       +---+       +---+       |       |
;               |       |               |       |       |
;               |       |   +-------+   |-------|       |----
;               |       |   |  via5 |   | metal5|       |
;               |       |   |       |   |       |       |
;   "big metal" |       |   +-------+   |-------|       |----
;   > 10 lambda |       |               |       |       |
;   ------------+       +---------------+       +-------+

;               |<----->|
;               rule-30.4

;   Contract:
;   mosis:rule-30.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-30.4 "SUBM") => 8

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           10          10          -1
    (define table-30.4 '#(-1 10 10 -1)) ; 6 metal

;   Definition:
    (define mosis:rule-30.4
        (lambda (tech)
            (look-up tech table-30.4)))

;;  -------------------------------------------------------------------
;;                  DEEP_N_WEL
;;  -------------------------------------------------------------------

;       NOT IMPLEMENTED YET

;;  ------------    mosis:rule-31.1     -------------------------------

;   Contract:
;   mosis:rule-31.1 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.1 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.1 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.1
        (lambda (tech)
            (look-up tech table-31.1)))

;;  ------------    mosis:rule-31.2     -------------------------------

;   Contract:
;   mosis:rule-31.2 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.2 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.2 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.2
        (lambda (tech)
            (look-up tech table-31.2)))

;;  ------------    mosis:rule-31.3     -------------------------------

;   Contract:
;   mosis:rule-31.3 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.3 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.3 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.3
        (lambda (tech)
            (look-up tech table-31.3)))

;;  ------------    mosis:rule-31.4     -------------------------------

;   Contract:
;   mosis:rule-31.4 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.4 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.4 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.4
        (lambda (tech)
            (look-up tech table-31.4)))

;;  ------------    mosis:rule-31.5     -------------------------------

;   Contract:
;   mosis:rule-31.5 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.5 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.5 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.5
        (lambda (tech)
            (look-up tech table-31.5)))

;;  ------------    mosis:rule-31.6     -------------------------------

;   Contract:
;   mosis:rule-31.6 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.6 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.6 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.6
        (lambda (tech)
            (look-up tech table-31.6)))

;;  ------------    mosis:rule-31.7     -------------------------------

;   Contract:
;   mosis:rule-31.7 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.7 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.7 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.7
        (lambda (tech)
            (look-up tech table-31.7)))

;;  ------------    mosis:rule-31.8     -------------------------------

;   Contract:
;   mosis:rule-31.8 : tech -> lambda

;   Purpose:
;   deliver rule value according tech

;   Example:
;   (mosis:rule-31.8 "SUBM") => -1

;   +-----------+-----------+-----------+-----------+
;   |  SCMOS    |   SUBM    |   DEEP    |   USER    |
;   +-----------+-----------+-----------+-----------+
;      -1           -1          -1          -1
    (define table-31.8 '#(-1 -1 -1 -1))

;   Definition:
    (define mosis:rule-31.8
        (lambda (tech)
            (look-up tech table-31.8)))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)

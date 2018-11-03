#   'How to get a cell out of which cell?'
#
#   README for Cell Generation
#   Just for the protocol, hopefully a complete list
#   noted in a makefile style



AND4: NAND3
	popcorn -c AND4 -n nand -b NAND3.cell

AOI21: NOR
	popcorn -c AOI21 -n nand NOR2.cell

AOI31: AOI21
	popcorn -c AOI31 -n nand AOI21.cell

NAND2: INV
	popcorn -c NAND2 -n nand INV.cell

NAND3: NAND2
	popcorn -c NAND3 -n nand NAND2.cell

NOR2: NNV
	popcorn -c NOR2 -n nor INV.cell

NOR3: NOR2
	popcorn -c NOR3 -n nor NOR2.cell

OAI21: NAND2
	popcorn -c OAI21 -n nor NAND2.cell

OAI31: OAI21
	popcorn -c OAI31 -n nor OAI21.cell

OR4: NOR3
	popcorn -c OR4 -n nor -b NOR3.cell


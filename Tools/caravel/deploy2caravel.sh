#!/bin/bash
#CARAVEL=/media/philipp/Daten/skywater/caravel-stdcelllib-stdcells

if [ -z "$CARAVEL" ]
then
	echo "Environment variables not found, please run '. env.sh' to define them."
	source env.sh || source ../env.sh
fi

if [ -z "$CARAVEL" ]
then
	echo "Environment variables still not found, please run '. env.sh' to define them."
	exit
fi


mkdir $CARAVEL/cells{,/lib,/lef,/lef/orig,/gds,/mag} 2>/dev/null

echo "Cleaning up old files"
rm -f $CARAVEL/cells/lib/*.lib $CARAVEL/cells/lef/orig/*.lef $CARAVEL/cells/lef/*.lef $CARAVEL/cells/gds/*.gds $CARAVEL/cells/mag/*.mag

cd $STDCELLLIB/Catalog

# The DRC Expander and the DRC Fixer need to run earlier in the StdCellLib instead, this would be too late:
#perl $CARAVEL/scripts/drcexpander.pl $PDK_ROOT/sky130A/libs.tech/magic/sky130A.tech >$CARAVEL/sky130Aexpanded.tech
#perl ../Tools/perl/drcfixall.pl $CARAVEL/sky130Aexpanded.tech

echo "Copying files that were created by StdCellLib"
cp *.mag $CARAVEL/cells/mag/
cp *.lib $CARAVEL/cells/lib/
cp *.cell $CARAVEL/cells/cell/
cp *.sp $CARAVEL/cells/sp/
cp outputlib/*.lef $CARAVEL/cells/lef/orig/
cp outputlib/*.gds $CARAVEL/cells/gds/
rm $CARAVEL/cells/mag/demoboard.mag

echo "Removing cells with DRC issues left"
cd $CARAVEL/cells/mag
rm -f corr.*.mag
perl $CARAVEL/scripts/removeDRCcells.pl

echo "Now cleaning up the files for Sky130"
cd $CARAVEL/cells/lef
perl fixup.pl

cd $CARAVEL/cells/mag
perl fixup.pl

cd $CARAVEL/cells/sp
perl fixup.pl

cd $CARAVEL/cells/lib
rm -f libresilicon.lib new.lib
libertymerge -b $STDCELLLIB/Catalog/libresilicon.libtemplate -o libresilicon.lib -u *.lib
perl removenl.pl >new.lib
mv new.lib libresilicon.lib

echo "Now generating the demo wafer, the macro placement and the test-bench"

perl $CARAVEL/scripts/generator.pl >$CARAVEL/verilog/rtl/user_proj_example.v
perl $CARAVEL/scripts/cells.pl >$CARAVEL/verilog/rtl/user_proj_cells.v
perl $CARAVEL/scripts/placement.pl >$CARAVEL/openlane/user_proj_example/macro_placement.cfg

cd $CARAVEL
#bash my.sh
echo "Now building the Caravel user-project"
make user_proj_example && make user_project_wrapper

echo "Deployment done.";

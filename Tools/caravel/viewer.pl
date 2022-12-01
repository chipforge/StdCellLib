#!/usr/bin/perl -w

my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";
my $CARAVEL=$ENV{'CARAVEL'} || "/media/philipp/Daten/skywater/caravel-stdcelllib-stdcells";

open OUT,"|magic -noconsole -T sky130A";
foreach(<$CARAVEL/cells/lef/*.lef>)
{
  print OUT "lef read $_\n";
} 
print OUT "def read ".$ARGV[0]."\n";
#print OUT "select top\n";
close OUT;

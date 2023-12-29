#!/usr/bin/perl -w

my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";
my $CARAVEL=$ENV{'CARAVEL'} || "/media/philipp/Daten/skywater/caravel-stdcelllib-stdcells";
my $magictech=$ARGV[0] || "sky130A";


open OUT,"|magic -noconsole -T $magictech";
foreach(<$CARAVEL/cells/lef/*.lef>)
{
  print OUT "lef read $_\n";
} 
print OUT "def read ".$ARGV[0]."\n";
#print OUT "select top\n";
close OUT;

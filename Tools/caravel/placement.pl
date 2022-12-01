#!/usr/bin/perl -w

my $width=0.48;
my $height=3.33;


my $row=8;

my $xpos=($row%2)? $width*80 : 44.640+0.480;

our $nextla=$height*$row;



my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";

foreach my $mag(sort <$STDCELLLIB/Catalog/*.mag>)
{
  next if((-s $mag)<=50);
  #print `ls -la $mag`;
  my $cell=$mag; $cell=~s/\.mag$/.cell/;
  next unless(-f $cell);
  my $lib=$mag; $lib=~s/\.mag$/.lib/;
  next unless(-f $lib);
  my $name=""; $name=$1 if($mag=~m/([\w\-\.]+)\.mag$/);
  next unless(-f $ENV{'CARAVEL'}."/cells/mag/$name.mag");

  print "$name $xpos $nextla N\n";
  $nextla+=$height*2;
}

#!/usr/bin/perl -w
use strict;

my $cellname=$ARGV[0] || "INV";
my $placer="";
my $deb=0;

open IN,"<../Tech/librecell_tech.py.bad";
my @bad=<IN>;
close IN;

open IN,"<../Tech/librecell_tech.py.good";
my @good=<IN>;
close IN;

my $ndiffs=0;

foreach(0 .. scalar(@bad)-1)
{
  $ndiffs++ if($bad[$_] ne $good[$_]);
}

print "Different lines between librecell_tech.py.good and librecell_tech.py.bad: $ndiffs\n";

my $prev=undef;

my %badlist=();

foreach my $variant (0 .. $ndiffs+1)
{
  open OUT,">../Tech/librecell_tech.$variant.py";
  my $counter=0;
  foreach(0 .. scalar(@bad)-1)
  {
    if($bad[$_] ne $good[$_])
    {
      $counter++;
      print OUT defined($badlist{$counter})?$good[$_]:($counter>$variant)?$good[$_]:$bad[$_];
    }
    else
    {
      print OUT $good[$_];
    }

  }
  close OUT;
  my $ret=system "lclayout --output-dir debuglib --tech ../Tech/librecell_tech.$variant.py --netlist $cellname.sp --cell $cellname -v $placer --placement-file $cellname.place --ignore-lvs ".($deb?"--debug-routing-graph ":"")." >>$cellname.$variant.log 2>>$cellname.$variant.err ";
  print "Variant: $variant Return: $ret\n";

  if($ret != 0) # indicates an error
  {
    print "Bad Line found: \n";
    system "diff ../Tech/librecell_tech.$variant.py ../Tech/librecell_tech.".($variant-1).".py";
    $badlist{$variant}=1;
  }

}

print "Activating the best option:\n";
system "cp -f ../Tech/librecell_tech.".($ndiffs+1).".py ../Tech/librecell_tech.py";


#!/usr/bin/perl -w
use strict;

if(scalar(@ARGV) != 2)
{
  print "Usage: $0 <input.cir> <output.sp>\n";
  print "All VDD, GND and all inputs/output nets to the cell must be labled in LTspice.\n";
  exit;
}



my $circuitname=$ARGV[1]; $circuitname=~s/\.\w+$//; $circuitname=~s/.*\///;
if(open(IN,"<$ARGV[0]"))
{
  if(open(OUT,">$ARGV[1]"))
  {
    my $head=<IN>; $head=~s/\r//g;
    print OUT "* converted by $0 : $head";
    my %ports=();
    my $circ="";
    while(<IN>)
    {
      s/\r//g;
      s/ 0 / GND /g;
      s/ 0 / GND /g; # This needs to be done 2 times since they are overlapping!
      my @a=split(" ",$_);
      $circ.=$_ if(m/^[MR]/);
      $ports{$a[1]}=1 if(m/^M/ && $a[1]!~m/^N\d\d\d$/);
      $ports{$a[2]}=1 if(m/^M/ && $a[2]!~m/^N\d\d\d$/);
      $ports{$a[3]}=1 if(m/^M/ && $a[3]!~m/^N\d\d\d$/);
      $ports{$a[4]}=1 if(m/^M/ && $a[4]!~m/^N\d\d\d$/);
    }
    print OUT ".subckt $circuitname ".join(" ",sort keys %ports)."\n";
    print OUT $circ;
    print OUT ".ends $circuitname";
    close OUT;
    print "$ARGV[1] has been written.\n";
  }
  else
  {
    print "Could not open $ARGV[1] for writing: $!\n";
  } 
  close IN;
}
else
{
  print "Could not open $ARGV[0] for reading: $!\n";
} 



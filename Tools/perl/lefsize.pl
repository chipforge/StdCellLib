#!/usr/bin/perl -w
use strict;



sub mymin($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[1]:$_[0];
}

sub mymax($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[0]:$_[1];
}

foreach my $mag(<*.mag>)
{
  my $cellname=$mag; $cellname=~s/\.mag$//;
  next if(defined($ENV{'CELL'}) && $ENV{'CELL'} ne $cellname);
  next unless(-f "$cellname.cell"); # We only want generated cells, no demoboards or other stuff

  my @mins=();
  my @maxs=();

  if(open(IN,"<$mag"))
  {
    while(<IN>)
    {
      if(m/^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/)
      { 
        my @a=split " ",$_;
        foreach(1 .. 4)
        {
          $mins[$_&1]=mymin($mins[$_&1],$a[$_]);
          $maxs[$_&1]=mymax($maxs[$_&1],$a[$_]);
        }
      }
    }
    close IN;
  }
  my @inputs=();
  my @outputs=();
  if(open(IN,"<$cellname.cell"))
  {
    #print STDERR "Reading $cellname.cell\n";
    while(<IN>)
    {
      @inputs=split " ",$1 if(m/^\.inputs (.*)/);
      @outputs=split " ",$1 if(m/^\.outputs (.*)/);
    }
    close IN;
  }
  else
  {
    print STDERR "Could not read cell $cellname.cell: $!\n";
  }
  my $area=defined($maxs[0])?"SIZE ".($maxs[0]-$mins[0])." BY ".($maxs[1]-$mins[1])." ;":"";

  print "$cellname\n$area\n";
}


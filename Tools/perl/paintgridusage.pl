#!/usr/bin/perl -w

print "This tool analyzes the available, used and unused grid:\n";
my $cellname=$ARGV[0] || "INV";
open MAGIN,"<$cellname.mag";
open REPORT,"<$cellname.err";
#open REPIN,"<$cellname.log";
open MAGOUT,">$cellname.grid.mag";
my $fac=50;
my $s=1;
my $t=2;
while(<MAGIN>)
{
  if(/<< labels >>/)
  {
    # Unused tracks
    while (my $line=<REPORT>)
    {
      if($line=~m/Unused tracks \(x coordinates\): \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
	  $_=int($_/$fac);
          print MAGOUT "<< met1 >>\nrect $_ -10 ".($_+$s)." $t\n";
        }
      }
      if($line=~m/Unused tracks \(y coordinates\): \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
	  $_=int($_/$fac);
          print MAGOUT "<< met1 >>\nrect -10 $_ $t ".($_+$s)."\n";
        }
      }
      if($line=~m/grid_xs: \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
          $_=int($_/$fac);
          print MAGOUT "<< met2 >>\nrect $_ -20 ".($_+$s)." -11\n";
        }
      }
      if($line=~m/grid_ys: \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
          $_=int($_/$fac);
          print MAGOUT "<< met2 >>\nrect -20 $_ -10 ".($_+$s)."\n";
        }
      }
    }
  }
  print MAGOUT $_;
}
close MAGIN;
close REPORT;
#close REPIN;
close MAGOUT;
print "Writing to $cellname.grid.mag\n";

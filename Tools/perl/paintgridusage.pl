#!/usr/bin/perl -w

print "This tool analyzes the available, used and unused grid:\n";
my $cellname=$ARGV[0] || "INV";
open MAGIN,"<$cellname.mag";
open REPORT,"<$cellname.err";
#open REPIN,"<$cellname.log";
open MAGOUT,">$cellname.grid.mag";
my $fac=5;
my $s=5;
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
          print MAGOUT "<< met1 >>\nrect $_ -100 ".($_+$s)." $t\n";
        }
      }
      if($line=~m/Unused tracks \(y coordinates\): \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
	  $_=int($_/$fac);
          print MAGOUT "<< met1 >>\nrect -100 $_ $t ".($_+$s)."\n";
        }
      }
      if($line=~m/grid_xs: \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
          $_=int($_/$fac);
          print MAGOUT "<< met2 >>\nrect $_ -200 ".($_+$s)." -110\n";
        }
      }
      if($line=~m/grid_ys: \[(.*?)\]/)
      {
        foreach(split(",",$1))
        {
          $_=int($_/$fac);
          print MAGOUT "<< met2 >>\nrect -200 $_ -100 ".($_+$s)."\n";
        }
      }
      if($line=~m/via cost: (\d+) \((-?\d+),(-?\d+)\) (\w+)/)
      {
        my $x=int($2/$fac);
	my $y=int($3/$fac);
        next unless($4 eq "pdiff_contact");
	print "via cost $1 $2 $3 $4\n";
        print MAGOUT "<< ".($1?"via3":"met3")." >>\nrect $x $y ".($x+$s)." ".($y+$s)."\n";
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

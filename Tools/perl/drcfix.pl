#!/usr/bin/perl -w

print "Handling $ARGV[0]\n";
open IN,"<".$ARGV[0];
my $mag=$ARGV[0];$mag=~s/\.drc$//;
my $mode=0;

sub form($)
{
  return int($_[0]*100);
}

while(<IN>)
{
  if(m/Mcon spacing < 0\.17um \(Mcon 2\)/)
  {
    $mode=1;
    my $dummy=<IN>;
    print "Found my rule\n";
    next;
  }
  if(m/\-\-\-\-\-\-\-\-\-\-\-/)
  {
    $mode=0;
    print "End of rule\n";
    next;
  }


  if($mode eq 1)
  {
    my @line1=split " ",$_;
    my $l2=<IN>;
    my @line2=split " ",$l2;
    print "LINE1 (@line1): $_\nLINE2 (@line2): $l2\n";
    if($line1[0] eq $line2[0] && $line1[2] eq $line2[2] && $line1[1]<$line2[1])
    {
      print "Vertikal\n";
      print "@line1 - @line2\n";
      open MAG,"<$mag";
      open CORR,">corr.$mag";
      print "Reading from $mag Writing to $mag\n";
      while(<MAG>)
      {
        print CORR $_;
        if(m/<< viali >>/)
        {	
          print CORR "<< viali >>\nrect ".form($line1[0])." ".form($line1[3])." ".form($line1[2])." ".form($line2[1])."\n";
	  while(<MAG>)
	  {
            print CORR $_;
          }
	}
      }
      close CORR;
      close MAG;
    }

  }
}
close IN;

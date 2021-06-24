#!/usr/bin/perl -w

sub step($)
{
  print "$_[0]\n";
}

my $tech=$ARGV[0] || "../Tech/libresilicon.tech";

foreach my $magfile (<*.mag>)
{
  next if($magfile=~m/^corr_/); # Ignore correction files
  next if($magfile eq "demoboard.mag");
  my $cellname=$magfile; $cellname=~s/\.mag$//;	

  step("NEXT STEP: DRC Check with Magic");
  system "../Tools/perl/drccheck.pl $cellname.mag $tech";

  step("NEXT STEP: DRC Fix");
  system "../Tools/perl/drcfix.pl $cellname.drc $tech";

  step("NEXT STEP: DRC Check with Magic");
  system "../Tools/perl/drccheck.pl $cellname.mag $tech";

  if(-f "corr_$cellname.mag")
  {
    unlink "$cellname.mag";
    rename "corr_$cellname.mag","$cellname.mag";
    print "DRC errors in $cellname corrected. Now running final DRC check:\n";
    step("NEXT STEP: Final DRC check");
    system "../Tools/perl/drccheck.pl $cellname.mag $tech";
  }

  #  exit;
}


foreach (<*.cell>)
{
  my $cellname=$_;
  $cellname=~s/\.cell$//;
  next if(-f "$cellname.mag");
  print "We should do $_\n";
  system "touch $_";
  $ENV{'CELL'}=$cellname;
  system "make layout";
}

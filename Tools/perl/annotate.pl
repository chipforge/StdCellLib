#!/usr/bin/perl -w

foreach(<str/*.gds>)
{
  next if(-f "$_.ann");	
  system "klayout -l librecell.lyp $_";
  print "Is it good?\n";
  my $val=<STDIN>;
  print "So you think $val?\n";
  if($val=~m/[eq]/i)
  {
    exit;
  }
  if($val=~m/[yn]/)
  {
    open OUT,">$_.ann";
    print OUT $val;
    close OUT;
  }
}

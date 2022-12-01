#!/usr/bin/perl -w
use strict;

sub readfile($)
{
  if(open MYRIN,"<$_[0]")
  {
    my $old=$/;
    undef $/;
    my $content=<MYRIN>;
    close MYRIN;
    $/=$old;
    return $content;
  }
  return undef;
}

foreach my $sp (<*.sp>)
{
  my $content=readfile($sp);
  $content=~s/\bvdd\b/VPWR/g;
  $content=~s/\bgnd\b/VGND/g;
  open OUT,">$sp";
  print OUT $content;
  close OUT;
}

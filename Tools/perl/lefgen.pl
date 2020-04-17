#!/usr/bin/perl -w
use strict;

# This tool compiles a single LEF from a template for the header and the LEF snippets for each cell

open IN,"<../Tech/template.lef";
print $_ while(<IN>);
close IN;

foreach(@ARGV)
{
  open IN,"<$_";
  while(<IN>)
  {
    print $_;
  }
  close IN;
  print "\n";
}


print "\nEND LIBRARY\n";

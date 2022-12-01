#!/usr/bin/perl -w

my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";



print <<EOF
`default_nettype none

/*
 *-------------------------------------------------------------
 *
 * user_proj_cells  (LibreSilicon Testwafer #1)
 *
 */

EOF
;

our $nextla=0;
our $nextio=0;

foreach my $mag(sort <$STDCELLLIB/Catalog/*.mag>)
{
  next if((-s $mag)<=50);
  #print `ls -la $mag`;
  my $cell=$mag; $cell=~s/\.mag$/.cell/;
  my $lib=$mag; $lib=~s/\.mag$/.lib/;
  my $name=""; $name=$1 if($mag=~m/([\w\-\.]+)\.mag$/);
  next unless(-f $cell);
  next unless(-f $lib);
  next unless(-f $ENV{'CARAVEL'}."/cells/mag/$name.mag");

  open CELL,"<$cell";
  print "module $name(\n";

  while(<CELL>)
  {
    if(m/^\.inputs (.*)/)
    {
      foreach my $inp(sort split " ",$1)
      {
        my $io=$nextio++;
	print "  inout $inp, // input\n";
      }
    }
    if(m/^\.outputs (.*)/)
    {
      foreach my $outp(sort split " ",$1)
      {
        my $io=$nextio++;
	print "  inout $outp, // output\n";
      }
    }

  }
  close CELL;
  print "     \`ifdef USE_POWER_PINS\n";
  print "	inout VPWR, // cell power supply\n";
  print "	inout VGND  // cell ground supply\n";
  print "     \`endif\n";
  print ");\n";
  print "endmodule\n\n";
}


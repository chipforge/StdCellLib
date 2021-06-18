#!/usr/bin/perl -w
open IN,"<$ARGV[0]";

print <<EOF
#include "../../defs.h"
#include "../../stub.c"
EOF
;

my $header=<IN>;
my @l=split "->",$header;
my @ins=split " ",$l[0];
my @outs=split " ",$l[1];
my %map=();

my $reg=0;
my @io=();
print " printf(\"Initializing the Inputs of the cell:\\n\");\n";
foreach(@ins)
{
  print "  reg_mprj_io_$reg = GPIO_MODE_MGMT_STD_OUTPUT; // $_\n";
  $io[$reg>>5]|=1<<($reg&31);
  $reg++;
}
print " printf(\"Initializing the Outputs of the cell:\\n\");\n";
foreach(@outs)
{
  $map{$_}=$reg++;

  print "  reg_mprj_io_$reg = GPIO_MODE_USER_STD_OUTPUT; // $_\n";
}

print "  reg_mprj_xfer=1;\n";
print "  while (reg_mprj_xfer == 1);\n";

foreach(0 .. 3)
{
  print "reg_la".$_."_ena=".sprintf("0x%08X",$io[$_]).";\n" if(defined($io[$_]));
}

my $counter=0;
print " printf(\"Starting the tests:\\n\");\n";

while(<IN>)
{
  last if(m/^function:/);
  @l=split " ",$_;
  my $if=0;
  foreach(@l)
  {
    if(m/(\w+)=(\d)/)
    {
      print "  assert(reg_la".$map{$1}."_data==$2); //$1\n";
    }
    else
    {
      print "  reg_la".$if."_data=$_; //$ins[$if]\n";
    }
    $if++;
  }
  print "  printf(\"Test $counter successful\\n\");\n\n";

  $counter++;
}

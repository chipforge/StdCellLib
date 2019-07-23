#!/usr/bin/perl -w
use strict;

print "searchTechRules.pl searches for working Tech Rules\n";

system "perl ../Tools/perl/cell2spice.pl";

my @params=(
	["unit_cell_width",50,300,5],
	["unit_cell_height",100,500,5],
	["routing_grid_pitch_x",5,40,5],
	["routing_grid_pitch_y",5,40,5],
	["grid_offset_x",0,30,5],
	["grid_offset_y",0,30,5],
	["power_rail_width",20,50,5],
	["minimum_gate_width_nfet",5,30,5],
	["minimum_gate_width_pfet",5,30,5],
	["minimum_pin_width",5,20,5],
);

mkdir "str";
chdir "str";

our $ende=0;

my $cell=$ARGV[0] || "INV";

while(!$ende)
{
  if(-f ".end")
  {
    unlink ".end";
    print "Exiting...\n";
    exit;
  }

  my %par=();
  my @b=();
  foreach my $a (@params)
  {
    my $v=$$a[1]+int(rand(($$a[2]-$$a[1]+1)/$$a[3]))*$$a[3];
    print "$$a[0] $$a[1]-$$a[2] steps:$$a[3] -> $v\n"; 
    exit if($v>$$a[2] || $v<$$a[1]);
    #exit if($v ==$$a[2]);
    $par{$$a[0]}=$v;
    push @b,$v;
  }

  my $fn="ls".join("_",@b);

  open IN,"<../../Tech/libresilicon.py";
  open OUT,">$fn.py";
  while(<IN>)
  {
    if(m/(\w+)\s*=/)
    {
      #print "? $1\n";	    
      if(defined($par{$1}))
      {
        #print "Exchanging $par{$1} into $_";
        $_="$1 = $par{$1}\n";
      }
    }
    print OUT $_;
  }
  close IN;
  close OUT;

  #unlink "$cell.gds";
  system "lclayout --output-dir . --tech $fn.py --netlist ../libresilicon.sp --cell $cell -v 2>$fn.err";
  if(-f "$cell.gds")
  {
    print "We found a solution\n";	    
    system "touch $fn.solution";
    system "klayout $cell.gds" if(-f "$cell.gds");
    exit;
  }
  system "lclayout --output-dir . --tech $fn.py --netlist ../libresilicon.sp --cell $cell -v --debug-routing-graph 2>$fn.gerr";
  if(-f "$cell.gds")
  {
    rename "$cell.gds","$fn.gds";
    system "klayout $fn.gds &" unless(-f ".hide"); 
  }

  #  exit;
}


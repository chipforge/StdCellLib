#!/usr/bin/perl -w
use strict;

##Initialze pointer
my $x=0;
my $y=0;

my $psc_width=4;
my $psc_height=4;
my $psc_spacing=4;

my $poly_width=2;
my $ndc_width=4; # NSC?
my $poly_to_ndc_spacing=1;

my $nwell_over_active=6;

my $poly_over_active=5;

my $ground_strip_height=4;
my $power_strip_height=4;
my $nsc_width=4;
my $nsc_height=4;
my $nsc_spacing=4;
my $extension_over_active=3;
my $poly_to_active_spacing=1;
my $metal_width=3;
my $ndc_to_ndc_spacing=2;
my $active_width=3;
my $ndiff_height=17; 
my $pdiff_height=17;



my $fnin=$ARGV[0] || "../../Catalog/INV.cell";
my $fnout=$ARGV[1] || "output.mag";

my @inputs=();
my @outputs=();

# Loading the cell file and parsing the inputs and outputs:
# TODO: This does not work when the inputs and ouputs are not added in the header!
if(open(IN,"<$fnin"))
{
  print "Parsing $fnin\n";
  while(<IN>)
  {
    @inputs=split " ",$1 if(m/\.inputs (.*)/);
    @outputs=split " ",$1 if(m/\.outputs (.*)/);
  }
  close IN;
}

# Generating the euler path from the cell netlist. We need the nmos transistors and we need the VDD+GND nets.
# TODO: The pmos euler network might not work for the calculated nmos network. How do we want to handle that?
my $euler=`perl euler.pl --network nmos --power $fnin`;
my @eulerp=split ",",$euler;

my @eulers=();
foreach(@eulerp)
{
  push @eulers,$_ if(m/^[A-W]\d*$/); # We extract only the inputs from the euler path which also contained the nets
}


print "Inputs: ".join(",",@inputs)." Outputs: ".join("-",@outputs)." Euler: $euler Eulers: ".join(",",@eulers)."\n";


my $number_of_inputs=scalar(@inputs);
print "Number of Inputs: $number_of_inputs\n";

if($number_of_inputs==0)
{
  print STDERR "Error: No inputs found.\n";
  exit;
}

# Now the graphical dimensions are calculated, primarily based on the number of inputs:
my $poly_spacing= $ndc_width + $poly_to_ndc_spacing*2 ; # =6
my $ndiff_width=$poly_width*$number_of_inputs+$poly_spacing*($number_of_inputs+1); # 12+42=54;
my $ground_strip_width=$nwell_over_active+$ndiff_width+$nwell_over_active; # =66
my $nwell_width=$ground_strip_width; # 66
my $nwell_height=$extension_over_active+$psc_height+$poly_over_active+$ndiff_height+$nwell_over_active; # =35
my $pdiff_width=$ndiff_width;
my $poly_height=52; # TODO this hardcoded value needs to be made dynamic # $extension_over_active+$ndiff_height+$nwell_over_active+?+$pdiff_height+$nwell_over_active
my $power_strip_width=$ground_strip_width; # 66


# Now generate the file for the tool magic:
open MAG,">$fnout";
print MAG "magic\ntech scmos\ntimestamp ".time()."\n";

#box draws a box at position ($x $y $sizex $sizey label)
sub box
{
  print MAG "<< $_[4] >>\nrect $_[0] $_[1] ".($_[0]+$_[2])." ".($_[1]+$_[3])."\n";
  if(defined($_[5]))
  {
    my $midx=$_[0]+$_[2]/2;
    my $midy=$_[1]+$_[3]/2;
    print MAG "<< labels >>\n";
    print MAG "rlabel $_[4] $midx $midy $midx $midy 1 $_[5]\n";
  }
}


##Create ground strips###
box($x,$y,$ground_strip_width,$ground_strip_height,"metal1","gnd!");


##Create p-substrate contact##
my $psc_box_position=$x-4;
my $number_of_psc=$ground_strip_width/8;
for my $i (1 .. $number_of_psc)
{
  $psc_box_position+=8;
  box($psc_box_position,$y,$psc_width,$psc_height,"psc");
  #box move right $psc_spacing
}

##Create n-diff area##
my $ndiff_box_position_x=$x+6;
my $ndiff_box_position_y=$y+9;
box($ndiff_box_position_x,$ndiff_box_position_y,$ndiff_width,$ndiff_height,"ndiff");

#Create n-well area##
my $nwell_box_position_x=$x+0;
my $nwell_box_position_y=$y+32;
box($nwell_box_position_x,$nwell_box_position_y,$nwell_width,$nwell_height,"nwell");

##Create p-diff area##
my $pdiff_box_position_x=$x+6;
my $pdiff_box_position_y=$y+38;
box($pdiff_box_position_x,$pdiff_box_position_y,$pdiff_width,$pdiff_height,"pdiff");

##Create poly-strips##
my $poly_box_position_x=$x+12;
my $poly_box_position_y=$y+6;
my $number_of_poly_strips=$number_of_inputs;
foreach my $i (1 .. $number_of_inputs)
{
  box($poly_box_position_x,$poly_box_position_y,$poly_width,$poly_height,"poly",$eulers[$i-1]);
  $poly_box_position_x+=8;
}

##Create power strips###
box($x,$y+60,$power_strip_width,$power_strip_height,"metal1","vdd!");

##Create n-substrate contact##
my $nsc_box_position_x=$x-4;
my $nsc_box_position_y=$y+60;
my $number_of_nsc=int($power_strip_width/8);

foreach my $i (1 .. $number_of_nsc)
{
  $nsc_box_position_x+=8;
  box($nsc_box_position_x,$nsc_box_position_y,$nsc_width,$nsc_height,"nsc");
  #box move right $nsc_spacing
}

print MAG "<< end >>\n";
close MAG;
system "magic -d XR $fnout";
# Now we need magic 4.2 with kairos support compiled in for SVG export:
open MAGIC "|magic -d XR $fnout -noconsole";
print MAGIC "plot svg $fnsvg\nquit\n";
close MAGIC;


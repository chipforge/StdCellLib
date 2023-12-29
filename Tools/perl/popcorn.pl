#!/usr/bin/perl -w
use strict;

#Parameters defined by the user:
our $maxstages=0;
my $maxtransistors=($maxstages+2)*($maxstages+2); # TODO: This is just a guess, please calculate the correct formula!!!
$maxtransistors=4;


our $unbalancedNmosPmos=0; # 0/1

our $varygates=1;
our $varysources=1;
our $varydrains=1;

#######

print "Opening microwave...\n";
mkdir "microwave";

############

# Functions:

sub cellPossibilities($) # (calculate the number of possible variants of a cell with a given number of transistors
{
  my $trans=$_[0];	
  my $nmospmos=$unbalancedNmosPmos?$trans-1:1;
  return 0 if(!$unbalancedNmosPmos && $trans&1);

  # This generator cannot generate TIE-High or TIE-Low cells.
  my $gates=1; # ($trans*2)**($trans-1); # 1 Input for each Transistor + 1 internal net for each transistor, but the gate of the first transistor is fixed to A
  foreach(1 .. $trans-1) # This tries to prevent skipping unused inputs, but it doesnt succeed completely, but it helps a lot to reduce unnecessary combinations
  {
    $gates*=$trans+$_+1; # 1 internal net per transistor + 2, 3, ... inputs. (The first transistor always gets "A" as fixed input, the second one can only use "A" or "B" as input or one of the internal nets, ...
  }

  my $sources=($trans+1)**$trans; # 1 internal net for each transistor + vdd/gnd
  my $drains=($trans+2)**$trans; # 1 internal net for each transistor + Y + Z

  print "Variants nmospmos: $nmospmos gates: $gates sources:$sources drains:$drains\n";
  my $combinations=$nmospmos*($varygates?$gates:1)*($varysources?$sources:1)*($varydrains?$drains:1);
  print "Total combinations: $combinations\n";
  return $combinations;
}

sub genCell($$) # (transistors, variant) generate Variant with #nmos and #pmos transistors
{
  my $trans=$_[0];
  my $variant=$_[1];
  my $nmospmos=$unbalancedNmosPmos?$trans-1:1;

  my $gates=1; # ($trans*2)**($trans-1); # 1 Input for each Transistor + 1 internal net for each transistor, but the gate of the first transistor is fixed to A
  foreach(1 .. $trans-1) # This tries to prevent skipping unused inputs, but it doesnt succeed completely, but it helps a lot to reduce unnecessary combinations
  {
    $gates*=$trans+$_+1;
  }
  my $sources=($trans+1)**$trans; # 1 internal net for each transistor + vdd/gnd
  my $drains=($trans+2)**$trans; # 1 internal net for each transistor + Y + Z

  my $nPMOS=int($trans/2);
  if($unbalancedNmosPmos)
  {
    $nPMOS=1+($variant%($trans-1));
    $variant=int($variant/($trans-1));
  }
  my $nNMOS=$trans-$nPMOS;

  foreach (1 .. $trans)
  {
    my $mosfet=($_<=$nPMOS)?"pmos":"nmos";
    my $vddgnd=($_<=$nPMOS)?"vdd":"gnd";
    my $ngate=($variant%($trans+$_));
    if($_==1 || !$varygates)
    {
      $ngate=$trans;
    }
    else
    {    
      $variant=int($variant/($trans+$_));
    }
    my $gate=($ngate<$trans)?($ngate+1):pack("C",$ngate-$trans+65);

    my $nsource=($variant%($trans+1));
    $variant=int($variant/($trans+1)) if($varysources);
    $nsource=$trans if(!$varysources);
    my $source=$nsource>=$trans?$vddgnd:$nsource+1;


    my $ndrain=($variant%($trans+2));
    $variant=int($variant/($trans+2)) if($varydrains);
    $ndrain=$trans if(!$varydrains);
    #print "ndrain: $ndrain trans: $trans\n";
    my $drain=($ndrain eq $trans)?"Z":($ndrain>$trans)?"Y":$ndrain+1;

    print "$mosfet $gate $drain $source\n";
  }
  print "\n";
}


############

foreach my $ntransistors(1 .. $maxtransistors)
{
  print "################ Trying $ntransistors transistors... ################\n";
  my $poss=cellPossibilities($ntransistors);
  print "They have $poss possible variants.\n";
  foreach my $i (0 .. $poss-1)
  {
    print "Trying to generate variant #$i ...\n";	   
    genCell($ntransistors,$i);
  }

}




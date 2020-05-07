#!/usr/bin/perl -w
use strict;

print "Generating a Schematic file for KiCad's EESchema from a cell netlist\n";

open IN,"<$ARGV[0]";
open OUT,">$ARGV[0].sch";

my $pi=3.1415926;

print OUT <<EOF
EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
\$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
\$EndDescr
EOF
;

my @devs=();
my $inputs="";
my $outputs="";

while(<IN>)
{
  push @devs,$_ if(m/^(pmos|nmos|res)/);
  $inputs=$1 if(m/^\.inputs (.*)/);
  $outputs=$1 if(m/^\.outputs (.*)/);
}

sub Wire($$$$)
{
print OUT <<EOF
Wire Wire Line
	$_[0] $_[1] $_[2] $_[3]
Wire Wire Line
	6550 3150 6550 2750
EOF
;
}


our %netx=();
our %nety=();

my $count=0;
foreach(@devs)
{
  my $angle=2*$pi*$count/scalar(@devs);
  my $x=4000+int(sin($angle)*3200);
  my $y=4000+int(cos($angle)*3200);

  my $x1=$x+288;
  my $y1=$y+46;
  my $y2=$y-45;
  my $x2=$x-25;
  my $x3=$x+68;

  if(m/^(n|p)mos (\w+) (\w+) (\w+)/)
  {
    my ($t,$g,$s,$d)=(uc($1),$2,$3,$4);
    my $dev="M$t"."MOS";
print OUT <<EOF    
\$Comp
L pspice:$dev M?
U 1 1 5D5D1D60
P $x $y
F 0 "M?" H $x1 $y1 50  0000 L CNN
F 1 "$dev" H $x1 $y2 50  0000 L CNN
F 2 "" H $x2 $y 50  0001 C CNN
F 3 "~" H $x2 $y 50  0001 C CNN
	1    $x $y
	1    0    0    -1  
\$EndComp
EOF
;
    if(defined($netx{$g}))
    {
      Wire($x-200,$y,$netx{$g},$nety{$g});
    }
    else
    {
      $netx{$g}=$x-200;
      $nety{$g}=$y;
    }
    if(defined($netx{$s}))
    {
      Wire($x+100,$y-200,$netx{$s},$nety{$s});
    }
    else
    {
      $netx{$s}=$x+100;
      $nety{$s}=$y-200;
    }
    if(defined($netx{$d}))
    {
      Wire($x+100,$y+200,$netx{$d},$nety{$d});
    }
    else
    {
      $netx{$d}=$x+100;
      $nety{$d}=$y+200;
    }
    $count++;
  }
  elsif(m/^res (\w+) (\w+) (\d+)/)
  {
print OUT <<EOF    
\$Comp
L pspice:R R?
U 1 1 5D5D26E8
P $x $y
F 0 "R?" H $x3 $y1 50  0000 L CNN
F 1 "R" H $x3 $y2 50  0000 L CNN
F 2 "" H $x $y 50  0001 C CNN
F 3 "~" H $x $y 50  0001 C CNN
	1    $x $y
	1    0    0    -1  
\$EndComp
EOF
;
    $count++;
  }
}

#Wire Wire Line
#	4350 4250 6850 4250
#Wire Wire Line
#	6850 4250 6850 2950

print OUT "\$EndSCHEMATC\n";

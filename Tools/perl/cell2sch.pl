#!/usr/bin/perl -w
use strict;

print STDERR "Converts .cell files to .sch files for eeschema and SVG files\n";
print STDERR "Usage: cell2sch.pl INV.cell\n";

my $cellfn=$ARGV[0];

# Min and Max functions that always prefers defined values
sub mymin
{
  return $_[1] if(!defined($_[0]));
  return $_[0] if(!defined($_[1]));
  return $_[0]>$_[1]?$_[1]:$_[0];
}
sub mymax
{
  return $_[1] if(!defined($_[0]));
  return $_[0] if(!defined($_[1]));
  return $_[0]>$_[1]?$_[0]:$_[1];
}


# Loading the .cell file:
open IN,"<$cellfn" or die "Could not open file: $!\n";
# Using graphviz dot to do the placement of the transistors and resistors on the schematic
open OUT,"|dot >$cellfn.g";

# Graphviz header
print OUT <<EOF
digraph cell {
EOF
;

my @devs=();
my $inputs="";
my $outputs="";

# Parsing all lines
while(<IN>)
{
  push @devs,$_ if(m/^(pmos|nmos|res)/);
  $inputs=$1 if(m/^\.inputs (.*)/);
  $outputs=$1 if(m/^\.outputs (.*)/);
}
close IN;

# Defining nodes and edges in the graphviz graph
my $count=0;
foreach(@devs)
{
  if(m/^(n|p)mos (\w+) (\w+) (\w+)/)
  {
    my ($t,$g,$s,$d)=(lc($1),$2,$3,$4);
    my $dev="$t"."mos".$count;
    print OUT "$dev [shape=\"rectangle\"]\n"; # node
    print OUT "$g -> $dev\n" unless($g=~m/(vdd|gnd)/); # edge
    print OUT "$g [shape=\"point\"]\n" if($g=~m/^\d+$/);
    print OUT "$g [fillcolor=\"yellow\", style=\"filled\"]\n" if($g=~m/^\w+$/);
    print OUT "$dev -> $s\n" unless($s=~m/(vdd|gnd)/); # edge
    print OUT "$s [shape=\"point\"]\n" if($s=~m/^\d+$/);
    print OUT "$s [fillcolor=\"yellow\", style=\"filled\"]\n" if($s=~m/^\w+$/);
    print OUT "$d -> $dev\n" unless($d=~m/(vdd|gnd)/); # edge
    print OUT "$d [shape=\"point\"]\n" if($d=~m/^\d+$/);
    print OUT "$d [fillcolor=\"yellow\", style=\"filled\"]\n" if($d=~m/^\w+$/);

    $count++;
  }
  elsif(m/^res (\w+) (\w+) (\d+)/)
  {
    my ($n1,$n2)=($1,$2);
    my $dev="res".$count;
    print OUT "$dev [shape=\"rectangle\"]\n";
    print OUT "$n1 -> $dev\n" unless($n1=~m/(vdd|gnd)/);
    print OUT "$dev -> $n2\n" unless($n2=~m/(vdd|gnd)/);
    $count++;
  }
}

print OUT "}\n";
close OUT;

# Now generating SVG output for debugging
system "dot -T svg <$cellfn.g >$cellfn.svg";
print "firefox $cellfn.svg\n";

our %coordx=();
our %coordy=();

# Reading the resulting graphviz file and extracting the coordinates
open IN,"<$cellfn.g";
undef $/;
my $g=<IN>;
my %stat=();
while($g=~s/(pmos|nmos|res)(\d+)\s*\[height=\d+\.?\d*,\s*pos="(\d+\.?\d*),(\d+\.?\d*)"//sm)
{
  $coordx{$2}=$3; 
    $stat{'minx'}=mymin($stat{'minx'},$3);
    $stat{'maxx'}=mymax($stat{'maxx'},$3);
  $coordy{$2}=$4;
    $stat{'miny'}=mymin($stat{'miny'},$4);
    $stat{'maxy'}=mymax($stat{'maxy'},$4);
    #print "$2 $3 $4\n";
}
close IN;

#print "X: $stat{minx} - $stat{maxx}\n";
#print "Y: $stat{miny} - $stat{maxy}\n";

#Generating a Schematic file for KiCad's EESchema from a cell netlist

open OUT,">$ARGV[0].sch";

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

#my $inputs="";
#my $outputs="";

sub Wire($$$$)
{
print OUT <<EOF
Wire Wire Line
	$_[0] $_[1] $_[2] $_[3]
EOF
;
}

our %netx=();
our %nety=();

$count=0;

# And finally generating the schematic file 
foreach(@devs)
{
  my $x=int($coordx{$count}*7900/$stat{'maxx'})+300;
  my $y=7650-int($coordy{$count}*6900/$stat{'maxy'});

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
L pspice:$dev M$count
U 1 1 5D5D1D60
P $x $y
F 0 "M$count" H $x1 $y1 50  0000 L CNN
F 1 "$dev" H $x1 $y2 50  0000 L CNN
F 2 "" H $x2 $y 50  0001 C CNN
F 3 "~" H $x2 $y 50  0001 C CNN
	1    $x $y
	1    0    0    -1  
\$EndComp
EOF
;
    if($g=~m/(vdd|gnd)/)
    {
    }
    elsif(defined($netx{$g}))
    {
      Wire($x-200,$y,$netx{$g},$nety{$g});
    }
    else
    {
      $netx{$g}=$x-200;
      $nety{$g}=$y;
    }
    if($s=~m/(vdd|gnd)/)
    {
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
    if($d=~m/(vdd|gnd)/)
    {
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
    my($n1,$n2,$v)=($1,$2,$3);
print OUT <<EOF    
\$Comp
L pspice:R R$count
U 1 1 5D5D26E8
P $x $y
F 0 "R$count" H $x3 $y1 50  0000 L CNN
F 1 "R" H $x3 $y2 50  0000 L CNN
F 2 "" H $x $y 50  0001 C CNN
F 3 "~" H $x $y 50  0001 C CNN
	1    $x $y
	1    0    0    -1  
\$EndComp
EOF
;
    if($n1=~m/(vdd|gnd)/)
    {
    }
    elsif(defined($netx{$n1}))
    {
      Wire($x,$y-250,$netx{$n1},$nety{$n1});
    }
    else
    {
      $netx{$n1}=$x;
      $nety{$n1}=$y-250;
    }
    if($n2=~m/(vdd|gnd)/)
    {
    }
    if(defined($netx{$n2}))
    {
      Wire($x,$y+250,$netx{$n2},$nety{$n2});
    }
    else
    {
      $netx{$n2}=$x;
      $nety{$n2}=$y+250;
    }

    $count++;
  }
}


print OUT "\$EndSCHEMATC\n";
close OUT;
print "eeschema $ARGV[0].sch\n";


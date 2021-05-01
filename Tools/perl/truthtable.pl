#!/usr/bin/perl -w
use strict;
use Getopt::Long;

# Parameters and their default values:
our $debug=0;
our $format="text"; # html latex text liberty verilog

# Parsing the commandline parameters:
GetOptions ("debug" => \$debug,
	    "v" => \$debug,
            "format=s" => \$format); # text,html,latex,liberty,verilog,testcad

our $testcadcounter=1;

# Convert a value to the gray code value:
sub bin2gray
{
    return $_[0] ^ ($_[0] >> 1);
}

sub verb # verbose debug output
{
  print $_[0] if($debug);
}

# Calculating the truth table for
sub truth
{
  my @l=@{$_[0]};
  my %v=%{$_[1]};

  verb "\nCalculating Truth table ...\n";

  my @todo=@l;
  my %iv=%v;

  #verb "Input A: $iv{A}-$v{A}\n";
  verb "Inputs: "; verb "$_=$iv{$_} " foreach(sort keys %iv); verb "\n";


  my $done=0;
  my $hadwork=0;

  while(!$done)
  {
    my @nexttodo=();
    $hadwork=0;
    foreach(@todo)
    {
      s/\s+$//m;
      verb "Line: $_\n";
      if(m/^res (\w+) (\w+) (\d+\.?\d*)/i)
      {
	my ($n1,$n2,$v)=($1,$2,$3);
        verb "Resistor found\n";
        my $i1=($n1=~m/^(vdd|gnd)$/i)?$n1:(defined($iv{$n1}) && $iv{$n1}=~m/^(vdd|gnd|0|1)$/i)?$iv{$n1}:undef;
        verb "i1: ".($i1||"")."\n";
        my $i2=($n2=~m/^(vdd|gnd)$/i)?$n2:(defined($iv{$n2}) && $iv{$n2}=~m/^(vdd|gnd|0|1)$/i)?$iv{$n2}:undef;
        verb "i2: ".($i2||"")."\n";
        if((defined($i1) && defined($i2)) && (($i1=~m/vdd/i && $i2=~m/gnd/i) || ($i1=~m/vdd/i && $i2=~m/gnd/i)))
        {
          die "ERROR: Short cirtuit detected: $n1->$i1->$iv{$n1} $n2->$i2->$iv{$2}!\n";
        }
        if(defined($i1))
        {
          verb "Setting: $n2 <= $i1\n";
          $iv{$n2}=$i1;
        }
        if(defined($i2))
        {
          verb "Setting: $n1 <= $i2\n";
          $iv{$n1}=$i2;
        }
        $hadwork=1 if(defined($i1) || defined($i2));
        push @nexttodo,$_ if((!defined($iv{$n1})) && (!defined($iv{$n2})));
        verb "Status: Net1: $n1-".($iv{$n1}||"")." Net2: $n2-".($iv{$n2}||"")."\n";
      }
      if(m/^([pn]mos) (\w+) (\w+) (\w+)/i)
      {
	my ($tr,$s,$g,$d)=($1,$2,$3,$4);
	#$g=~s/^(\d+)$/$tr$1/; This was necessary when popcorn generated same names for different internal nets in nmos and pmos
	#$d=~s/^(\d+)$/$tr$1/; But it failed for less structured cells (e.g. transmission gates)
        verb "Transistor: $_\n";
  
        if(defined($iv{$s}))
        {
          my $source=$iv{$s}; $source=~s/vdd/1/i; $source=~s/gnd/0/i;
          my $t=$source ^ ($tr=~m/nmos/i ?0:1);
          if($t)
          {
            verb "Transitor conducting\n";
	    verb "g: $g iv{g}=".($iv{$g}||"")."\n";
	    verb "d: $d iv{d}=".($iv{$d}||"")."\n";
	    my $ig=($g=~m/^(vdd|gnd)$/i)?$g:(defined($iv{$g}) && $iv{$g}=~m/^(vdd|gnd|0|1)$/i)?$iv{$g}:undef;
	    verb "ig: ".($ig||"")."\n";
	    my $id=($d=~m/^(vdd|gnd)$/i)?$d:(defined($iv{$d}) && $iv{$d}=~m/^(vdd|gnd|0|1)$/i)?$iv{$d}:undef;
	    verb "id: ".($id||"")."\n";

	    if((defined($ig) && defined($id)) && (($ig=~m/vdd/i && $id=~m/gnd/i) || ($ig=~m/vdd/i && $id=~m/gnd/i)))
	    {
              die "ERROR: Short cirtuit detected: $g->$ig->$iv{$g} $d->$id->$iv{$d}!\n";
	    }
            if(defined($ig))
	    {
              verb "Setting: $d <= $ig\n";
              $iv{$d}=$ig;
	    }
            if(defined($id))
	    {
              verb "Setting: $g <= $id\n";
              $iv{$g}=$id;
            }
            $hadwork=1 if(defined($id) || defined($ig));
	    push @nexttodo,$_ if((!defined($iv{$d})) && (!defined($iv{$g})));
	    verb "Status: Source: $d-".($iv{$d}||"")." Drain: $g-".($iv{$g}||"")."\n";
          }
	  else
	  {
            verb "Transistor not conducting\n";
	  }
        } 
        else
        {
          verb "No information yet.\n";
          push @nexttodo,$_;
        }
      }
    }
    if(!$hadwork)
    {
      verb "No further progress. Exiting.\n";
      foreach(sort keys %iv)
      {
        verb "Status: $_ : $iv{$_}\n";
      }
      last;
    }
    verb "Still to be done:\n@nexttodo\n\n";
    $done=1 if(!scalar(@nexttodo));
    @todo=@nexttodo;
  }

  verb "Results: "; verb "$_=$iv{$_} " foreach(sort keys %iv); verb "\n";

  $iv{$_}=~s/vdd/1/i foreach(keys %iv);
  $iv{$_}=~s/gnd/0/i foreach(keys %iv);

  return %iv;
}


if(!scalar(@ARGV)) # no parameters were given
{
  print "Calculates the truthtable for a given cell\n";
  print "Usage: truthtable.pl <filename.cell>\n";
}

# Take all the given filenames from the commandline
foreach my $file(@ARGV)
{
  my $cellname=$file; $cellname=~s/\.cell$//;

  # Open each file
  if(open(IN,"<$file"))
  {
    print STDERR "Analyzing $file\n" if($debug);
    my @lines=<IN>; # Read all lines into an array
    close IN;

    my %inputs=();
    my %intermediates=();
    my %outputs=();
    my %differential=();

    # Here we are parsing all transistor lines for input-, output- and intermediate nets
    # But this is just a guess:
    foreach(@lines)
    {
      next if(m/^#/); # Ignore comment lines
      #$differential{$1}=$2 if(m/^\.differential (\w+) (\w+)/);
      $inputs{$1}=1 if(m/^[pn]mos\s*([A-W]+\d*)/);
      $intermediates{$1}=1 if(m/^[pn]mos.*([X-Y]\w*\d*)/);
      $outputs{$1}=1 if(m/^[pn]mos.*\w+ ([X-Z]\w*\d*)/);
    }
    delete($outputs{"Y"}) if(defined($outputs{"Z"})); # If we have Z, then Y is an internal net and Z is the output net

    my @ins=sort keys %inputs;
    my @outs=sort keys %outputs;

    # Now we are parsing for the real inputs and ouputs if they are available
    foreach my $line(@lines)
    {
      @ins=split(" ",$1) if($line=~m/^\.inputs (\w.*)/i);
      @outs=split(" ",$1) if($line=~m/^\.outputs (\w.*)/i)
    }
    $inputs{$_}=1 foreach(@ins);

    foreach my $a(@ins)
    {
      if($a=~m/_n$/)
      {
        my $b=$a; $b=~s/_n$/_p/;
        if(defined($inputs{$b}))
	{
          $differential{$a}=$b;
	  #print STDERR "Differential input detected: $a <-> $b\n";
	}
      }
    }

    my $ninputs=scalar(@ins);
    my $noutputs=scalar(@outs);
    my $combinations=2**$ninputs; # We calculate the number of possible combinations in the truthtable

    verb "Number of Inputs: $ninputs (".join(",",@ins).") -> Combinations: $combinations\n";
    verb "Number of Outputs: $noutputs (".join(",",@outs).")\n";

    if($ninputs<1)
    {
      die "ERROR: A cell without an input!\n";
    }

    # Now we start with the header of the output files:
    if($format eq "text")
    {
      print join(" ",@ins)."->".join(" ",@outs); print "\n";
    }
    elsif($format eq "latex")
    {
print <<EOF
%%  ************    LibreSilicon's StdCellLibrary   *******************
%%
%%  Organisation:   Chipforge
%%                  Germany / European Union
%%
%%  Profile:        Chipforge focus on fine System-on-Chip Cores in
%%                  Verilog HDL Code which are easy understandable and
%%                  adjustable. For further information see
%%                          www.chipforge.org
%%                  there are projects from small cores up to PCBs, too.
%%
%%  File:           StdCellLib/Documents/LaTeX/truthtable_$cellname.tex
%%
%%  Purpose:        Truth Table File for $cellname
%%
%%  ************    LaTeX with circdia.sty package      ***************
%%
%%  ///////////////////////////////////////////////////////////////////
%%
%%  Copyright (c) 2019 by chipforge <hsank\@nospam.chipforge.org>
%%  All rights reserved.
%%
%%      This Standard Cell Library is licensed under the Libre Silicon
%%      public license; you can redistribute it and/or modify it under
%%      the terms of the Libre Silicon public license as published by
%%      the Libre Silicon alliance, either version 1 of the License, or
%%      (at your option) any later version.
%%
%%      This design is distributed in the hope that it will be useful,
%%      but WITHOUT ANY WARRANTY; without even the implied warranty of
%%      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%%      See the Libre Silicon Public License for more details.
%%
%%  ///////////////////////////////////////////////////////////////////

\\begin{center}
EOF
;

      print "    {\(Z = \\lnot ((B1 \\land B0) \\lor A) \\)}\n";
      print "    \\begin{table}[h] %\\caption{\\(Z = \\lnot ((B1 \\land B0) \\lor A) \\)}\n";
      print "        \\begin{center}\n";
      print "            \\begin{tabular}{";
      print "|c" foreach(@ins);
      print "|";
      print "|c" foreach(@outs);
      print "|} \\hline\n";
      print "            "; 
      print join(" & ",@ins)." & ".join(" & ",@outs)." \\\\ \\hline\\hline\n";
    }
    elsif($format eq "html")
    {
      print "<table border='1' class='truthtable'>\n<tr><th>".join("</th><th>",@ins)."</th><th><b>".join("</b></th><th><b>",@outs)."</b></th></tr>\n";
    }
    elsif($format eq "testcad")
    {
      foreach (@ins)
      {
        print "$testcadcounter PI ".($testcadcounter+1)." ; # $_\n";
	$testcadcounter+=2;
      }
    }

    my %values=();
    our %sum=();
    our %results=();
    # Now we calculate all the truth-table values:
    foreach my $i(0 .. 2**$ninputs-1)
    {
      # We count from 0 .. 2^n-1 and take the graycode, and then interpret that as a binary value for the input stimulus:
      my $output="";
      my $gray=bin2gray($i); 
      $output.="            " if($format eq "latex");
      $output.="<tr>" if($format eq "html");
      foreach(0 .. $ninputs-1)
      {
	$output.="& " if($format eq "latex" && $_>0);
        $output.="<td>" if($format eq "html");
        $output.="".($gray&(1<<$_))?"1 ":"0 " if($format eq "text" || $format eq "latex" || $format eq "html"); # not for liberty!
        $output.="</td>" if($format eq "html");
	$values{$ins[$_]}=($gray&(1<<$_))?1:0;
      }

      my $ignoreinvalidinputs=0; # Look for differential inputs that have the same value, and are therefore invalid
      foreach my $k1(keys %differential)
      {
        $ignoreinvalidinputs=1 if($values{$k1} eq $values{$differential{$k1}});
      }
      next if($ignoreinvalidinputs);

      print $output;

      # Here we are using the truth function to calculate all network states for the given inputs:
      my %res=truth(\@lines,\%values);
      # The result is a hash with the intermediate/output netnames as keys and the resulting values as values
     
      # Now we are analyzing the results
      foreach my $out (@outs)
      {
	$res{$out}="HIGH-Z" if(!defined($res{$out}));
        $sum{$out}{$res{$out}}++; # We are counting the occurance of all output values of the whole truthtable to decide, which value is more often used, which helps to decide whether the function can be represented in a shorter way with a negation
	my @a=();
	foreach(@ins)
	{
          push @a,$res{$_}?"$_":"!$_"; # Here we are collecting all values for a AO representation, e.g. (A && !B && C) || (!A && B && C))
	}
	push @{$results{$out}{$res{$out}}},join($format eq "liberty"?"&":" && ",@a); # Here the single values are put together: (A && !B && C)
      }

      if($format eq "text")
      {
        print "$_=$res{$_} " foreach(@outs); 
      }
      elsif($format eq "latex")
      {
        print "& $res{$_} " foreach(@outs);
        print "\\\\ \\hline";
      }
      elsif($format eq "html")
      {
        print "<td><b>$res{$_}</b></td>" foreach(@outs);
      }
      print "</tr>" if($format eq "html");
      print "\n" if($format eq "text" || $format eq "html");
    }
    print "</table>\n" if($format eq "html");

      foreach my $out (@outs) # We might have more than one output of a cell
      {
        my $not=($sum{$out}{0}||0)>($sum{$out}{1}||0)?1:0;
        # If we have more 0 than 1 results, then the negated inverse is shorted: 
	# TODO: When there are HIGH-Z outputs we should split the HIGH-Z outputs from the others and give a function for output-enable and HIGH-Z
	if($format eq "liberty")
	{
          print "  pin($out) {\n    direction: output;\n    function:\"";
	}
	elsif($format eq "testcad")
	{
	}
	else
	{
	  print "function: $out = ";
	}
	my @list=defined($results{$out}{$not})?@{$results{$out}{$not}}:();
	if(!scalar(@list))
	{
	}
	elsif($not)
	{
          print "(".join($format eq "liberty"?"|":" || ",@list).")";
	}
	else
	{
          print "!(".join($format eq "liberty"?"|":" || ",@list).")";
        }
	print $format eq "liberty" ? "\";\n  }":" ";
        # TODO: We should try more functional representations like AOI, OAI, OR, NOR and see which one is the shortest representation
      }

    print "\n" if($format eq "text" || $format eq "liberty");
    if($format eq "latex")
    {
	    print <<EOF
            \\end{tabular}
        \\end{center}
    \\end{table}
\\end{center}
EOF
;
    }
  }
}
print STDERR "Done.\n" if($debug);

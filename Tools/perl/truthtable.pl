#!/usr/bin/perl -w
use strict;
use Getopt::Long;

our $debug=0;
our $format="text"; # html latex

GetOptions ("debug" => \$debug,
	    "v" => \$debug,
            "format=s" => \$format);

sub bin2gray
{
    return $_[0] ^ ($_[0] >> 1);
}

sub verb # verbose debug output
{
  print $_[0] if($debug);
}

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
      if(m/^(\w+) (\w+) (\w+) ([pn]mos)/i)
      {
	my ($s,$g,$d,$tr)=($1,$2,$3,$4);
	$g=~s/^(\d+)$/$tr$1/;
	$d=~s/^(\d+)$/$tr$1/;
        verb "Transistor: $_\n";
  
        if(defined($iv{$s}))
        {
          my $source=$iv{$s}; $source=~s/vdd/1/i; $source=~s/gnd/0/i;
          my $t=$source ^ ($tr=~m/nmos/i ?0:1);
          if($t)
          {
            verb "Transitor conducting\n";
	    my $ig=($g=~m/^(vdd|gnd)$/i)?$g:(defined($iv{$g}) && $iv{$g}=~m/^(vdd|gnd)$/i)?$iv{$g}:undef;
	    my $id=($d=~m/^(vdd|gnd)$/i)?$d:(defined($iv{$d}) && $iv{$d}=~m/^(vdd|gnd)$/i)?$iv{$d}:undef;

	    if((defined($ig) && defined($id)) && (($ig=~m/vdd/i && $id=~m/gnd/i) || ($ig=~m/vdd/i && $id=~m/gnd/i)))
	    {
              die "ERROR: Short cirtuit detected: $g->$ig->$iv{$g} $d->$id->$iv{$d}!\n";
	    }
            $iv{$d}=$ig if(defined($ig)); 
            $iv{$g}=$id if(defined($id)); 
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

if(!scalar(@ARGV))
{
  print "Calculates the truthtable for a given cell\n";
  print "Usage: truthtable.pl <filename.cell>\n";
}

foreach my $file(@ARGV)
{
  if(open(IN,"<$file"))
  {
    print STDERR "Analyzing $file\n";
    my @lines=<IN>;
    close IN;

    my %inputs=();
    my %intermediates=();
    my %outputs=();
 
    foreach(@lines)
    {
      next if(m/^#/);
      $inputs{$1}=1 if(m/^([A-W]\d*) .*[pn]mos/);
      $intermediates{$1}=1 if(m/^([X-Y]\d*) .*[pn]mos/);
      $outputs{$1}=1 if(m/^\w+ ([X-Z]\d*) .*[pn]mos/);
    }
    delete($outputs{"Y"}) if(defined($outputs{"Z"}));

    my @ins=sort keys %inputs;
    my @outs=sort keys %outputs;

    my $ninputs=scalar(keys %inputs); my $combinations=2**$ninputs;
    my $noutputs=scalar(keys %outputs);
    verb "Number of Inputs: $ninputs (".join(",",@ins).") -> Combinations: $combinations\n";
    verb "Number of Outputs: $noutputs (".join(",",@outs).")\n";

    if($ninputs<1)
    {
      die "ERROR: A cell without an input!\n";
    }

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
%%  File:           StdCellLib/Documents/LaTeX/truthtable_AOI21.tex
%%
%%  Purpose:        Truth Table File for AOI21
%%
%%  ************    LaTeX with circdia.sty package      ***************
%%
%%  ///////////////////////////////////////////////////////////////////
%%
%%  Copyright (c) 2018 by chipforge <hsank\@nospam.chipforge.org>
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
print "            "; print join(" & ",@ins)." & ".join(" & ",@outs)." \\\\ \\hline\\hline\n";
    }
    elsif($format eq "html")
    {
      print "<table border='1'><th>".join("</th><th>",@ins)."</th><th><b>".join("</b></th><th><b>",@outs)."</b></th></tr>";
    }
    my %values=();
    our %sum=();
    our %results=();
    foreach my $i(0 .. 2**$ninputs-1)
    {
      my $gray=bin2gray($i); 
      print "            " if($format eq "latex");
      foreach(0 .. $ninputs-1)
      {
	print "& " if($format eq "latex" && $_>0);
        print "".($gray&(1<<$_))?"1 ":"0 ";
	$values{$ins[$_]}=($gray&(1<<$_))?1:0;
      }
      my %res=truth(\@lines,\%values);
      
      foreach my $out (@outs)
      {
        $sum{$out}{$res{$out}}++;
	my @a=();
	foreach(@ins)
	{
          push @a,$res{$_}?"$_":"!$_";
	}
	push @{$results{$out}{$res{$out}}},join(" && ",@a);
      }

      if($format eq "text")
      {
        print "$_=$res{$_} " foreach(@outs); 
      }
      elsif($format eq "latex")
      {
        print "& $res{$_} " foreach(@outs);
      }
      elsif($format eq "html")
      {
        print "<td><b>$res{$_}</b></td>" foreach(@outs);
      }
      print "\\\\ \\hline" if($format eq "latex");
      print "\n";
    }
      foreach my $out (@outs)
      {
        my $not=$sum{$out}{0}>$sum{$out}{1}?1:0;
	if($not)
	{
          print "FUNCTION: $out = (".join(" || ",@{$results{$out}{$not}}).")";
	}
	else
	{
          print "FUNCTION: $out = ! (".join(" || ",@{$results{$out}{$not}}).")";
        }
      }

    print "\n" if($format eq "text");
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
print STDERR "Done.\n";

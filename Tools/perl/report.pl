#!/usr/bin/perl -w

sub readfile($)
{
  if(open MYRIN,"<$_[0]")
  {
    my $old=$/;
    undef $/;
    my $content=<MYRIN>;
    close MYRIN;
    $/=$old;
    return $content;
  }
  return undef;
}

our %stats=();

open OUT,">report.csv";
foreach my $py(<str/*.py>)
{
  my $params=$1 if($py=~m/ls(.*)\.py$/);
  my $err=$py; $err=~s/\.py$/.err/;
  my $gerr=$py; $gerr=~s/\.py$/.gerr/;
  my $gds=$py; $gds=~s/\.py$/.gds/;
  my $good=$py; $good=~s/\.py$/.good/;
  my $mag=$py; $mag=~s/\.py$/.mag/;
  my $ann=$gds.".ann";

  my $errcontent=readfile($err);
  my $gerrcontent=readfile($err);
  my $anncontent=readfile($ann)||"";
  my $isgds=-s $gds;
  my $isgood=($anncontent=~m/y/i);
  my $isworking=-s $mag;
  my $error="UNKNOWN";
  my $weight=0;

  if($isworking)
  {
    $error="working";
    $weight=100;
  }
  elsif($isgood)
  {
    $error="good";
    $weight=90;
  }
  elsif($errcontent=~m/Gate not x-aligned on grid/) # Bug or parameters not checked
  { #  assert (center_x - tech.grid_offset_x) % tech.routing_grid_pitch_x == 0, Exception("Gate not x-aligned on grid.")
    $error="gateXalign";
  }
  elsif($errcontent=~m/Terminal node not x-aligned/) # Bug or parameters not checked
  { # assert next_x == x, Exception("Terminal node not x-aligned.")
    $error="terminalXalign";
  }
  elsif($errcontent=~m/Graph has been disconnected/) # Bug or parameters not checked
  { # Exception("Graph has been disconnected by removal of reserved nodes.")
    $error="GraphDisconnect";
  }    
  elsif($gerrcontent=~m/ZeroDivisionError:/) # Bug caused by grid_offset_x=0
  {
    $error="ZeroDivision";
  }
  elsif($errcontent=~m/assert nx\.is_connected\(graph\)/) # Bug or parameters not checked
  {
    $error="connectedGraph";
  }
  elsif($errcontent=~m/Nets without terminals/) # Bug or parameters not checked
  {
    $error="NetsWithoutTerminals";
  }
  elsif($errcontent=~m/min\(\) arg is an empty seq/) # Bug
  {
    $error="minArgEmpty";
  }
  elsif($errcontent=~m/KeyError.*metal1/) # Bug or parameters not checked
  {
    $error="KeyErrorMetal1";
  }
  elsif($errcontent=~m/Keyboard/) # It was interrupted by the user, not a bug
  {
    unlink $py;
    unlink $gds;
    unlink $err;
    unlink $gerr;
    next;
  }
  elsif($errcontent=~m/has no attribute 'multi_via'/) # Tech file was empty
  {
    next;	 
  }
  else
  {
    #print "Unknown status: $errcontent\n";
    $error="UNKNOWN-TO-BE-CLASSIFIED";
  } 
  print OUT "".join(";",split("_",$params)).";".$error.";$weight\n";
  $stats{$error}++;
  $stats{$weight}++;


}


foreach (sort keys %stats)
{
  print "$_: $stats{$_}\n";
}



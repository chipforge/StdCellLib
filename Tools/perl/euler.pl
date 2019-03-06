#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Carp;
use Getopt::Long;

our $debug=0;
our $network="both"; # both,pmos,nmos
our $power=0;
our $help=0;

GetOptions ("network=s" => \$network,
	    "debug" => \$debug,
	    "power" => \$power,
            "help|h" => \$help);

if($help)
{
  print <<EOF
Euler Path generator for LibreSilicon cells
Usage: $ARGV[0] <options> <filename.cell>
Options: --network=<both,pmos,nmos> which network of the cell should be analyzed? pulldown network or pullup network
	 --power                    include power nets (vdd,gnd) into the graph
	 --debug                    show debug output
	 --help                     display this help
Example: perl euler.pl ../../Catalog/AND4.cell --network pmos --debug --power
EOF
;
}    
   
sub eulerPath {
        my %graph = @_;
	
	return() if(scalar(@_)<2);
    
        # count the number of vertices with odd degree
        my @odd = ();
        foreach my $vert ( sort keys %graph ) {
            my @edg = @{ $graph{$vert} };
    
            my $size = scalar(@edg);
            if ( $size % 2 != 0 ) {
                push @odd, $vert;
            }
        }
    
        push @odd, ( keys %graph )[0];
    
        if ( scalar(@odd) > 3 ) {
            return "None";
    
        }
    
        my @stack = ( $odd[0] );
        my @path  = ();
    
        while (@stack) {
            my $v = $stack[-1];
    
            if ( @{$graph{$v}} ) {
                my $u = ( @{ $graph{$v} } )[0];
                push @stack, $u;
    
                # Find index of vertice v in graph{$u}
    
                my @graphu = @{ $graph{$u} };  # This is line 54.
                my ($index) = grep $graphu[$_] eq $v, 0 .. $#graphu;
		#            delete @{ $graph{$u} }[$index];
		#delete @{ $graph{$v} }[0];
		 splice @{ $graph{$u} }, $index, 1;
                shift @{ $graph{$v} };
    
            }
            else {
    
                push @path, pop(@stack);
            }
    
        }
    
   
        return @path;
}



my %graphs = (); # 1 => ["B",3], "B" => [1,3,4,5], 3 =>[1,"B",4,5], 4 => ["B",3,5], 5 => ["B",3,4]);

#%graphs=(1 => [2,3], 2=>[1,4],3=>[1,4],4=>[3,2,5,5],5=>[4,4]);
#%graphs=(5 => [6,6,7], 6=>[5,5,0,0],0=>[6,6,7],7=>[5,0]);

%graphs=(1=>["A","B"], "A"=>[1,3], "B"=>[1,2], 2=>["B","D"], 3=>["A","C"], "C"=>[3,4], "D"=>[2,4], 4=>["C","D","E","F"], "E"=>[4,5], "F"=>[4,5], 5=>["E","F"]);

if($ARGV[0] && open(IN,"<$ARGV[0]"))
{
  %graphs=();
  while(<IN>)
  {
    if(m/^(\w+) (\w+) (\w+) ([pn]mos)/i)
    {
      my($g,$d,$s,$t)=($1,$2,$3,$4);
      next if(lc($network) eq "pmos" && lc($t) eq "nmos");
      next if(lc($network) eq "nmos" && lc($t) eq "pmos");
      print "$_" if($debug);
      if($power || $d!~m/(gnd|vdd)/i)
      {
        push @{$graphs{$g}},$d;
        push @{$graphs{$d}},$g;
      }
      if($power || $s!~m/(gnd|vdd)/i)
      {
        push @{$graphs{$g}},$s;
        push @{$graphs{$s}},$g;
      }
    }
  }
  close IN;
}

my @path = eulerPath(%graphs);
if($debug)
{
  print "Original graph:\n";
  print Dumper \%graphs;
  print "Generated Euler path:\n";
  print Dumper \@path;

}   
print join(",",@path)."\n"; 

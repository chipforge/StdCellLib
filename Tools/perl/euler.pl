#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Carp;
use Getopt::Long;

# Parameters and their default values:
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

# Function which generates the Euler path from a given graph:
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


# Some sample graphs for testing the algorithm:
my %graphs = (); # 1 => ["B",3], "B" => [1,3,4,5], 3 =>[1,"B",4,5], 4 => ["B",3,5], 5 => ["B",3,4]);
#%graphs=(1 => [2,3], 2=>[1,4],3=>[1,4],4=>[3,2,5,5],5=>[4,4]);
#%graphs=(5 => [6,6,7], 6=>[5,5,0,0],0=>[6,6,7],7=>[5,0]);
%graphs=(1=>["A","B"], "A"=>[1,3], "B"=>[1,2], 2=>["B","D"], 3=>["A","C"], "C"=>[3,4], "D"=>[2,4], 4=>["C","D","E","F"], "E"=>[4,5], "F"=>[4,5], 5=>["E","F"]);

# Loading the cell
if($ARGV[0] && open(IN,"<$ARGV[0]"))
{
  %graphs=();
  while(<IN>) # reading each line
  {
    if(m/^([pn]mos) (\w+) (\w+) (\w+)/i) # Does the line define a transistor?
    {
      my($t,$g,$d,$s)=($1,$2,$3,$4); # Extract all the parameters from the line
      next if(lc($network) eq "pmos" && lc($t) eq "nmos"); # If we only look for pmos transistors we skip nmos transistors
      next if(lc($network) eq "nmos" && lc($t) eq "pmos"); # and vice versa
      print "$_" if($debug);
      if($power || $d!~m/(gnd|vdd)/i) # We skip power connections when needed
      {
        push @{$graphs{$g}},$d; # Here we add the gate-drain connection to the graph
        push @{$graphs{$d}},$g;
      }
      if($power || $s!~m/(gnd|vdd)/i)
      {
        push @{$graphs{$g}},$s; # Here we add the source-gate connection to the graph
        push @{$graphs{$s}},$g;
      }
    }
  }
  close IN;
}

# Done with parsing the cell file. Now the euler path is generated:

my @path = eulerPath(%graphs);
# The euler path has been generated, now it is being written out:
if($debug)
{
  print "Original graph:\n";
  print Dumper \%graphs;
  print "Generated Euler path:\n";
  print Dumper \@path;

}   
print join(",",@path)."\n"; 

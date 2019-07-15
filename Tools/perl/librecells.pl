#!/usr/bin/perl -w

mkdir "outputlib";

my $debug=0;

my $sp=$ARGV[0]||"libresilicon.sp";

open IN,"<$sp";
while(<IN>)
{
  if(m/^\.subckt (\w+)/)
  {
    my $cellname=$1;	   
    my $placer=""; $placer="--placer=hierarchical" if($cellname=~m/^(CLK|DFF|FAX|HAX)/);
    next if($cellname eq "CLKBUF3");# TODO: CLKBUF3 currently takes too much time to generate so we have to skip it, librecell needs to be improved
    my $cmd="lclayout --output-dir outputlib --tech ../Tech/librecell_tech.py --netlist $sp --cell $cellname -v $placer";
    print "$cmd\n";
    system $cmd;

    open OUT,"|magic -dnull -noconsole -T ../Tech/libresilicon ".($debug?"":">/dev/null 2>/dev/null");
    print OUT <<EOF
drc off
box 0 0 0 0
gds readonly true
gds rescale false
gds read outputlib/$cellname
writeall force $cellname
quit -noprompt
EOF
;
    close OUT;
    #system "gds2mag --config /root/libresilicon/gds2mag/example/example_config.toml -i outputlib/$1.gds -o _$1.mag";
    #    exit; # Stop after doing one cell
  }
}


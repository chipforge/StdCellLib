#!/usr/bin/perl -w

mkdir "outputlib";

my $debug=0;

my $sp=$ARGV[0]||"libresilicon.sp";

$ENV{'PySpiceLogLevel'}="DEBUG" if($debug);

open IN,"<$sp";
while(<IN>)
{
  if(m/^\.subckt (\w+)/)
  {
    my $cellname=$1;	   
    my $placer=""; $placer="--placer=hierarchical" if($cellname=~m/^(CLK|DFF|FAX|HAX)/);
    if($cellname eq "CLKBUF3")
    {
      print STDERR "TODO: CLKBUF3 currently takes too much time to generate so we have to skip it, librecell needs to be improved\n";
      next;
    }
    my $cmd="lclayout --output-dir outputlib --tech ../Tech/librecell_tech.py --netlist $sp --cell $cellname -v $placer";
    print "$cmd\n";
    system $cmd;

    # For this processing step, the refrenced libresilicon.tech file needs to contain the cifinput section to import from GDS and the extract section to do the parasitic extraction:
    open OUT,"|magic -dnull -noconsole -T ../Tech/libresilicon.tech ".($debug?"":">/dev/null 2>/dev/null");
    print OUT <<EOF
drc off
cellname rename (UNNAMED) $cellname
box 0 0 0 0
gds readonly true
gds rescale false
gds read outputlib/$cellname
select
port makeall
writeall force $cellname
quit -noprompt
EOF
; # $cellname.spice
    close OUT;
    system "cp $cellname.fixed $cellname.mag" if(-f "$cellname.fixed");
    unlink "$cellname.nodes";
    unlink "$cellname.res.ext";
    unlink "$cellname.spice";
    unlink "$cellname.ext";
    unlink "$cellname.al";
    unlink "$cellname.res.lump";
    unlink "$cellname.sim";
    open OUT,"|magic -dnull -noconsole -T ../Tech/libresilicon.tech $cellname.mag ".($debug?"":">/dev/null 2>/dev/null");
    print OUT <<EOF
extract warn all
extract all
ext2sim rthresh 0
ext2sim cthresh 0
ext2sim alias on
ext2sim labels on
ext2sim
extresist tolerance 10
extresist simplify off
extresist extout on
extresist lumped on
extresist geometry
extresist all
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice format ngspice
ext2spice subcircuits on
ext2spice extresist on
ext2spice hierarchy on
ext2spice $cellname.spice
ext2spice
quit -noprompt
EOF
;
    close OUT;

    system "lctime --debug --liberty libresilicon.lib --include ../Tech/libresilicon.m --spice $cellname.spice --cell $cellname --output $cellname.lib";
    #system "libertyviz -l INV.lib --cell INV --pin Y --related-pin A --table cell_rise";



    #system "gds2mag --config ~/libresilicon/gds2mag/example/example_config.toml -i outputlib/$1.gds -o _$1.mag";
    #    exit; # Stop after doing one cell
  }
}


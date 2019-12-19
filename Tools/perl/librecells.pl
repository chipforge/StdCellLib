#!/usr/bin/perl -w

mkdir "outputlib";

my $debug=1;

my $sp=$ARGV[0]||"libresilicon.sp";

$ENV{'PySpiceLogLevel'}="DEBUG" if($debug);
undef($ENV{'PySpiceLogLevel'}) unless($debug);

open IN,"<$sp";
while(<IN>)
{
  if(m/^\.subckt (\w+)/)
  {
    my $cellname=$1;	   
    next if(defined($ENV{'CELL'}) && $cellname ne $ENV{'CELL'});

    my $placer=""; $placer="--placer=hierarchical" if($cellname=~m/^(CLK|DFF|FAX|HAX)/);
    if($cellname eq "CLKBUF3")
    {
      print STDERR "TODO: CLKBUF3 currently takes too much time to generate so we have to skip it, librecell needs to be improved\n";
      next;
    }
    unlink "outputlib/$cellname.mag";
    system "../Tools/perl/cell2spice.pl $cellname";
    my $cmd="lclayout --output-dir outputlib --tech ../Tech/librecell_tech.py --netlist $sp --cell $cellname -v $placer";
    print "$cmd\n";
    system $cmd;

    if(-f "outputlib/$cellname.mag")
    {
      system "cp outputlib/$cellname.mag $cellname.mag";
    }
    else
    {
      # For this processing step, the refrenced libresilicon.tech file needs to contain the cifinput section to import from GDS and the extract section to do the parasitic extraction:
      open OUT,"|magic -dnull -noconsole -T ../Tech/libresilicon.tech ".($debug?"":">/dev/null 2>/dev/null");
      print OUT <<EOF
drc off
cellname rename (UNNAMED) $cellname
box 0 0 0 0
gds readonly true
gds rescale true
gds warning align
gds ordering yes
gds read outputlib/$cellname
select
port makeall
writeall force $cellname
quit -noprompt
EOF
; # $cellname.spice
      close OUT;

      exit;
    }

    system "cp $cellname.fixed $cellname.mag" if(-f "$cellname.fixed");
    unlink "$cellname.nodes";
    unlink "$cellname.res.ext";
    unlink "$cellname.spice";
    unlink "$cellname.ext";
    unlink "$cellname.al";
    unlink "$cellname.res.lump";
    unlink "$cellname.sim";
    print "First magic call:\n";
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
quit -noprompt
EOF
;
    close OUT;
    #system "cat $cellname.res.ext >>$cellname.ext";
    system "cat $cellname.ext";
    print "Second magic call:\n";
    open OUT,"|magic -dnull -noconsole -T ../Tech/libresilicon.tech $cellname.mag ".($debug?"":">/dev/null 2>/dev/null");
    print OUT <<EOF
ext2sim rthresh 0
ext2sim cthresh 0
ext2sim alias on
ext2sim labels on
ext2sim
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice format ngspice
ext2spice subcircuits on
ext2spice extresist off
ext2spice hierarchy on
ext2spice $cellname.spice
ext2spice
quit -noprompt
EOF
;
    close OUT;
    #system "grep -v \"option scale\" $cellname.spice >$cellname.spice2";
    open SIN,"<$cellname.spice";
    open SOUT,">$cellname.spice2";
    while(<SIN>)
    {
      s/\.option scale=1u//;
      s/w=1000/w=1u/;
      s/l=1000/l=1u/;
      print SOUT $_;
    }
    close SIN;
    close SOUT;

    system "mv $cellname.spice2 $cellname.spice";

    system "../Tools/perl/libgen.pl >$cellname.libtemplate";
    system "lctime --debug --liberty $cellname.libtemplate --include ../Tech/libresilicon.m --spice $cellname.spice --cell $cellname --output $cellname.lib";
    system "lctime --debug --liberty $cellname.libtemplate --include ../Tech/libresilicon.m --spice $cellname.sp --cell $cellname --output $cellname.lib";

    #system "libertyviz -l INV.lib --cell INV --pin Y --related-pin A --table cell_rise";



    #system "gds2mag --config ~/libresilicon/gds2mag/example/example_config.toml -i outputlib/$1.gds -o _$1.mag";
    #    exit; # Stop after doing one cell
  }
}


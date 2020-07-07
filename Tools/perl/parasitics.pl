#!/usr/bin/perl -w

my $mag=$ARGV[0] || ""; $mag=~s/\.mag$//i;
my $sp=$mag; $sp.=".par.sp";
my $par=$ARGV[1] || $sp;

my $tech=$ARGV[2] || "../Tech/libresilicon.tech";

print "parasitics.pl - Extract parasitics from a .mag file for characterization into a .par.sp (PARasitics-SPice) file\n";
print "Usage: parasitics.pl input.mag output.par.sp\n";

if(-f "$mag.mag")
{
    unlink "$mag.nodes";
    unlink "$mag.res.ext";
    unlink "$mag.spice";
    unlink "$mag.ext";
    unlink "$mag.al";
    unlink "$mag.res.lump";
    unlink "$mag.sim";

    print "First magic call:\n";
    open OUT,"|magic -dnull -noconsole -T $tech $mag.mag";
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
    #system "cat $cellname.ext";
    print "Second magic call:\n";
    open OUT,"|magic -dnull -noconsole -T $tech $mag.mag";
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
ext2spice $mag.spice
ext2spice
quit -noprompt
EOF
;
    close OUT;
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

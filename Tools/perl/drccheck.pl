#!/usr/bin/perl -w

my $mag=$ARGV[0] || ""; $mag=~s/\.mag$//i;

my $tech=$ARGV[1] || "../Tech/libresilicon.tech";

print "drccheck.pl - Check DRC rules with magic\n";
print "Usage: drccheck.pl input.mag\n" if(scalar(@ARGV)<1);

my $style="drc(fast)"; # "drc(full)";

if(-f "$mag.mag")
{
    open OUT,"|magic -dnull -noconsole -T $tech $mag.mag";
    my $outfile="$mag.drc";

    print OUT <<EOF
drc style $style
drc check
drc list count
drc listall catchup
set oscale [cif scale out]
set drcresult [lsort -stride 2 -index 0 [drc listall why]]
set fout [open \"$outfile\" w]
set countall 0
foreach {errtype coordlist} \$drcresult {
puts \$fout \$errtype
puts \$fout "----------------------------------------"
foreach coord \$coordlist {
    set bllx [expr {\$oscale * [lindex \$coord 0]}]
    set blly [expr {\$oscale * [lindex \$coord 1]}]
    set burx [expr {\$oscale * [lindex \$coord 2]}]
    set bury [expr {\$oscale * [lindex \$coord 3]}]
    set coords [format " %.3f %.3f %.3f %.3f" \$bllx \$blly \$burx \$bury]
    puts \$fout "\$coords"
    incr countall
}
puts \$fout "----------------------------------------"
}
puts \$fout ""
puts \$fout "Number of DRC errors: \$countall"

close \$fout
quit -noprompt
EOF
;

    close OUT;
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

#!/usr/bin/perl -w

my $mag=$ARGV[0] || ""; $mag=~s/\.mag$//i;
my $sp=$mag; $sp.=".log";
my $par=$ARGV[1] || $sp;

my $tech=$ARGV[2] || "../Tech/libresilicon.tech";

print "drccheck.pl - Check DRC rules with magic\n";
print "Usage: parasitics.pl input.mag drc.log\n";

if(-f "$mag.mag")
{
    open OUT,"|magic -dnull -noconsole -T $tech $mag.mag";
    print OUT <<EOF
drc style drc(full)
drc check
drc list count
drc listall catchup
set oscale [cif scale out]
set drcresult [drc listall why]
foreach {errtype coordlist} \$drcresult {
puts \$errtype
puts "----------------------------------------"
foreach coord \$coordlist {
    set bllx [expr {\$oscale * [lindex \$coord 0]}]
    set blly [expr {\$oscale * [lindex \$coord 1]}]
    set burx [expr {\$oscale * [lindex \$coord 2]}]
    set bury [expr {\$oscale * [lindex \$coord 3]}]
    set coords [format " %.3f %.3f %.3f %.3f" \$bllx \$blly \$burx \$bury]
    puts "\$coords"
}
puts "----------------------------------------"
}
puts ""



quit -noprompt
EOF
;
##drc listall catchup

    close OUT;
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

#!/usr/bin/perl -w


# Now we need magic 4.2 with kairos support compiled in for SVG export:
my $mag=$ARGV[0]; $mag=~s/\.mag$//i; $mag=~s/\.svg$//i;
my $svgvar=$mag; $svgvar.=".svg";
my $svg=$ARGV[1] || $svgvar;

print "mag2svg - Convert magic files to SVG\n";
print "Usage: mag2svg input.mag output.svg\n";

if(-f "$mag.mag")
{
  open MAGIC,"|magic -d XR -noconsole -nowindow $mag";
  print MAGIC "plot svg $svg\nquit\n";
  close MAGIC;
  print "$svg written.\n" if(-f $svg);
  print "Could not generate $svg , perhaps magic is not installed or missing Kairos support?\n" if(! -f $svg);
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

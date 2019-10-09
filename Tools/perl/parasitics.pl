#!/usr/bin/perl -w

my $mag=$ARGV[0]; $mag=~s/\.mag$//i; 
my $sp=$mag; $sp.=".par.sp";
my $par=$ARGV[1] || $sp;

print "parasitics.pl - Extract parasitics from a .mag file for characterization into a .par.sp (PARasitics-SPice) file\n";
print "Usage: parasitics.pl input.mag output.par.sp\n";

if(-f "$mag.mag")
{
  open MAGIC,"|magic -d XR -noconsole -nowindow -T ../Tech/libresilicon.tech $mag";
  print MAGIC "extract all\next2spice cthresh 0 rthresh 0 $par\next2spice\nquit\n";
  close MAGIC;
  #print "$svg written.\n" if(-f $svg);
  #print "Could not generate $svg , perhaps magic is not installed or missing Kairos support?\nThe cairo library development files need to be installed and magic needs to be configured with --with-cairo.\nMake sure that magic configure says 'Cairo: yes' in the summary.\n" if(! -f $svg);
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

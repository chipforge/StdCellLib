#!/usr/bin/perl -w

my $mag=$ARGV[0]; $mag=~s/\.mag$//i; 
my $sp=$mag; $sp.=".flat.mag";
my $flat=$ARGV[1] || $sp; 
my $tech=$ARGV[2] || "../Tech/libresilicon.tech";

print "flatten.pl - Flatten a hierarchical .mag file into a flattened .mag file\n";
print "Usage: flatten.pl input.mag output.mag [Technology]\n";

if(-f "$mag.mag")
{
  open MAGIC,"|magic -noconsole -nowindow -T $tech $mag";
  unlink $flat;
  $flat=~s/\.mag$//i; # We need to remove the extension otherwise load will not work
  print MAGIC "select\nexpand\nflatten $flat\nload $flat\nsave\n";
  print MAGIC "exit\n";
  close MAGIC;
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

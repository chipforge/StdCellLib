#!/usr/bin/perl -w

mkdir "Pool";

open G,">graph.g";

our $ncells=0;

sub handleRecursive($$)
{
  my $output1=$_[0]; $output1=~s/^Catalog/Pool/;
  print "Handling $_[0]\n";
  foreach(0 .. 2)
  {
    my $output=$output1;
    $output=~s/\.cell$/-$_.cell/;
    my $pop=$output; $pop=~s/\.cell$//; $pop=~s/^Pool\///; $pop=~s/^Catalog\///;
    print "\n\nTools/tcl/popcorn -o Pool -c $pop $_[0] -n $_\n";
    system "Tools/tcl/popcorn -o Pool -c $pop $_[0] -n $_";
    if(-f $output)
    {
      print G "$_[0] -> $output\n";
      $ncells++;
      handleRecursive($output,$_[1]+1) if($_[1]<2);
    }
    else
    {
      last;
    }
  }
}

foreach(<Catalog/*.cell>)
{
  handleRecursive($_,0);
}

print "Total cells generated: $ncells\n";

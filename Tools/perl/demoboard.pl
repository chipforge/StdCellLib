#!/usr/bin/perl -w

my @cells=();

foreach my $cell (<*.cell>)
{
  my $name=$cell; $name=~s/\.cell$//;
  next unless (-f "$name.mag");
  push @cells,$cell;
}

my $squared=sqrt(scalar(@cells)||1);

print STDERR "Cells: ".scalar(@cells)." Squared: $squared\n";

sub mymin($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[1]:$_[0];
}

sub mymax($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[0]:$_[1];
}



my $counter=0;
our $x=0;
our $y=0;

my $now=time();

print <<EOF
magic
tech scmos
timestamp $now
EOF
;

our $labels="";

foreach(@cells)
{
  my @mins=();
  my @maxs=();
  my $mag=$_; $mag=~s/\.cell$/.mag/;
  my $name=$_; $name=~s/\.cell$//;
  my $timestamp="1";

  if(open(IN,"<$mag"))
  {
    while(<IN>)
    {
      $timestamp=$1 if(m/^timestamp (\d+)/);	      
      if(m/^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/)
      { 
        my @a=split " ",$_;
        foreach(1 .. 4)
        {
          $mins[$_&1]=mymin($mins[$_&1],$a[$_]);
          $maxs[$_&1]=mymax($maxs[$_&1],$a[$_]);
        }
      }
    }
    close IN;
  }
  next unless(defined($maxs[0]));

  my $height=$maxs[0]-$mins[0];
  my $width=$maxs[1]-$mins[1];


  print "use $name  $name"."_0\n";
  print "timestamp $timestamp\n";
  print "transform 1 0 $x 0 1 $y\n";
  print "box 0 0 $width $height\n";

  my $lx=$x+$width/2;
  my $ly=$y+$height/2;
  $labels.="flabel space $lx $ly $lx $ly 0 FreeSans 1600 0 0 0 $name\n";

  $x+=$width;
  if(int($counter/$squared)>int(($counter-1)/$squared))
  {
    $x=0;
    $y+=$height;
  }

  $counter++; 
}
print "<< labels >>\n";
print $labels;

print "<< end >>\n";



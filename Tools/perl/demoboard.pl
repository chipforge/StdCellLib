#!/usr/bin/perl -w

my $times=$ARGV[0] || 1;

my @cells=();

foreach my $cell (<*.cell>)
{
  my $name=$cell; $name=~s/\.cell$//;
  next unless (-f "$name.mag");
  push @cells,$cell foreach(1 .. $times);
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

my $now=0; # time(); # 0 indicates that DRC needs to be run

my $usedtech="scmos";

our $labels="";

our $row=0;

our $printedheader=0;

our $magscale=undef;


foreach(@cells)
{
  my @mins=();
  my @maxs=();
  my $mag=$_; $mag=~s/\.cell$/.mag/;
  my $name=$_; $name=~s/\.cell$//;
  my $timestamp="0"; # Indicates that DRC needs to be run

  if(open(IN,"<$mag"))
  {
    my $layer="";
    while(<IN>)
    {
      $magscale=$1 if(m/^magscale (\d+ \d+)/);	    
      $usedtech=$1 if(m/^tech (\w+)/);
      #$timestamp=$1 if(m/^timestamp (\d+)/);	      
      #
      if(m/^<< (\w+) >>/)
      {
        $layer=$1;
      }
      next if($layer eq "checkpaint"); 
      if(m/^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/)
      { 
        #print STDERR "$name min:@mins max:@maxs $_";
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

  print STDERR "$name maxs: ".join("/",@maxs)." ";
  print STDERR "mins: ".join("/",@mins)." ";


  if(!$printedheader)
  {
    print <<EOF
magic
tech $usedtech
EOF
;
    print "magscale $magscale\n" if(defined($magscale));
    print <<EOF
timestamp $now
<< checkpaint >>
rect -100 -100 10000 10000
EOF
;
    $printedheader=1;
  }



  my $height=$maxs[0]+$mins[0];
  my $width=$maxs[1]-$mins[1];
  print STDERR "Cell-Width: $width Cell-Height: $height\n";

  my $dir=($row%2)?"-1":"1";

  my $bx=$x;
  my $by=$y; # -$mins[0];

  if($row%2)
  {
    $bx=$x+$width;
    $by=$y+$height; # +$mins[0];
  }
  print "use $name  $name"."_0\n";
  print "timestamp $timestamp\n";
  print "transform $dir 0 $bx 0 $dir $by\n";
  print "box 0 0 $width $height\n";
  #print STDERR "$name $width $height\n";

  my $lx=$x+int($width/2);
  my $ly=$y+int($height/2);

  $labels.="flabel space $lx $ly $lx $ly 0 FreeSans 80 0 0 0 $name\n";

  $x+=$width;
  if(int($counter/$squared)>int(($counter-1)/$squared))
  {
    $x=0;
    $y+=$height;
    $row++;
  }

  $counter++; 
}
print "<< labels >>\n";
print $labels;

print "<< end >>\n";



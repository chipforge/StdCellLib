#!/usr/bin/perl -w


# Now we need magic 4.2 with kairos support compiled in for SVG export:
my $mag=$ARGV[0]; $mag=~s/\.mag$//i; $mag=~s/\.svg$//i;
my $svgvar=$mag; $svgvar.=".svg";
my $svg=$ARGV[1] || $svgvar;

print "mag2svg - Convert magic files to SVG\n";
print "Usage: mag2svg input.mag output.svg\n" if(scalar(@ARGV)<1);

sub mymin($$)
{
  return $_[1] if(!defined($_[0]));
  return $_[0] if(!defined($_[1]));
  return $_[0]<$_[1]?$_[0]:$_[1];
}
sub mymax($$)
{
  return $_[1] if(!defined($_[0]));
  return $_[0] if(!defined($_[1]));
  return $_[0]>$_[1]?$_[0]:$_[1];
}

our $usewarning=0;



if(-f "$mag.mag")
{
	#  open MAGIC,"|magic -d XR -noconsole -nowindow -T ../Tech/libresilicon.tech $mag";
	#  print MAGIC "plot svg $svg\nexit\n";
	#  close MAGIC;
	#  print "$svg written.\n" if(-f $svg);
	#  print "Could not generate $svg , perhaps magic is not installed or missing Kairos support?\nThe cairo library development files need to be installed and magic needs to be configured with --with-cairo.\nMake sure that magic configure says 'Cairo: yes' in the summary.\n" if(! -f $svg);


  open IN,"<$mag.mag";
  #<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1419pt" height="760pt" viewBox="0 0 1419 760" version="1.1">
  my $layer="";
  my $rects="";
  my @limits=();
  while(<IN>)
  {
    if(m/^<< ([^>]+) >>/)
    {
      $layer=$1;
      #print "Layer: $layer\n";
    }
    elsif(m/^use/ && !$usewarning)
    {
      print STDERR "WARNING: Hierarchical magic files are not supported yet!\n";
      $usewarning=1; 
    }	     
    elsif(m/^rect (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*)/)
    {
      #print "Rect\n";	    
      my $width=$3-$1;
      my $height=$4-$2;
      $limits[1]=mymin($limits[1],$1);
      $limits[2]=mymin($limits[2],$2);
      $limits[3]=mymax($limits[3],$3);
      $limits[4]=mymax($limits[4],$4);
      $rects.="<rect x='$1' y='$2' width='$width' height='$height' class='$layer'/>\n";
    }
            #rlabel metal1 0 61 64 67 0 vdd
    elsif(m/rlabel (\S+) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (.*)/)
    {
      my $x=($2+$4)/2;
      my $y=($3+$5)/2;
      my $width=$4-$2;
      my $height=$5-$3;
      $rects.="<rect x='$2' y='$3' width='$width' height='$height' class='port'/>\n";

      $rects.="<text x='$x' y='$5'>$7</text>\n";
    }
  }
  close IN;
  my $width=($limits[3]||0)-($limits[1]||0);
  my $height=($limits[4]||0)-($limits[2]||0);
  if($width)
  {
    print "Writing $svg\n";
    open OUT,">$svg";
    print OUT <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="$limits[1] $limits[2] $width $height" version="1.1">
<style type="text/css">
rect { fill-opacity: 0.9; stroke-width:0.3px; stroke-opacity:0.5 }
.polysilicon { fill:#dc5f5f; }
.metal1 { fill:#9cb3ea; }
.m2contact { fill:#8b87c2; }
.metal2 { fill:#c3b3d3; }
.metal3 { fill:#e2abc9; }
.ndiffusion { fill:#42d542; }
.pdiffusion { fill:#caa073; }
.pdcontact { fill:#8592c8; }
.polycontact { fill:#8e2aaa; }
.nwell { fill:#bdbdbd; }
.pwell { fill:#ccccbd; }
.fence { stroke:#c8c8c8; fill:none }
.labels { fill:#ffffff; }
.port { stroke:#505050; fill:none}
text { font: normal 7px sans-serif; text-anchor: middle;}
</style>
$rects
</svg>
EOF
    ;  
    close OUT;
  }
  else
  {
    print "Error: Empty magic file!\n";
  }
}
else
{
  print STDERR "Error: Could not load magic file $mag.mag\n";
}

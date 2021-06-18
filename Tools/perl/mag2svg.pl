#!/usr/bin/perl -w


my $mag=$ARGV[0] || ""; $mag=~s/\.mag$//i; $mag=~s/\.svg$//i;
my $svgvar=$mag; $svgvar.=".svg";
my $svg=$ARGV[1] || $svgvar;
my $tech=$ARGV[2] || "../Tech/libresilicon.tech";

my %ignorelayers=("checkpaint"=>1);

print "mag2svg - Convert magic files to SVG\n";
print "Usage: mag2svg input.mag output.svg\n" if(scalar(@ARGV)<1);

our %colors=();
our %styles=();
our $csscolors="";

sub initColors()
{
  my $dir=$ENV{'MAGIC_DIR'} || "/usr/local/lib/magic/sys";	 
  open IN,"<$dir/mos.24bit.std.cmap";
  while(<IN>)
  {
    if(m/^(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\w+)\s*$/)
    {
      $colors{$4}=sprintf("#%02X%02X%02X",$1,$2,$3);
      #print "$4:$colors{$4}\n";
    }
  }
  close IN;
  for my $style (<$dir/mos.24bit.dstyle>)
  {
    open IN,"<$style";
    while(<IN>)
    {
      if(m/^(\d+)\s+(\w+)\s+(\d+)\s+(\w+)\s+(\w+)\s+(\d+)\s+(\S+)\s+(\w+)/)
      {
	my $c=$colors{$3}||sprintf("#%02x%02x%02x",rand()*256,rand()*256,rand()*256);
	$styles{$8}=$c;
	#print "$8:$c\n";
      }
    }
    close IN;    
  }
  foreach my $tech (<$dir/*.tech>)
  {
    #print "tech$tech\n";	  
    open IN,"<$tech";
    while(<IN>)
    {
      if(m/^\s*styles\s*$/)
      {
	#print "styles found\n";
        while(<IN>)
        {
          last if(m/^\s*end\s*$/);
	  if(m/^\s*(\w+)\s+(\w+)/)
	  {
            my $s=$styles{$2}||"";
	    #print "$1 $s\n" if($s);
            $csscolors.=".$1 { fill:$s; }\n" if($s ne "");
	  }
	}	
      }
    }
    close(IN);
  }

}
initColors();

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
  # Now we need magic 4.2 with kairos support compiled in for SVG export:
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
      close IN; # We dont need it anymore, we use a different approach now:

      open MAGIC,"|magic -noconsole -nowindow -T $tech $mag";
      my $flat="tmp".int(rand()*10000).".mag";
      unlink $flat;
      $flat=~s/\.mag$//i; # We need to remove the extension otherwise load will not work
      print MAGIC "select\nexpand\nflatten $flat\nload $flat\nsave\n";
      print MAGIC "exit\n";
      close MAGIC;
      system "$0 $flat.mag $svg $tech";
      unlink $flat;
      exit;
    }	     
    elsif(m/^rect (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*)/)
    {
      #print "Rect\n";	    
      next if(defined($ignorelayers{$layer}));
      my $width=$3-$1;
      my $height=$4-$2;
      $limits[1]=mymin($limits[1],$1);
      $limits[2]=mymin($limits[2],$2);
      $limits[3]=mymax($limits[3],$3);
      $limits[4]=mymax($limits[4],$4);
      my $ny=-$4;
      $rects.="<rect x='$1' y='$ny' width='$width' height='$height' class='$layer'/>\n";
    }
            #rlabel metal1 0 61 64 67 0 vdd
    elsif(m/rlabel (\S+) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (\-?\d+\.?\d*) (.*)/)
    {
      my $x=($2+$4)/2;
      my $y=($3+$5)/2;
      my $width=$4-$2;
      my $height=$5-$3;
      my $ny=-$5;
      $rects.="<rect x='$2' y='$ny' width='$width' height='$height' class='port'/>\n";
      $ny+=$height;
      $rects.="<text x='$x' y='$ny'>$7</text>\n";
    }
  }
  close IN;
  my $width=($limits[3]||0)-($limits[1]||0);
  my $height=($limits[4]||0)-($limits[2]||0);
  $limits[2]=-($limits[4] || 0);
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
.poly { fill:#dc5f5f; }
.li1 { fill:#8ca3da; }
.metal1 { fill:#9cb3ea; }
.met1 { fill:#9cb3ea; }
.m2contact { fill:#8b87c2; }
.licon1 { fill:#8b87c2; }
.metal2 { fill:#c3b3d3; }
.metal3 { fill:#e2abc9; }
.ndiffusion { fill:#42d542; }
.pdiffusion { fill:#caa073; }
.pdcontact { fill:#8592c8; }
.mcon { fill:#8592c8; }
.polycontact { fill:#8e2aaa; }
.nwell { fill:#bdbdbd; fill-opacity: 0.5;}
.pwell { fill:#ccccbd; }
.fence { stroke:#c8c8c8; fill:none }
.bound { stroke:#c8c8c8; fill:none }
.labels { fill:#ffffff; }
.port { stroke:#505050; fill:none}
.abutment { fill:none; stroke:#ffffff; stroke-width:2 }
text { font: normal 7px sans-serif; text-anchor: middle;}
$csscolors
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

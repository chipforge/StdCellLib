#!/usr/bin/perl -w

# Converting MAGIC files to JSON for https://app.siliwiz.com/

my $scale=3; # Scale 1 would be technically correct, but the result is so small that you cannot see much, so Scale 3 is usually better
my $movex=15;
my $movey=25;

print <<EOF
{
  "version": 1,
  "app": "siliwiz",
  "generator": "mag2siliwiz",
  "timestamp": 1676492697,
  "rects": [
EOF
;

sub layername($)
{
  my $d=$_[0];
  $d=~s/^met(\d+)$/metal$1/;
  $d=~s/^([np])diffusion$/$1 diffusion/;
  $d=~s/^([np])well$/$1 well/;
  $d=~s/^via1$/metal2 via/;
  $d=~s/^poly$/polysilicon/;
  $d=~s/^polycont$/metal1 via/;
  $d=~s/^[np]diffc$/metal1 via/;
  return $d;
}
sub ioname($)
{
  my $d=$_[0];
  $d=~s/GND/vss/;
  $d=~s/VDD/vdd/;
  $d=~s/A/in/;
  $d=~s/Y/out/;
  return $d;
}

my @lines=<STDIN>;
my $layer="undef";
my $count=0;
foreach(@lines)
{
  if(m/^<< (\w+) >>/)
  {
    $layer=layername($1);
  }
  if(m/^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/)
  {
    print ", " if($count);
    print " { \"x\": ".($1*$scale+$movex).", \"y\": ".($2*$scale+$movey).", \"width\": ".(($3-$1)*$scale).", \"height\": ".(($4-$2)*$scale).", \"layer\": \"$layer\" }\n";
    $count++;
  }
  if(m/^rlabel (\w+) (-?\d+) (-?\d+) (-?\d+) (-?\d+) (-?\d+) (\w+)/)
  {
    print ", " if($count);
    print " { \"x\": ".($2*$scale+$movex).", \"y\": ".($3*$scale+$movey).", \"width\": ".(($4-$2)*$scale).", \"height\": ".(($5-$3)*$scale).", \"layer\": \"".layername($1)."\", \"label\": \"".ioname($7)."\" }\n";
    $count++;
  }
}

print <<EOF
  ],
  "graph": {
    "dcSweep": false,
    "minInVoltage": 0,
    "maxInVoltage": 5,
    "pulseDelay": 0,
    "riseTime": 50,
    "signalNames": "in out"
  }
}
EOF
;

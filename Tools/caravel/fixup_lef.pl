#!/usr/bin/perl -w
use strict;

my %layersToDo=("li1"=>1,"mcon"=>1,"locali"=>1,"metal1"=>1);

sub readfile($)
{
  if(open MYRIN,"<$_[0]")
  {
    my $old=$/;
    undef $/;
    my $content=<MYRIN>;
    close MYRIN;
    $/=$old;
    return $content;
  }
  return undef;
}


foreach my $origlef (<orig/*.lef>)
{
  my $lef=$origlef; $lef=~s/^orig\///;	
  my $mag="../mag/$lef"; $mag=~s/\.lef$/\.mag/;
  print STDERR "origlef: $origlef\n lef: $lef\n mag:$mag\n";
  my $obs="";



  if(open(MAGIN,"<$mag"))
  {
    print "Extracting Obstruction information from $mag\n";	  
    my $active=0;
    my $factor=100.0;
    while(<MAGIN>)
    {
      if(m/magscale (\d+) (\d+)/)
      {
        $factor=100.0*$2;
      }
      if(m/<< (\w+) >>/)
      {
        $active=defined($layersToDo{$1});
	$obs.="    LAYER $1 ;\n" if($active);
      }
      if(m/rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/ && $active)
      {
        $obs.="      RECT ( ".($1/$factor)." ".($2/$factor)." ) ( ".($3/$factor)." ".($4/$factor)." ) ;\n";
      }
    }
    close MAGIN;
  }
  else
  {
     print "ERROR: Could not open magic file $mag : $!\n";
  }

  #print "$mag\n$obs\n";
  #next;
  
  my $content=readfile("orig/$lef");
  $content=~s/\sOBS\s.*?\sEND\s//sg;
  open OUT,">$lef.temp";
  print OUT $content;
  close OUT;

  my $cell=$lef; $cell=~s/\.lef//;
  print "$lef\n";
  #  open LEFIN,"<orig/$lef";
  open LEFOUT,">$lef";
  our $pin="";
  my $filled=0;
  our $macro="NOTTOBEFOUND";

  #print "$obs\n";
  foreach(split "\n",$content) # while(<LEFIN>)
  {
    $_.="\n";	  
    $macro=$1 if(m/MACRO\s+(\w+)/);
    $pin=$1 if(m/PIN\s+(\w+)/);
    #s/SYMMETRY X Y R90/SITE unit/;
    #s/SITE CORE/SYMMETRY X Y R90/;
    #s/SITE unit.*//;
    s/metal2/met1/;
    s/VDD/VPWR/;
    s/GND/VGND/;
    s/USE SIGNAL/USE POWER/ if($pin eq "VDD" || $pin eq "VPWR");
    s/USE POWER/USE GROUND/ if($pin eq "GND" || $pin eq "VGND"); # GND braucht USE GROUND statt USE POWER

    if(m/^\s*END\s+$macro/ && !$filled) # Inject the obstructions here
    {
      print LEFOUT "\n  OBS\n$obs\n  end\n";
      $filled=1;
    }
    #print $_;
    print LEFOUT $_;	   
    #print "$macro\n";
    #print $_;
    if(m/FOREIGN/)
    {
      if(open(MAG,"<$mag"))
      {
        my $layer="";
        while(<MAG>)
        {
          if(m/<< (\w+) >>/)
	  {
            $layer=$1;
	  }
          if(m/rect 0 0 (\d+) (\d+)/)
          {
            next if($layer eq "checkpaint");
            my $h=$1;
            my $w=$2;
            my $factor=0.01;
	    #print "$lef -> ".($1*$factor)." ".($2*$factor)."\n";
	    #print LEFOUT " SIZE ".($1*$factor)." BY ".($2*$factor)." ;\n";
          }
          if(m/string FIXED_BBOX 0 0 (\d+) (\d+)/)
          {
            my $h=$1;
            my $w=$2;
            my $factor=0.01;
	    #print "$lef -> ".($1*$factor)." ".($2*$factor)."\n";
	    #print LEFOUT " SIZE ".($1*$factor)." BY ".($2*$factor)." ;\n";
          }

	}
        close MAG;
      }
    }
  }
  close LEFOUT;
  #close LEFIN;

  system "cp $lef $lef.beforemagic";

  open MAGIC,"|magic -dnull -noconsole -T sky130A";
  print MAGIC "lef read $lef\n";
  print MAGIC "load $cell\n";
  print MAGIC "lef write $lef\n";
  print MAGIC "quit\n";
  close MAGIC;
}

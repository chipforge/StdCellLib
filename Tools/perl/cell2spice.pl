#!/usr/bin/perl -w

my $tech="w=1.0u l=1.0u";

if(open IN,"<../Tech/transistor.sp")
{
  print "Loading tech specs from transistor.sp file\n";
  $tech=<IN>; $tech=~s/[\n\r]//s;
  close IN;
}

print "Tech specs: $tech\n";

my @cells=<*.cell>;
my $cell=undef;

if(scalar(@ARGV))
{
  $cell=$ARGV[0];
  $cell=~s/\.cell$//;
  @cells=$cell.".cell";
}

open OUT,">".($cell?"$cell.sp":"libresilicon.sp");

print "Params: ".scalar(@ARGV)." ".scalar(@cells)."\n";

foreach my $fn (@cells)
{
  my $short=$fn; $short=~s/\.cell//;
  my $transistors="";
  print "Opening $fn\n";
  open IN,"<$fn" || die "Error opening cell file: $!\n";
  my $M=0;
  my $ios="";
  while(<IN>)
  {
    if(m/^\.(inputs|outputs) (.*)/)
    {
      $ios.=" ".$2;
    }
    if(m/^([pn]mos) (\w+) (\w+) (\w+)/i)
    {
      my($t,$g,$d,$s)=($1,$2,$3,$4);
      my $x=($t eq "pmos")?"vdd":"gnd";
      $transistors.="M$M $d $g $s $x $t $tech\n";
            #M1  vdd    B a_2_6# vdd pmos w=0.5u l=0.05u
            #M2  Y a_2_6# vdd vdd pmos w=0.5u l=0.05u
            #M3  a_9_6# A a_2_6# gnd nmos w=0.5u l=0.05u
            #M4  gnd    B a_9_6# gnd nmos w=0.5u l=0.05u
            #M5  Y a_2_6# gnd gnd nmos w=0.25u l=0.05u
	    #$transistors.="+ ad=0p pd=0u as=0p ps=0u\n";
      $M++;
    }
    if(m/^res (\w+) (\w+) (\w+)/i)
    {
      my($n1,$n2,$v)=($1,$2,$3);
      $transistors.="R$M $n1 $n2 $v\n";
      $M++;
    }
  }
  $ios=~s/,/ /g;$ios=~s/  / /g; $ios=~s/^ //; $ios=~s/ $//;
  print OUT ".subckt $short vdd gnd $ios\n";
  print OUT $transistors;
  print OUT ".ends $short\n\n";
  close IN;
}

close OUT;


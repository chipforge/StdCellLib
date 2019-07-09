#!/usr/bin/perl -w

open OUT,">libresilicon.sp";

foreach my $fn (<*.cell>)
{
  my $short=$fn; $short=~s/\.cell//;
  my $transistors="";

  open IN,"<$fn";
  my $M=0;
  my $ios="";
  while(<IN>)
  {
    if(m/^\.(inputs|outputs) (.*)/)
    {
      $ios.=" ".$2;
    }
    if(m/^(\w+) (\w+) (\w+) ([pn]mos)/i)
    {
      my($g,$d,$s,$t)=($1,$2,$3,$4);
      my $x=($t eq "pmos")?"vdd":"gnd";
      $transistors.="M$M $d $g $s $x $t w=0.5u l=0.05u\n";
            #M1  vdd    B a_2_6# vdd pmos w=0.5u l=0.05u
            #M2  Y a_2_6# vdd vdd pmos w=0.5u l=0.05u
            #M3  a_9_6# A a_2_6# gnd nmos w=0.5u l=0.05u
            #M4  gnd    B a_9_6# gnd nmos w=0.5u l=0.05u
            #M5  Y a_2_6# gnd gnd nmos w=0.25u l=0.05u
      $transistors.="+ ad=0p pd=0u as=0p ps=0u\n";
      $M++;
    }
  }
  $ios=~s/,/ /g;$ios=~s/  / /g; $ios=~s/^ //; $ios=~s/ $//;
  print OUT ".subckt $short vdd gnd $ios\n";
  print OUT $transistors;
  print OUT ".ends $short\n\n";
}

close OUT;


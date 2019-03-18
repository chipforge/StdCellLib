open OUT,">libresilicon.spice";

foreach my $fn (<*.cell>)
{
  my $short=$fn; $short=~s/\.cell//;

  print OUT ".subckt $short Y B vdd gnd A\n";

  open IN,"<$fn";
  my $M=0;
  while(<IN>)
  {
    if(m/^(\w+) (\w+) (\w+) ([pn]mos)/i)
    {
      my($g,$d,$s,$t)=($1,$2,$3,$4);
      my $x=($t eq "pmos")?"vdd":"gnd";
      print OUT "M$M $g $d $s $x $t w=0.5u l=0.05u\n";
            #M1  vdd    B a_2_6# vdd pmos w=0.5u l=0.05u
            #M2  Y a_2_6# vdd vdd pmos w=0.5u l=0.05u
            #M3  a_9_6# A a_2_6# gnd nmos w=0.5u l=0.05u
            #M4  gnd    B a_9_6# gnd nmos w=0.5u l=0.05u
            #M5  Y a_2_6# gnd gnd nmos w=0.25u l=0.05u
      print OUT "+ ad=0p pd=0u as=0p ps=0u\n";
      $M++;
    }
  }
  print OUT ".ends $short\n\n";
}

close OUT;


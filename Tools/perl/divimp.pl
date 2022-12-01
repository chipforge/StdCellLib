#!/usr/bin/perl -w

my $maxios=38+128-2;
my $usedios=0;
my $totalios=0;
my $group=0;
foreach my $cell(<*.cell>)
#foreach my $cell(qw(AAAAOI3322.cell AAAOAI3221.cell AAAOAOI33311.cell AAAOI222.cell AAAOI333.cell AAOAOI33111.cell AAOI22.cell AAOOAAOI2224.cell AOAAOI2124.cell AOAI221.cell AOI21.cell ASYNC1.cell ASYNC2.cell ASYNC3.cell INV.cell MARTIN1989.cell MUX2.cell MUX3.cell MUX4.cell MUX8.cell NAND2.cell NAND3.cell NAND4.cell NOR2.cell NOR3.cell NOR4.cell OAAAOI2132.cell OAAOAOI21311.cell OAAOI224.cell OAOOAAOI21132.cell OAI41.cell OOOOAI3332.cell OR4.cell sutherland1989.cell vanberkel1991.cell))
{
  my $thisios=0;
  my $cn=$cell; $cn=~s/\.cell$//;
  if(-f "outputlib/$cn.gds")
  {
    open IN,"<$cell";
    while(<IN>)
    {
      if(m/^\.(inputs|outputs) (.*)$/)
      {
	@ins=split(" ",$2);
	$thisios+=@ins;
      }
    }
    close IN;
    $totalios+=$thisios;
    if($usedios+$thisios>$maxios)
    {
      $usedios=0;
      $group++;
      print "NEXT GROUP\n";
    }
    $usedios+=$thisios;
    print "$group $cn $thisios\n";
 
  }

}

#!/usr/bin/perl -w

my @cells=qw(AAAAOI3322.cell AAAOAI3221.cell AAAOAOI33311.cell AAAOI222.cell AAAOI333.cell AAOAOI33111.cell AAOI22.cell AAOOAAOI2224.cell AOAAOI2124.cell AOAI221.cell AOI21.cell ASYNC1.cell ASYNC2.cell ASYNC3.cell INV.cell MARTIN1989.cell MUX2.cell MUX3.cell MUX4.cell MUX8.cell NAND2.cell NAND3.cell NAND4.cell NOR2.cell NOR3.cell NOR4.cell OAAAOI2132.cell OAAOAOI21311.cell OAAOI224.cell OAOOAAOI21132.cell OAI41.cell OOOOAI3332.cell OR4.cell sutherland1989.cell vanberkel1991.cell);

foreach my $cell(@cells)
{
  my $CELL=$cell; $CELL=~s/\.cell$//;
  $ENV{'CELL'}=$CELL;
  if(!-f $cell)
  {
    print "Cell $CELL existiert nicht!\n";
    next;
  }
  system "touch $cell" if(-f $cell);
  system "make layout";
}

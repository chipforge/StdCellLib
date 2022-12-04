#!/usr/bin/perl -w

my $maxios=38+128-2;
my $usedios=0;
my $totalios=0;
my $group=1;

our $githubuser="thesourcerer8";
our $CARAVEL="";
our @repos=();

my $magictech="gf180mcuC";

sub step($)
{
  print "$_[0]\n";
  print STDERR "$_[0]\n";
}

sub nextgroup($)
{
  $CARAVEL="gf180_stdcelllib_$_[0]";
  system "git clone git\@github.com:$githubuser/$CARAVEL.git" unless(-d $CARAVEL);
  return(undef) unless(-d $CARAVEL);
  push @repos,$CARAVEL;
  return $CARAVEL;
}

sub addcell($$)
{
  my ($group,$cn)=@_;
  print "Adding cell $cn to group $group\n";
  mkdir "$CARAVEL/cells";
  mkdir "$CARAVEL/cells/mag";
  mkdir "$CARAVEL/cells/lib";
  mkdir "$CARAVEL/cells/cell";
  mkdir "$CARAVEL/cells/sp";
  mkdir "$CARAVEL/cells/lef";
  mkdir "$CARAVEL/cells/lef/orig";
  mkdir "$CARAVEL/cells/gds";
  system "cp $cn.mag $CARAVEL/cells/mag/";
  system "cp $cn.lib $CARAVEL/cells/lib/" if(-f "$cn.lib");
  system "cp $cn.cell $CARAVEL/cells/cell/";
  system "cp $cn.sp $CARAVEL/cells/sp/";
  system "cp outputlib/$cn.lef $CARAVEL/cells/lef/orig/";
  system "cp outputlib/$cn.gds $CARAVEL/cells/gds/";
}

sub endgroup($)
{
  my $CARAVEL=$_[0];

  #$ENV{'STD_CELL_LIBRARY'}='sky130_fd_sc_ls';
  $ENV{'STDCELLLIB'}='../'; # /home/philipp/libresilicon/StdCellLib
  $ENV{'OPENLANE_ROOT'}=$ENV{'PWD'}."/$CARAVEL/dependencies/openlane_src"; # =$(readlink -f $(pwd)/../openlane )
  #$ENV{'OPENLANE_TAG'}="gfmpw-0c";
  $ENV{'CARAVEL'}=$ENV{'PWD'}."/$CARAVEL"; # =$(pwd)
  $ENV{'CARAVEL_ROOT'}=$ENV{'PWD'}."/$CARAVEL/caravel";
  $ENV{'PDK_ROOT'}=$ENV{'PWD'}."/$CARAVEL/dependencies/pdks"; # =$(readlink -f $(pwd)/../pdk )
  $ENV{'PDK'}="gf180mcuC";
  #$ENV{'PATH'}.=#export PATH=$PATH:$(readlink -f $(pwd)../openlane_summary/ )
  print "Writing Environment file for easy debugging, just \"source env.sh\" when you need it:\n";
  open OUT,">$CARAVEL/env.sh";
  foreach(qw(STDCELLLIB OPENLANE_ROOT CARAVEL CARAVEL_ROOT PDK_ROOT PDK))
  {
    print OUT "export $_=\"".$ENV{$_}."\"\n";
  }
  close OUT;

  mkdir "$CARAVEL/dependencies",0777;
  chdir "$CARAVEL";
  system "perl ../../Tools/caravel/configgen.pl >openlane/user_proj_example/config.json";



  chdir "cells/lef";
  step("fixup_lef $CARAVEL");
  system "perl ../../../../Tools/caravel/fixup_lef.pl $magictech";
  chdir "../../../";
  chdir "$CARAVEL/cells/mag";
  step("fixup_mag $CARAVEL");
  system "perl ../../../../Tools/caravel/fixup_mag.pl $magictech" if($magictech eq "sky130A");
  chdir "../../../";
  chdir "$CARAVEL/cells/sp";
  step("fixup_sp $CARAVEL");
  system "perl ../../../../Tools/caravel/fixup_sp.pl $magictech";
  chdir "../../../";

  chdir "$CARAVEL/cells/lib";
  step("libertymerge");
  system "libertymerge -b ../../../libresilicon.libtemplate -o libresilicon.lib -u *.lib";
  step("removenl");
  system "perl ../../../../Tools/caravel/removenl.pl >new.lib";
  system "mv new.lib libresilicon.lib";
  chdir "../../../";
  step("generator");
  system "perl ../Tools/caravel/generator.pl >$CARAVEL/verilog/rtl/user_proj_example.v";
  step("cells");
  system "perl ../Tools/caravel/cells.pl >$CARAVEL/verilog/rtl/user_proj_cells.v";
  step("placement");
  system "perl ../Tools/caravel/placement.pl >$CARAVEL/openlane/user_proj_example/macro_placement.cfg";
  chdir $CARAVEL; 
  step("make user_proj_example");
  system "make setup";
  system "make user_proj_example && make user_project_wrapper";
  system "make dist";
  system "git add cells env.sh verilog/rtl/user_proj_cells.v verilog/rtl/user_proj_example.v openlane/user_proj_example/*";
  system "git commit -m \"Automatically generated files\"";
  chdir "..";
}

print "Selecting first group:\n";
nextgroup($group);
my @cells=qw(AAAAOI3322.cell AAAOAI3221.cell AAAOAOI33311.cell AAAOI222.cell AAAOI333.cell AAOAOI33111.cell AAOI22.cell AAOOAAOI2224.cell AOAAOI2124.cell AOAI221.cell AOI21.cell ASYNC1.cell ASYNC2.cell ASYNC3.cell INV.cell MARTIN1989.cell MUX2.cell MUX3.cell MUX4.cell MUX8.cell NAND2.cell NAND3.cell NAND4.cell NOR2.cell NOR3.cell NOR4.cell OAAAOI2132.cell OAAOAOI21311.cell OAAOI224.cell OAOOAAOI21132.cell OAI41.cell OOOOAI3332.cell OR4.cell sutherland1989.cell vanberkel1991.cell);
push @cells,<*.cell>;
my %seen=();

print "Adding all the cells onboard the Caravels:\n";
foreach my $cell (@cells)
{
  next if(defined($seen{$cell}));
  $seen{$cell}=1;
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
    if(($usedios+$thisios)>$maxios)
    {
      $usedios=0;
      $group++;
      print "NEXT GROUP\n";
      my $res=nextgroup($group);
      last unless($res);
    }
    $usedios+=$thisios;
    $totalios+=$thisios;
    print "$group $cn $thisios\n";
    addcell($group,$cn); 
  }

}
print "Now shipping all the Caravels\n";
endgroup($_) foreach(@repos);
print "All Caravels are done.\n";

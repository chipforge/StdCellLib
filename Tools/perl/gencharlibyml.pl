#!/usr/bin/perl -w

open OUT,">libresilicon-charlib.yml";


print OUT <<EOF
settings:
    lib_name: libresilicon-$ENV{'PDK'}
    units:
        time:               ns
        voltage:            V
        current:            uA
        pulling_resistance: kOhm
        leakage_power:      nW
        capacitive_load:    pF
        energy:             fJ
    named_nodes:
        vdd:
            name:       VDD
            voltage:    3.3
        vss:
            name:       GND
            voltage:    0
        pwell:
            name:       VPW
            voltage:    0
        nwell:
            name:       VNW
            voltage:    3.3
    cell_defaults:
        models: [gf180.ngspice]
        slews: [0.015, 0.04, 0.08, 0.2, 0.4]
        loads: [0.06, 0.18, 0.42, 0.6, 1.2]
cells:
EOF
;	

foreach my $cell(<*.cell>)
{
  open IN,"<$cell";
  my $cn=$cell; $cn=~s/\.cell$//;
  print OUT "    $cn:\n";
  print OUT "        netlist: $cn.sp\n";
  while(<IN>)
  {
    if(/^\.inputs (.*?)\s*$/)
    {
      my $ins=$1; $ins=~s/ /,/g;
      print OUT "        inputs: [$ins]\n";
    }
    if(/^\.outputs (.*?)\s$/)
    {
      my $outs=$1; $outs=~s/ /,/g;
      print OUT "        outputs: [$outs]\n";
    }
  }
  close IN;

  if(open(IN,"<outputlib/$cn.lef"))
  {
    while(<IN>)
    {
      if(m/SIZE\s+(\d+\.?\d*)\s+BY\s+(\d+\.\d*)/)
      {
        my $area=int($1*$2*100);
	print OUT "        area: $area\n";
      }
    }
    close IN;
  }
  if(open(IN,"<$cn.truthtable.v"))
  {
    print OUT "        functions:\n";
    while(<IN>)
    {
      s/function: //; s/\&\&/\&/g; s/\|\|/\|/g;
      print OUT "            - $_";
    }
    close IN;
  }

}

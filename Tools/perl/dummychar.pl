#!/usr/bin/perl -w
use strict;

my $pdk=$ENV{'PDK'};

print <<EOF
library (ls_stdcells_$pdk) {
  delay_model: table_lookup;
  in_place_swap_mode: match_footprint;
  time_unit: "1ns";
  voltage_unit: "1V";
  current_unit: "1uA";
  pulling_resistance_unit: "1kohm";
  leakage_power_unit: "1nW";
  capacitive_load_unit (1.0, pf);
  slew_upper_threshold_pct_rise: 80.0;
  slew_lower_threshold_pct_rise: 20.0;
  slew_upper_threshold_pct_fall: 80.0;
  slew_lower_threshold_pct_fall: 20.0;
  input_threshold_pct_rise: 50.0;
  input_threshold_pct_fall: 50.0;
  output_threshold_pct_rise: 50.0;
  output_threshold_pct_fall: 50.0;
  nom_process: 1.0;
  nom_voltage: 5.0;
  nom_temperature: 25.0;
  default_operating_conditions: typical;
  operating_conditions (typical) {
    process: 1.0;
    voltage: 5.0;
    temperature: 25.0;
  }
  lu_table_template (delay_template_5x5) {
    variable_1: total_output_net_capacitance;
    variable_2: input_net_transition;
    index_1 (
      "1000.000000, 1001.000000, 1002.000000, 1003.000000, 1004.000000"
    );
    index_2 (
      "1000.000000, 1001.000000, 1002.000000, 1003.000000, 1004.000000"
    );
  }
EOF
;

my @cells=$ARGV[0] || <*.cell>;
foreach my $cell(@cells)
{
  $cell=~s/\.cell$//;
  my $area=123456;
  my @inputs=();
  my @outputs=();
  
  open IN,"<$cell.cell"; 
  $/="\n";
  foreach my $line(<IN>)
  {
    @inputs=split(" ",$1) if($line=~m/^\.inputs (\w.*)/i);
    @outputs=split(" ",$1) if($line=~m/^\.outputs (\w.*)/i)
  }
  close IN;
  open IN,"<$cell.truthtable.v";
  undef $/;
  my %funcs=();
  while(<IN>)
  {
    if(m/(\w+) = ((.*))$/)
    {
      my ($pin,$func)=($1,$2);
      $func=~s/ //g; $func=~s/\&\&/\&/g; $func=~s/\|\|/\|/g;
      $funcs{$pin}="      function: \"".$func."\";";
    }
  }
  close IN;

  print <<EOF
  cell ($cell) {
    area: $area;
    cell_leakage_power: 0.1173;
EOF
;
  foreach(@inputs)
  {
    print <<EOF
    pin ($_) {
      direction: input;
      rise_capacitance: 0.02579587473901343;
      fall_capacitance: 0.025800536095056198;
      capacitance: 0.025798205417034818;
    }
EOF
  ;
  }
  foreach(@outputs)
  {
    print <<EOF
    pin ($_) {
      direction: output;
EOF
      ;
    if(!defined($funcs{$_}))
    {
      print STDERR "Warning: In the cell $cell the output $_ does not have a defined function in the $cell.truthtable.v ! Use this cell on your own risk.\n";
    }
    else
    {
      print $funcs{$_}."\n";
    }
    print <<EOF
    }
EOF
  ;

  }
  print <<EOF
  }
EOF
  ;
}

print <<EOF
}
EOF
;

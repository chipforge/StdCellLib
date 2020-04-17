#!/usr/bin/perl -w
use strict;

#Liberty File generator
#

print <<EOF
/*
 delay model :       typ
 check model :       typ
 power model :       typ
 capacitance model : typ
 other model :       typ
*/
library(ls05_stdcells) {

  delay_model : table_lookup;
  in_place_swap_mode : match_footprint;

  /* unit attributes */
  time_unit : "1ns";
  voltage_unit : "1V";
  current_unit : "1uA";
  pulling_resistance_unit : "1kohm";
  leakage_power_unit : "1nW";
  capacitive_load_unit (1,pf);

  slew_upper_threshold_pct_rise : 80;
  slew_lower_threshold_pct_rise : 20;
  slew_upper_threshold_pct_fall : 80;
  slew_lower_threshold_pct_fall : 20;
  input_threshold_pct_rise : 50;
  input_threshold_pct_fall : 50;
  output_threshold_pct_rise : 50;
  output_threshold_pct_fall : 50;
  nom_process : 1;
  nom_voltage : 5;
  nom_temperature : 25;
  operating_conditions ( typical ) {
     process : 1;
     voltage : 5;
     temperature : 25;
  }
  default_operating_conditions : typical;

  lu_table_template(delay_template_5x1) {
    variable_1 : input_net_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  lu_table_template(delay_template_5x5) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_net_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  lu_table_template(delay_template_5x6) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_net_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(delay_template_6x1) {
    variable_1 : input_net_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(delay_template_6x6) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_net_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  power_lut_template(energy_template_5x5) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_transition_time;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  power_lut_template(energy_template_5x6) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_transition_time;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  power_lut_template(energy_template_6x6) {
    variable_1 : total_output_net_capacitance;
    variable_2 : input_transition_time;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(hold_template_3x5) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  lu_table_template(hold_template_3x6) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  power_lut_template(passive_energy_template_5x1) {
    variable_1 : input_transition_time;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  power_lut_template(passive_energy_template_6x1) {
    variable_1 : input_transition_time;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(recovery_template_3x6) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(recovery_template_6x6) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(removal_template_3x6) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }
  lu_table_template(setup_template_3x5) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0");
  }
  lu_table_template(setup_template_3x6) {
    variable_1 : related_pin_transition;
    variable_2 : constrained_pin_transition;
    index_1 ("1000.0, 1001.0, 1002.0");
    index_2 ("1000.0, 1001.0, 1002.0, 1003.0, 1004.0, 1005.0");
  }

EOF
;

sub mymin($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[1]:$_[0];
}

sub mymax($$)
{
  return $_[1] unless(defined($_[0]));
  return ($_[0]>$_[1])?$_[0]:$_[1];
}

foreach my $mag(<*.mag>)
{
  my $cellname=$mag; $cellname=~s/\.mag$//;
  next if(defined($ENV{'CELL'}) && $ENV{'CELL'} ne $cellname);
  next unless(-f "$cellname.cell"); # We only want generated cells, no demoboards or other stuff

  my @mins=();
  my @maxs=();

  if(open(IN,"<$mag"))
  {
    while(<IN>)
    {
      if(m/^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)/)
      { 
        my @a=split " ",$_;
        foreach(1 .. 4)
        {
          $mins[$_&1]=mymin($mins[$_&1],$a[$_]);
          $maxs[$_&1]=mymax($maxs[$_&1],$a[$_]);
        }
      }
    }
    close IN;
  }
  my @inputs=();
  my @outputs=();
  if(open(IN,"<$cellname.cell"))
  {
    #print STDERR "Reading $cellname.cell\n";
    while(<IN>)
    {
      @inputs=split " ",$1 if(m/^\.inputs (.*)/);
      @outputs=split " ",$1 if(m/^\.outputs (.*)/);
    }
    close IN;
  }
  else
  {
    print STDERR "Could not read cell $cellname.cell: $!\n";
  }
  my $area=defined($maxs[0])?($maxs[0]-$mins[0])*($maxs[1]-$mins[1]):1;

  if($mag=~m/^PAD/)
  {
     print "cell ($cellname) { area : $area;  dont_touch : true; }\n";
  }
  else
  {

    my $output= <<EOF
/* --------------- *
 * Design : $cellname *
 * --------------- */
cell ($cellname) {
area : $area;
  cell_leakage_power : 0.1173;
EOF
    ;
    if($cellname=~m/DFF/)
    {
      $output.=<<EOF
  ff (DS0000,P0000) {
    next_state : "D";
    clocked_on : "(!CLK)";
  }
EOF
    ;
    }
    foreach my $pin(@inputs)
    {
      $output.=<<EOF
  pin($pin)  {
    direction : input;
    capacitance : 0.021636;
    rise_capacitance : 0.021558;
    fall_capacitance : 0.021636;
  }
EOF
      ;
    }
    foreach my $pin(@outputs)
    {
      $output.=<<EOF
  pin($pin)  {
    direction : output;
    capacitance : 0;
    rise_capacitance : 0;
    fall_capacitance : 0;
    max_capacitance : 0.412286;
    function : "(A B)";
    timing() {
      related_pin : "A";
      timing_sense : positive_unate;
      cell_rise(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.135468, 0.140265, 0.143242, 0.13881, 0.114394", \\
          "0.183319, 0.188338, 0.192664, 0.189481, 0.166138", \\
          "0.273479, 0.278684, 0.28851, 0.283829, 0.263192", \\
          "0.633258, 0.642891, 0.649771, 0.649274, 0.635584", \\
          "1.17327, 1.18296, 1.18962, 1.18895, 1.17762");
      }
      rise_transition(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.0882, 0.0924, 0.0966, 0.099, 0.1194", \\
          "0.15, 0.153, 0.1608, 0.1644, 0.1788", \\
          "0.2802, 0.282, 0.2862, 0.2916, 0.3078", \\
          "0.816, 0.816, 0.8178, 0.8202, 0.8334", \\
          "1.6218, 1.6218, 1.6218, 1.6224, 1.6278");
      }
      cell_fall(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.167177, 0.202284, 0.265877, 0.308151, 0.430135", \\
          "0.224319, 0.259107, 0.322892, 0.36637, 0.491938", \\
          "0.335646, 0.36992, 0.433808, 0.478536, 0.607888", \\
          "0.780065, 0.81504, 0.877625, 0.920222, 1.05187", \\
          "1.44281, 1.47773, 1.54009, 1.58262, 1.71347");
      }
      fall_transition(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.0924, 0.093, 0.1026, 0.1098, 0.123", \\
          "0.1596, 0.1602, 0.1626, 0.1692, 0.1848", \\
          "0.3, 0.2994, 0.3024, 0.3054, 0.3198", \\
          "0.8784, 0.8778, 0.8778, 0.879, 0.8832", \\
          "1.7466, 1.7466, 1.7472, 1.7466, 1.7472");
      }
    }
    timing() {
      related_pin : "B";
      timing_sense : positive_unate;
      cell_rise(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.136152, 0.134149, 0.125177, 0.110593, 0.042182", \\
          "0.183231, 0.182144, 0.17419, 0.160977, 0.096749", \\
          "0.274689, 0.272369, 0.266243, 0.255334, 0.19685", \\
          "0.634485, 0.635477, 0.627876, 0.618186, 0.573561", \\
          "1.17451, 1.17509, 1.1673, 1.15736, 1.11436");
      }
      rise_transition(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.0882, 0.0924, 0.1062, 0.1128, 0.1254", \\
          "0.15, 0.1518, 0.162, 0.168, 0.1836", \\
          "0.2796, 0.2814, 0.2874, 0.2922, 0.3132", \\
          "0.8166, 0.816, 0.8166, 0.819, 0.8364", \\
          "1.6218, 1.6218, 1.6218, 1.6224, 1.6278");
      }
      cell_fall(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.184677, 0.225252, 0.305561, 0.360668, 0.524913", \\
          "0.242571, 0.284064, 0.362196, 0.417523, 0.585336", \\
          "0.35573, 0.394873, 0.473847, 0.52801, 0.697587", \\
          "0.797996, 0.837006, 0.915518, 0.968772, 1.13728", \\
          "1.46119, 1.49974, 1.57798, 1.63114, 1.79857");
      }
      fall_transition(delay_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.0948, 0.0966, 0.1014, 0.1044, 0.1242", \\
          "0.1602, 0.1602, 0.1626, 0.168, 0.1854", \\
          "0.3012, 0.3012, 0.3024, 0.3042, 0.3144", \\
          "0.8784, 0.8784, 0.8784, 0.8784, 0.8808", \\
          "1.7466, 1.7472, 1.7472, 1.7466, 1.7472");
      }
    }
    internal_power() {
      related_pin : "A";
      rise_power(energy_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.175608, 0.272801, 0.56388, 0.796823, 1.60912", \\
          "0.179968, 0.272459, 0.560982, 0.787696, 1.58173", \\
          "0.183768, 0.275337, 0.554906, 0.779866, 1.55639", \\
          "0.186245, 0.28634, 0.555533, 0.774262, 1.53242", \\
          "0.187373, 0.286781, 0.556141, 0.773763, 1.52594");
      }
      fall_power(energy_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.682097, 0.778941, 1.07036, 1.30235, 2.11129", \\
          "0.689417, 0.782563, 1.06662, 1.29547, 2.08731", \\
          "0.695489, 0.786172, 1.06565, 1.29154, 2.06909", \\
          "0.695343, 0.788895, 1.06847, 1.29133, 2.05413", \\
          "0.69663, 0.790587, 1.06979, 1.29218, 2.05161");
      }
    }
    internal_power() {
      related_pin : "B";
      rise_power(energy_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.160502, 0.275229, 0.589983, 0.855199, 1.76734", \\
          "0.167535, 0.276072, 0.579905, 0.83989, 1.73518", \\
          "0.172685, 0.276093, 0.574742, 0.828704, 1.70676", \\
          "0.177439, 0.274921, 0.574026, 0.821518, 1.67723", \\
          "0.178672, 0.274961, 0.57311, 0.818917, 1.66749");
      }
      fall_power(energy_template_5x5) {
        index_1 ("0.025, 0.05, 0.1, 0.3, 0.6");
        index_2 ("0.06, 0.18, 0.42, 0.6, 1.2");
        values ( \\
          "0.849374, 0.958819, 1.29574, 1.55392, 2.45958", \\
          "0.857665, 0.975853, 1.28725, 1.54387, 2.4309", \\
          "0.863952, 0.977353, 1.28374, 1.53701, 2.40901", \\
          "0.87666, 0.981387, 1.28499, 1.53302, 2.38627", \\
          "0.872437, 0.982928, 1.28642, 1.53364, 2.3813");
      }
    }
EOF
      ;
    }
    $output.=<<EOF
  }
}

EOF
;

    $output= <<EOF
/* --------------- *
 * Design : $cellname *
 * --------------- */
cell ($cellname) {
area : $area;
  cell_leakage_power : 0.1173;
EOF
    ;
    if($cellname=~m/DFF/)
    {
      $output.=<<EOF
  ff (DS0000,P0000) {
    next_state : "D";
    clocked_on : "(!CLK)";
  }
EOF
    ;
    }
 
    foreach my $pin(@inputs)
    {
      $output.=<<EOF
  pin($pin)  {
    direction : input;
  }
EOF
      ;
    }
    my $truthtable=`perl ../Tools/perl/truthtable.pl --format liberty $cellname.cell`;
    $output.=$truthtable;
    my %functions=();
    #foreach(split "\n",$truthtable)
    #{
    #  my @a=split"=",$_;
    #  $functions{$a[0]}=$a[1];
    #  print "$cellname: Pin $a[0] has the function $a[1].\n";
    #}

    #    foreach my $pin(@outputs)
    #{
    #      $output.=<<EOF
    #  pin(pin)  {
    #    direction : output;
    ##    function : "$functions{$pin}";
    #  }
    #EOF
    #      ;
    #}
    print $output;
    print <<EOF
}

EOF
;


  }

}

print "} /* END*/\n";

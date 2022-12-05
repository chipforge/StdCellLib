#!/usr/bin/perl -w

my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";

print STDERR "Warning: environment variable CARAVEL not defined! Please define it.\n" unless (-d $ENV{'CARAVEL'}."/cells/mag/");


print <<EOF
// SPDX-FileCopyrightText: 2022 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`ifndef __USER_DEFINES_H
// User GPIO initial configuration parameters
`define __USER_DEFINES_H

// deliberately erroneous placeholder value; user required to config GPIO's to other
`define GPIO_MODE_INVALID                  13'hXXXX

// Authoritive source of these MODE defs is: caravel/verilog/rtl/user_defines.v
// Useful GPIO mode values.  These match the names used in defs.h.
//
`define GPIO_MODE_MGMT_STD_INPUT_NOPULL    13'h0403
`define GPIO_MODE_MGMT_STD_INPUT_PULLDOWN  13'h0c01
`define GPIO_MODE_MGMT_STD_INPUT_PULLUP    13'h0801
`define GPIO_MODE_MGMT_STD_OUTPUT          13'h1809
`define GPIO_MODE_MGMT_STD_BIDIRECTIONAL   13'h1801
`define GPIO_MODE_MGMT_STD_ANALOG          13'h000b

`define GPIO_MODE_USER_STD_INPUT_NOPULL    13'h0402
`define GPIO_MODE_USER_STD_INPUT_PULLDOWN  13'h0c00
`define GPIO_MODE_USER_STD_INPUT_PULLUP    13'h0800
`define GPIO_MODE_USER_STD_OUTPUT          13'h1808
`define GPIO_MODE_USER_STD_BIDIRECTIONAL   13'h1800
`define GPIO_MODE_USER_STD_OUT_MONITORED   13'h1802
`define GPIO_MODE_USER_STD_ANALOG          13'h000a

EOF
;


our $nextla=0;
our $nextio=0;
our $conf="";
my $MPRJ_IO_PADS=38;

our %setting=();

foreach my $mag(<cells/mag/*.mag>)
{
  next if((-s $mag)<=50);
  #print `ls -la $mag`;
  my $cell=$mag; $cell=~s/\.mag$/.cell/; $cell=~s/\/mag\//\/cell\//;
  my $lib=$mag; $lib=~s/\.mag$/.lib/; $lib=~s/\/mag\//\/lib\//;

  my $name=""; $name=$1 if($mag=~m/([\w\-\.]+)\.mag$/);
  print STDERR "$mag $cell $lib\n";
  next unless(-f $cell);
  #next unless(-f $lib);
  #next unless(-f $ENV{'CARAVEL'}."/cells/mag/$name.mag");

  open CELL,"<$cell";

  while(<CELL>)
  {
    if(m/^\.inputs (.*)/)
    {
      foreach my $inp(sort split " ",$1)
      {
        my $io=$nextio++;
	if($io<$MPRJ_IO_PADS)
	{
	  $setting{$io}="GPIO_MODE_MGMT_STD_INPUT_PULLDOWN";
	}
	else
	{
	# Logic Analyzer does not need IO pins to be configured
	}
      }
    }
    if(m/^\.outputs (.*)/)
    {
      foreach my $outp(sort split " ",$1)
      {
        my $io=$nextio++;
	if($io<$MPRJ_IO_PADS)
	{
	  $setting{$io}="GPIO_MODE_MGMT_STD_OUTPUT";
	}
	else
	{
          # Logic Analyzer... 
	}
      }
    }

  }
  close CELL;
}

foreach(5 .. 37)
{
  print "`define USER_CONFIG_GPIO_$_"."_INIT `".($setting{$_}||"GPIO_MODE_MGMT_STD_INPUT_NOPULL")."\n";
}

print "`endif // __USER_DEFINES_H\n";

#!/usr/bin/perl -w

my $STDCELLLIB=$ENV{'STDCELLLIB'} || "/home/philipp/libresilicon/StdCellLib";

print <<EOF
`default_nettype none

/*
 *-------------------------------------------------------------
 *
 * user_proj_ls130tw1  (LibreSilicon Testwafer #1)
 *
 */

module user_proj_example #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,        // User area 1 3.3V supply
    inout vdda2,        // User area 2 3.3V supply
    inout vssa1,        // User area 1 analog ground
    inout vssa2,        // User area 2 analog ground
    inout vccd1,        // User area 1 1.8V supply
    inout vccd2,        // User area 2 1.8v supply
    inout vssd1,        // User area 1 digital ground
    inout vssd2,        // User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq,

);

    // IRQ
    assign irq = 3'b000;	// Unused

EOF
;


our $nextla=0;
our $nextio=0;
our $conf="";
my $MPRJ_IO_PADS=38;

foreach my $mag(<$STDCELLLIB/Catalog/*.mag>)
{
  next if((-s $mag)<=50);
  #print `ls -la $mag`;
  my $cell=$mag; $cell=~s/\.mag$/.cell/;
  my $lib=$mag; $lib=~s/\.mag$/.lib/;

  my $name=""; $name=$1 if($mag=~m/([\w\-\.]+)\.mag$/);
  next unless(-f $cell);
  next unless(-f $lib);
  next unless(-f $ENV{'CARAVEL'}."/cells/mag/$name.mag");

  open CELL,"<$cell";
  print "$name $name(\n";
  print " `ifdef USE_POWER_PINS\n";
  print "  \.VPWR(vccd1),\n"; # ??? Should we do 3.3V or 1.8V ?
  print "  \.VGND(vssd1),\n";
  print " `endif\n";


  while(<CELL>)
  {
    if(m/^\.inputs (.*)/)
    {
      foreach my $inp(sort split " ",$1)
      {
        my $io=$nextio++;
	if($io<$MPRJ_IO_PADS)
	{
          print "  \.$inp(io_in[$io]),\n";
	  $conf.="assign io_oeb[$io] = 1'b1;\n";
          $inout{"io$io"}="ioin";
	}
	else
	{
	  my $la=$io-$MPRJ_IO_PADS;
          print "  \.$inp(la_data_in[$la]),\n";
          $inout{"io$io"}="lain";
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
          print "  \.$outp(io_out[$io]),\n";
	  $conf.="assign io_oeb[$io] = 1'b0;\n";
          $inout{"io$io"}="ioout";
	}
	else
	{
	  my $la=$io-$MPRJ_IO_PADS;
          print "  \.$outp(la_data_out[$la]),\n";
          $inout{"io$io"}="laout";
	}
      }
    }

  }
  close CELL;
  print ");\n";
}
print $conf;
print "endmodule\n";
print "`default_nettype wire\n";

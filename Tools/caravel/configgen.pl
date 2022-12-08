#!/usr/bin/perl -w
use strict;


my $lefs=join(" ",map { $ENV{'PWD'}."/".$_ } <cells/lef/*.lef>);
my $gds=join(" ",map { $ENV{'PWD'}."/".$_ } <cells/gds/*.gds>);
my $libs=join(" ",map { $ENV{'PWD'}."/".$_ } <cells/lib/libres*.gds>);
my $verilog=$ENV{'PWD'}."/verilog/rtl/user_proj_cells.v";
#    "EXTRA_LIBS": ["dir::../../cells/lib/libres*.lib"],
 
print <<EOF
{
    "DESIGN_NAME": "user_proj_example",
    "DESIGN_IS_CORE": 0,
    "VERILOG_FILES": ["dir::../../verilog/rtl/defines.v", "dir::../../verilog/rtl/user_proj_example.v"],
    "EXTRA_LEFS": ["$lefs"],
    "EXTRA_GDS_FILES": ["$gds"],
    "VERILOG_FILES_BLACKBOX": ["$verilog"],
    "PLACE_SITE": "GF018hv5v_green_sc9",
    "STD_CELL_LIBRARY_OPT": "gf180mcu_fd_sc_mcu9t5v0",
    "GPL_CELL_PADDING": 0,
    "DPL_CELL_PADDING": 4,
    "SYNTH_READ_BLACKBOX_LIB": 0,
    "CLOCK_TREE_SYNTH": 0,
    "DESIGN_IS_CORE": 0,
    "CLOCK_PERIOD": 10,
    "CLOCK_PORT": "wb_clk_i",
    "CLOCK_NET": "counter.clk",
    "FP_SIZING": "absolute",
    "DIE_AREA": "0 0 400 400",
    "FP_PIN_ORDER_CFG": "dir::pin_order.cfg",
    "PL_BASIC_PLACEMENT": 0,
    "PL_TARGET_DENSITY": 0.55,
    "VDD_NETS": ["vccd1"],
    "GND_NETS": ["vssd1"],
    "DIODE_INSERTION_STRATEGY": 4,
    "RUN_CVC": 1,
    "pdk::sky130*": {
        "FP_CORE_UTIL": 45,
        "RT_MAX_LAYER": "met4",
        "scl::sky130_fd_sc_hd": {
            "CLOCK_PERIOD": 10
        },
        "scl::sky130_fd_sc_hdll": {
            "CLOCK_PERIOD": 10
        },
        "scl::sky130_fd_sc_hs": {
            "CLOCK_PERIOD": 8
        },
        "scl::sky130_fd_sc_ls": {
            "CLOCK_PERIOD": 10,
            "SYNTH_MAX_FANOUT": 5
        },
        "scl::sky130_fd_sc_ms": {
            "CLOCK_PERIOD": 10
        }
    },
    "pdk::gf180mcuC": {
        "STD_CELL_LIBRARY": "gf180mcu_fd_sc_mcu9t5v0",
        "CLOCK_PERIOD": 24.0,
        "FP_CORE_UTIL": 40,
        "RT_MAX_LAYER": "Metal4",
        "SYNTH_MAX_FANOUT": 4,
        "PL_TARGET_DENSITY": 0.45
    }
}
EOF
;

#!/usr/bin/perl -w

open IN,"<libresilicon.lib";
undef $/;
my $content=<IN>;
$content=~s/area/pg_pin (VPWR) { voltage_name : "VPWR"; pg_type : "primary_power"; } pg_pin (VGND) { voltage_name : "VGND"; pg_type : "primary_ground"; } area/g;

#$content=~s/"\s*\n/"/gs;
#$content=~s/;\s*\n/;/gs;
$content=~s/\n//gs;
$content=~s/\\//gs;



print $content;

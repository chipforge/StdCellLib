#!/usr/bin/perl -w
use strict;
print "Writing functions.html\n";
open OUT,">functions.html";
print OUT <<EOF
<html>
<head><title>Cell Functions</title>
</head>
<body>
<h1>Cell functions:</h1>
<table border='1'>
<tr><td>Cell</td><td>Function</td></tr>
EOF
;

foreach(<*.cell>)
{
  my $func1=`../Tools/perl/truthtable.pl --format=text $_`;
  my $func2=""; $func2=$1 if($func1=~m/FUNCTION: (.*)/); $func2=~s/FUNCTION:/<br\/>/;
  print OUT "<tr><td>$_</td><td>$func2</td></tr>";
}

print OUT "</table></body></html>\n";
close OUT;

print "You can now execute:\nfirefox functions.html\n";

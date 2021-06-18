#!/usr/bin/perl -w

# This tool generates a HTML build report

my $report="buildreport.html";

open OUT,">$report";
print OUT "<html><head>";
print OUT '<meta http-equiv="refresh" content="60">' if(!-f ".done");
print OUT <<EOF
<style>
body
{
	font-family: Verdana, Helvetica, sans-serif;
	font-size: 100%;
	color: black;
	background-color: #f8f8f8;
	margin: 10;
	padding: 0 0 25px 0
}

div, form
{
	margin: 0;
	padding: 0
}

p, ul, ol, table
{
	padding: 0;
	margin: 0.8em 0;
	border-collapse: collapse;
}
th
{
	text-align: left;
	font-size: 100%;
	background-color: #f0f0f0;
	padding: 3px 3px 3px 3px;
}
td
{
	padding: 3px 3px 3px 3px;
	vertical-align: middle;
}

a	  { color: #DE0019; text-decoration: underline }
a:link	  { color: #DE0019; text-decoration: underline }
a:visited { color: #DE0019; text-decoration: underline }
a:hover	  { color: black; text-decoration: underline }
a:active  { color: white; background-color: black; text-decoration: underline }
a:focus	  { color: white; background-color: black; text-decoration: underline }

		img,
a		img,
a:link		img,
a:visited 	img,
a:hover		img,
a:active	img,
a:focus		img
{ border: 0px none white; }


</style>
EOF
;
print OUT "<title>Build Report Libresilicon</title></head><body>";
print OUT "<h1>Build Report</h1>";
print OUT "Generated: ".localtime()." by <a href='https://libresilicon.com/' target='_blank'>LibreSilicon</a> <a href='https://github.com/thesourcerer8/StdCellLib' target='_blank'>Standard Cell Library Generator</a><br/>\n";

print OUT "<h2>Input files: PDK, <a href='https://download.libresilicon.com/process/v1/process_design_rules.pdf' target='_blank' title='Design Rules'>DRC</a>, <a title='layer colours, resistances, layer numbers'>layer definitions</a>, process parameters:</h2>";
print OUT "These input files are necessary to define the rules and parameters for the standard cell library. All those files are collected in the <b>Tech</b> directory.<br/>";
my %inputs=("drc.lydrc"=>"<a href='https://www.klayout.de/doc-qt5/about/drc_ref.html' target='_blank'>DRC</a> rules for <a href='https://klayout.de/' target='_blank'>KLayout</a> GDS Viewer","librecell_tech.py"=>"Cell layouting rules, DRC","libresilicon.m"=>"Transistor <a href='http://bsim.berkeley.edu/' target='_blank'>BSIM</a> model SPICE <a href='http://bsim.berkeley.edu/models/bsim3/' target='_blank'>parameters</a> (*.lib files in other tools)","libresilicon.tech"=>"<a href='http://opencircuitdesign.com/magic/' target='_blank'>Magic</a> Layers and <a href='http://opencircuitdesign.com/magic/techref/maint2.html' target='_blank'>Parasitic extraction parameters</a>","nmos.sp"=>"Transistor size template for SPICE models","pmos.sp"=>"Transistor size template for SPICE models","template.lef"=>"Template for the header of <a href='https://en.wikipedia.org/wiki/Library_Exchange_Format' target='_blank'>Library Exchange Format</a> LEF Files");
print OUT "<table border='1'><tr><th>Filename</th><th>Description</th></tr>";
foreach(sort keys %inputs)
{
	#  print OUT "<tr><td><a href='../Tech/$_' target='_blank'>$_</a></td><td>$inputs{$_}</td></tr>";
  print OUT "<tr><td>".(-f "../Tech/$_"? "<a href='../Tech/$_' target='_blank'><font color='green'>&radic;</font>$_</a>":"<font color='red'>X</font>")."</td><td>$inputs{$_}</td></tr>";

}
print OUT "</table>";

print OUT "<h2>Standard Cells:</h2>\n";
print OUT "These are the generated standard cells. ";
print OUT "You can click on the green ticks and the error messages to get more details or download the files. By moving the mouse over the header line you will get explanations for each column.<br/>\n";

print OUT "<table border='1'>";
print OUT "<tr><th>Cell</th><th title='Cell description'>cell</th><th title='Magic (*.mag) file with the physical layout was generated'>Magic</th><th title='SVG Image file of the physical layout was generated'>Layout</th><th title='Schematic file of the circuit in PNG format'>Schematic</th><th title='Logfile of the generation was generated'>Log</th><th title='Error file with error messages from the cell generation was created'>Err</th><th title='DRC Check by MAGIC'>DRC</th><th title='The characterization has generated a .lib file in liberty file format'>Liberty</th><th title='A Library-Exchange-Format (LEF) file was generated'>LEF</th><th title='a GDS-II file with the mask was generated'>GDS</th><th title='A simple SPICE netlist of the circuit without parasitic extraction'>SPICE</th><th title='A SPICE netlist with parasitic extraction included was generated'>Parasitic</th><th title='The 2D area/size of the cell in square lambdas'>Area</th><th title='The result of the Layout-Vs.-Schematic check of the cell layouting step'>LVS</th><th title='The number of deduplicated euler tours'>Euler</th><th title='Runtime of the cell layouting step'>LayoutTime</th><th title='number of generated nets during layouting step'>Nets</th><th title='Number of Ports of the cell'>Ports</th><th title='Routing iterations in the layouting step'>Iterat.</th><th title='Error messages generated by layouting or characterization'>Errors</th></tr>";
foreach my $file (<*.cell>)
{
  my $errfile=$file; $errfile=~s/\.cell$/.err/;
  my $logfile=$file; $logfile=~s/\.cell$/.log/;
  my $magfile=$file; $magfile=~s/\.cell$/.mag/;
  my $drcfile=$file; $drcfile=~s/\.cell$/.drc/;
  my $libfile=$file; $libfile=~s/\.cell$/.lib/;
  my $svgfile=$file; $svgfile=~s/\.cell$/.svg/;
  my $schfile="doc/".$file; $schfile=~s/\.cell$/_svg.png/;
  my $pngfile=$file; $pngfile=~s/\.cell$/.png/;
  my $leffile="outputlib/".$file; $leffile=~s/\.cell$/.lef/;
  my $gdsfile="outputlib/".$file; $gdsfile=~s/\.cell$/.gds/;
  my $spfile=$file; $spfile=~s/\.cell$/.sp/;
  my $spicefile=$file; $spicefile=~s/\.cell$/.spice/;
  my $runfile=$file; $runfile=~s/\.cell$/.running/;
  my $dontlayoutfile=$file; $dontlayoutfile=~s/\.cell$/.dontlayout/;

  my $area="";
  my $lvs="";
  my $euler="";
  my $layouttime="";
  my $nets="";
  my $errors="";
  my $routing="";
  my $ports=0;
  my $b1=(-f $runfile)?"<b>":"";
  my $b2=(-f $runfile)?"<b>":"";
  my $drccount=0;

  if(open DRC,"<$drcfile")
  {
    while(<DRC>)
    {
      $drccount=$1 if(m/Number of DRC errors: (\d+)/);
    }
  } 

  print OUT "<tr><td>$b1$file$b2</td>";
  print OUT "<td>".(-f $file ? "<a href='$file' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $magfile ? "<a href='$magfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $svgfile ? "<a href='$svgfile' target='_blank'><font color='green'>&radic;</font><img src='$svgfile' height='30'/></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $schfile ? "<a href='$schfile' target='_blank'><font color='green'>&radic;</font><img src='$schfile' height='30'/></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $logfile ? "<a href='$logfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $errfile ? "<a href='$errfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $drcfile ? "<a href='$drcfile' target='_blank'><font color='green'>&radic;</font> $drccount</a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $libfile ? "<a href='$libfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $leffile ? "<a href='$leffile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $gdsfile ? "<a href='$gdsfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $spfile?"<a href='$spfile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";
  print OUT "<td>".(-f $spicefile?"<a href='$spicefile' target='_blank'><font color='green'>&radic;</font></a>":"<font color='red'>X</font>")."</td>";

  if(open LIB,"<$libfile")
  {
    while(<LIB>)
    {
      $area=$1 if m/area:\s*(\d+)\.?\d*\s*/;
    }
    close LIB;
  }
  if(open LIB,"<$errfile")
  {
    while(<LIB>)
    {
      $lvs=$1 if(m/LVS result: (\w+)/ && $lvs eq "");
      $euler=$1 if m/Number of deduplicated eulertours: (\d+)/;
      $layouttime=$1 if(m/INFO:\s*Done\s*\(Total duration: ([\d:.]+)\s*\)/);
      $nets=$1 if(m/Nets output: (\d+)/);
      $routing=$1 if(m/Routing iteration (\d+)/);
      $ports=scalar(split(",",$1)) if(m/Subcircuit ports: (.*)/);
      $errors.=$1." " if(m/AssertionError: (.*)/);
      $errors.=$1." " if(m/Exception: (.*)/);
      $errors.=$1." " if(m/ERROR: (.*)/);
      $errors.=$1." " if(m/(Segmentation fault \(core dumped\))/);
      $errors=~s/LVS check failed!//;
    }
    close LIB;
  }
  $layouttime=~s/\.\d+$//;
  $lvs=~s/FAILED/<font color='red'>FAILED<\/font>/;

  $errors.=" <b>This cell is currently building...</b>" if(-f $runfile);
  $errors.=" This cell has been excluded from building " if(-f $dontlayoutfile);

  print OUT "<td align='right'>$area</td><td>$lvs</td><td>$euler</td><td>$layouttime</td><td>$nets</td><td>$ports</td><td>$routing</td><td><a href='$errfile' target='_blank'><font color='red'>$errors</font></a></td>";

  print OUT "</tr>";


}
print OUT "</table><br/>";


print OUT "<h2>Output files (needed by RTL2GDS tools like <a href='http://opencircuitdesign.com/qflow/' target='_blank'>qflow</a>, <a href='https://theopenroadproject.org/' target='_blank'>OpenROAD</a>, Cadence, Synopsys, ...):</h2>";
print OUT "These are the resulting output files, you can download and use them with other EDA tools to build your chips:<br/>\n";
my %outputs=("libresilicon.sp"=>"<a href='https://en.wikipedia.org/wiki/SPICE' target='_blank'>SPICE</a> netlist with all cells","libresilicon.lib"=>"<a href='https://people.eecs.berkeley.edu/~alanmi/publications/other/liberty07_03.pdf' target='_blank'>LIBERTY</a> File with Characterization of all cells, can be viewed with <a href='https://codeberg.org/tok/librecell/src/branch/master/librecell-lib' target='_blank'>libertyviz</a>","libresilicon.lef"=>"<a href='https://en.wikipedia.org/wiki/Library_Exchange_Format' target='_blank'>Library Exchange Format</a> (LEF) File with all cells","library.gds"=>"<a href='https://en.wikipedia.org/wiki/GDSII' target='_blank'>GDS-II</a> file with masks for all cells, can be viewed with <a href='https://www.klayout.de/' target='_blank'>KLayout</a>","../Documents/StdCellLib.pdf"=>"PDF Documentation of the Standard cell library","demoboard.mag"=>"Demoboard: <a href='demoboard.svg' target='_blank'>".(-s "demoboard.svg"?"<img src='demoboard.svg' width='200' border='0'/>":"")."</a> with all cells");
print OUT "<table border='1'><tr><th>Filename</th><th>Description</th></tr>";
foreach(sort keys %outputs)
{
  print OUT "<tr><td>".(-f $_? "<a href='$_' target='_blank'><font color='green'>&radic;</font> $_</a>":"<font color='red'>X</font>$_")."</td><td>$outputs{$_}</td></tr>";
}
print OUT "</table>";

print OUT "If you want to build your own standard cell library, you can try our <a href='https://pdk.libresilicon.com/'>Online Standard Cell Library Generator</a> or download the <a href='https://github.com/thesourcerer8/StdCellLib/'>generator software</a> and run it yourself.<br/>\n";

print OUT "</body></html>";
print "firefox $report\n";
close OUT;


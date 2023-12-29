print STDERR "DRC Expander - expands the DRC rules in MAGIC tech files and annotates the layers that might cause the DRC issues\n";

# Original tech file:
my $tech=$ARGV[0] || "/usr/local/lib/magic/sys/sky130A.tech";
my $expand=0;
my $debug=0;
my $createrules=0; # Create code for rules instead of expanding the tech file

print STDERR "Processing the original tech file: $tech\n";

#our %contacts=();
our %alias=();

# Required DRC rules for SKY130: area,cifmaxwidth,edge4way,exact_overlap,extend,overhang,rect_only,spacing,surround,width
my $rules=<<EOF
surround types1 types2 distance presence error 
widespacing types1 wwidth types2 distance flavor error 
spacing types1 types2 distance adjacency error 
width type-list width error 
overhang types1 types2 distance error
extend types1 types2 distance error  
rect_only types error
angles types allowed why 
edge types1 types2 d OKTypes cornerTypes cornerDist error [plane] 
edge4way types1 types2 d OKTypes cornerTypes cornerDist error [plane] 
exact_overlap type-list
no_overlap type-list1 type-list2
off_grid types pitch why 
area types minarea minedge why
maxwidth layers mwidth [bends] why 
cifwidth layer width why
cifspacing layer1 layer2 separation adjacency why 
cifarea layer minarea minedge why 
cifmaxwidth layer mwidth [bends] why
EOF
;

print STDERR "Extracting optional arguments:\n";
my @erules=();
foreach my $line(split "\n",$rules)
{
  if($line=~m/\[/)
  {
    my $a=$line; $a=~s/\[\w+\]//;
    my $b=$line; $b=~s/\[//; $b=~s/\]//;
    #print "A: $a\nB: $b\n";
    push @erules,$a;
    push @erules,$b;
  }
  else
  {
    #print "R: $line\n";	  
    push @erules,$line;
  }
}

print STDERR "Handling rules:\n";
foreach my $rule (@erules)
{
  print STDERR "  # Rule: $rule\n";	
  my @a=split " ",$rule;
  my $kind=shift @a;
  #print "Kind:$kind\n";
  my $regexp="^\\s*($kind)";
  my @types=("zero","other");
  my @typelists=();
  foreach(@a)
  {
    $regexp.="\\s+";
    if($_=~m/^(types|type-list|layer|OKTypes)/)
    {
      $regexp.="(\\S+)";
      push @types,"type-list";
    }
    elsif($_=~m/^(why|error)/)
    {
      $regexp.="\"([^\"]*)\"";
      push @types,"why";
    }
    else
    {
      $regexp.="(\\S+)";
      push @types,"other";
    }
  }

  next unless($createrules);
  
  $regexp.="\\s*\$";
  print "  if(m/$regexp/)\n  {\n";
  print '    print " # ORIGINAL RULE:$oneline\n";'."\n";
  foreach(2 .. scalar(@types)-1)
  {
    print "    my \$vl$_=\$$_;\n" if($types[$_] eq "type-list");
    print "    my \$l$_=join \" \",allLayers(\$vl$_);\n" if($types[$_] eq "type-list");
    #    print "    print STDERR \"L$_: \$vl$_ -> \$l$_\n\" if(\$debug);\n" if($types[$_] eq "type-list");
    print "    my \$text=\$$_;\n" if($types[$_] eq "why"); 
    push @typelists,$_ if($types[$_] eq "type-list");
  }
  print "    print \"  ";
  foreach(1 .. scalar(@types)-1)
  {
    print "\$$_ " if($types[$_] eq "other");
    print "\$vl$_ " if($types[$_] eq "type-list");
    if($types[$_] eq "why")
    {
      print "\\\"\$$_ ";
      #print "[erase ".join(",",@typelists)."]";
      foreach my $tl (@typelists)
      {
        print "[erase \$l$tl]";
      }
      print "\\\"";
    }
  }
  print "\\n\";\n";
  print "  }\n";
  print "\n"; 
  # $1 $vl1 $vl2 $4 $5 \"$6 [erase $l1]".(($vl1 eq $vl2)?"":"[erase $l2]")."\"\n"; 


}

exit if($createrules);

#magic:  tech layers allli
# At first we are reading through the original tech file to search for all the virtual layers that need to be expanded
open IN,"<$tech";
undef $/;
my $content=<IN>;
$/="\n";
$content=~s/\\\n//sg;

foreach(split("\n",$content))
{
  s/\\//g;
  if(m/^\s*(spacing|surround)\s+(\S+)\s+(\S+)\s+/)
  {
    my $a2=$2;
    my $a3=$3;
    $alias{$a2}=1;
    $alias{$a3}=1;
    foreach(split(",",$a2))
    {
      $alias{$_}=1;
      $alias{$1}=1 if(m/^([^\/]+)/);
    }
    foreach(split(",",$a3))
    {
      $alias{$_}=1;
      $alias{$1}=1 if(m/^([^\/]+)/);
    }
  }
  # Rule: width type-list width error
  if(m/^\s*(width)\s+(\S+)\s+(\S+)\s+"([^"]*)"\s*$/)
  {
    $alias{$2}=1;
    foreach(split(",",$2))
    {
      $alias{$_}=1;
    }
  }
}
close IN;


if($debug)
{
  print STDERR "BEFORE:\n";
  foreach(sort keys %alias)
  {
    print STDERR "$_ -> $alias{$_}\n";
  }
}

# No we are asking magic what those virtual layers actually mean
    print STDERR "Running magic -T $tech ...\n";
    if(open OUT,"|magic -dnull -noconsole -T $tech >magic.layers.out")
    {
      print OUT "puts \"CUT HERE -------- CUT HERE\"\n";
      foreach(sort keys %alias)
      {
	s/\(// unless(m/\)/);
	s/\)// unless(m/\(/);
	#print STDERR "[tech layers $_]\n";
        print OUT "puts \"EXPANDING: $_\"\n";
        print OUT "puts [tech layers $_]\n";
      }
      print OUT "puts \"CUT HERE -------- CUT HERE\"\n";
      print OUT "quit -noprompt\n";
      close OUT;

      # Now we are retrieving the answer from Magic:
      if(open IN,"<magic.layers.out")
      {
        while(<IN>)
        {
          if(m/^EXPANDING: (\S+)/)
          {
            my $next=<IN>;
            chomp $next;
            $alias{$1}=$next;
           }
         }
         close IN;
       }
       else
       {
         die "Could not get the results from magic!\n";
       }
    }
    else
    {
      die "Could not run magic!\n";
    }
    print STDERR "Done with magic.\n";


if($debug)
{
  print STDERR "\n\nAFTER:\n";
  foreach(sort keys %alias)
  {
    print STDERR "$_ -> $alias{$_}\n";
  }
  exit;
}

open IN,"<$tech";

# This function expands a single layer-list into all the physical layers it means
sub allLayers($)
{
	#if($_[0] !~ m/\//) # If we do not look for "images" (which are signalled by / in the typelist and are currently not supported by magic), then we can just use the whole typelist which is more efficient.
	#{
	#return split " ",$alias{$_[0]} ;
        #}

  my @a=split ",",$_[0];
  my %b=();
  foreach(@a)
  {
    print STDERR "piece: $_\n" if($debug);
    if(m/(\/\S+)/ && defined($alias{$_}) && $alias{$_})
    {    
      print STDERR "WE FOUND A SLASH AND AN ALIAS\n" if($debug);
      my $image=$1;
      foreach my $part(split " ",$alias{$_})
      {
        print STDERR "PART: $part\n" if($debug);
        $b{$part.(($part =~ m/\//)?"":$image)}=1;
      }
    }
    elsif(m/^([^\/]+)(\/\S+)/) # This is a workaround for bugs in magic that hopefully get fixed
    {
      print STDERR "WE FOUND A SLASH BUT NO ALIAS\n" if($debug);
      my $image=$2;
      my $short=$1;
      foreach my $part(split " ",$alias{$short})
      {
        print STDERR "PART: $part\n" if($debug);
        $b{$part.$image}=1;
      }
    }
    else
    {
      print STDERR "NO SLASH OR ALIAS\n" if($debug);
      foreach my $part(split " ",$alias{$_})
      {
        $b{$part}=1;
      }
    }
  }
  return sort keys %b;
}

my $section="";
our %drckind=();
# Finally we are processing the whole tech file and annotating the rules:
while(<IN>)
{
  while($_=~m/\\$/)
  {
    $_.=<IN>;
  }
  if(m/^(\w+)/)
  {
    $section=$1;
  }
  #  if($section eq "contact" && m/^\s+(\w+)/)
  #{
  #  my $a=$_;
  #  $a=~s/^\s+//; $a=~s/\s+$//;
  #  my @a=split(/\s+/,$a);
  #  my $cont=shift(@a);
  #  foreach my $cnt(@a)
  #  {
  #    print STDERR "CONTACT: $cont -> $cnt\n";
  #    $contacts{$cont}{$cnt}=1;
  #    $contacts{$cnt}{$cont}=1;
  #  }
  #}
  #if($section eq "aliases" && m/^\s+(\w+)/)
  #{
  #  my $a=$_;
  #  $a=~s/^\s+//; $a=~s/\s+$//;
  #  my @a=split(/\s+/,$a);
  #  my $cont=shift(@a);
  #  foreach my $cnt(@a)
  #  {
  #    print STDERR "ALIAS: $cont -> $cnt\n";
  #    $alias{$cont}=$cnt;
  #  }
  #}
  my $oneline=$_;	  
  $oneline=~s/\n//sg;
  tr/\\//;
  if($section eq "drc")
  {
    if(m/^\s*(\w+)/)
    {
      $drckind{$1}=1;
    }
  }
 

  if(m/^\s*(spacing|surround)\s+(\S+)\s+(\S+)\s+(\d+)\s+\\?\s*(\w+)\s+\\?\s*"([^"]+)"/)
  {
    #print " # ORIGINAL RULE:$oneline\n";
    my $vl1=$2;
    my $vl2=$3;
    my $text=$6;
    my $l1=join " ",allLayers($vl1);
    print STDERR "L1: $vl1 -> $l1\n" if($debug);
    my $l2=join " ",allLayers($vl2);
    print STDERR "L2: $vl2 -> $l2\n" if($debug);

    if($expand)
    {
        foreach my $layer1(allLayers($vl1))
        {
          foreach my $layer2(allLayers($vl2))
          {
	    #print "  $1 $layer1 $layer2 $4 $5 \"$6 [erase $layer1]".(($layer1 eq $layer2)?"":"[erase $layer2]")."\"\n"; 
          }
        }
    }
    else
    {
      print "  $1 $vl1 $vl2 $4 $5 \"$6 [erase $l1".(($vl1 eq $vl2)?"":",$l2")."]\"\n"; 
    }
    #print "\n";
  }
  # Rule: width type-list width error
  elsif(m/^\s*(width)\s+(\S+)\s+(\S+)\s+"([^"]*)"\s*$/)
  {
    print " # ORIGINAL RULE:$oneline\n";
    my $vl2=$2;
    print STDERR "ALLLAYERS $vl2\n" if($debug);
    my $l2=join ",",allLayers($vl2); # For painting we need a different strategy to try each layer individually
    print STDERR "INFO: vl2=$vl2 l2=$l2\n" if($debug);
    my $text=$4;
    print "  $1 $vl2 $3 \"$4 [paint $l2]\"\n";
  }


  else
  {
    print $_;
  }
}
close IN;

print STDERR "".join(",", sort keys %drckind)."\n";

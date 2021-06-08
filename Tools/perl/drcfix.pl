#!/usr/bin/perl -w

if(scalar(@ARGV)<1)
{ 
  print "Usage: drcfix.pl report.drc\n";
  exit;	
}

# Rules we have to deal with:

#Local interconnect spacing < 0.17um (LI 3)
#Metal1 spacing < 0.14um (Met1 2)

print "Handling $ARGV[0]\n";
open IN,"<".$ARGV[0];
my $mag=$ARGV[0];$mag=~s/\.drc$/.mag/; $mag=~s/\.mag\.mag/\.mag/;
my $mode=0;

sub form($)
{
  return int($_[0]*100);
}

my $insert="";

our $tech=$ARGV[1] || "../Tech/libresilicon.tech";

#sub tryfix($)
#{
  print "Trying the fix on $mag:\nRuning magic ...\n";
  open OUT,"|magic -dnull -noconsole -T $tech $mag";

print OUT <<EOF
proc redirect_variable {varname cmd} {
    rename puts ::tcl::orig::puts
    global __puts_redirect
    set __puts_redirect {}
    proc puts args {
        global __puts_redirect
        set __puts_redirect [concat \$__puts_redirect [lindex \$args end]]
        set args [lreplace \$args end end]
        if {[lsearch -regexp \$args {^-nonewline}]<0} {
            set __puts_redirect "\$__puts_redirect\\n"
        }
        return
    }
    uplevel \$cmd
    upvar \$varname destination
    set destination \$__puts_redirect
    unset __puts_redirect
    rename puts {}
    rename ::tcl::orig::puts puts
}

proc fix_drc {} {
   drc on
   drc check
   drc catchup
   redirect_variable drccount {puts [drc count total]}
   set nFixed 0
   set drcc [string trim [string map {"Total DRC errors found: " ""} \$drccount] ]
   set nRounds \$drcc
   puts \$drccount
   #puts \$drcc
   for {set i 0} {\$i < \$nRounds} {incr i} {
     puts "I inside first loop: \$i"
     if {\$drcc > 0} {
       redirect_variable drcresult {puts [drc find]}
       puts \$drcresult
       if {[string first "\\[erase" \$drcresult] != -1} {
         regexp {\\[erase ([^\\]]+)\\]} \$drcresult full layernames
         foreach drcparts [split \$layernames ","] {
           foreach layername [split \$drcparts " "] {
             puts "Erasing \$layername"
             set res [erase \$layername]
	     puts \$res
	   }
           drc check
           drc catchup
           redirect_variable drccountnew {puts [drc count total]}
           set drccn [string trim [string map {"Total DRC errors found: " ""} \$drccountnew] ]
           if {\$drccn < \$drcc} {
             puts "Hoory, we fixed a DRC issue"
             incr nFixed 
             set drcc \$drccn
	     #save corr_$mag
	     #exit
           } else {
             puts "Trying to fix this DRC issue did not reduce the number of DRC issues (\$drccn vs. \$drcc) so we undo and try something else"
             foreach layername [split \$drcparts " "] {
               puts "Undoing \$layername"
	       #erase \$layername
               undo
             }
           }
	 }
       }
     }
   }

   if {\$nFixed >0} {
      puts "We have fixed some issues, now we save the file"
      save corr_$mag
      puts "File saved."
   }	   
}   
puts "Trying to FIX some DRC issues"
fix_drc
puts "Done trying to FIX some DRC issues"
quit -noprompt
EOF
;
close OUT;

#}

#tryfix();

if(0)
{

while(<IN>)
{
  if(m/Mcon spacing < 0\.17um \(Mcon 2\)/)
  {
    $mode="viali";
    my $dummy=<IN>;
    print "Found my rule\n";
    next;
  }
  if(m/Diffusion contact spacing < 0.17um \(LIcon 2\)/)
  {
    $mode="ndiffc";
    my $dummy=<IN>;
    print "Found my rule\n";
    next;
  }
  if(m/Local interconnect spacing < 0.17um \(LI 3\)/)
  {
    $mode="li_spacing";
    my $dummy=<IN>;
    print "Found my rule\n";
    next;
  }

  if(m/\-\-\-\-\-\-\-\-\-\-\-/)
  {
    $mode=0;
    print "End of rule\n";
    next;
  }


  if($mode eq 1)
  {
    my @line1=split " ",$_;
    my $l2=<IN>;
    my @line2=split " ",$l2;
    print "LINE1 (@line1): $_\nLINE2 (@line2): $l2\n";
    if($line1[0] eq $line2[0] && $line1[2] eq $line2[2] && $line1[1]<$line2[1])
    {
      print "Vertikal\n";
      print "@line1 - @line2\n";
      $insert.="<< $mode >>\nrect ".form($line1[0])." ".form($line1[3])." ".form($line1[2])." ".form($line2[1])."\n";
    }
    elsif($line1[1] eq $line2[1] && $line1[3] eq $line2[3] && $line1[0]<$line2[0])
    {
      print "Horizontal\n";
      print "@line1 - @line2\n";
      $insert.="<< $mode >>\nrect ".form($line1[2])." ".form($line1[1])." ".form($line2[3])." ".form($line1[1])."\n";
    }

  }


  if($mode eq "li_spacing")
  {
    my @line1=split " ",$_;
    my $l2=<IN>;
    my @line2=split " ",$l2;
    print "LINE1 (@line1): $_\nLINE2 (@line2): $l2\n";
    #if($line1[0] eq $line2[0] && $line1[2] eq $line2[2] && $line1[1]<$line2[1])
    #{
    #  print "Vertikal\n";
    #  print "@line1 - @line2\n";
      tryfix("box position $line1[0] $line1[1]\nbox size $line2[0] $line2[1]\nerase li\n");
    #  $insert.="<< $mode >>\nrect ".form($line1[0])." ".form($line1[3])." ".form($line1[2])." ".form($line2[1])."\n";
    #}
    #elsif($line1[1] eq $line2[1] && $line1[3] eq $line2[3] && $line1[0]<$line2[0])
    #{
    #  print "Horizontal\n";
    #  print "@line1 - @line2\n";
    #  $insert.="<< $mode >>\nrect ".form($line1[2])." ".form($line1[1])." ".form($line2[3])." ".form($line1[1])."\n";
    #}

  }


}
close IN;

open MAG,"<$mag";
open CORR,">corr.$mag";
print "Reading from $mag Writing to corr.$mag\n";
while(<MAG>)
{
  if(m/<< end >>/)
  {	
    print CORR $insert;
  }
  print CORR $_;
}
close CORR;
close MAG;

}

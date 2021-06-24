#!/usr/bin/perl -w

if(scalar(@ARGV)<1)
{ 
  print "Usage: drcfix.pl problematic.mag [techfile.tech]\n";
  exit;	
}

# Rules we have to deal with:

#Local interconnect spacing < 0.17um (LI 3)
#Metal1 spacing < 0.14um (Met1 2)

print "Handling $ARGV[0]\n";
open IN,"<".$ARGV[0];
my $mag=$ARGV[0];$mag=~s/\.drc$/.mag/; $mag=~s/\.mag\.mag/\.mag/;
my $output="corr_$mag";
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

proc getCheckpoint {} {
   #save checkpoint
   #return
   redirect_variable undostack {undo print 10}
   #puts "Undostack: \$undostack"
   #head=0xd620c840	tail=0xd5b648a0	cur=0xd5b648a0
   regexp {cur=(0x\\w+)} \$undostack full cur
   #puts "cur: \$cur"
   undo print 20
   return \$cur
}

proc undoToCheckpoint {checkpoint} {
   #load checkpoint
   #return
   redirect_variable undostack {undo print 10}
   regexp {cur=(0x\\w+)} \$undostack full cur
   regexp {head=(0x\\w+)} \$undostack full head
   #undo print 20
   if {\$head ne 0x0} {
     if {\$checkpoint == 0x0} {
       set checkpoint \$head
     }
     set tries 0
     while {\$cur ne \$checkpoint && \$cur ne 0x0 && \$tries < 200 } {
       #puts "Undo ..."
       undo
       #undo print 20
       redirect_variable undostack {undo print 10}
       regexp {cur=(0x\\w+)} \$undostack full cur
       incr tries
     }
     if {\$tries > 180} {
       puts "WARNING: \$tries tries were tried, this is strange"
       #undo print 20
     }
   }
}

#getCheckpoint

proc fix_drc {} {
   drc on
   drc check
   drc catchup
   drc listall catchup
   redirect_variable drccount {drc count total}
   set checkpoint [getCheckpoint]
   puts "Checkpoint: \$checkpoint"
   set nFixed 0
   set drcc [string trim [string map {"Total DRC errors found: " ""} \$drccount] ]
   if {\$drcc == 0} return
   set yReposition {0 2 -2}

   foreach yRepo \$yReposition {
   puts "Trying Reposition \$yRepo"
   set nRounds \$drcc
   puts \$drccount
   #puts \$drcc
   for {set i 0} {\$i <= \$nRounds + 10 } {incr i} {
     puts "I inside first loop: \$i"
     if {\$drcc > 0} {
       redirect_variable drcresult {drc find}
       puts "move up \$yRepo"
       move up \$yRepo
       puts \$drcresult
       if {[string first "\\[" \$drcresult] != -1} {
         regexp {\\[(erase|paint) ([^\\]]+)\\]} \$drcresult full drccommand layernames
         if {\$yRepo != 0 } { 
           puts "This is an addition for Sky130: We have some 20nm wide inter-net spacings that we need to paint on locali, so we reposition the box and try to paint on locali"
           set drccommand "paint" 
	   set layernames "locali"
         }
	 if {\$drccommand == "erase" } {
	   redirect_variable bbox {box}
	   #lambda:       44 x 10      (     0,  309  ), (    44,  319  )  440 
	   regexp {lambda:\\s*\\d+ x \\d+\\s+\\([^\\)]*\\), \\(\\s*(\\d+),\\s*(\\d+)} \$bbox full boxX boxY
           puts "Bounding box for erase: \$boxX \$boxY"
           if {\$boxY >= 309 } { 
             puts "This is an addition for Sky130: We do not want to erase the power rails, so we skip ignore rules outside the core of the cell"
	     set layernames "" 
	   }
	 }
         foreach drcparts [split \$layernames ","] {
           foreach layername [split \$drcparts " "] {
             puts "\$drccommand \$layername"
	     \$drccommand \$layername
	   }
           drc check
           drc catchup
           redirect_variable drccountnew {drc count total}
           set drccn [string trim [string map {"Total DRC errors found: " ""} \$drccountnew] ]
	   if {\$drccn == 0} {
             puts "We have fixed all issues, no need to try more"
             save $output
             puts "File $output saved."
             quit -noprompt
	   }
           if {\$drccn < \$drcc} {
             puts "Hoory, we fixed a DRC issue"
             incr nFixed 
             set drcc \$drccn
             set checkpoint [getCheckpoint]
             puts "New Checkpoint: \$checkpoint"
	     #save $output
	     #exit
           } else {
             puts "Trying to fix this DRC issue did not reduce the number of DRC issues (\$drccn vs. \$drcc) so we undo and try something else"
	     undoToCheckpoint \$checkpoint
	     #foreach layername [split \$drcparts " "] {
	     #  puts "Undoing \$layername"
	     #  #erase \$layername
	     #  undo
	     #}
           }
	 }
       }
      }
     }
   }

   if {\$nFixed >0} {
      puts "We have fixed some issues, \$drccn issues are remaining, we give up and save the file now."
      save $output
      puts "File $output saved."
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

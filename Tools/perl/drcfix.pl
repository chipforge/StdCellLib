#!/usr/bin/perl -w

if(scalar(@ARGV)<1)
{ 
  print "Usage: drcfix.pl report.drc\n";
  exit;	
}


print "Handling $ARGV[0]\n";
open IN,"<".$ARGV[0];
my $mag=$ARGV[0];$mag=~s/\.drc$/.mag/; $mag=~s/\.mag\.mag/\.mag/;
my $mode=0;

sub form($)
{
  return int($_[0]*100);
}

my $insert="";


sub tryfix($)
{
  print "Trying the fix on $mag:\n$_[0]\nRuning magic ...\n";
print <<EOF
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
   set drcc [string map {"Total DRC errors found: " ""} \$drccount]
   puts \$drccount
   puts \$drcc
   if {\$drcc > 0} {
     redirect_variable drcresult {puts [drc find]}
     puts \$drcresult
     if {[string first "Local interconnect spacing" \$drcresult] != -1} {
        erase li
	drc check
	drc catchup
        redirect_variable drccountnew {puts [drc count total]}
        set drccn [string map {"Total DRC errors found: " ""} \$drccountnew]
        if {\$drccn < \$drcc} {
          puts "Hoory, we fixed a DRC issue"
	} else {
          puts "Trying to fix this DRC issue caused more issues so we undo and try something else"
          undo
	}
     }
     
   }
}   


% puts \$mydrc
EOF
;

}

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
print "Reading from $mag Writing to $mag\n";
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


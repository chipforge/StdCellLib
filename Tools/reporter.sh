#!/bin/bash
echo This script generates a build report every 10 seconds, so that you can monitor the progress of the standard cell generation.
rm -f .done
perl ../Tools/perl/buildreport.pl 
firefox buildreport.html &
while [ ! -f .done ] ;
do
	perl ../Tools/perl/buildreport.pl 
	sleep 10
done


#!/bin/bash
echo This script generates a build report every 10 seconds, so that you can monitor the progress of the standarc cell generation.
while true
do
perl ../Tools/perl/buildreport.pl 
sleep 10
done


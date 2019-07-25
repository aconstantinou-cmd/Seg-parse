#!/bin/bash

if [[ $# -eq 0 ]] ; then
	echo "This script parses grepable nmap input and formats it ready for a segmentation report"
    echo ""
    echo "example: ./nmap-parser.sh nmap.gnmap"

    exit 0
fi

cat $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " "\n"  "TCP ports:" $3 "\n" s}' > $1.new
sleep 2
cat $1.new |sed s/\(\)// > results.txt
sleep 1
sed -i '/filtered/d' results.txt
sed -i '/closed/d' results.txt
sleep 1
rm *.new
sed  -i 's/\/.*/,/g' results.txt
sed -i ':begin;$!N;s/\(^.*,\)\n/\1/;tbegin;P;D' results.txt
sleep 1
sed -Ei 's/(([0-9]{1,3}\.){3}[0-9]{1,3})/\n\n\1/' results.txt

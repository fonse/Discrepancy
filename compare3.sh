#!/bin/bash

orders=`seq 13`
seqs="champer1 champer2 champer3 bruijn25 bruijn50 ford"
title=all

dir=`dirname $0`
#for seq in $seqs
#do
#	for i in $orders
#	do
#		echo -n "$i "
#		$dir/bin/extract_peak.py "$dir/data/3/$seq-$i.raw" 3 $i > "$dir/data/3/$seq-$i-peaks.dat"
#	done
#	echo ""
#done

mkdir "$dir/graphs/3/compare-$title" &>/dev/null

for i in $orders
do
	echo -n "$i "
	gnuplot 2>/dev/null <<- EOF
		set terminal png

		set grid
		set logscale y
		set format x ""

	    set output "$dir/graphs/3/compare-$title/compare-$title-$i.png"
		plot '$dir/data/3/champer1-$i-peaks.dat' title 'Champwenowne 1' with lines, \
	         '$dir/data/3/champer2-$i-peaks.dat' title 'Champwenowne 2' with lines, \
	         '$dir/data/3/champer3-$i-peaks.dat' title 'Champwenowne 3' with lines, \
	         '$dir/data/3/ford-$i-peaks.dat' title 'Ford' with lines, \
	         '$dir/data/3/bruijn25-$i-peaks.dat' title 'Bruijn 25%' with lines, \
	         '$dir/data/3/bruijn50-$i-peaks.dat' title 'Bruijn 50%' with lines
	EOF
done
echo  ""


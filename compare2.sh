#!/bin/bash

orders=`seq 20`
seqs="champer ford em"
title=all

dir=`dirname $0`
#for seq in $seqs
#do
#	for i in $orders
#	do
#		echo -n "$i "
#		$dir/bin/extract_peak.py "$dir/data/2/$seq-$i.raw" 2 $i > "$dir/data/2/$seq-$i-peaks.dat"
#	done
#	echo ""
#done

mkdir "$dir/graphs/2/compare-$title" &>/dev/null

for i in $orders
do
	echo -n "$i "
	gnuplot 2>/dev/null <<- EOF
		set terminal png

		set grid
		set logscale y
		set format x ""

		set output "$dir/graphs/2/compare-$title/compare-$title-$i.png"
		plot '$dir/data/2/champer-$i-peaks.dat' title 'Champwenowne' with lines, \
	         '$dir/data/2/ford-$i-peaks.dat' title 'Ford' with lines, \
	         '$dir/data/2/em-$i-peaks.dat' title 'Ehrenfeucht Mycielski' with lines

	EOF
done
echo  ""


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
		set logscale x
		set xtics ("2" 2, "2²" 4, "2³" 8, "2⁴" 16, "2⁵" 32, "2⁶" 64, "2⁷" 128, "2⁸" 256, "2⁹" 512, "2¹⁰" 1024, "2¹¹" 2048, \
		           "2¹²" 4096, "2¹³" 8192, "2¹⁴" 16384, "2¹⁵" 32768, "2¹⁶" 65536, "2¹⁷" 131072, "2¹⁸" 262144, "2¹⁹" 524288)

		set output "$dir/graphs/2/compare-$title/compare-$title-$i.png"
		plot '$dir/data/2/champer-$i-peaks.dat' title 'Champwenowne' with lines, \
	         '$dir/data/2/ford-$i-peaks.dat' title 'Ford' with lines, \
	         '$dir/data/2/em-$i-peaks.dat' title 'Ehrenfeucht Mycielski' with lines

	EOF
done
echo  ""


#!/bin/bash

orders=`seq 20`
seqs="champer ford em"

orders=`seq 13`
seqs="champer1 champer2 champer3 bruijn25 bruijn50 ford"

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

for i in $orders
do
	echo -n "$i "
	gnuplot 2>/dev/null <<- EOF
		set terminal png

		set grid
		set logscale x
#		set xtics ("2" 2, "2²" 4, "2³" 8, "2⁴" 16, "2⁵" 32, "2⁶" 64, "2⁷" 128, "2⁸" 256, "2⁹" 512, "2¹⁰" 1024, "2¹¹" 2048, \
#		           "2¹²" 4096, "2¹³" 8192, "2¹⁴" 16384, "2¹⁵" 32768, "2¹⁶" 65536, "2¹⁷" 131072, "2¹⁸" 262144, "2¹⁹" 524288)
#
#		set output "$dir/graphs/2/compare-all-$i.png"
#		plot '$dir/data/2/champer-$i-peaks.dat' title 'Champwenowne' with lines, \
#	         '$dir/data/2/ford-$i-peaks.dat' title 'Ford' with lines, \
#	         '$dir/data/2/em-$i-peaks.dat' title 'Ehrenfeucht Mycielski' with lines
	         
	         
	    set xtics ("3" 3, "3²" 9, "3³" 27, "3⁴" 81, "3⁵" 243, "3⁶" 729, "3⁷" 2187, "3⁸" 6561, "3⁹" 19683, "3¹⁰" 59049, "3¹¹" 177147, "3¹²" 531441)
	    set output "$dir/graphs/3/compare-all-$i.png"
		plot '$dir/data/3/champer1-$i-peaks.dat' title 'Champwenowne 1' with lines, \
	         '$dir/data/3/champer2-$i-peaks.dat' title 'Champwenowne 2' with lines, \
	         '$dir/data/3/champer3-$i-peaks.dat' title 'Champwenowne 3' with lines, \
	         '$dir/data/3/ford-$i-peaks.dat' title 'Ford' with lines, \
	         '$dir/data/3/bruijn25-$i-peaks.dat' title 'Bruijn 25%' with lines, \
	         '$dir/data/3/bruijn50-$i-peaks.dat' title 'Bruijn 50%' with lines
	EOF
	echo  ""
done

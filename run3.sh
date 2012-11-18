#!/bin/bash

orders=`seq 13`
seqs="champer1 champer2 champer3 bruijn25 bruijn50 ford"
generate=true

generate=

T="$(date +%s)"
dir=`dirname $0`
if [ ! -e $dir/data/3 ]; then mkdir -p $dir/data/3; fi
if [ ! -e $dir/graphs/3 ]; then mkdir -p $dir/graphs/3; fi

if [ ! -e $dir/bin/extford3 ]; then g++ $dir/lib/extford3.cpp -o $dir/bin/extford3; fi
if [ ! -e $dir/bin/ocurrencias ]; then  g++ $dir/lib/ocurrencias.cpp -o $dir/bin/ocurrencias; fi

if [ $generate ]
then
	echo "Generating sequences..."
	$dir/bin/champer3.py 1000000 0 > $dir/data/3/champer1.txt
	$dir/bin/champer3.py 1000000 1 > $dir/data/3/champer2.txt
	$dir/bin/champer3.py 1000000 2 > $dir/data/3/champer3.txt
	$dir/bin/extford3 1000000 25 > $dir/data/3/bruijn25.txt
	$dir/bin/extford3 1000000 50 > $dir/data/3/bruijn50.txt
	$dir/bin/extford3 1000000 > $dir/data/3/ford.txt
fi

for seq in $seqs
do
	if [ ! -e "$dir/graphs/3/$seq" ]; then mkdir "$dir/graphs/3/$seq"; fi
	if [ ! -e "$dir/graphs/3/$seq-witness" ]; then mkdir "$dir/graphs/3/$seq-witness"; fi

	echo -n "Processing $seq..."	
	for i in $orders
	do
		echo -n " $i"
		if [ $generate ]
		then
			$dir/bin/ocurrencias 3 "$dir/data/3/$seq.txt" 1000000 $i > "$dir/data/3/$seq-$i.raw"
		fi
		
		gnuplot 2>/dev/null <<- EOF
			set terminal png

			set grid
			set logscale x
			set xtics ("3" 3, "3²" 9, "3³" 27, "3⁴" 81, "3⁵" 243, "3⁶" 729, "3⁷" 2187, "3⁸" 6561, "3⁹" 19683, "3¹⁰" 59049, "3¹¹" 177147, "3¹²" 531441)

			set output "$dir/graphs/3/$seq/$seq-$i.png"
			plot '$dir/data/3/$seq-$i.raw' using 1:(\$2/\$1 - 1.0/$((3 ** $i))) title 'Discrepancia por defecto' with lines, \
		     '$dir/data/3/$seq-$i.raw' using 1:(\$3/\$1 - 1.0/$((3 ** $i))) title 'Discrepancia por exceso' with lines

			set yrange [0:$((3**i - 1))]
			set ytics ("" $((3**i - 1))/3.0, "" 2*$((3**i - 1))/3.0)

			set output "$dir/graphs/3/$seq-witness/$seq-witness-$i.png"
			plot '$dir/data/3/$seq-$i.raw' using 1:4 title 'Testigo por defecto' with points, \
			     '$dir/data/3/$seq-$i.raw' using 1:5 title 'Testigo por exceso' with points
		EOF
	done
	echo ""
done


T="$(($(date +%s)-T))"
printf "\nTime taken: %02dm %02ds\n" "$((T/60%60))" "$((T%60))"
echo "Total disk usage: `du -ch $dir/data/3/ | awk '/total$/ { print $1 }'`"

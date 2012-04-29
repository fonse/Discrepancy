#! /usr/bin/env python
import sys
    
try:
    f = open(sys.argv[1], 'r')
    a = int(sys.argv[2])
    k = int(sys.argv[3])
except:
    print "No se pudo leer el archivo"
    exit(1)

currmax = 0
currmax_i = 0
for line in f:
    i, mi, ma, _, _ = line.split("\t")
    i, mi, ma = int(i), float(mi), float(ma)
    discrepancy = max( (a ** -k) - mi/i , ma/i - (a ** -k))

    if discrepancy > currmax:
        currmax = discrepancy
        currmax_i = i

    if i % 1000 == 0:
        print currmax_i, currmax
        currmax = 0

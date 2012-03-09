#! /usr/bin/env python
import sys
import random
  
def baseconvert(n, base):
    digits = "0123456789abcdefghijklmnopqrstuvwxyz"

    s = ""
    while 1:
        r = n % base
        s = digits[r] + s
        n = n / base
        if n == 0:
            break

    return s


random.seed(836857)
def func1(parts, order):
    random.shuffle(parts)
    return parts
 
def func2(parts, order):
    powers = ["2" * i for i in range(order,0,-1)]
    return sorted(parts, key=lambda x: map(lambda i: x.count(i), powers) + [x])


funcs = [lambda x,y : x, func1, func2]
    
try:
    n = int(sys.argv[1])
except:
    print "Falta indicar la longitud deseada"
    exit(1)

try:
    func = funcs[int(sys.argv[2])]
except:
    func = funcs[0]

    

l = 0
order = 1
s = ""
while len(s) < n:
    parts = [baseconvert(i, 3).zfill(order) for i in xrange(0, 3 ** order)]
    parts = func(parts, order)
    
    for part in parts:
    	s += part
    	
    order += 1

print s

#! /usr/bin/env python
import sys
  
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


try:
    n = int(sys.argv[1])
except:
    print "Falta indicar la longitud deseada"
    exit(1)
    
i = 0
s = ""
while len(s) < n:
    s += baseconvert(i, 2)
    i += 1;
    
print s

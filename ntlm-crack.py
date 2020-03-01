#!/usr/bin/env python3
import sys
import hashlib
import binascii
if(len(sys.argv)!=3):
    print(sys.argv[0]+" [hash] [wordlist]")
    exit(0)
lines=[]
with open(sys.argv[2]) as file:
    lines=[line.rstrip('\n') for line in file]
for passwd in lines:
    h=binascii.hexlify(hashlib.new('md4',passwd.encode('utf-16le')).digest())
    if h.decode("utf-8")==sys.argv[1]:
        print(passwd)

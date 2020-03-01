CC=g++
crypt-crack: crypt-crack.cc
	$(CC) -Wall -Wextra -std=c++17 -O3 -flto -lcrypt -o crypt-crack crypt-crack.cc

clean:
	rm -rf crypt-crack

AS=as
CC=gcc
BIN=spawn_shell
ARCH=$(shell uname -m)

$(BIN): crt0.o main.o
	$(CC) -static -nostdlib -e _start -o $(BIN) crt0.o main.o

crt0.o: crt0.s
	$(AS) -o crt0.o crt0.s

main.o: main.c
	$(CC) -c -o main.o main.c

clean:
	rm -f crt0.o main.o $(BIN)

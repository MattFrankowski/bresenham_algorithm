CC=gcc
ASMBIN=nasm

all : asm cc link
asm : 
	$(ASMBIN) -o bresen.o -f elf -g -l bresen.lst bresen.asm
cc :
	$(CC) -m32 -c -fpack-struct -g -O0 main.c
link :
	$(CC) -m32 -g -fpack-struct -o bresenham main.o bresen.o
gdb :
	gdb bresenhamm

clean :
	rm *.o
	rm *.lst
debug : all gdb

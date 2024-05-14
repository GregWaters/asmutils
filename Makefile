all: clear

clear:
	@nasm -f elf64 clear.asm
	@ld -O1 clear.o -o bin/clear
	@rm clear.o

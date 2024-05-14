BITS := $(shell getconf LONG_BIT)

define MAKE_EXECUTABLE
	nasm -f elf$(BITS) src/$@.asm -o obj/$@.o -I src/utility/ -D BITS=$(BITS)
	ld -O1 obj/$@.o -o bin/$@
endef

all: clear true false

clear:
	$(MAKE_EXECUTABLE)

true:
	$(MAKE_EXECUTABLE)

false:
	$(MAKE_EXECUTABLE)

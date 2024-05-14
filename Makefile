BITS := $(shell getconf LONG_BIT) # determine whether or not the system is 32 or 64 bit
$(shell mkdir -p bin/ obj/) # make the directories we need when make is run, if they do not already exist

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

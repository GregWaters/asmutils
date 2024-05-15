BITS := $(shell getconf LONG_BIT) # determine whether or not the system is 32 or 64 bit
FILES := $(patsubst src/%.asm,%,$(wildcard src/*.asm)) # get all source files without their extensions or path

# Ansi escape codes for different colors
TXT_BLUE := '\e[1;34m'
TXT_GREEN := '\e[0;32m'
TXT_WHITE := '\e[1;37m'

$(shell mkdir -p bin/ obj/) # make the directories we need when make is run, if they do not already exist

define ASSEMBLE
	@nasm -f elf$(BITS) src/$@.asm -o obj/$@.o -I src/utility/ -D BITS=$(BITS)
	@ld -O1 obj/$@.o -o bin/$@
	@strip -s bin/$@
	@echo -e \'$(TXT_BLUE)$@$(TXT_WHITE)\' assembled and linked.
endef

.PHONY: clean all

all: $(FILES)
	@echo -en $(TXT_GREEN)
	@echo All files assembled successfully!

$(FILES):
	$(ASSEMBLE)
	
clean:
	@rm -r bin/ obj/
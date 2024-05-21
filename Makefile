BITS := $(shell getconf LONG_BIT)
FILES := $(patsubst src/%.asm,%,$(wildcard src/*.asm))
$(shell mkdir -p bin/ obj/)

define ASSEMBLE
	@nasm -f elf$(BITS) src/$@.asm -o obj/$@.o -I src/utility/ -D BITS=$(BITS)
	@ld -O1 obj/$@.o -o bin/$@
	@strip -s bin/$@
	@echo -e \''\e[1;34m'$@'\e[1;37m'\' assembled and linked.
endef

.PHONY: clean all

all: $(FILES)
	@echo -e '\e[0;32m'All files assembled successfully!

$(FILES):
	$(ASSEMBLE)
	
clean:
	@rm -r bin/ obj/
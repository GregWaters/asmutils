FILES := $(patsubst src/%.asm,%,$(wildcard src/*.asm))
$(shell mkdir -p bin/ obj/)
$(shell export MAKEFLAGS="-j$(grep -c ^processor /proc/cpuinfo)")

define ASSEMBLE
	@nasm -f elf64 src/$@.asm -o obj/$@.o -I src/utility/
	@ld -O1 obj/$@.o -o bin/$@
	@strip -s bin/$@
	@echo -e '\e[1;34m$@\e[1;37m' assembled and linked.
endef

.PHONY: clean all

all: $(FILES)
	@echo -e '\e[0;32mAll files assembled successfully!\e[0m'

$(FILES):
	$(ASSEMBLE)
	
clean:
	@rm -r bin/ obj/

# Linux utilities in x86 Assembly

Small, fast executables for daily command-line tasks. Be aware that they may lack additional functionality aside from their main use case! (For example, the `clear` command cannot clear text on another terminal using the `-T` flag)
This functionality will later be added, but this is very much a work in progress!

# Build all binaries

All you need to build the project is run `make` in the project directory. From there, all object files will reside in `obj/`, and all executables will reside in `bin/`.
To build an individual binary, simply run `make` with the name of the command to build. Ex: `make clear`, `make true`, etc.

You can freely modify the makefile's instructions. For example, replacing `ld` with `llvm-ld` in the 'ASSEMBLE' macro.

# Linux utilities in 64-bit x86 Assembly

Small, fast executables for daily command-line tasks. Be aware that they may lack additional functionality aside from their main use case! (For example, the `clear` command cannot clear text on another terminal using the `-T` flag)
This functionality will later be added, but this is very much a work in progress!

**Warning**: The code makes **direct** calls to the kernel and the code may not work under a non-Linux kernel.

# Build all binaries

All you need to build the project is run `make` in the project directory. From there, all object files will reside in `./obj/`, and all executables will reside in `./bin/`.
To build an individual binary, simply run `make` with the name of the command to build, though I'm not sure why you'd use this as I compile/assemble these programs on a 4-core 1.9GiB ram machine and every single program is assembled in ~42ms.

You can freely modify the makefile's instructions. For example, replacing `ld` with `llvm-ld` in the 'ASSEMBLE' macro.

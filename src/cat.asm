; cat - concatenate files and print on the standard output

%include "macros.asm"

section .data
filename: db "test.txt"

section .text
global _start

_start:

%if BITS == 32
    mov eax, 5 ; open file (x86)
%else
    mov rax, 2 ; open file (x86-64)
%endif

    mov arg0, filename
    xor arg1, arg1 ; open file in 'read only' mode
    mov arg2, 0q400 ; read as owner (octal constant) this may be incorrect!
    syscall

    ; TODO - hopefully I can find a way to use the pipe syscall to put the file's bytes directly into stdout

    exit 0

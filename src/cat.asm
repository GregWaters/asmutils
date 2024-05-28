;==============================================================================
; cat - concatenate files and print on the standard output
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

%assign BUFFER_SIZE 0x4000 ; 16KiB buffer

section .text
global _start


_start:
    mov callreg, _OPEN
    mov arg0, filename
    xor arg1, arg1 ; open file in 'read only' mode
    mov arg2, 0q444 ; octal constant
    syscall

    smov callreg, _EXIT
    xor arg0, arg0
    syscall


section .data
filename: db "test.txt"
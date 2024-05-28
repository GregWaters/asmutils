;==============================================================================
; cat - concatenate files and print on the standard output
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start

_start:
    smov eax, _OPEN
    mov arg0, filename
    xor arg1, arg1 ; open file in 'read only' mode
    mov arg2, 0q444 ; octal constant
    syscall

%if BITS == 32
    mov edi, eax ; store file descriptor in edi
    mov eax, _SENDFILE
    mov arg1, 1 ; stdout

%else
    ; 64 bit code

%endif

    smov eax, _EXIT
    xor arg0, arg0
    syscall


section .data
filename: db "test.txt"

;==============================================================================
; cat - concatenate files and print on the standard output
; /!\ Work in progress /!\ Later fix sendfile call!
;==============================================================================

section .text
global _start

_start:
    mov rax, 2
    mov rdi, filename
    mov rdx, 0q755 ; standard permissions -- may be incorrect
    syscall ; open(filename)

    mov rdi, rax
    mov rax, 5
    mov rsi, statbuf
    syscall

    mov rax, 40
    mov rdi, 1
    mov rsi, r15 ; relic from a distant past
    mov rdx, 0 ; interpreted as nullptr
    mov r10, [statbuf + 48] ; statbuf.st_size
    syscall

    mov rax, 60
    dec rdi
    syscall

section .bss
    statbuf resb 144 ; reserve 144 bytes for the 64-bit stat structure

section .data
filename: db "example.s", 0

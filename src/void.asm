;==============================================================================
; void - is there anybody out there?
;==============================================================================

section .text
global _start

_start:
    pop rcx ; argc
    pop rbx ; argv

    cmp ecx, 2
    jl help

loop_begin:

    



help:
    mov rax, 1
    mov rdi, rax
    mov rsi, help_text
    mov rdx, 73
    syscall ; write(stdout, help_text, 73)

    mov rax, 60
    syscall ; exit(1)


section .data
help_text:
    db `Usage: void [FILENAMES]\nFiles erased with this utility are unrecoverable\n`

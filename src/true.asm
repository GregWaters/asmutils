;==============================================================================
; true - do nothing, successfully
;==============================================================================

section .text
global _start


_start:
    mov rax, 60
    xor rdi, rdi
    syscall ; exit(0)

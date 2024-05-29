;==============================================================================
; true - do nothing, successfully
;==============================================================================

section .text
global _start


_start:
    mov rax, 60 ; exit()
    xor rdi, rdi
    syscall

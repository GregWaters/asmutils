;==============================================================================
; false - do nothing, unsuccessfully
;==============================================================================

section .text
global _start


_start:
    mov rax, 60
    mov rdi, 1
    syscall ; exit(1)

;==============================================================================
; false - do nothing, unsuccessfully
;==============================================================================

section .text
global _start


_start:
    mov al, 60 ; exit()
    inc edi
    syscall

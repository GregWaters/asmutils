;==============================================================================
; false - do nothing, unsuccessfully
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start


_start:
    mov eax, _EXIT
    mov arg0, 1
    syscall

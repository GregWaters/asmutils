;==============================================================================
; false - do nothing, unsuccessfully
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start


_start:
    smov callreg, _EXIT
    mov arg0, 1
    syscall

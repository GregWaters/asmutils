;==============================================================================
; true - do nothing, successfully
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start


_start:
    smov callreg, _EXIT
    xor arg0, arg0
    syscall

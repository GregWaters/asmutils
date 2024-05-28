;==============================================================================
; syscalls.inc - bit-independent utility macros for system calls
;==============================================================================

; Great guide to system call numbers and conventions: https://syscall.sh


;==============================================================================
; Syscall numbers
;==============================================================================
%if BITS == 32
    %iassign _EXIT 1
    %iassign _FORK 2
    %iassign _READ 3
    %iassign _WRITE 4
    %iassign _OPEN 5
    %iassign _CLOSE 6
%else
    %iassign _READ 0
    %iassign _WRITE 1
    %iassign _OPEN 2
    %iassign _CLOSE 3
    %iassign _EXIT 60
%endif


;==============================================================================
; Syscall registers
;==============================================================================
%if BITS == 32
    %define callreg eax
    %define arg0 ebx
    %define arg1 ecx
    %define arg2 edx
    %define arg3 esi
    %define arg4 edi
    %define arg5 ebp
%else
    %define callreg rax
    %define arg0 rdi
    %define arg1 rsi
    %define arg2 rdx
    %define arg3 r10
    %define arg4 r8
    %define arg5 r9
%endif

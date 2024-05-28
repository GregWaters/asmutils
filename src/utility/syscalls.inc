;==============================================================================
; syscalls.inc - bit-independent utility macros for system calls
;==============================================================================


;==============================================================================
; Syscall numbers (added when needed as a dependency)
;==============================================================================
%if BITS == 32
    %assign _EXIT 1
    %assign _FORK 2
    %assign _READ 3
    %assign _WRITE 4
    %assign _OPEN 5
    %assign _CLOSE 6
    %assign _STAT 106
    %assign _FSTAT 108
    %assign _SENDFILE 187
%else    
    %assign _READ 0
    %assign _WRITE 1
    %assign _OPEN 2
    %assign _CLOSE 3
    %assign _STAT 4
    %assign _FSTAT 5
    %assign _SENDFILE 40
    %assign _FORK 57
    %assign _EXIT 60
%endif


;==============================================================================
; Syscall registers
;==============================================================================
%if BITS == 32
    %define arg0 ebx
    %define arg1 ecx
    %define arg2 edx
    %define arg3 esi
    %define arg4 edi
    %define arg5 ebp
%else
    %define arg0 rdi
    %define arg1 rsi
    %define arg2 rdx
    %define arg3 r10
    %define arg4 r8
    %define arg5 r9
%endif

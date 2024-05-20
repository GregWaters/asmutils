%if BITS == 32

; the syscall number is also stored in the return register
%define syscall_reg eax
%define arg0 ebx
%define arg1 ecx
%define arg2 edx
%define arg3 esi
%define arg4 edi
%define arg5 ebp

%define argv esi

%elif BITS == 64

%define syscall_reg rax
%define arg0 rdi
%define arg1 rsi
%define arg2 rdx
%define arg3 r10
%define arg4 r8
%define arg5 r9

%define argv rsi ; arg values - string representation of cmdline arguments

%endif

%define argc edi ; arg count - number of cmdline arguments (including the executable name)

%macro exit $1

%if BITS == 32
    mov syscall_reg, 1 ; x86 exit call number
%else
    mov syscall_reg, 60 ; x86-64 exit call number
%endif

%if $1 == 0 ; optimize instruction if returning zero
	xor arg0, arg0
%else
    mov arg0, $1
%endif
	syscall


%endmacro
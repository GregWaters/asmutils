;==============================================================================
; cat - concatenate files and print on the standard output
;
; This file contains optimizations specific to system bits.
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start

_start:

%if BITS == 32
    ; x86
    mov eax, _OPEN
    mov ebx, filename
    xor ecx, ecx ; open file in 'read only' mode (0)
    mov edx, 0q755
    syscall

    mov edi, eax ; store file descriptor in edi
    mov eax, _FSTAT
    mov ebx, edi ; file descriptor
    mov ecx, statbuf
    syscall

    mov eax, _SENDFILE
    mov ebx, 1 ; output fd
    mov ecx, edi ; input fd
    mov edx, offset
    lea esi, [statbuf + 44] ; get file size from statbuf (bytes we're sending to stdout)
    syscall

%else
    ; x86-64
    mov rax, _OPEN
    mov rdi, filename
    xor rsi, rsi
    mov rdx, 0q755
    syscall

    mov r15, rax ; store file descriptor in r15d, just in case it's clobbered
    mov rax, _FSTAT
    mov rdi, r15
    mov rsi, statbuf
    syscall

    mov rax, _SENDFILE
    mov rdi, 1
    mov rsi, r15
    mov rdx, offset
    mov r10, [statbuf + 48] ; get file size from statbuf (bytes we're sending to stdout)
    syscall

%endif

    mov eax, _EXIT
    xor arg0, arg0
    syscall

%if BITS == 32
section .bss
    statbuf resb 88 ; reserve 88 bytes for the 32-bit stat structure
%else
section .bss
    statbuf resb 144 ; reserve 144 bytes for the 64-bit stat structure
%endif

section .data
filename: db "test.txt", 0
offset: dq 0

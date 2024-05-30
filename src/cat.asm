;==============================================================================
; cat - concatenate files and print on the standard output
;
; TODO - Work with stack operations and move past 'testing'
; with a static filename variable
;==============================================================================

section .text
global _start

_start:
    ; basically being a prick and lying so the program works
    mov eax, 72
    inc edi
    mov esi, 4
    syscall ; fcntl(1, 4, O_RDONLY)

    pop rcx ; get argc (TODO)

.loop_begin: ; TODO
    ; get file descriptor
    mov al, 2
    mov edi, filename
    xor esi, esi
    syscall ; open(filename)

    ; get file size
    mov edi, eax
    mov eax, 5
    mov esi, statbuf
    syscall ; fstat(fd, &statbuf)

    ; use sendfile to output the entire file
    mov al, 40
    mov esi, edi
    mov edi, 1
    xor edx, edx ; interpreted as nullptr
    mov r10, [statbuf + 48] ; statbuf.st_size
    syscall ; sendfile(fd, stdout, NULL, statbuf.st_size)

    mov eax, 60 ; must use eax here, as bits beyond 16 may be overwritten
    dec edi
    syscall ; exit(0)

section .bss
    statbuf resb 144 ; reserve 144 bytes for the 64-bit stat structure

section .data
filename: db "example.asm", 0

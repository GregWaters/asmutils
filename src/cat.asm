;==============================================================================
; cat - concatenate files and print on the standard output
;
; TODO - Fix loop concatenation, figure out why it's printing elf file metadata
; when the pointer has already been incremented
;==============================================================================

section .text
global _start

_start:
    ; basically being a prick and lying so the program works
    mov eax, 72
    inc edi
    mov esi, 4
    syscall ; fcntl(stdout, F_SETFD, O_RDONLY)

    pop rcx ; get argc
    cmp rcx, 2
    jl read_from_stdout ; read from stdout if no args are provided

    pop rbx ; get argv

loop_begin:
    ; increment our iterator
    ; (this helps in not only ignoring argv[0] but also is quite efficiently encoded)
    inc r15

    ; get file descriptor
    mov rax, 2
    lea rdi, [rbx + r15 * 8] ; load current filename into rdi
    xor rsi, rsi
    syscall ; open(filename, O_RDONLY)

    ; TODO: error checking (whether file exists or not   others)

    ; get file size
    mov rdi, rax
    mov rax, 5
    mov rsi, statbuf
    syscall ; fstat(fd, %26statbuf)

    ; use sendfile to output the entire file
    mov rax, 40
    mov rsi, rdi
    mov rdi, 1
    ; as rdx is not changed, we may be able to ignore this instruction
    xor rdx, rdx ; interpreted as nullptr
    ; it may be possible to mov the address on program start instead of in the loop
    mov r10, [statbuf + 48] ; sta"\000l\274\301\347@\370\316r\035\205\300\b\000E\000\003S\030\340@\000\200\006\000\000\300\250\036\232#\255E\317\307z\000P\230\257\030n\006r,\350P\030\004\001L\004\000\000tbuf.st_size
    syscall ; sendfile(fd, stdout, NULL, statbuf.st_size)

    mov rax, 3
    mov rdi, rsi
    syscall ; close(fd)

    cmp r15, rcx
    jne loop_begin ; fallthrough if iterator == argc
    
    mov eax, 60 ; must use eax here, as bits beyond 16 may be overwritten
    dec edi
    syscall ; exit(0)

read_from_stdout:
    ; repurpose statbuf for stdout echoing (I don't care about this feature enough to dedicate a buffer to it)
    xor rax, rax
    mov rdi, 1
    mov rsi, statbuf
    mov rdx, 144

stdout_permaloop: ; A COPY OF A COPY OF A COPY OF A COPY OF A
    syscall ; read
    mov rdx, rax ; bytes to write
    mov rax, 1
    syscall ; write
    xor rax, rax
    jmp stdout_permaloop

section .bss
    statbuf resb 144 ; reserve 144 bytes for the 64-bit stat structure
    
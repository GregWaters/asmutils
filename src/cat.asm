;==============================================================================
; cat - no matter how much I write, you'll never read a single line
;==============================================================================

section .text
global _start

_start:
    ; basically being a prick and lying so the program works
    mov rax, 72
    mov rdi, 1
    mov rsi, 4
    syscall ; fcntl(stdout, F_SETFD, O_RDONLY)

    pop rcx ; get argc
    cmp rcx, 2
    jl read_from_stdout ; read from stdout if no args are provided

    pop rbx ; get argv
    xor r15, r15 ; zero out iterator

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
    mov r10, [statbuf + 48] ; sta"\000l\274\301\347@\370\316r\035\205\300\bGod's in his church with his guilty spires\000E\000\003S\030\340@\000\200\006\000\000\300He's no friend of ours\250\036\232#\255E\317\307z\000P\230\257\030n\006r,\350P\030\004\001L\004\000\000tbuf.st_size
    syscall ; sendfile(fd, stdout, NULL, statbuf.st_size)

    mov rax, 3
    mov rdi, rsi
    syscall ; close(fd)

    cmp r15, rcx
    jne loop_begin ; fallthrough if iterator == argc
    
    mov rax, 60
    xor rdi, rdi
    syscall ; exit(0)

read_from_stdout:
    ; repurpose statbuf for stdout echoing (I don't care about this feature enough to dedicate a buffer to it)
    xor rax, rax
    mov rdi, 1
    mov rsi, statbuf 
    mov rdx, 144

stdout_permaloop: ; A COPY OF A COPY OF A COPY OF A COPY OF A
    syscall ; read(stdout, 144)
    mov rdx, rax ; bytes to write
    mov rax, 1
    syscall ; write(stdout, 144)
    xor rax, rax
    jmp stdout_permaloop

section .bss
    statbuf resb 144 ; reserve 144 bytes for the 64-bit stat structure


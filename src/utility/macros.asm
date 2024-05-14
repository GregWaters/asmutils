%macro exit $1

%if BITS == 32
	mov eax, 1 ; exit syscall number (x86)

%if $1 == 0 ; optimize instruction if returning zero
	xor edi, edi

%else    
    mov edi, $1

%endif
	syscall

%elif BITS == 64
    mov rax, 60 ; exit syscall number (x86-64)

%if $1 == 0 ; optimize instruction if returning zero
    xor rdi, rdi

%else
    mov rdi, $1

%endif
    syscall

%endif

%endmacro
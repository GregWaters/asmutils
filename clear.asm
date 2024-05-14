section .data
	clear: db `\ec`

section .text
global _start

	_start:

%if __?BITS?__ == 32
	; clear the active terminal screen
	mov eax, 4     ; 'write' syscall number (x86)
	mov edi, 1     ; stdout
	mov ecx, clear ; 'clear' escape sequence
	mov edx, 2     ; length of string
	syscall
	
	; exit(0)
	mov eax, 1
	xor edi, edi
	syscall

%elif __?BITS?__ == 64

	mov rax, 1     ; 'write' syscall number (x64)
	mov rdi, 1     ; stdout
	mov rsi, clear ; 'clear' escape sequence
	mov rdx, 2     ; length of string
	syscall

	; exit(0)
	mov rax, 60
	xor rdi, rdi
	syscall

%else
	; If the user is compiling on a fossil, just throw an error
	%error "16-bit (?) format not supported"
%endif

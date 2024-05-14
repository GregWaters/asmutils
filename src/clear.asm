%include "macros.asm"

section .data
	clear: db `\ec`

section .text
global _start

	_start:

%if BITS == 32
	; clear the active terminal screen
	mov eax, 4     ; 'write' syscall number (x86)
	mov edi, 1     ; stdout
	mov ecx, clear ; 'clear' escape sequence
	mov edx, 2     ; length of string
	
%elif BITS == 64

	mov rax, 1     ; 'write' syscall number (x64)
	mov rdi, 1     ; stdout
	mov rsi, clear ; 'clear' escape sequence
	mov rdx, 2     ; length of string

%endif

	syscall ; call 'write' with the given parameters
	exit 0 ; exit the program

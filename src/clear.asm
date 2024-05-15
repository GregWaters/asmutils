; clear - clear the terminal screen

%include "macros.asm"

section .data
	clear: db `\ec`

section .text
global _start

	_start:

%if BITS == 32
	mov eax, 4     ; 'write' syscall number (x86)
%elif BITS == 64
	mov rax, 1     ; 'write' syscall number (x64)
%endif

	mov arg0, 1     ; stdout
	mov arg1, clear ; 'clear' escape sequence
	mov arg2, 2     ; length of string
	
	syscall ; call 'write' with the given parameters
	exit 0 ; exit the program

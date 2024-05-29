;==============================================================================
; clear - clear the terminal screen
;==============================================================================

%include "macros.inc"
%include "syscalls.inc"

section .text
global _start


_start:
	mov eax, _WRITE
	mov arg0, 1     ; stdout
	mov arg1, clear ; 'clear' escape sequence
	mov arg2, 2     ; length of string
	syscall
	
	mov eax, _EXIT
	dec arg0
	syscall


section .data
	clear: db `\ec`
	
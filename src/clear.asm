;==============================================================================
; clear - clear the terminal screen
;==============================================================================

section .text
global _start


_start:
	mov rax, 1
	mov rdi, rax
	mov rsi, clear
	mov rdx, 10
	syscall ; write(stdout, "\e[H\e[J\e[3J", 11)

	mov al, 60 ; we can assume that the higher bits have been zeroed out
	dec rdi ; rdi is always one at this position, so we can zero it out with this instruction
	syscall ; exit(0)


section .data
	clear: db `\e[H\e[J\e[3J`

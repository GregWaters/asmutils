;==============================================================================
; clear - you win, but can't say that out loud
;==============================================================================

section .text
global _start


_start:
	mov rax, 1
	mov rdi, rax
	mov rsi, clear
	mov rdx, 10
	syscall ; write(stdout, "\e[H\e[J\e[3J", 10)

	mov al, 60
	dec rdi
	syscall ; exit(0)


section .data
	clear: db `\e[H\e[J\e[3J`

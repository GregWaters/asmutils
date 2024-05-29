;==============================================================================
; clear - clear the terminal screen
;
; I seriously doubt that it can get any more efficient than this,
; given the obvious simplicity of the program.
; For those well-versed in x86 assembly, you may be wondering
; why I choose to use the registers I do.
; 
; Some instructions can be more simply encoded than others,
; for example a single-byte immediate `mov` like `mov dl, 11` below.
; It's a free improvement, as it does not change the output at all.
;==============================================================================

section .text
global _start


_start:
	inc al
	inc edi
	mov rsi, clear
	mov dl, 11
	syscall ; write(stdout, "\e[H\e[2J\e[3J", 11)

	mov al, 60
	dec edi
	syscall ; exit(0)


section .data
	clear: db `\e[H\e[2J\e[3J`
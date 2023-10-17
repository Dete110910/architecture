section .data

section .text
global _start

_start: 
	mov rax, 5
	mov al, 7
	mov ah, 12
	mov ah, al
	mov r15b, r8b

	mov rax, 60
	mov rdi, 0
	syscall

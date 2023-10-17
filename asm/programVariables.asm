section .data
message: db 'Hello, Computer Architect!', 10

section .bss	; new variables section
number resb 1	; first the number and the directive resb -> reserved byte and the number of bytes reserved

section .text
global _start

_start:

	mov rax, 7
	mov rbx, 5
	mov [number], rax
	add rbx, [number]

	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 28
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

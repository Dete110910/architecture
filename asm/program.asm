section .data 			;constants section
message: db 'Hello, Computer Architect!', 10 ;first constant. 10 is a line fit

section .text
global _start			;when the program starsts, run the _start label

_start: 

        mov rax, 5
	mov rax, 1		; system call number should be stored in rax (screen)
	mov rdi, 1		; argument #1 in rdi: where to write (file descriptor)?
	mov rsi, message	; argument #2 in rsi: where does the string start?
	mov rdx, 28		; argument #3 in rdx: how many bytes to write?
	syscall			; this instruction invokes a system call

	mov rax, 60		; 'exit' syscall number
	mov rdi, 0		; 0: normal exit
	syscall		 

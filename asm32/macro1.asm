%macro print 2
	mov eax, SYS_WRITE		; Get the interruption number (syscall -> 4 for write)
	mov ebx, STDOUT		; Get file descriptor (1 -> write)
	mov ecx, %1  
	mov edx, %2
	int 0x80
%endmacro


section .data
	SYS_WRITE equ 4
	STDOUT    equ 1
	LINE_FEED equ 0x0A
	msg1      db 'Universidad pedagógica y Tecnológica de Colombia', LINE_FEED
	len1  	  equ $ - msg1

section .text

global _start

_start: 
	print msg1, len1

end:
	mov eax, 1			; system call number
	mov ebx, 0			; 0: normal exit
	int 0x80			; Syscall 

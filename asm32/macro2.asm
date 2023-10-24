%macro print 2
	mov eax, SYS_WRITE		; Get the interruption number (syscall -> 4 for write)
	mov ebx, STDOUT		; Get file descriptor (1 -> write)
	mov ecx, %1  
	mov edx, %2
	int 0x80
%endmacro

%macro read 2
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .bss
	var1 		resb 50

section .data
	SYS_WRITE 	equ 4
	SYS_READ	equ 3
	STDOUT 		equ 1
	STDIN		equ 0
	LINE_FEED 	equ 0x80
	msg1 		db 'Enter a number -> '
	len1 		equ $ - msg1
	msg2		db 'The number entered is: '
	len2		equ $ - msg2


section .text

global _start

_start:
	print msg1, len1
	read var1, 50
	print msg2, len2
	print var1, 50 

end:
	mov eax, 1			; system call number
	mov ebx, 0			; 0: normal exit
	int 0x80			; Syscall 

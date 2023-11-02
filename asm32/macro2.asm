%macro print 2					; Begin print macro with 2 arguments
	mov eax, SYS_WRITE			; Put the interruption number (syscall -> 4)
	mov ebx, STDOUT				; Get file descriptor (1 -> write)
	mov ecx, %1  				; Get the first argument 
	mov edx, %2				; Get the second argument
	int 0x80				; Syscall
%endmacro

%macro read 2					; Begin read macro with 2 arguments 
	mov eax, SYS_READ			; Put the interruption number (syscall -> 3)
	mov ebx, STDIN				; Put the file descriptor (0 -> read)
	mov ecx, %1  				; Get the first argument 
	mov edx, %2				; Get the second argument
	int 0x80				; Syscall
%endmacro

section .bss					; The variable section. Here we can declare variables
	var1 		resb 50			; The first var with "var1" as name and 50 bytes reserved

section .data					; The data section. Here we can initialize constantes
	SYS_WRITE 	equ 4			; Initialize the "SYS_WRITE" constant which indicates the sys call for write
	SYS_READ	equ 3			; Initialize the "SYS_READ" constant which indicates the sys call for read 
	STDOUT 		equ 1			; Initialize the "STDOUT" constante which indicates the file descriptor for standard output
	STDIN		equ 0			; Initialize the "STDIN" constante which indicates the file descriptor for standard input
	LINE_FEED 	equ 0x80		; Initialize the "LINE_FEED" constant which indicates the line feed (println) for strings.
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

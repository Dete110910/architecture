section .data

	file_name db "hola3.txt", 0  ; Very important put this 0. Otherwise, the file name will be that concat with other strings (the other messages). In addition, the exec problems were

	msg db "Welcome to Tutorials Point", 0xa
	len equ $ - msg
	msgdone db "Written to file", 0xa
	len_done equ $ - msgdone

section .bss

	fd_out resb 1
	fd_in  resb 1
	info resb 26

section .text
   global _start         ;must be declared for using gcc

_start:                  ;tell linker entry point

	;create the file
	mov  eax, 8
	mov  ebx, file_name
	mov  ecx, 0660        ;read, write and execute by all
	int  0x80             ;call kernel
	
	mov [fd_out], eax

	mov eax, 4		; write in file
	mov ebx, [fd_out]
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax, 6		; close
	mov ebx, [fd_out]
	int 0x80

	mov eax, 4		; write in screen
	mov ebx, 1
	mov ecx, msgdone
	mov edx, len_done
	int 0x80

	mov eax, 5		; read
	mov ebx, file_name
	mov ecx, 0
	mov edx, 0766
	int 0x80

	mov [fd_in], eax 	; save fd in variable

	mov eax, 3		; read the content file
	mov ebx, [fd_in]
	mov ecx, info
	mov edx, 26
	int 0x80

	mov eax, 6
	mov ebx, [fd_in]
	int 0x80


	mov eax, 4
	mov ebx, 1
	mov ecx, info
	mov edx, 26
	int 0x80

        mov	eax,1             ;system call number (sys_exit)
        int	0x80              ;call kernel

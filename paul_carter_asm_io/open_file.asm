%include "asm_io.inc"
segment .data

	file_name db "hola3.txt", 0  ; very important put this 0. otherwise, the file name will be that concat with other strings (the other messages). in addition, the exec problems were

	msg db "welcome to tutorials point", 0xa
	len equ $ - msg
	msgdone db "written to file", 0xa
	len_done equ $ - msgdone
segment .bss

	fd_out resb 1
	fd_in  resb 1
	info resb  26

segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
	
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

	popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



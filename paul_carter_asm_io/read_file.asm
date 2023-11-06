%include "asm_io.inc"

segment .data

	file_name db "hola3.txt", 0  ; very important put this 0. otherwise, the file name will be that concat with other strings (the other messages). in addition, the exec problems were

	msg db "welcome to tutorials point", 0xa
	len equ $ - msg

	msgdone db "written to file", 0xa
	len_done equ $ - msgdone

	msg_new_line db " nueva linea", 0xa

	buff db 0	; buffer used to store each character read in file

segment .bss

	fd_out resb 1
	fd_in  resb 1
	info resb  26

	counter resd 1	; counter used to print the sequence of numbers

segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
	
	mov dword [counter], 1	  ; assign 1 to counter variable

	mov eax, 5		; sys_call to open a file
	mov ebx, file_name	; string pointing to file name
	mov ecx, 0		; mode (0 = only read)
	mov edx, 0766		; permits 
	int 0x80

	mov [fd_in], eax 	; save fd in variable

	mov eax, [counter]	;---- 
	call print_int		;    Used to print the first number
	inc dword [counter]	;----

read_loop:
	mov eax, 3		; read the contents of a file 
	mov ebx, [fd_in]	; read the file indicated by the fd in [fd_in] variable
	mov ecx, buff		; store the value read in buff
	mov edx, 1		; size of buff (only 1 byte)
	int 0x80
	
	cmp eax, 0		; cmp if it byte is end of file
	jz end_of_file		; if is end of file, jump to 
	
	mov al, byte [buff]	; move buff value to al. Is byte cause al uses only a byte
	cmp al, 0xA		; cmp if al value is a line_feed
	jz new_line		; if is line_feed, jump

	mov eax, 4		; writes the contents in a file
	mov ebx, 1		; in this case, this is fd for screen
	mov ecx, buff		; prints the buff value
	mov edx, 1		; size of buff
	int 0x80	
	jmp read_loop		; reiterates

new_line:
	call print_nl		
	mov eax, [counter]	; moves counter value to eax
	call print_int		
	inc  dword [counter]	; increments by 1 the counter value
	jmp read_loop
	

end_of_file:

	mov eax, 6		; sys call to close a file
	mov ebx, [fd_in]	; close the file indicates by fd_in value 
	int 0x80

	popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



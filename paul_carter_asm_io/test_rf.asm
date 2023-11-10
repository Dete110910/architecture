
;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"

segment .data
	file_name db "hola3.txt", 0

	buff db 0
segment .bss 

	fd_in resb 1 
	info resb 26
	counter resd 1
	counter2 resb 1

segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
	
	mov dword [counter], 1
;	inc byte [info]

	mov eax, 5
	mov ebx, file_name
	mov ecx, 0
	mov edx, 0766
	int 0x80

	mov [fd_in], eax

	mov eax, [counter]
	call print_int
	inc dword [counter]

read_loop:
	mov eax, 3
	mov ebx, [fd_in]
	mov ecx, buff
	mov edx, 1
	int 0x80

	cmp eax, 0
	jz end_of_file

	mov al, byte [buff]

	cmp al, 0xA
	jz new_line

	mov eax, 4
	mov ebx, 1
	mov ecx, buff
	mov edx, 1
	int 0x80
	jmp read_loop


new_line:
	call print_nl
	mov eax, [counter]
	;call print_int
	inc dword [counter]
	jmp read_loop
	
end_of_file:
	mov eax, 6
	mov ebx, [fd_in]
	int 0x80

	mov eax, [counter2]
	mov [counter2], eax
	call print_int
	inc eax
	cmp eax, 1
	jge asm_main
	jmp end

end: 
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



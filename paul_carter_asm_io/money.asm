%include "asm_io.inc"

%macro get_bills 1
	pusha
	mov ebx, %1
	mov eax, [ebx]
	mov ebx, one_hundred
	sub eax, ebx
	cmp eax, 0
	jz cabe
	
cabe: 
	call print_int
end:
	popa
%endmacro
segment .data

	one_hundred equ 100000
	fifty equ 50000
	twenty equ 20000
	ten equ 10000
	five equ 5000
	two equ 2000
	one_t equ 1000
	five_hc equ 500
	two_hc equ 200
	one_hc equ 100
	fifty_c equ 50

	input db 5
	inputmsg db "Enter the value: ", 0
segment .bss
	

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	
	mov eax, inputmsg
	call print_string
	call read_int

	mov [input], eax
	
	get_bills input
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



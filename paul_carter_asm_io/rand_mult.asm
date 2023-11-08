%include "asm_io.inc"

%macro print_header 0
	pusha
	mov eax, header
	call print_string

	mov eax, line
	call print_string
	popa
%endmacro

%macro print_store 2
	pusha
	mov eax, %1
	call print_string
	call read_int

	mov ebx, %2
	mov [ebx], eax
	popa
%endmacro

%macro print_store_char 2
	pusha
	mov eax, %1
	call print_string
	call read_char
	call read_char

	mov ebx, %2
	mov [ebx], eax
	popa
%endmacro

%macro multiply_print 2
	pusha
	mov ecx, 10
	mov eax, %1
	mov ebx, [eax]
	mov edx, 1

loop_start:
	mov eax, outmsg
	call print_string
	
	mov ebx, [module]
	imul ebx, edx

	mov eax, [module]
	call print_int

	mov eax, times1
	call print_string

	mov eax, edx
	call print_int

	mov eax, equal
	call print_string
	
	mov eax, ebx
	call print_int
	call print_nl

	inc edx
	loop loop_start
end_multiply:
	popa
%endmacro

%macro clear_screen 0
	pusha
	mov eax, clr
	call print_string
	popa
%endmacro

segment .data
	
	header db "Multiplication table", 0xa, 0
	line db "------------------------", 0xa, 0
	prompt1 db "Enter the limit number: ", 0
	outmsg db  "The result is -> ", 0
	outmsg1 db "The selected number was: ", 0
	times1 db " x ", 0
	equal db " = ", 0
	prompt2 db "Do you want to continue (y) or (n): "
	clr     db  0x1b, "[2J", 0x1b, "[H", 0    ;print "\033c"

	y equ 121

segment .bss
	
	input1 resd 1
	random resb 1
	answer resb 2
	module resb 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha


	print_header
	
	print_store prompt1, input1

	mov eax, 0x163
	mov ebx, random
	mov ecx, 1
	mov edx, 0
	int 0x80

	mov eax, [random]
	mov ebx, [input1]
	idiv ebx
	mov [module], edx

	mov eax, outmsg1
	call print_string
	mov eax, [module]
	call print_int
	call print_nl

	
	multiply_print module, 10 	; the idea is that the second parameter is the number of times the operation is to be performed

	print_store_char prompt2, answer

	cmp byte [answer], y
	je asm_main
	jmp end_program

end_program:
	clear_screen
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



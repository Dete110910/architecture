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

%macro multiply 2
	pusha
	mov ecx, 11
	mov eax, %1
	mov ebx, [eax]
	mov edx, 0
loop_start:
	mov eax, outmsg
	call print_string

	imul ebx, edx
	mov eax, ebx
	call print_int

	mov eax, times1
	call print_string

	mov eax, edx
	call print_int

	mov eax, equal
	call print_string

	call print_nl
	loop loop_start
end_multiply:
	popa
%endmacro

%macro print_result_with_nl 2
	pusha
	mov eax, %1
	call print_string
	mov ebx, %2
	mov eax, [ebx]
	call print_int
	popa
%endmacro

segment .data
	
	header db "Multiplication table", 0xa, 0
	line db "------------------------", 0xa, 0
	prompt1 db "Enter a number: ", 0
	outmsg db  "The result is -> ", 0
	times1 db " x ", 0
	equal db " = ", 0
	prompt2 db "Do you want to continue (y) or (n): "

segment .bss
	
	input1 resd 1
	answer resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	print_header
	
	print_store prompt1, input1
	
	multiply input1, 4

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



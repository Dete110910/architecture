%include "asm_io.inc"

%macro print_storage 2
	pusha
	mov eax, %1
	call print_string
	call read_int
	mov ebx, %2
	mov [ebx], eax
	popa
%endmacro

%macro square_number 2
	pusha
	mov ebx, %1
	mov eax, [ebx]
	mul eax
	mov ebx, %2
	mov [ebx], eax
	popa
%endmacro

%macro multiply_storage 3
	pusha
	mov ebx, %1
	mov eax, [ebx]
	mov ecx, %2
	mov edx, [ecx]
	mul edx
	mov ebx, %3
	mov [ebx], eax
	popa
%endmacro

%macro multiply_storage_const 3
	pusha
	mov ebx, %1
	mov eax, [ebx]
	mov ecx, %2
	mul ecx
	mov edx, %3
	mov [edx], eax
	popa
%endmacro

%macro division_storage_const 0 
	pusha
	
	popa
%endmacro

%macro print_result_with_nl 2
	pusha
	mov eax, %1
	call print_string
	mov ebx, %2
	mov eax, [ebx]
	call print_int
	call print_nl
	popa
%endmacro

%macro print_data_message 2
	pusha
	mov eax, $1
	call print_string
	mov eax, $2
	call print_int
	popa
%endmacro

segment .data
;
; initialized data is put in the data segment here
;
prompt1 db    "Enter a number: ", 0      
outmsg1 db    "Square of input is: ", 0
outmsg2 db    "Cube of input is: ", 0
outmsg3 db    "Cube of input times 25 is: ", 0
outmsg4 db    "Quotient of cube/100 is: ", 0
outmsg5 db    "Remainder of cube/100 is: ", 0
outmsg6 db    "The negation of remainder is: ", 0

twenty_five equ 25
one_hundred dd 100.0


segment .bss
;
; uninitialized data is put in the bss segment
;

input1 resd 1
result resd 1
square resd 1
cube resd 2
cube_times_tf resd 2
quotient_cube_div_by_100 resd 2
remainder resd 2

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	
	print_storage prompt1, input1

	square_number input1, square

	print_result_with_nl outmsg1, square
	
	multiply_storage square, input1, cube
	
	print_result_with_nl outmsg2, cube
	
	multiply_storage_const cube, twenty_five, cube_times_tf
	
	print_result_with_nl outmsg3, cube_times_tf

	mov eax, [cube]
	cdq
	mov ecx, 100
	idiv ecx
	call print_nl
	call print_int

	mov eax, edx
	call print_nl
	call print_int

	mov ecx, eax
	mov eax, outmsg4
	call print_string
	mov eax, ecx
	call print_int
	call print_nl

;	fld dword [cube]
;	fdiv dword [one_hundred]
;	fstp dword [quotient_cube_div_by_100]
;	mov eax, [quotient_cube_div_by_100]
;	call print_int
;	call print_nl

;	fld dword [cube]
;	fdiv dword [one_hundred]
;	fprem
;	fstp dword [remainder]
;	mov eax, [remainder]
;	call print_int
;	call print_nl



;	print_result_with_nl outmsg4, quotient_cube_div_by_100 

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



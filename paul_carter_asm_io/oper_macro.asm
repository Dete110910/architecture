

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"

%macro showing_result	0		; Define showing_result macro
	pusha				; saves the general purpose register information on the stack
	call print_string		; Print the arithmetic operation message
	mov eax, ebx			; Move the ebx value to eax register for print it
	call print_int			; Call the "print_int" function to print one integer
	call print_nl			; Call the "print_nl" function to print a new line
	popa				; Extracts the information from the stack and puts it in the registers
%endmacro


segment .data
;
; initialized data is put in the data segment here
;

prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0
prompt3 db    "Enter 1 to continue. Otherwise it will be close: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the sum of these is ", 0
outmsg4 db    ", the rest of these is ", 0
outmsg5 db    ", the multiplication of these is ", 0
outmsg6 db    ", the division of these is ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

input1  resd 1
input2  resd 1
input3  resd 1
 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;
start:
	mov eax, prompt1
	call print_string
	call read_int
	mov [input1], eax

	mov eax, prompt2
	call print_string
	call read_int
	mov [input2], eax

	mov eax, outmsg1
	mov ebx, [input1]
	showing_result

	mov eax, outmsg2
	mov ebx, [input2]
	showing_result

	mov ebx, [input1]
	add ebx, [input2]
	mov eax, outmsg3
	showing_result

	mov ebx, [input1]
	sub ebx, [input2]
	mov eax, outmsg4
	showing_result

	mov eax, [input1]
	mov ebx, [input2]
	mul ebx
	mov ebx, eax
	mov eax, outmsg5
	showing_result

	mov eax, [input1]
	mov ebx, [input2]
	div ebx
	mov ebx, eax
	mov eax, outmsg6
	showing_result

	mov eax, prompt3
	call print_string
	call read_int
	
	cmp eax, 1
	je start
	jne end

end:
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



%include "asm_io.inc"

%macro read_string 2
	pusha
	mov edi, %1
	mov ecx, %2

%%loop_str_start:
	call read_char
	cmp al, LINE_FEED
	je %%loop_str_end
	mov [edi], al
	inc edi
	loop %%loop_str_start
%%loop_str_end:
	mov byte [edi], 0
	popa
%endmacro

segment .data

prompt1 db "Enter your name: ", 0
prompt2 db "Enter your age: ", 0
prompt3 db "Do you want to continue? Enter (y) or (n): ", 0
kidmsg db ", you are a kid ", 0
teenmsg db ", you are a teenager ", 0
adultmsg db ", you are an adult ", 0
oldmsg db ", you are a little old man/girl ", 0
LINE_FEED equ 10
yes db "y", 0

segment .bss
age resd 1
name resb 22
continue resb 2

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	
	mov eax, prompt2
	call print_string
	call read_int

	mov [age], eax

	mov eax, prompt1
	call print_string
	read_string name, 20


	mov eax, name
;	call print_string
	
	;mov eax, [age]
	;cmp eax, 12
	;jle iskid

	;cmp eax, 18
	;jle isteenager

	;cmp eax, 25
	;jle isadult

	;jne isold
;	jmp next_action

iskid:
	mov eax, kidmsg
	call print_string
	call print_nl
	jmp next_action

isteenager:
	mov eax, teenmsg
	call print_string
	call print_nl
	jmp next_action

isadult:
	mov eax, adultmsg
	call print_string
	call print_nl
	jmp next_action

isold: 
	mov eax, oldmsg
	call print_string
	call print_nl
	jmp next_action

next_action:
	mov eax, prompt3
	call print_string
;	call read_char
	read_string continue, 4
	;call read_char
;	je asm_main
;	jne endprogram

endprogram:
	call print_nl
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



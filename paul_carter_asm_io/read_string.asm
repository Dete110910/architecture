%include "asm_io.inc"

%macro read_string 2
	pusha
	popa
%endmacro

segment .data

segment .bss

name db 20

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	
	call print_string
	read_string name, 20

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



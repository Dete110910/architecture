%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;


segment .bss
;
; uninitialized data is put in the bss segment
;


 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	
    ; Set video mode 3 (80x25 text mode)
    mov ah, 0x00 ; set video mode function
    mov al, 0x03 ; video mode 3 (80x25 text mode)
    int 0x10 ; call BIOS interrupt

    ; Clear the console text screen
    mov ah, 0x06 ; scroll up function
    mov al, 0x00 ; clear entire screen
    mov bh, 0x07 ; attribute (white on black)
    mov cx, 0x0000 ; upper left corner (row 0, column 0)
    mov dx, 0x184F ; lower right corner (row 24, column 79)
    int 0x10 ; call BIOS interrupt

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



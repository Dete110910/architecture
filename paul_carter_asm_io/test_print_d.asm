section .data
    fmt db "Quotient: %lf, Remainder: %lf", 10, 0  ; Formato para imprimir los valores de punto flotante
    divisor dd 2.0
    dividendo dd 8.0
twenty_five equ 25
one_hundred dd 100.0


section .bss
    quotient_cube_div_by_100 resq 1  ; Reserva espacio para el cociente
    remainder resq 1  ; Reserva espacio para el resto
cube resd 2

section .text
global asm_main

asm_main:

	enter 0,0
	pusha

    fld dword [dividendo]    ; Carga el dividendo en la pila de la FPU
    fdiv dword [divisor]     ; Divide el valor de la pila de la FPU por el divisor
    fprem                    ; Calcula el resto de la división
    fstp dword [cube]       ; Almacena el resto de la división en la memoria

	mov eax, [cube]
	call print_int
        popa
    	mov eax, 0
	leave
	ret


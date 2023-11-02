section .data
    clear_screen db "\x1b[2]", 0   ; Secuencia de escape ANSI para limpiar la pantalla

section .text
global _start

_start:
    ; Llamar a la función de impresión personalizada
    mov eax, 4
    mov ebx, 1
    mov ecx, clear_screen
    mov edx, 4  ; Longitud de la secuencia de escape
    int 0x80

    ; Salir del programa
    mov eax, 1
    mov ebx, 0
    int 0x80


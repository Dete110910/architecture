section .data
    filename db "archivo.txt", 0    ; Nombre del archivo
    mode     db 0644                ; Permisos para el archivo (rw-r--r--)
    file     dd 0                   ; Descriptor de archivo

section .bss
    buffer resb 1024                ; Espacio para un búfer de datos (por ejemplo, 1024 bytes)

section .text
    global _start

_start:
    ; Llamada al sistema para abrir el archivo
    mov eax, 5        ; Código de llamada al sistema para abrir un archivo (sys_open)
    mov ebx, filename ; Puntero al nombre del archivo
    mov ecx, 0        ; Modo de apertura (0 = solo lectura)
    mov edx, mode     ; Permisos
    int 80h           ; Interrupción del sistema para realizar la llamada

    ; Comprobar errores al abrir el archivo (eax contiene el resultado)
    cmp eax, -1
    je error_open

    ; Si se abre correctamente, el descriptor de archivo se guarda en ebx
    mov [file], eax

    ; Realiza otras operaciones con el archivo abierto aquí

    ; Cerrar el archivo cuando hayas terminado
    mov eax, 6        ; Código de llamada al sistema para cerrar un archivo (sys_close)
    mov ebx, [file]   ; Descriptor de archivo a cerrar
    int 80h           ; Interrupción del sistema para realizar la llamada

    ; Finaliza el programa
    mov eax, 1        ; Código de llamada al sistema para salir (sys_exit)
    mov ebx, 0        ; Código de retorno
    int 80h           ; Interrupción del sistema para salir

error_open:
    ; Maneja el error al abrir el archivo aquí y luego sale del programa


section .data				; Defines ".data" section where constants are to be declared

msg db "Hello World!", 0x0a		; Declares "msg" with "Hello World!\n" as value

len equ $ - msg				; Defines length of the "msg"

section .text				; Defines ."text" section where "code" is to be written

global _start				; Declares "_start" as a global label. It is used to let other files know where the program starts

_start:					; start label

mov eax, 4				; Put sys_write system call in eax register

mov ebx, 1				; Put stdout file descriptor in ebx register

mov ecx, msg				; Store msg in ecx register

mov edx, len				; Put msg len in edx register

int 0x80				; Perform the system call (Here prints the msg)

mov eax , 1				; Put sys_exit system call in eax register

mov ebx , 0				; Setting exit status in ebx register

int 0x80				; Calling interrupt handler to exit program

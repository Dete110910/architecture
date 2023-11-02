global _start		; must be declared for linker

section .data

first_prompt db "Enter the first number "		; first_prompt="Enter the first number "

len_first_prompt equ $ - first_prompt			; len_first_prompt equals size of first_prompt

second_prompt db "Enter the second number "		; second_prompt="Enter the second number "

len_second_prompt equ $ - second_prompt			; len_second_prompt equals size of second_prompt

disp_prompt db "The Sum is "				; disp_prompt="The Sum is "

len_disp_prompt equ $ - disp_prompt			; len_disp_prompt equals size of disp_prompt

section .bss

first resb 2		; Unitialized data variable first

second resb 2		; Unitialized data variable second

sum resb 1		; Unitialized data variable sum

section .text

_start:			; start label

mov eax, 4		; sys_write system call

mov ebx, 1		; stdout file descriptor

mov ecx, first_prompt		; ecx=first_prompt

mov edx, len_first_prompt	; edx=len_first_prompt

int 0x80		; Calling interrupt handler

mov eax, 3		; sys_read system call

mov ebx, 2		; stdin file descriptor

mov ecx, first		; Read first input value

mov edx, 2		; 2 bytes (numeric, 1 for sign) of that data value

int 0x80		; Calling interrupt handler

mov eax, 4		; sys_write system call

mov ebx, 1		; stdout file descriptor

mov ecx, second_prompt		; ecx=second_prompt

mov edx, len_second_prompt	; edx=len_second_prompt

int 0x80		; Calling interrupt handler

mov eax, 3		; sys_read system call

mov ebx, 2		; stdin file descriptor

mov ecx, second		; Read second input value

mov edx, 2		; 2 bytes (numeric, 1 for sign) of that data value

int 0x80		; Calling interrupt handler

mov eax, 4		; sys_write system call

mov ebx, 1		; stdout file descriptor

mov ecx, disp_prompt		; ecx=disp_prompt

mov edx, len_disp_prompt	; edx=len_disp_prompt

int 0x80		; Perform the system call

mov eax,  [first]		; Moving first value to accumulator

;sub eax, '0'		; Converting to ASCII value

mov ebx,  [second]		; Moving second value to ebx

;sub ebx, '0'		; Converting to ASCII value

add eax, ebx		; Adding the numbers in registers

add eax, '0'		; Converting to ASCII value

mov [sum], eax		; Storing the result in sum

mov eax, 4		; sys_write system call

mov ebx, 1		; stdout file descriptor

mov ecx, sum		; ecx=sum

mov edx, 1	                 
                                    

int 0x80		; Perform the system call

mov eax , 1		; sys_exit system call

mov ebx , 0		; setting exit status

int 0x80		; Calling interrupt handler to exit program

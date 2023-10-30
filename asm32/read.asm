section .data					; Defines ".data" section where constants are to be declared

	msg db "Enter a number: ", 0		; Declares "msg" with "Enter a number: " as value
	len1 equ $ - msg			; Defines length of the "msg"
	resmsg db "Sum is: ", 0			; Declares "resmsg" with "Sum is: " as value
	len2 equ $ - resmsg			; Defines length of the "resmsg"

section .bss

	first resb 2				; Declare the "first" variable with 2 bytes of length
	second resb 2				; Declare the "second" variable with 2 bytes of length
	result resb 2				; Declare the "result" variable with 2 bytes of length

section .text					; Defines ."text" section where "code" is to be written

global _start					; Declares "_start" as a global label. It is used to let other files know where the program starts

_start:						; start label

	mov eax, 4				; Put sys_write system call in eax register
	mov ebx, 1				; Put stdout file descriptor in ebx register
	mov ecx, msg				; Store msg in ecx register
	mov edx, len1				; Put msg len in edx register
	int 0x80				; Perform the system call (Here prints the msg)

	mov eax, 3				; Puts sys_read system call in eax register
	mov ebx, 0				; Puts stdin file descriptor number in ebx register
	mov ecx, first				; Puts first variable in ecx register to store the value entered
	mov edx, 2				; Puts the legth of the variable "first" in the edx register to indicate the read size
	int 0x80				; Perform the system call (read the value)

	mov eax, 4				; Put sys_write system call in eax register
	mov ebx, 1				; Put stdout file descriptor in ebx register
	mov ecx, msg				; Store msg in ecx register
	mov edx, len1				; Put msg len in edx register
	int 0x80				; Perform the system call (Here prints the msg)

	mov eax, 3				; Puts sys_read system call in eax register
	mov ebx, 0				; Puts stdin file descriptor number in ebx register
	mov ecx, second				; Puts first variable in ecx register to store the value entered
	mov edx, 2				; Puts the legth of the variable "first" in the edx register to indicate the read size
	int 0x80				; Perform the system call (read the value)
	
	mov eax, [first]			; Move the value of the "first" variable to eax register
	sub eax, '0'				; Substract '0' to value of eax register to convert in a numeric value
	mov ebx, [second]			; Move the value of the "second" variable to ebx register
	sub ebx, '0'				; Substract '0' to value of ebx register to convert in a numeric value
	add eax, ebx				; Add ebx value to eax value and store in eax register
	add eax, '00'				; Add '0' to value of eax register to convert to ASCII
	mov [result], eax			; Store value of the eax register to address of "result" variable

	mov eax, 4				; Put sys_write system call in eax register
	mov ebx, 1				; Put stdout file descriptor in ebx register
	mov ecx, resmsg				; Store resmsg in ecx register
	mov edx, len2				; Put resmsg len in edx register
	int 0x80				; Perform the system call (Here prints the msg)

	mov eax, 4				; Put sys_write system call in eax register
	mov ebx, 1				; Put stdout file descriptor in ebx register
	mov ecx, result				; Store result value in ecx register
	mov edx, 1				; Put result len in edx register
	int 0x80				; Perform the system call (Here prints the msg)

	mov eax , 1				; Put sys_exit system call in eax register
	mov ebx , 0				; Setting exit status in ebx register
	int 0x80				; Calling interrupt handler to exit program

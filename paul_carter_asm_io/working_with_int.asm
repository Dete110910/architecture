%include "asm_io.inc"

%macro print_storage 2					; Defines print_storage macro. It receives 2 parameters
	pusha						; Saves the registers
	mov eax, %1					; Store the first argument in eax register
	call print_string				; Call the print_string function that prints the string that begins in address location in eax
	call read_int					; Call the read_int function that reads the integer value typed by the user. It stores the value in eax
	mov ebx, %2					; Moves the second argument to ebx register
	mov [ebx], eax					; Moves the eax value to the address stored in ebx register. It stores eax value in the memory location pointed to ebx
	popa						; Restore the register 
%endmacro

%macro square_number 2					; Defines square_number macro. It receives 2 parameters
	pusha						; Saves the registers
	mov ebx, %1					; Stores the first argument in ebx register
	mov eax, [ebx]					; Load the value stored in ebx address in eax
	mul eax						; Multiplies the value of eax  by itself and stores in eax
	mov ebx, %2					; Stores the second argument in ebx register
	mov [ebx], eax					; Moves the eax value to the address stored in ebx register. It stores eax value in the memory location pointed to ebx
	popa						; Restore registers
%endmacro

%macro multiply_storage 3				; Defines multiply_storage macro. It receives 3 parameters
	pusha						; Saves the registers
	mov ebx, %1					; Saves the first argument in ebx register
	mov eax, [ebx]					; Saves the value stored in ebx memory addres in eax 
	mov ecx, %2					; Saves the second parameter in ecx 
	mov edx, [ecx]					; Saves the value of ecx in edx
	mul edx						; Multiplies eax value to edx value and stores it in eax
	mov ebx, %3					; Saves the third parameter in ebx 
	mov [ebx], eax					; Moves the eax value to the address stored in ebx register. It stores eax value in the memory location pointed to ebx
	popa						; Restore registers
%endmacro

%macro multiply_storage_const 3				; Defines multiply_storage_const macro. It receives 3 parameters
	pusha						; Saves the registers
	mov ebx, %1					; Store the first parameter in ebx 
	mov eax, [ebx]					; Saves the ebx value in eax 
	mov ecx, %2					; Store the second parameter in ecx 
	mul ecx						; Multiplies eax value by ecx value and stores it in eax 
	mov edx, %3					; Store the third parameter in edx
	mov [edx], eax					; Moves the eax value to the address stored in ebx register. It stores eax value in the memory location pointed to edx
	popa						; Restore registers
%endmacro

%macro division_storage_const 3				; Defines division_storage_const macro. It receives 3 parameters 
	pusha						; Saves the registers
	mov ebx, %1					; Store the first parameter in ebx
	mov eax, [ebx]					; Saves the ebx value in eax
	cdq 						; This instruction is used to convert dword (32 bits) to qword (64 bits). Later, u can perform signed division operation
	mov ecx, 100					; Stores the 100 value to ecx 
	idiv ecx					; Integer division. It divides eax value to ecx value. The quotient is stored in eax, the remainder in edx
	mov ebx, %2					; Store the second parameter in ebx register
	mov [ebx], eax					; Moves eax value to address located in ebx 
	mov ebx, %3					; Store the third parameter in ebx
	mov [ebx], edx					; Store edx value in ebx address location
	popa						; Restore register
%endmacro

%macro negate_storage 2					; Defines negate_storage macro. It receives 2 parameters
	pusha						; Saves the registers
	mov ebx, %1					; Store the first parameter in ebx
	mov eax, [ebx]					; Saves the ebx value in eax
	neg eax						; Negate the eax value and stores in eax
	mov ebx, %2					; Store the second parameter in ebx
	mov [ebx], eax					; Saves the eax value in ebx address location
	popa						; Restore registers
%endmacro

%macro print_result_with_nl 2				; Defines print_result_with_nl macro. It receives 2 parameters
	pusha						; Saves the registers
	mov eax, %1					; Store the first parameter in eax
	call print_string				; Call print_string function that prints the string which initial address are stored in eax
	mov ebx, %2					; Store the second parameter in ebx
	mov eax, [ebx]					; Saves the ebx value in eax
	call print_int					; Call print_int function that prints value stored in eax
	call print_nl					; Call print_nl function that prints new line
	popa						; Restore registers
%endmacro


segment .data

prompt1 db    "Enter a number: ", 0						; Defines prompt1 message with null character at the end 
prompt2 db    "Enter 1 to continue. Otherwise the program will close. ", 0	; Defines prompt2 message with null character at the end
outmsg1 db    "Square of input is: ", 0						; Defines outmsg1 message with null character at the end
outmsg2 db    "Cube of input is: ", 0						; Defines outmsg1 message with null character at the end
outmsg3 db    "Cube of input times 25 is: ", 0					; Defines outmsg1 message with null character at the end
outmsg4 db    "Quotient of cube/100 is: ", 0					; Defines outmsg1 message with null character at the end
outmsg5 db    "Remainder of cube/100 is: ", 0					; Defines outmsg1 message with null character at the end
outmsg6 db    "The negation of remainder is: ", 0				; Defines outmsg1 message with null character at the end

twenty_five equ 25


segment .bss

input1 resd 1									; Defines input1 variable reserving 4 bytes of length (1 dword)
input2 resd 1									; Defines input2 variable reserving 4 bytes of length (1 dword)
square resd 1									; Defines square variable reserving 4 bytes of length (1 dword)
cube resd 2									; Defines cube variable reserving 8 bytes of length (2 dword)
cube_times_tf resd 2								; Defines cube_times_tf variable reserving 8 bytes of length (2 dword)
quotient_div_100 resd 2								; Defines quotient_div_100 variable reserving 2 bytes of length (2 dword)
remainder resd 2								; Defines remainder variable reserving 8 bytes of length (2 dword)
neg_remainder resd 2								; Defines neg_remainder variable reserving 8 bytes of length (2 dword)

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

start:
	print_storage prompt1, input1					; Call macro that prints prompt1 message and store the entered value in input1 variable
	
	square_number input1, square					; Call macro that squares the value of input1 variable and stores in the variable square

	print_result_with_nl outmsg1, square				; Call macro that print one message and the result. In this case, outmsg1 and square result
	
	multiply_storage square, input1, cube				; Call macro that multiply two numbers and stores it in one variable. In this case, multiply square with input1 and stores in cube
	
	print_result_with_nl outmsg2, cube				; Call macro that print one message and the result. In this case, outmsg2 and cube result
	
	multiply_storage_const cube, twenty_five, cube_times_tf		; Call macro that multiply two numbers and stores it in one variable. In this case, multiply cube  with twenty_five and stores in cube_times_tf
	
	print_result_with_nl outmsg3, cube_times_tf			; Call macro that print one message and the result. In this case, outmsg3 and cube_times_tf result

	division_storage_const cube, quotient_div_100, remainder	; Call macro that divide two numbers and storage the quotient and remainder in variables

	print_result_with_nl outmsg4, quotient_div_100			; Call macro that print one message and the result. In this case, outmsg4 and quotient_div_100 result

	print_result_with_nl outmsg5, remainder				; Call macro that print one message and the result. In this case, outmsg5 and remainder result

	negate_storage remainder, neg_remainder				; Call macro that negate and storage a number. In this case, negate remainder

	print_result_with_nl outmsg6, neg_remainder			; Call macro that print one message and the result. In this case, outmsg6 and neg_remainder result

	print_storage prompt2, input2					; Call macro that prints prompt2 message and store the entered value in input2 variable
	mov eax, [input2]						; Moves the value of variable 2 in eax register
	cmp eax, 1							; Compare the eax value with 1. It set the condition code in the machine status word
	je start							; Conditional jump that are based on the status of a set of condition codes stores in a special register called machine status word. If the cmp operation performed is true, jump to start label
	jne end								; Jump to end label if the last cmp operation performed is not equal

end:
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



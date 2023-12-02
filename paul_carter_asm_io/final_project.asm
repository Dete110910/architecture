%include "asm_io.inc"
%macro open_file 0                      ; mode (0 = only read)
        mov edx, 0766                   ; permits
        int 0x80
        mov [fd_in], eax                ; save fd in variable
        popa
%endmacro
%macro getmaxsize 0                     ; MACRO TO COMPARE ACTUAL MAX VALUE WITH LINE SIZE FOR GET NEW MAX VALUE
        pusha                           ; save register
        mov eax, [bigsizeword]          ; mov eax max size value
        mov ebx, [counterword]          ; move ebx line size
        cmp ebx,eax                     ; compare max size and line size
        jg ismax                        ; if grater line size
        jmp isless                      ; if else
ismax:
        mov edx, [counterword]          ; mov edx value size line
        mov  [bigsizeword], edx         ; mov to max size , size line
isless:
        popa                            ; recover register
%endmacro
%macro show_table 0                     ; MACRO TO SHOW TABLE
        pusha
        mov ecx, 4                      ; init counter =4, to add border and numbers
        add ecx, [bigsizeword]          ; add to counter max value line
        p_init_table                    ; show line init table
        p_title                         ; show title
        p_sep_table                     ; show line separator table
        p_body                          ; show values
        exit				; show exit option
        p_end_table                     ; show line end table
        popa
%endmacro
%macro exit 0				; MACRO TO SHOW EXIT OPTION
        pusha
        mov eax, v_border		; vertical border to eax
        call print_string		; print vertical border
        mov eax, exit_op		; exit option to eax 
        call print_string		; print exit option
        sub ecx, 8                      ; sub the lenght of exit
        print_blank ecx                 ; print blanks 
        mov eax, v_border		; vertical border to eax
        call print_string		; print vertical border
	call print_nl			; print line feed
        popa
%endmacro
%macro p_body 0
        pusha
        mov dword [c], 1		; clean counter to option
%%loopbody:
        popa
        pusha
	mov eax, [c_aux]		; mov to eax counter to quantity of options in the menu
	mov ebx, [c]			; mov to eax counter option 
        cmp eax, ebx  			; Compare if counter option y quantity options is iqual to end ejecution loop
        je  %%end_loopbody  		; go to end_loopbody
        mov eax, v_border		; vertical border to eax
        call print_string		; print vertical border
        mov eax, [c]			; move to eax counter option
        call print_int			; print number option
        mov eax, dot			; move to eax dot plus space
        call print_string		; print dot plus space
        print_line			; call macro to print line 
        inc byte [c]			; increment counter option
        sub ecx, [countertextsize]	; substract to ecx (cell size), print line size
        cmp byte [c], 10		; compare if counter option is greater to 10 
        jle %%one			; go to one, when value is less to 10
        jmp %%two			; go to two, always
%%one:
        sub ecx, 3			; substract 3 to cell size
        jmp %%con			; go to continue, always
%%two:
        sub ecx, 4			; substract 4 to cell size
	jmp %%con			; go to continue, always
%%con:
	cmp ecx, 0
	je %%cont_without_blank
        print_blank ecx			; call macro to print a quantity of blank 
	jmp %%cont_without_blank
%%cont_without_blank:
        mov eax, v_border		; move to eax vertical border
        call print_string		; print vertical border
        call print_nl			; print line feed
        jmp %%loopbody    		; go to loopbody, always
%%end_loopbody:
        popa			
%endmacro
%macro p_title  0			; MACRO TO PRINT TITLE
        pusha
        mov eax, v_border		; move to eax vertical border
        call print_string		; print vertical border
        sub ecx, [titlesize]		; substract to cell size, titlesize 
        mov eax, ecx			; move to eax, value to ecx
        shr eax, 1			; split eax into two using byte shift
        print_blank eax			; print first blank
        print_line			; call macro to print line
        sub ecx, eax			; substracto to cell size, eax
        print_blank ecx			; call macro to print a quantity of blank
        mov eax, v_border		; move to eax verticcal border
        call print_string		; print vertical border
        call print_nl			; print line feed
        popa
%endmacro
%macro print_line 0			; MACRO TO PRINT NEXT LINE IN THE FILE
        pusha
        mov dword [countertextsize], 0	; initialize variable text size value to 0 
%%read_ploop:
        mov eax , [countertextsize] 	; move to eax text size
        mov eax, 3                      ; read the contents of a file
        mov ebx, [fd_in]                ; read the file indicated by the fd in [fd_in] variable
        mov ecx, buff                   ; store the value read in buff
        mov edx, 1                      ; size of buff (only 1 byte)
        int 0x80
        cmp eax, 0                      ; cmp if it byte is end of file
        je %%end_plloop               	; go to end_plloop , when is end of the file
        mov al, byte [buff]             ; move buff value to al. Is byte cause al uses only a byte
        cmp al, 0xA                     ; cmp if al value is a line_feed
        je %%end_plloop               	; if is line_feed, go to end_plloop
        inc byte [countertextsize]	; increment text size
        call print_char			; print letter in the txt
        jmp %%read_ploop                ; go to read_ploop, always
%%end_plloop:
        popa
%endmacro
%macro print_blank 1			; MACRO TO PRINT BLANK
        pusha
        mov ecx, %1			; move to eax, quantity of blanks
	mov eax, blank			; move to eax blank 
%%loopspaces:			
        call print_string		; print blank 
        loop %%loopspaces		; go to loopspaces if eax > 0, and decrement eax
        popa
%endmacro
%macro p_end_table 0                    ; MACRO TO SHOW END BORDER TABLE
        pusha
        mov eax, bi_table               ; mov to eax middle init border
        call print_string               ; print border
        p_mid_table                     ; call macro to show middle border
        mov eax, be_table               ; mov to eax middle end border
        call print_string               ; print border
        call print_nl                   ; print line feed
        popa
%endmacro
%macro p_sep_table 0                    ; MACRO TO SHOW LINE SEPARATOR TABLE
        pusha
        mov eax, mi_table               ; mov to eax middle init border
        call print_string               ; print border
        p_mid_table                     ; call macro to show middle border
        mov eax, me_table               ; mov to eax middle end border
        call print_string               ; print border
        call print_nl                   ; print line feed
        popa
%endmacro
%macro p_init_table 0                   ; MACRO TO SHOW INIT BORDER TABLE
        pusha
        mov eax, ti_table               ; mov to eax init top border
        call print_string               ; print border
        p_mid_table                     ; call macro to show middle border
        mov eax, te_table               ; mov to eax end top border
        call print_string               ; print border
        call print_nl                   ; print line feed
        popa
%endmacro
%macro p_mid_table 0                    ; MACRO TO SHOW MIDDLE BORDER TABLE
        pusha
%%printm:
        mov eax, m_table                ; mov to eax middle border
        call print_string               ; print border
        loop %%printm                   ; loop to printm, and decrement ecx
        popa
%endmacro
%macro cls 0				; MACRO TO CLEAN SCREEEN
        mov eax, clr			; mov to eax value to clean screen
        call print_string		; print clean crean
%endmacro
segment .data
        booleano db 1,0			; booelean used to verify if we are in the title 
	c_aux dd 0			; quantity of options in the menu
        file_name db "hola3.txt", 0     ; very important put this 0. otherwise, the file name will be that concat with other strings (the other messages). in addition, the exec problems were
        buff db 0                       ; buffer used to store each character read in file
        ti_table db "╔", 0		; string to top init table
        m_table db "═", 0		; string to middle in the table
        te_table db "╗", 0		; string to top end table
        mi_table db "╠", 0		; string to middle init table
        me_table db "╣", 0		; string to middle end table
        bi_table db "╚", 0		; stirng to botton init table
        be_table db "╝", 0		; string to botton end table
        v_border db "║", 0		; string vertical border
        dot db ". ", 0			; string dot plus blank
        blank db " ", 0			; string to blank
        exit_op db "0. Salir", 0	; string exit option
        optionmsg  db "Your option is: ", 0			;string for enter oprion
        correct_op_msg db "You entered the option: ", 0		; string to show the option entered
        wrong_op db "Wrong option", 0				; message when the option entered is wrong (do not exist)
        continue_program db "press ENTER to continue", 0	; message to press enter for continue
        clr     db  0x1b, "[2J", 0x1b, "[H"     		;print "\033c"
segment .bss
        fd_in  resb 1			; file descriptor
        counter resd 1                  ; counter used to verify title
        counterword resd 1              ; counter used to save size line
        bigsizeword resd  1             ; counter used to save max size
        titlesize resd 1                ; title size
        countertextsize resd 1		; counter used to save line size
        c resd 1			; counter used to now max options
	c_option resb 1			; counter used to show options
        option resd 1			; variable to save inpunt option
segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha                           ; save register values
        mov byte [counterword], 0       ; assign 0 to counter word
        mov byte [bigsizeword], 8       ; assign 0 to bigsizeword
	mov byte [countertextsize], 0	; assign 0 to countertextsize
        mov eax, 5                      ; sys call to open a file
        mov ebx, file_name              ; string pointing to file name
        mov ecx, 0                      ; mode (0 = only read)
        mov edx, 0766                   ; permits
        int 0x80 
        mov [fd_in], eax                ; save fd in variable

read_loop:
        cls				; call macro to clean screen
        mov eax, 3                      ; read the contents of a file
        mov ebx, [fd_in]                ; read the file indicated by the fd in [fd_in] variable
        mov ecx, buff                   ; store the value read in buff
        mov edx, 1                      ; size of buff (only 1 byte)
        int 0x80
        cmp eax, 0                      ; cmp if it byte is end of file
        jz end_of_file                  ; if is end of file, jump to
        mov al, byte [buff]             ; move buff value to al. Is byte cause al uses only a byte
        cmp al, 0xA                     ; cmp if al value is a line_feed
        jz new_line                     ; if is line_feed, jump
        inc byte [counterword]          ; + 1 to size line
        jmp read_loop                   ; reiterates
new_line:
	mov eax , [c_aux]		; move to eax quantity options value
	inc eax				; increment eax
	mov [c_aux], eax		; move to quantity options value of eax
        mov al, byte [booleano]		; move to al , boolean value
        cmp al, 1  			; Compare al with 1
        je  is_true  			; go to is true, if are iquals
        jmp end_conditional  		; go to end_conditional, always
is_true:
        mov byte [booleano], 0		; move to booleano 0
        mov eax, [counterword]		; move to eax, value of counter size line
        mov [titlesize], eax		; move to titlesize value of eax
        jmp end_conditional		; go to end_conditional, always
end_conditional:
        getmaxsize			; call macro to get max size
        mov eax, [counterword]		; move quantity of 
        sub [counterword], eax          ; size word = 0
        jmp read_loop                   ; go to read loop
end_of_file:
        mov eax, 6                      ; sys call to close a file
        mov ebx, [fd_in]                ; close the file indicates by fd_in value
        int 0x80
        mov eax, 5			; sys call to open a file
        mov ebx, file_name		; string pointing to file name
        mov ecx, 0			; mode (0 = only read)
        mov edx, 0766			; permits
        int 0x80
	show_table                      ; call macro to show tablei
        mov eax, optionmsg		; move optionmsg to eax
        call print_string		; print optionmsg
        call read_int			; call funtion to read a number int
        cmp eax, 0			; compare result of read_int (eax) and 0
        je end				; if are equeals, go to end
        cmp eax, [c]			; comprare result of read_int and max number of option
        jge wrong_option		; if are greater or equal, go to wrong_option
	jl correct_option		; if are less, go to correc_option
        jmp wrong_option		; go to end, always
correct_option:
        mov [option], eax		; move option read to variable option
        mov eax, correct_op_msg		; move to eax correct option message
        call print_string		; print correct option message
        mov eax, [option]		; move to eax option read
        call print_int			; print option read
        call print_nl			; print feed line
        jmp enter_op			; go to enter_op, always
wrong_option:
        mov eax, wrong_op		; move wrong option message to eax
        call print_string		; print wrong option message
        call print_nl			; print feed line
        jmp enter_op			; go to enter_op, always
enter_op:
        mov eax, continue_program	; move contine program message
        call print_string		; print contine program message
	call print_nl
        call read_char			; read char
        call read_char			; needed to read correctly
        cmp eax, 0x0A			; compare char read and feed line 
        je continue_op			; if are equals go to continue_op 
        jne wrong_option		; if no are equals go to wrong_option
continue_op:
        jmp end_of_file			; go to end_of_file, always
end:
        cls				; call macro to clean screen
        mov eax, 6                      ; sys call to close a file
        mov ebx, [fd_in]                ; close the file indicates by fd_in value
        int 0x80
        popa
        mov     eax, 0                  ; return back to C
        leave
        ret

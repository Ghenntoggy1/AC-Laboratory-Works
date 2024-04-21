SYS_WRITE equ 1 ; write text to stdout
SYS_READ equ 0  ; read text from stdin
SYS_EXIT equ 60 ; terminate the program

STDIN_FILE_DESCR equ 0  ; standart input file descriptor

STDOUT_FILE_DESCR equ 1 ; standart output file descriptor
STDERR_FILE_DESCR equ 2 ; standart error file descriptor

; %include "test.asm"

section .data
    random_generated_numbers_message db 'Generated Numbers: ', 0
    welcome_message db 'Enter your choice (1-10, 0 to exit): ', 0
    selected_choice_message db 'Your choice: ', 0

    task_1 db 'Option 1 - Task 1: Concatenate 2 Strings.', 0xa, 0
    task_2 db 'Option 2 - Task 3: Searching for a substring in a string.', 0xa, 0
    task_3 db 'Option 3 - Task 4: Replacing a substring with another substring in a string.', 0xa, 0
    task_4 db 'Option 4 - Task 9: Inverting a string.', 0xa, 0
    task_5 db 'Option 5 - Task 15: Deleting a character from a string.', 0xa, 0
    task_6 db 'Option 6 - Task 18: Converting a Number to a String.', 0xa, 0
    task_7 db 'Option 7 - Task 20: Converting a String to a Real Number.', 0xa, 0
    task_8 db 'Option 8 - Task 35: Generating a random number.', 0xa, 0
    task_9 db 'Option 9 - Task 44: Determining the arithmetic mean of a list of numbers.', 0xa, 0
    task_10 db 'Option 10 - Task 50: Calculating the product of elements in a list of numbers.', 0xa, 0
    exit_0 db 'Option 0 - Exit Program.', 0xa, 0
    selected_option_1 db 'Option 1 selected.', 0xa, 0
    selected_option_2 db 'Option 2 selected.', 0xa, 0
    selected_option_3 db 'Option 3 selected.', 0xa, 0
    selected_option_4 db 'Option 4 selected.', 0xa, 0
    selected_option_5 db 'Option 5 selected.', 0xa, 0
    selected_option_6 db 'Option 6 selected.', 0xa, 0
    selected_option_7 db 'Option 7 selected.', 0xa, 0
    selected_option_8 db 'Option 8 selected.', 0xa, 0
    selected_option_9 db 'Option 9 selected.', 0xa, 0
    selected_option_10 db 'Option 10 selected.', 0xa, 0

    input_string_1_message db 'Input String 1: ', 0
    input_string_2_message db 'Input String 2: ', 0
    output_string_message db 'Output String: ', 0
    string_1_print db 'Your Input String 1: ', 0
    string_2_print db 'Your Input String 2: ', 0

    input_string_message db 'Input String: ', 0
    output_user_string_message db 'Your String: ', 0
    output_inversed_string_message db 'Inversed String: ', 0

    invalid_selected_message db 0, 'Invalid Option Selected.', 0xa, 0
    exit_message db 'Exiting program...', 0xa, 0
    new_line db 0xa

    lower_bound_random_tasks dd 1
    upper_bound_random_tasks dd 55
    lower_bound_input db 'Input Lower Bound: ', 0
    upper_bound_input db 'Input Upper Bound: ', 0
    lower_bound_print db 'Your Input Lower Bound: ', 0
    upper_bound_print db 'Your Input Upper Bound: ', 0
    generated_random db 'Random Generated Number: ', 0
    invalid_bounds_message db 'Lower Bound is Greater than Upper Bound! Input again.', 0xa

    input_substring_message db 'Input Substring: ', 0
    output_substring_message db 'Your Substring: ', 0
    found_substring_message db 'Substring found on index: ', 0
    not_found_substring_message db 'Substring is not found.', 0xa, 0

    input_substring_to_replace_message db 'Input Substring that you want to replace: ', 0
    input_substring_replacement_message db 'Input Replacement Substring: ', 0
    output_substring_to_replace_message db 'To Replace: ', 0
    output_substring_replacement_message db 'Replacement: ', 0
    output_replaced_message db 'Replaced String: ', 0

    input_character_message db 'Input character that will be removed: ', 0
    output_character_message db 'Your character: ', 0
    no_character_found_message db 'This character is not present in the original string', 0xa, 0

section .bss
    user_choice resb 2 ; reserve 2 bytes for User Choice
    buffer resb 22     ; Buffer to hold the resulting string (up to 20 characters + whitespace + null terminator)

    ; Task 1, 4, 3, 9
    string_1 resb 256
    string_2 resb 256
    result_string resb 256*2

    ; Task 35
    lower_bound_task_rnd resq 10
    upper_bound_task_rnd resq 10

    ; Task 4
    string_3 resb 256

    ; Task 5
    character resb 1
section .text
    global _start
_start:
    mov rax, random_generated_numbers_message
    call _print

    mov rsi, 10  ; number of iterations = generated numbers
    mov r8d, [lower_bound_random_tasks]
    mov r9d, [upper_bound_random_tasks]
    call _generateNumbers

    call _menu
    
_menu:
    mov rax, task_1
    call _print
    mov rax, task_2
    call _print
    mov rax, task_3
    call _print
    mov rax, task_4
    call _print
    mov rax, task_5
    call _print
    mov rax, task_6
    call _print
    mov rax, task_7
    call _print
    mov rax, task_8
    call _print
    mov rax, task_9
    call _print
    mov rax, task_10
    call _print
    mov rax, exit_0
    call _print

    ; Print welcome message
    mov rax, welcome_message
    call _print

    ; Call getChoice procedure/subroutine to get the input choice from user
    call _getChoice

    ; Print selected choice message
    mov rax, selected_choice_message
    call _print
    mov rax, user_choice
    call _print
    mov rax, new_line
    call _print

    mov rsi, user_choice
    call _ascii_to_int
    mov r8, rax  ; save choice - might not need it

    cmp rax, 0
    je _exitSuccess
    jl _invalidChoiceSelected
    
    cmp rax, 10
    je _option10Selected
    jg _invalidChoiceSelected

    cmp rax, 1
    je _concatenateTwoStrings

    cmp rax, 2
    je _option2Selected

    cmp rax, 3
    je _option3Selected

    cmp rax, 4
    je _option4Selected

    cmp rax, 5
    je _option5Selected

    cmp rax, 6
    je _option6Selected

    cmp rax, 7
    je _option7Selected

    cmp rax, 8
    je _option8Selected

    cmp rax, 9
    je _option9Selected

; procedure to generate random numbers in range of values stored in r8, r9
; input: r8 - lower bound, r9 - upper bound, rsi - number of generations
; output: print generated random numbers (count = value in rsi)
_generateNumbers:
    rdtsc                        ; Generate another timestamp for more randomness
    xor     rdx, rdx             ; Clearing upper part of rdx for division
    ; mov rcx, r8
    ; mov     rcx, 55 - 1 + 1      
    mov rcx, r9
    sub rcx, r8
    add rcx, 1
    div     rcx                  ; EDX:EAX / ECX --> EAX quotient, EDX remainder
    mov     rax, rdx             ; RAX = [0,54]
    add     rax, r8 ; Adjusting range to [1, 55]

    push rsi

    ; Convert the number to a string
    mov     rdi, buffer          ; Pointer to the buffer for storing the string
    mov     rbx, 10              ; Base 10 for converting to ASCII
    call    _convert_to_string

    ; Print the string
    mov rax, rdi
    call    _print
    pop rsi
    ; Decrement loop counter and loop if not zero
    dec     rsi
    jnz     _generateNumbers

    mov rax, new_line
    call _print
    ret

; Subroutine to convert a number in RAX to a string
; Input: RAX - number to be converted
;        RBX - base (e.g., 10 for decimal)
; Output: RDI - pointer to the resulting string
_convert_to_string:
    mov rsi, buffer + 21     ; Pointer to the end of the buffer
    mov byte [rsi], 0x20     ; Add Whitespace to the end of the generated number string
    mov byte[rsi + 1], 0     ; Add null-termination symbol   
    _convert_loop:
        dec     rsi                  ; Move the pointer backwards
        xor     rdx, rdx             ; Clearing rdx for division
        div     rbx                  ; Divide rax by rbx, remainder in rdx
        add     dl, '0'              ; Convert remainder to ASCII
        mov     [rsi], dl            ; Store ASCII character in the buffer
        test    rax, rax             ; Check if quotient is zero
        jnz     _convert_loop         ; If not zero, continue the loop
        mov     rdi, rsi             ; Set rdi to point to the resulting string
        ret

; subroutine/procedure that prints the string from RAX Register.
; input: RAX as pointer to string.
; output: print string at RAX.
_print:
    push rax   ; save the value of RAX for later
    mov rbx, 0 ; counter of length of the string
_printLoop:
    inc rax        ; increment the value of the char
    inc rbx        ; increment the counter of the length
    mov cl, [rax]  ; holds next value in the string - next char (cl - 8-bit equivalent of a RCX Register)
    cmp cl, 0      ; compare value of char with "0" - terminal Symbol
    jne _printLoop ; jump to _printLoop - enters next iteration

    mov rax, SYS_WRITE          ; move "1" code into RAX for syscall ID for WRITING (ID)
    mov rdi, STDOUT_FILE_DESCR  ; move "1" FILE DESCRIPTOR for STANDART OUTPUT (arg 1)
    pop rsi                     ; pushed RAX - pointer to string, pop into RSI (arg 2)
    mov rdx, rbx                ; move the value stored in rbx (length of the string), into RDX Register (arg 3)
    syscall                     ; call Kernel
    ret                         ; return

; subroutine to get the input from user
; input: nothing
; output: RSI Register contains User Input Choice
_getChoice:
    mov rax, SYS_READ         ; move "0" code into RAX for syscall ID for READING (ID)
    mov rdi, STDIN_FILE_DESCR ; move "0" FILE DESCRIPTOR for STANDART INPUT (arg 1)
    mov rsi, user_choice      ; move "user_choice" into RSI Register (arg 2)
    mov rdx, 2                ; move "2" into RDX Register, which will signify how many characters to take from user (arg 3)
    syscall                   ; call Kernel

    ; Exclude newline character
    ; _loop_newline_elimination_choice:
        mov rsi, user_choice        ; Move the address of user_choice to RSI
        inc rsi                     ; Increment RSI to point to the second character
        cmp byte[rsi], 0xa          ; Compare RSI value in byte form with "\n" in byte form - 0xa
        je _eliminateNextLineSymbol ; If user input contains new line symbol, jump to subroutine that will put "0" symbol - termination symbol
        ; jne _loop_newline_elimination_choice

    ret ; Return

; subroutine to get the input from user
; input: RSI Register contains the variable where to store the string
; output: RSI Register contains User Input String methods
_getStrings_Task:
    mov rax, SYS_READ         ; move "0" code into RAX for syscall ID for READING (ID)
    mov rdi, STDIN_FILE_DESCR ; move "0" FILE DESCRIPTOR for STANDART INPUT (arg 1)
    mov rdx, 256              ; move "256" into RDX Register, which will signify how many characters to take from user (arg 3)
    syscall                   ; call Kernel
    mov r10, 0
    call _loop_newline_elimination
    ret

; Exclude newline character
_loop_newline_elimination:
    inc rsi                     ; Increment RSI to point to the second character
    inc r10
    cmp byte[rsi], 0
    je .end_loop_elimination
    cmp byte[rsi], 0xa          ; Compare RSI value in byte form with "\n" in byte form - 0xa
    je _eliminateNextLineSymbol ; If user input contains new line symbol, jump to subroutine that will put "0" symbol - termination symbol
    jne _loop_newline_elimination
    .end_loop_elimination:
        ret ; Return

    ; subroutine that will eliminate next line symbol from user choice.
    ; input: RSI pointer to next symbol in user choice after digit.
    ; output: RSI pointer to user choice.
    _eliminateNextLineSymbol:
        mov byte [rsi], 0 ; Replace the newline character with null terminator
        sub rsi, r10      ; Decrement RSI Register to point the actual digit choice from user
        ret               ; return

; Procedure to convert ASCII input to integer
; Input: rsi - address of the input buffer containing ASCII digits
; Output: rax - integer value
_ascii_to_int:
    mov rax, 0 ; clear rax
    mov rcx, 0 ; clear rcx (counter)
    _next_digit:
        movzx rdx, byte [rsi + rcx] ; load the next byte from the input buffer
        cmp rdx, 0                  ; check if it's newline character
        je _done_conversion ; if yes, end conversion
        sub rdx, '0'        ; convert ASCII digit to integer
        imul rax, 10        ; multiply current value by 10
        add rax, rdx        ; add the digit to the result
        inc rcx             ; move to the next character
        jmp _next_digit     ; repeat
    _done_conversion:
        ret

_invalidChoiceSelected:
    call _clearInputBuffer
    push rax
    mov rax, invalid_selected_message
    call _print
    pop rax

    jmp _menu

; subroutine that will end the program with ERROR CODE = "0" - Success.
_exitSuccess:
    mov rax, SYS_EXIT ; move "60" code into RAX for syscall ID for EXIT (ID)
    mov rdi, 0        ; move "0" ERROR CODE 0 = NO ERROR (arg 1) 
    syscall           ; call Kernel

_concatenateTwoStrings:
    mov rax, selected_option_1
    call _print

    mov rax, input_string_1_message
    call _print
    mov rsi, string_1
    call _getStrings_Task
    mov r8, string_1

    mov rax, input_string_2_message
    call _print
    mov rsi, string_2
    call _getStrings_Task
    mov r9, string_2

    mov rax, string_1_print
    call _print
    mov rax, string_1
    call _print
    mov rax, new_line
    call _print

    mov rax, string_2_print
    call _print
    mov rax, string_2
    call _print
    mov rax, new_line
    call _print

    mov rsi, string_1  ; Source pointer for the first string
    mov rdi, result_string  ; Destination pointer for the result
    call _copy_string

    ; Find the end of the first string
    mov rcx, 0  ; Counter for the length of the first string
    .find_end_first_string:
        cmp byte [rdi + rcx], 0  ; Check for null terminator
        je .end_find_end_first_string  ; If null terminator is found, end loop
        inc rcx  ; Increment counter
        jmp .find_end_first_string  ; Continue loop
    .end_find_end_first_string:

    mov rsi, string_2
    mov rdi, result_string
    call _append_string

    mov rax, output_string_message
    call _print
    mov rax, result_string
    call _print

    mov rdi, string_1     ; Destination pointer for string_1
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_1

    mov rdi, string_2     ; Destination pointer for string_2
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_2

    mov rdi, result_string ; Destination pointer for output_string
    mov rcx, 512           ; Number of bytes to clear
    rep stosb              ; Clear output_string

    mov rax, new_line
    call _print
    
    jmp _menu

; Function to copy a null-terminated string from source to destination
_copy_string:
    mov rcx, 0
    .copy_loop:
        mov al, [rsi]  ; load a character from the source
        cmp al, 0      ; check if it's the null terminator
        jz .copy_done  ; if yes, we're done
        inc rcx
        mov [rdi], al  ; copy the character to the destination
        inc rsi        ; move to the next character in source
        inc rdi        ; move to the next character in destination
        jmp .copy_loop ; repeat the process
    .copy_done:
        mov byte [rdi], 0 ; add null terminator to the destination
        sub rdi, rcx
        sub rsi, rcx
        ret

; Function to append a null-terminated string from source to destination
_append_string:
    add rdi, rcx
    .append_loop:
        mov al, [rsi]    ; load a character from the source
        cmp al, 0        ; check if it's the null terminator
        jz .append_done  ; if yes, we're done
        inc rcx          ; increment counter register
        mov [rdi], al    ; copy the character to the destination
        inc rsi          ; move to the next character in source
        inc rdi          ; move to the next character in destination
        jmp .append_loop ; repeat the process
    .append_done:
        sub rdi, rcx
        ret    

_option2Selected:
    mov rax, selected_option_2
    call _print

    ; call print_test
    mov rax, input_string_1_message
    call _print
    mov rsi, string_1
    call _getStrings_Task

    call _findLengthString
    mov r8, rcx
    mov rax, output_user_string_message
    call _print
    mov rax, string_1
    call _print
    mov rax, new_line
    call _print

    mov rax, input_substring_message
    call _print
    mov rsi, string_2
    call _getStrings_Task
    call _findLengthString
    mov r9, rcx

    mov rax, output_substring_message
    call _print
    mov rax, string_2
    call _print
    mov rax, new_line
    call _print

    mov rcx, string_1
    mov rdx, string_2
    call _compare_strings
    
    cmp r12, 0
    je .no_substring_found
    jne .substring_is_found
    .no_substring_found: 
        mov rax, not_found_substring_message
        call _print
    .substring_is_found:
        mov rdi, string_1     ; Destination pointer for string_1
        mov rcx, 256          ; Number of bytes to clear
        rep stosb             ; Clear string_1

        mov rdi, string_2     ; Destination pointer for string_2
        mov rcx, 256          ; Number of bytes to clear
        rep stosb             ; Clear string_2
        xor rcx, rcx
        xor rdx, rdx
        xor r8, r8
        xor r9, r9
        xor r10, r10
        xor r11, r11
        xor r12, r12
        jmp _menu

_compare_strings:
    mov r10, 0 ; index of substring found
    mov r11, 0
    mov r12, 0
    ; Compare two null-terminated strings pointed to by rcx and rdx
    .loop:
        mov al, [rcx]
        cmp al, 0
        je .exit_loop
        cmp al, [rdx]
        jne .mismatch
        je .match
        jmp .loop
    .match:
        inc rcx
        inc rdx
        inc r11
        cmp byte [rdx], 0
        je .found_substring
        cmp byte [rcx], 0
        je .exit_loop
        jmp .loop
    .mismatch:
        inc rcx
        inc r10
        jmp .loop
    .found_substring:
        sub rdx, r11
        mov r12, r11
        push rdx
        push rcx
        mov rax, found_substring_message
        call _print
        mov rax, r10
        mov rbx, 10
        
        call _convert_to_string
        mov rax, rdi
        call _print
        mov rax, new_line
        call _print
        pop rcx
        pop rdx
        add r10, r12
        xor r11, r11
        jmp .loop
    .exit_loop:
        ret

_option3Selected:
    mov rax, selected_option_3
    call _print

    mov rax, input_string_message
    call _print
    mov rsi, string_1
    call _getStrings_Task

    call _findLengthString
    mov r8, rcx
    mov rax, output_user_string_message
    call _print
    mov rax, string_1
    call _print
    mov rax, new_line
    call _print

    mov rax, input_substring_to_replace_message
    call _print
    mov rsi, string_2
    call _getStrings_Task
    call _findLengthString
    mov r9, rcx

    mov rax, output_substring_to_replace_message
    call _print
    mov rax, string_2
    call _print
    mov rax, new_line
    call _print

    mov rax, input_substring_replacement_message
    call _print
    mov rsi, string_3
    call _getStrings_Task
    call _findLengthString
    mov r10, rcx

    mov rax, output_substring_replacement_message
    call _print
    mov rax, string_3
    call _print
    mov rax, new_line
    call _print

    mov rsi, string_2
    call _findLengthString
    mov r10, rcx

    mov rcx, string_1
    mov rdx, string_2
    mov rbx, string_3
    mov r8, result_string
    
    ; rcx - original string rdx - original substring rbx - replacement substring r8 - result string
    call _replace_substring

    mov rax, output_replaced_message
    call _print

    ; sub r8, r11
    mov rax, r8
    call _print

    mov rax, new_line
    call _print

    mov rdi, string_1     ; Destination pointer for string_1
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_1

    mov rdi, string_2     ; Destination pointer for string_2
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_2

    mov rdi, string_3     ; Destination pointer for string_2
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_3

    mov rdi, result_string
    mov rcx, 256*2
    rep stosb

    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    xor r14, r14
    jmp _menu

; Procedure to replace a substring from a string with another substring
; Input: rcx - original string
;        rdx - original substring
;        rbx - replacement substring
;        r8  - address where the result string will be stored
; Output: r8 - replaced string
_replace_substring:
    mov r9, 0
    mov r11, 0
    mov r14, 0
    mov r15, 0
    .loop:
        mov al, [rcx]
        cmp al, 0
        je .exit_loop
        cmp al, [rdx]
        jne .mismatch
        je .match
    .match:
        inc rcx ; next symbol in original string
        inc rdx ; next symbol in replaced string
        inc r9
        cmp byte [rdx], 0
        je .found_substring
        jne .not_full_substring
        cmp byte [rcx], 0
        je .exit_loop
        jmp .loop
    .mismatch:
        cmp r15, 0
        jg .restore_substring
        je .not_restore_substring
        .restore_substring:
            mov rdx, string_2
            add rdx, r15
            mov r15, 0
        .not_restore_substring:
            mov [r8], al
            inc rcx
            inc r8
            inc r11
            jmp .loop
        
    .not_full_substring:
        inc r14  ; use r14 counter to verify if full substring
        mov [r8], al
        inc r8
        inc r11
        inc r15
        jmp .loop
    .found_substring:
        sub r8, r14
        sub r11, r14
        xor r14, r14
        mov r13, 0
        mov r15, 0
        .loop_new_substring:
            mov al, [rbx]
            mov [r8], al
            cmp al, 0
            je .end_loop_new_substring
            inc rbx
            inc r8
            inc r11
            inc r13
            jmp .loop_new_substring
        .end_loop_new_substring:
        sub rbx, r13
        sub rdx, r10
        jmp .loop
    .exit_loop:
        sub r8, r11
        ret

_option4Selected:
    mov rax, selected_option_4
    call _print

    mov rax, input_string_message
    call _print
    mov rsi, string_1
    call _getStrings_Task

    mov rsi, string_1
    call _findLengthString ; rsi - string, rcx - length
    
    mov rax, string_1  ; string to be inversed is in RAX register
    add rax, rcx       ; Point to the end of the string
    mov rsi, string_2  ; output string is in RSI Register
    
    mov rsi, string_1
    add rsi, rcx
    sub rsi, 1
    mov rdi, string_2
    call _invert_string
    mov rax, output_inversed_string_message
    call _print
    mov rax, string_2
    call _print

    mov rax, new_line
    call _print

    mov rdi, string_1     ; Destination pointer for string_1
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_1

    mov rdi, string_2     ; Destination pointer for string_2
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_2

    jmp _menu

_invert_string:
    mov r8, rcx
    .invert_loop:
        mov al, [rsi]  ; load a character from the source
        cmp rcx, 0      ; check if it's the null terminator
        jz .invert_done  ; if yes, we're done
        dec rcx
        mov [rdi], al  ; copy the character to the destination
        dec rsi        ; move to the next character in source
        inc rdi        ; move to the next character in destination
        jmp .invert_loop ; repeat the process
    .invert_done:
        mov byte [rdi], 0 ; add null terminator to the destination
        sub rdi, r8
        add rsi, r8
        ret
_findLengthString:
    mov rcx, 0
    mov rdi, rsi
    _loop:
        cmp byte [rdi], 0  ; Check if the current character is null (end of string)
        je _end            ; If null, end the loop

        inc rcx            ; Increment the counter
        inc rdi            ; Move to the next character in the string
        jmp _loop          ; Jump back to the start of the loop
    
    _end:
        ret

_option5Selected:
    mov rax, selected_option_5
    call _print

    mov rax, input_string_message
    call _print
    mov rsi, string_1
    call _getStrings_Task

    mov rax, output_user_string_message
    call _print
    mov rax, string_1
    call _print
    mov rax, new_line
    call _print
    
    mov rax, input_character_message
    call _print
    mov rsi, character
    call _getCharacter_Task
    call _clearInputBuffer
    mov rax, output_character_message
    call _print
    mov rax, character
    call _print
    mov rax, new_line
    call _print

    mov rcx, string_1
    mov rdx, character
    call _delete_character
    
    cmp r9, 0
    je .no_character
    jne .character_found
    .no_character:
        mov rax, no_character_found_message
        call _print
    .character_found:
        mov rax, output_string_message
        call _print
        mov rax, string_2
        call _print
        mov rax, new_line
        call _print
    mov rdi, string_1     ; Destination pointer for string_1
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_1

    mov rdi, string_2     ; Destination pointer for string_2
    mov rcx, 256          ; Number of bytes to clear
    rep stosb             ; Clear string_2

    mov rdi, character    ; Destination pointer for character
    mov rcx, 1            ; Number of bytes to clear
    rep stosb             ; Clear character

    xor rax, rax
    xor rbx, rbx
    xor rdx, rdx
    xor rcx, rcx
    xor r8, r8
    xor r9, r9
    jmp _menu

; subroutine to get the input from user
; input: RSI Register contains the variable where to store the string
; output: RSI Register contains User Input String methods
_getCharacter_Task:
    mov rax, SYS_READ         ; move "0" code into RAX for syscall ID for READING (ID)
    mov rdi, STDIN_FILE_DESCR ; move "0" FILE DESCRIPTOR for STANDART INPUT (arg 1)
    mov rdx, 1                ; move "256" into RDX Register, which will signify how many characters to take from user (arg 3)
    syscall                   ; call Kernel
    mov r10, 0
    call _loop_newline_elimination
    ret

; Procedure that deletes a certain character from the original string input from user
; Input: rcx - original string
;        rdx - character to be deleted
; Output: rbx - new string
_delete_character:
    mov r8, 0
    mov r9, 0
    mov rbx, string_2
    .loop:
        mov al, [rcx]
        cmp al, 0
        je .exit_loop
        cmp al, [rdx]
        jne .continue
        je .delete
    .continue:
        mov [rbx], al
        inc rcx
        inc rbx
        inc r8
        jmp .loop
    .delete:
        inc rcx
        inc r9
        jmp .loop
    .exit_loop:
        sub rbx, r8
        ret

_option6Selected:
    mov rax, selected_option_6
    call _print
    jmp _menu

_option7Selected:
    mov rax, selected_option_7
    call _print
    jmp _menu

_option8Selected:
    xor r8, r8
    xor r9, r9
    mov rax, selected_option_8
    call _print
    _loop_rnd:
        call _getBounds
        mov r8, lower_bound_task_rnd
        mov r9, upper_bound_task_rnd
        cmp r8, r9
        jg _invalidBounds

    mov rsi, lower_bound_task_rnd
    call _ascii_to_int            ; Convert ASCII string to integer
    mov r8, rax

    mov rsi, upper_bound_task_rnd
    call _ascii_to_int            ; Convert ASCII string to integer
    mov r9, rax

    mov rax, generated_random
    call _print
    mov rsi, 1
    call _generateNumbers

    mov rdi, lower_bound_task_rnd     ; Destination pointer for string_1
    mov rcx, 10          ; Number of bytes to clear
    rep stosq             ; Clear string_1

    mov rdi, upper_bound_task_rnd     ; Destination pointer for string_2
    mov rcx, 10          ; Number of bytes to clear
    rep stosq             ; Clear string_2

    jmp _menu

_invalidBounds:
    mov rax, invalid_bounds_message
    call _print
    jmp _loop_rnd
    ret

_getBounds:
        mov rax, lower_bound_input
        call _print
        mov rsi, lower_bound_task_rnd
        call _getBoundRND
        mov rax, lower_bound_print
        call _print
        mov rax, lower_bound_task_rnd
        call _print
        mov rax, new_line
        call _print

        mov rax, upper_bound_input
        call _print
        mov rsi, upper_bound_task_rnd
        call _getBoundRND
        mov rax, upper_bound_print
        call _print
        mov rax, upper_bound_task_rnd
        call _print
        mov rax, new_line
        call _print

        ret

_getBoundRND:
    mov rax, SYS_READ         ; move "0" code into RAX for syscall ID for READING (ID)
    mov rdi, STDIN_FILE_DESCR ; move "0" FILE DESCRIPTOR for STANDART INPUT (arg 1)
    mov rdx, 10               ; move "256" into RDX Register, which will signify how many characters to take from user (arg 3)
    syscall                   ; call Kernel

    mov r10, 0
    call _loop_newline_elimination
    ret ; Return

_option9Selected:
    mov rax, selected_option_9
    call _print
    jmp _menu

_option10Selected:
    call _clearInputBuffer
    mov rax, selected_option_10
    call _print
    jmp _menu
   
; Clear the input buffer
_clearInputBuffer:
    push rax
    mov rax, SYS_READ         ; syscall ID for reading (ID)
    mov rdi, STDIN_FILE_DESCR ; file descriptor for standard input (arg 1)
    mov rsi, user_choice      ; address to store the input (arg 2)
    mov rdx, 2                ; number of characters to read (arg 3)  TODO: ask about correct way to restore the input buffer - when 12345 prompt takes 45 as choice
    syscall                   ; call Kernel
    pop rax
    ret
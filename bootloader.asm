[org 0x7c00]
    xor ax, ax      ; Clear ax
    mov ds, ax      ; Set data segment to 0
    mov es, ax      ; Set extra segment to 0
    mov si, msg     ; Set si to point to the message
    call main     ; Call print function
    jmp $           ; Infinite loop

main:
	mov ax, 0x07C0  ; Set up data segment
	mov ds, ax
	mov es, ax
	
	mov si, hello_msg   ; Print a welcome message
	call print_string
	
	mov si, prompt_msg  ; Print a prompt message
	call print_string
	
	call read_char	  ; Read a character from keyboard
	
	mov si, newline	 ; Move cursor to the next line
	call print_string
	
	mov si, echo_msg	; Print the character that was entered
	call print_string
	
	call print_char	 ; Print the character
	
	jmp $
print_string:
	lodsb			   ; Load the next characterMore actions
	or al, al		   ; Check for null terminator
	jz end_print_string ; If null, end of string
	
	call print_char	 ; Print the character
	jmp print_string	; Repeat for the next character
	
end_print_string:
	ret

; Print a character in AL
print_char:
	mov ah, 0x0E		; BIOS teletype function
	int 0x10			; Call BIOS interrupt
	
	ret

; Read a character from the keyboard
read_char:
	mov ah, 0		   ; BIOS keyboard input function
	int 0x16			; Call BIOS interrupt
	
	ret

; Data section

hello_msg db "Welcome to My Bootloader!", 0
prompt_msg db "Enter a character: ", 0
echo_msg db "You entered: ", 0
newline db 0x0D, 0x0A, 0

times 510-($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0xaa55 ; Boot signature

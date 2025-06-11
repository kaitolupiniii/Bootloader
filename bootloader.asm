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
print:
    lodsb           ; Load character from si into al
    or al, al       ; Check for null terminator
    jz done         ; If null terminator, jump to done
    mov ah, 0x0e    ; Set teletype mode
    int 0x10        ; Call BIOS interrupt to print character
    jmp print       ; Loop back to print next character
done:
    ret

msg:
    db "Hello, World!", 0 ; Null-terminated message string

times 510-($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0xaa55 ; Boot signature

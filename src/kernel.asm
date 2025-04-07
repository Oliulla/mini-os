[org 0x1000]
bits 16

start:
    mov si, msg

print_loop:
    lodsb           ; load byte from [si] into AL
    or al, al
    jz hang
    mov ah, 0x0E    ; teletype BIOS print
    int 0x10
    jmp print_loop

hang:
    cli
    hlt             ; stop

msg db "Welcome to MiniOS!", 0

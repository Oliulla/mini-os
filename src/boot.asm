[org 0x7C00]       ; BIOS loads the bootloader here
bits 16

start:
    cli            ; disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; load second sector (our kernel) into memory at 0x1000
    mov ah, 0x02    ; BIOS read sector
    mov al, 1       ; # of sectors
    mov ch, 0       ; cylinder
    mov cl, 2       ; sector (starts at 1)
    mov dh, 0       ; head
    mov dl, 0x80    ; first hard drive
    mov bx, 0x1000  ; buffer segment
    int 0x13        ; BIOS disk interrupt

    ; jump to kernel
    jmp 0x0000:0x1000

times 510 - ($ - $$) db 0  ; pad to 510 bytes
dw 0xAA55                 ; boot signature

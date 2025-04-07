; boot.asm - Loads kernel and jumps to it
[org 0x7C00]

mov [BOOT_DRIVE], dl

; Load kernel from disk (just one sector for now)
mov ah, 0x02
mov al, 1
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, [BOOT_DRIVE]
mov bx, 0x8000
int 0x13

jmp 0x0000:0x8000

BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xAA55

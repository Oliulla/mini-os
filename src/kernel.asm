; kernel.asm
[org 0x8000]

mov si, message
call print_string

.loop:
    call get_key
    call print_char
    jmp .loop

; --- print_string: prints a null-terminated string at [si]
print_string:
    lodsb
    or al, al
    jz .done
    call print_char
    jmp print_string
.done:
    ret

; --- print_char: print AL to screen
print_char:
    mov ah, 0x0E
    int 0x10
    ret

; --- get_key: wait for a key press and return ASCII in AL
get_key:
    in al, 0x64         ; check if key is ready
    test al, 1
    jz get_key          ; not ready? try again

    in al, 0x60         ; read scan code

    ; Simple US QWERTY map (just a few keys)
    cmp al, 0x1E        ; A
    je .A
    cmp al, 0x30        ; B
    je .B
    cmp al, 0x2E        ; C
    je .C
    cmp al, 0x39        ; SPACE
    je .SPACE
    jmp get_key

.A:
    mov al, 'A'
    ret
.B:
    mov al, 'B'
    ret
.C:
    mov al, 'C'
    ret
.SPACE:
    mov al, ' '
    ret

message db "Type A, B, C or SPACE!", 0

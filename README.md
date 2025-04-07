🔥 Love it. **OS development in Assembly** is one of the most mind-blowing, empowering projects you can do as a low-level programmer. You go from “hello world” to **booting your own OS in QEMU or on real hardware** — no Linux, no Windows, just _your code_ talking directly to the machine.

---

### 🛠️ Your First OS Project: **"MiniOS"**

You'll start with:

- A **bootloader** (in pure 16-bit x86 Assembly)
- That loads a **kernel**
- And prints something to the screen (no OS needed)

---

### ✅ What You’ll Build (Phase 1)

**Goal:** Make your PC boot your custom OS and show `"Welcome to MiniOS!"` in real mode.

---

### 📁 Folder Structure

```
mini-os/
├── boot.asm         ; bootloader (512 bytes)
├── kernel.asm       ; kernel to load and run
├── Makefile         ; build into a bootable .iso
```

---

### 🔥 boot.asm (Bootloader)

```asm
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
```

---

### 🧠 kernel.asm (Loaded by bootloader)

```asm
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
```

---

### 🛠️ Makefile

```makefile
all: mini-os.img

mini-os.img: boot.bin kernel.bin
	cat boot.bin kernel.bin > mini-os.img

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.asm
	nasm -f bin kernel.asm -o kernel.bin

clean:
	rm -f *.bin *.img
```

---

### 🚀 Run it in QEMU

```bash
make
qemu-system-i386 -fda mini-os.img
```

You should see:

```
Welcome to MiniOS!
```

---

### 🧭 Next Steps After This

Once Phase 1 works, you can:

- Add keyboard input (using BIOS interrupt 0x16)
- Switch to **32-bit protected mode**
- Write a memory manager
- Build a tiny filesystem
- Write a shell

---

### ⚡️ Want me to guide you through Phase 2 (Protected Mode)?

Let me know — I can walk you through enabling 32-bit mode and writing a more complex kernel. It’s where things get really exciting.

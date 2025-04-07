all: mini-os.img

mini-os.img: boot.bin kernel.bin
	cat boot.bin kernel.bin > mini-os.img

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.asm
	nasm -f bin kernel.asm -o kernel.bin

clean:
	rm -f *.bin *.img

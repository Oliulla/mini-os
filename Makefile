SRC=src
BUILD=build

all: $(BUILD)/mini-os.img

$(BUILD)/mini-os.img: $(BUILD)/boot.bin $(BUILD)/kernel.bin
	cat $(BUILD)/boot.bin $(BUILD)/kernel.bin > $(BUILD)/mini-os.img

$(BUILD)/boot.bin: $(SRC)/boot.asm
	nasm -f bin $(SRC)/boot.asm -o $(BUILD)/boot.bin

$(BUILD)/kernel.bin: $(SRC)/kernel.asm
	nasm -f bin $(SRC)/kernel.asm -o $(BUILD)/kernel.bin

clean:
	rm -f $(BUILD)/*.bin $(BUILD)/*.img

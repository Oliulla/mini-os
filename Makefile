ASM=nasm
SRC=src
BUILD=build

all: $(BUILD)/mini-os.img

$(BUILD)/mini-os.img: $(BUILD)/boot.bin $(BUILD)/kernel.bin
	cat $(BUILD)/boot.bin $(BUILD)/kernel.bin > $(BUILD)/mini-os.img

$(BUILD)/boot.bin: $(SRC)/boot.asm
	$(ASM) -f bin $< -o $@

$(BUILD)/kernel.bin: $(SRC)/kernel.asm
	$(ASM) -f bin $< -o $@

clean:
	rm -f $(BUILD)/*.bin $(BUILD)/mini-os.img

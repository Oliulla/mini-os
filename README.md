## Mini-OS Documentation

### Overview

Mini-OS is a simple bootable operating system kernel written in assembly. The system loads a kernel from a disk and displays a message to the user, prompting them to type specific characters. The kernel processes keypresses (A, B, C, and space) and prints the corresponding character to the screen. The system supports basic keyboard input and output via BIOS interrupts.

### Features

- **Bootloader**: A bootloader (boot.asm) that loads the kernel from disk.
- **Kernel**: A simple kernel (kernel.asm) that interacts with the user through the screen.
- **User Input**: The kernel waits for user input, displays corresponding characters for `A`, `B`, `C`, and `SPACE`.
- **Assembly Code**: The OS is written in x86 Assembly Language using NASM syntax.

### Files

1. **boot.asm**: The bootloader code responsible for loading the kernel from disk.
2. **kernel.asm**: The kernel code that displays a message and handles user input.
3. **Makefile**: A script to compile the bootloader and kernel into a bootable image.

### Prerequisites

Before you can use Mini-OS, ensure you have the following tools installed on your system:

- **NASM (Netwide Assembler)**: A powerful assembler used to compile the assembly code.
- **QEMU**: An emulator to run the bootable image and test the operating system.
- **Make**: A build automation tool to handle the compilation process.

### Steps to Build Mini-OS

1. **Clone or Download the Source Code**

   Make sure you have the source code in the appropriate directory structure. The basic structure should look like this:

   ```
   mini-os/
   ├── Makefile
   ├── src/
   │   ├── boot.asm
   │   └── kernel.asm
   └── build/
       ├── mini-os.img (generated)
       ├── boot.bin (generated)
       └── kernel.bin (generated)
   ```

2. **Install Prerequisites**

   Install the required tools on your system:

   - **NASM**: Install NASM to assemble the code.

     ```bash
     sudo apt-get install nasm
     ```

   - **QEMU**: Install QEMU to test the bootable image.

     ```bash
     sudo apt-get install qemu
     ```

   - **Make**: Install `make` to automate the build process.
     ```bash
     sudo apt-get install make
     ```

3. **Build the OS Image**

   To compile the Mini-OS, run the following command from the root of your project directory:

   ```bash
   make
   ```

   This command compiles the `boot.asm` and `kernel.asm` files into binary files (`boot.bin` and `kernel.bin`) and then combines them into a bootable image (`mini-os.img`) located in the `build/` directory.

4. **Clean Up the Build Artifacts**

   To clean up the generated files (binary and image), you can use the following command:

   ```bash
   make clean
   ```

   This will remove all files in the `build/` directory with `.bin` and `.img` extensions.

### Running Mini-OS

After building the bootable image, you can run Mini-OS in QEMU to test it.

1. **Run the Image in QEMU**

   Use the following command to boot the image in QEMU:

   ```bash
   qemu-system-i386 -fda build/mini-os.img
   ```

   This command will start QEMU with the `mini-os.img` file as the floppy disk (`-fda`), simulating the system boot.

   **Note**: If you encounter warnings about the image format or block devices, you can specify the `-drive format=raw` option explicitly:

   ```bash
   qemu-system-i386 -fda build/mini-os.img -drive format=raw
   ```

2. **Interact with the OS**

   Once the Mini-OS is booted, the following message will be displayed:

   ```
   Type A, B, C or SPACE!
   ```

   You can then type the following keys:

   - **A**: Displays `A` on the screen.
   - **B**: Displays `B` on the screen.
   - **C**: Displays `C` on the screen.
   - **Space**: Displays a space on the screen.

3. **Exit the OS**

   The OS does not yet support an explicit exit or shutdown. You can manually close the QEMU window to stop the simulation.

### Explanation of Key Components

1. **boot.asm** (Bootloader)

   The bootloader is responsible for loading the kernel from disk and jumping to it. It is stored in the first sector of the disk. The bootloader performs the following tasks:

   - Loads the kernel from the disk into memory at address `0x8000`.
   - Jumps to the kernel code to start execution.

2. **kernel.asm** (Kernel)

   The kernel is a simple program that:

   - Clears the screen using BIOS interrupt `0x10` and an escape sequence.
   - Displays a message to the user: `"Type A, B, C or SPACE!"`.
   - Waits for a keypress using the `get_key` function.
   - Responds to keypresses by displaying the corresponding character on the screen (A, B, C, SPACE).

3. **Makefile**

   The Makefile automates the build process for the bootloader and kernel. It contains the following rules:

   - **all**: Builds the final `mini-os.img` by combining the bootloader and kernel binaries.
   - **$(BUILD)/boot.bin**: Assembles the bootloader (`boot.asm`) into a binary file.
   - **$(BUILD)/kernel.bin**: Assembles the kernel (`kernel.asm`) into a binary file.
   - **clean**: Cleans up the build directory by removing generated `.bin` and `.img` files.

### Future Enhancements

- **Support More Keypresses**: Extend the `get_key` function to support more keys (e.g., Enter, Backspace).
- **Add More System Features**: Implement basic memory management, task scheduling, and file handling.
- **Error Handling**: Add error messages or logging to help diagnose problems during execution.
- **Interactive Interface**: Implement a more complex interactive interface with menus, user input validation, etc.

### Conclusion

Mini-OS is a basic example of an operating system kernel written in assembly. It demonstrates essential OS features like bootloading, keyboard input handling, and screen output. You can extend it further to add more complex functionality as you explore OS development and assembly programming.

# fusionOS - Pre-Beta Bootloader Snippets

## Disclaimer
These code snippets represent the **very first version** of the fusionOS bootloader. They are legacy materials originating from an early development phase over a year ago. 

Because this is an initial prototype, please be aware that **multiple bugs and logical errors** are present in this code. While these issues were addressed in later versions of the project, they remain here in their original state for archival and educational purposes.

**This repository does not include the actual fusionOS operating system or its setup routines.**

## Repository Contents
To provide full transparency and allow for immediate testing/study, the following files are included:
- **`bootloader.asm`**: The Stage 1 assembly source code (MBR).
- **`stage2.asm`**: The Stage 2 assembly source code (Menu & Protected Mode logic).
- **`Makefile`**: The build script used to compile and link the components.
- **`fusionos-boot.img`**: The final pre-compiled 10MB binary image.

## Purpose and Usage
This repository is intended for those who wish to examine the raw source code or virtualize the bootloader within a **QEMU environment**. It demonstrates:
- The early transition logic from 16-bit Real Mode to 32-bit Protected Mode.
- A BIOS-based boot menu and the initial ASCII splash screen.
- Basic sector loading using BIOS interrupts.

## Testing Functionality
Since the actual fusionOS kernel is not included in this repository, the boot process will intentionally halt or loop after a menu selection is made. 

To test the chainloading capabilities (e.g., booting into Linux, Windows, or other ISOs), you must provide your own **ISO files of other operating systems**. You will need to manually configure your environment to point to these external files.

## How to Build and Virtualize
If you wish to compile the code from the provided source:
1. Install `nasm` and `qemu-system-x86`.
2. Run `make` to re-generate the binary files and the 10MB image.
3. Run `make test` to launch the virtual environment using QEMU.

---
*Developed as the initial foundation for fusionOS research.*

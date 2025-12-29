# FusionOS Bootloader Build System
# Kompiliert den Bootloader in eine bootfähige Binary

ASM = nasm
DD = dd
QEMU = qemu-system-x86_64

STAGE1 = stage1.bin
STAGE2 = stage2.bin
IMAGE = fusionos-boot.img

.PHONY: all clean test usb info

all: $(IMAGE)

# Stage 1: MBR Bootloader (512 Bytes)
$(STAGE1): bootloader.asm
	@echo "Building Stage 1 Bootloader..."
	$(ASM) -f bin -o $(STAGE1) bootloader.asm
	@echo "✓ Stage 1 compiled (512 bytes)"

# Stage 2: Erweiterter Loader
$(STAGE2): stage2.asm
	@echo "Building Stage 2 Loader..."
	$(ASM) -f bin -o $(STAGE2) stage2.asm
	@echo "✓ Stage 2 compiled"

# Bootfähiges Image erstellen
$(IMAGE): $(STAGE1) $(STAGE2)
	@echo "Creating bootable image..."
	$(DD) if=/dev/zero of=$(IMAGE) bs=1M count=10 2>/dev/null
	$(DD) if=$(STAGE1) of=$(IMAGE) conv=notrunc 2>/dev/null
	$(DD) if=$(STAGE2) of=$(IMAGE) seek=1 conv=notrunc 2>/dev/null
	@echo "✓ Bootloader built successfully: $(IMAGE)"
	@ls -lh $(IMAGE)

# In QEMU testen
test: $(IMAGE)
	@echo "Testing in QEMU..."
	@echo "Press Ctrl+Alt+G to release mouse, Ctrl+C to quit"
	$(QEMU) -drive format=raw,file=$(IMAGE) -m 512M

# Auf USB schreiben (VORSICHT!)
usb: $(IMAGE)
	@echo "⚠️  WARNING: This will overwrite ALL data on the USB device!"
	@read -p "Enter USB device name (e.g., sdb): " device && \
	echo "You entered: /dev/$$device" && \
	read -p "Are you ABSOLUTELY sure? Type 'YES' to continue: " confirm && \
	if [ "$$confirm" = "YES" ]; then \
		sudo dd if=$(IMAGE) of=/dev/$$device bs=4M status=progress && \
		sudo sync && \
		echo "✓ Bootloader written to /dev/$$device"; \
	else \
		echo "Cancelled."; \
	fi

clean:
	@echo "Cleaning build files..."
	rm -f $(STAGE1) $(STAGE2) $(IMAGE)
	@echo "✓ Clean complete"

info:
	@echo "══════════════════════════════════════"
	@echo "  FusionOS Bootloader Build System"
	@echo "══════════════════════════════════════"
	@echo ""
	@echo "Build targets:"
	@echo "  make         - Build bootloader"
	@echo "  make test    - Test in QEMU"
	@echo "  make usb     - Write to USB (DANGEROUS!)"
	@echo "  make clean   - Clean build files"
	@echo "  make info    - Show this help"
	@echo ""
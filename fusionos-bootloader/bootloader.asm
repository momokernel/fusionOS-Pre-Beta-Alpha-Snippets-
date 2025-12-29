[BITS 16]
[ORG 0x7C00]

start:
    cli                     ; Interrupts aus für Setup
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Lade Stage 2 (15 Sektoren ab Sektor 2)
    mov ah, 0x02
    mov al, 15
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov bx, 0x7E00
    int 0x13
    jc disk_error

    jmp 0x0000:0x7E00       ; Far Jump um CS zu setzen

disk_error:
    mov si, err_msg
    mov ah, 0x0E
.loop:
    lodsb
    test al, al
    jz .halt
    int 0x10
    jmp .loop
.halt:
    hlt
    jmp .halt

err_msg db "Disk Error!", 0

times 510-($-$$) db 0
dw 0xAA55
[BITS 16]
[ORG 0x7E00]

stage2_entry:
    call display_splash
    call display_menu
    call wait_for_input
    ret                     ; Sicherheits-Ret

; --- Menü Logik ---
display_splash:
    mov si, splash_msg
    call print_string
    ret

display_menu:
    mov si, menu_header
    call print_string
    mov si, menu_fusionos
    call print_string
    ; ... weitere Menüpunkte hier einfügen ...
    ret

wait_for_input:
    mov ah, 0x00
    int 0x16
    cmp al, '1'
    je switch_to_pm
    jmp wait_for_input

switch_to_pm:
    cli
    call enable_a20
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode_start

enable_a20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

print_string:
    mov ah, 0x0E
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

; --- Daten Bereich ---
splash_msg db "      ______           _             ____   _____  ", 13, 10
          db "     |  ____|         (_)           / __ \ / ____| ", 13, 10
          db "     | |__ _   _ ___  _  ___  _ __ | |  | | (___   ", 13, 10
          db "     |  __| | | / __|| |/ _ \| '_ \| |  | |\___ \  ", 13, 10
          db "     | |  | |_| \__ \| | (_) | | | | |__| |____) | ", 13, 10
          db "     |_|   \__,_|___/|_|\___/|_| |_|\____/|_____/  ", 13, 10
          db "          Universal Bootloader v0.1.0-beta         ", 13, 10, 0

menu_header db 13, 10, "  [ FusionOS Boot Manager ]", 13, 10, 0
menu_fusionos db "  [1] Boot FusionOS (Protected Mode)", 13, 10, 0

; --- Protected Mode (32-bit) ---
[BITS 32]
protected_mode_start:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov esp, 0x90000
    
    ; VGA "FusionOS" Text
    mov edi, 0xB8000
    mov dword [edi], 0x0F460F75 ; 'uF'
    jmp $

; --- GDT ---
gdt_start:
    dq 0x0
gdt_code:
    dq 0x00CF9A000000FFFF
gdt_data:
    dq 0x00CF92000000FFFF
gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

times 7680-($-$$) db 0
[org 0x7c00]      






getChar:
    ;db 0
    mov ah, 0
    int 0x16
    ;mov [bx], al
    jmp showChar

showChar:
    
    mov ah, 0x0e
    
    cmp al, 13
    je exit
    int 0x10
    jmp getChar



exit:
    jmp $


times 510-($-$$) db 0  
db 0x55, 0xaa          
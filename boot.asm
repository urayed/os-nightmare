[org 0x7c00]      

newLine:
    mov ah, 0x0e
    mov al, 13      
    int 0x10
    mov al, 10      
    int 0x10
    mov al, '>'
    int 0x10
    jmp clearBuffer



buffer:

    times 10 db 0
    mov bx, buffer
    jmp getChar

clearBuffer: 
    mov cx, 10
    mov di, buffer
    jmp clearLoop

clearLoop: 
    mov byte [di], 0
    inc di
    loop clearLoop
    jmp buffer

getChar:
    mov ah, 0
    int 0x16
    
    jmp showChar

showChar:
    
    mov ah, 0x0e

    cmp al, 13
    je preparePrint

    int 0x10

    cmp bx, buffer + 9
    jae preparePrint

    jmp addCharToBuffer
    

addCharToBuffer:
    mov [bx], al
    inc bx
    jmp getChar

preparePrint:
    mov ah, 0x0e
    mov bx, buffer
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    jmp print

print:
    

    cmp bx, buffer + 9
    jae newLine

    mov al, [bx]
    int 0x10
    inc bx
    jmp print


exit:
    jmp $


times 510-($-$$) db 0  
db 0x55, 0xaa          
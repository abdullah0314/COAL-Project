
include emu8086.inc
.model small
.stack 100h
.data 
msg db '     -----------------String Reversal & Palindrome Checker-----------------$'
string db 20
       db ?
       db 20 dup('$') 
.code

;=========Reverse Procedure=========

reverse proc
    mov si, offset string+2
    mov al, [string+1]    
    dec al                 
    mov ah, 0
    mov di, offset string+2       
    add di, ax 
    
    print 'Reverse String is: '
    rev_loop:
    cmp si, di
    jge end
    
    mov al, [si]
    mov bl, [di]
    mov [si], bl
    mov [di], al 
    
    inc si
    dec di 
    
    jmp rev_loop
    
    end:       
    mov bl, [string+1]
    xor bh, bh
    mov byte ptr[string+2+bx], '$'
    
    mov dx, offset string+2
    mov ah, 09h
    int 21h
    ret
reverse endp

;=========Palindrome Checking Procedure=========

palindrome proc
    mov si, offset string+2
    mov al, [string+1]    
    dec al                 
    mov ah, 0
    mov di, offset string+2       
    add di, ax 
     
    loop:
    mov al, [si]
    cmp al, [di]
    jne not_palindrome
    
    cmp si, di
    jge palindrom                

    inc si
    dec di
    jmp loop     

    not_palindrome:
    printn 'String is not a Palindrome'
    ret

    palindrom:
    printn 'String is a Palindrome'
    ret
palindrome endp

;=========Main Procedure=========

main proc
    mov ax, @data
    mov ds, ax  
    mov dx, offset msg
    mov ah, 09h
    int 21h           
    
    printn
    printn
    
    print 'Enter a String: '
    mov dx, offset string
    mov ah, 0ah
    int 21h  
      
    printn
    
    print 'Original String is: '
    mov bl, [string+1]
    xor bh, bh
    mov byte ptr[string+2+bx], '$'
    
    mov dx, offset string+2
    mov ah, 09h
    int 21h   
     
    printn
    call reverse
    printn
    call palindrome
    
    mov ah, 4ch
    mov al, 0
    int 21h
main endp
end main
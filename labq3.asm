[org 0x100]

jmp start 

data:   dw  60, 55, 45, 50 
swapflag:   db  0 


swap: 
    push ax  
   ; push cx   
                               
    mov  ax, [bx + si]         
    xchg ax, [bx + si + 2]     
    mov  [bx + si], ax         
                               
    dec  cx                    
    ; do some storage here       
    ; pop cx    
    pop ax   

    ret       


bubblesort: 
    push ax         ; three new pushes 
    push cx 
    push si 


    dec  cx 
    shl  cx, 1                   

    mainloop:  
        mov  si, 0                   
        mov  byte[swapflag], 0       

        innerloop: 
            mov  ax, [bx + si]
            cmp  ax, [bx + si + 2]
            jbe  noswap 

               call swap    
               mov  byte[swapflag], 1

            noswap: 
            add  si, 2 
            cmp  si, cx
            jne  innerloop

        cmp  byte[swap], 1 
        je   mainloop 


    pop si 
    pop cx 
    pop ax 
    ret    
start: 
    mov  bx, data 
    mov  cx, 4 

    call bubblesort 

    mov ax, 0x4c00 
    int 0x21 
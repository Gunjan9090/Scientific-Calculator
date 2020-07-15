    data segment
    ten dw 10d 
 
    a dw ?
    b dw ?
    c dw ?
    d dw ?  
    wellcome db ' Welcome',13, 10 ,'$'
    exit    db 'Press any otherkey to terminate',13,10,'$'
    select db 'Select an option',13,10,'$'
    option1 db 'a=Addition',13,10,'$'
    option2 db 'b=Subtraction',13,10,'$'
    option3 db 'c=Multiplication',13,10,'$'
    option4 db 'd=Division',13,10,'$'
    option5 db 'e=Power_2',13,10,'$'
    option6 db 'f=Power_3',13,10,'$'
    option7 db 'g=Power_n',13,10,'$'
    option8 db 'h=Factorial',13,10,'$'
 
                                                                                                             
    enter_number1 db 'Enter first number:','$'
    enter_number2 db 'Enter second number:','$'
    answer db 'Answer= ','$'
    nextline db 13,10,'$'
   
    enter_cnum1_a db "Enter number on a:",13,10,'$'
    enter_cnum1_b db "Enter number on b:",13,10,'$'
    enter_cnum2_c db "Enter number on c:",13,10,'$'
    enter_cnum2_d db "Enter number on d:",13,10,'$'
ends

stack segment
    dw  128 dup(0)
ends

code segment 
    print    MACRO c  
            push    ax
            mov     al, c
            mov     ah, 0x0E
            int     0x10     
            pop     ax
    ENDM

    start:
        push ax      
        mov ax,data
        mov ds,ax
        mov es,ax    
        pop ax     
        
        mov di,0
   menu:
        lea dx, wellcome
        call print_line
        
  

        lea dx, option1
        call print_line   
       
        lea dx, option2
        call print_line   
       
        lea dx, option3
        call print_line   
       
        lea dx, option4
        call print_line   
       
        lea dx, option5
        call print_line   
       
        lea dx, option6
        call print_line
        
        lea dx, option7
        call print_line   
       
        lea dx, option8
        call print_line   
       

        lea dx, exit
        call print_line
     
        lea dx, select
        call print_line   
     
  
        call get_choice ;     
        cmp al,61h
        je addition:
        
        cmp al,62h
        je subtraction:
        
        cmp al,63h        
        je multiplication:
        
        cmp al,64h
        je division:      
                     
        cmp al,65h
        je power_2:
        
        cmp al,66h
        je power_3:
        
        cmp al,67h
        je power_n:
        
        cmp al,68h
        je factorial:


     end:  
    MOV  AH, 00h;wait for any key
    INT  16h
       
    mov ax, 0x4c00; terminating 
    int 21h                                                        
;##################################
;###clearing sub routine###########
;##################################
  clear_screen:
    pusha
    MOV  AH, 00h;wait for any key
    INT  16h
    
    mov ax,0xb800 
    mov es,ax 
    xor di,di 
    xor ax,ax 
    mov cx,2000d 
    cld 
    rep stosw
    popa      
  ret
 ;#################################################################
 ;Following functions are for power_2,power_3,power_n
 ;#################################################################
    power_2:
     pusha
        call print_nextline
        lea dx,enter_number1
        call print_line 
    
        call get_operand
        push ax;saving first operand
        call print_nextline 
        
        mov bx,2
        pop ax;first
      
        cmp bx,1
        je  raised_to_power2_1
        mov cx,bx
        mov bx,ax
        dec cx
        loop_pow2: 
            mul bx  
            dec cx
            jnz loop_pow2
        raised_to_power2_1:
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa  
      call  clear_screen
  call  clear_screen
  jmp   menu   
    power_3:
     pusha
        call print_nextline
        lea dx,enter_number1
        call print_line 
    
        call get_operand
        push ax;saving first operand
        call print_nextline 
        
        mov bx,3
        pop ax;first
      
        cmp bx,1
        je  raised_to_power3_1
        mov cx,bx
        mov bx,ax
        dec cx
        loop_pow3: 
            mul bx  
            dec cx
            jnz loop_pow3
        raised_to_power3_1:
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa 
    call  clear_screen
    jmp   menu
  power_n:
        pusha
      
       call get_two_values ;provides values in ax and bx
         push bx
         push ax
        pop bx;second
        pop ax;first
      
        cmp bx,1
        je  raised_to_power_1
        mov cx,bx
        mov bx,ax
        dec cx
        loop: 
            mul bx  
            dec cx
            jnz loop
        raised_to_power_1:
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa 
    call  clear_screen
   jmp   menu
   
 factorial:
        pusha
        call print_nextline
        lea dx,enter_number1
        call print_line 
    
        call get_operand
        push ax;saving first operand
        call print_nextline 
        
        pop ax;first
      
        cmp ax,1
        je  factorial_answer
        cmp ax,0
        je  factorial_0
     
        mov bx,ax
        dec bx     
        
        fact: 
            mul bx  
            dec bx
            jz factorial_answer
            jmp fact 
        factorial_0:
         mov ax,1
        factorial_answer:
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa 
    call  clear_screen
    jmp   menu
 ;#################################################################
 ;Following functions are for integer add, sub, multi and divide   
 ;#################################################################       
    addition:    
    pusha
       call get_two_values ;provides values in ax and bx
  
        add ax,bx  
        
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa 
  call  clear_screen
  jmp   menu    
    subtraction:
        pusha
  
       call get_two_values ;provides values in ax and bx  
       push ax
       push bx
       call print_nextline 
        lea dx,answer
        call print_line      
        pop bx
        pop ax
       call  do_subtraction
        popa
    call  clear_screen
    jmp   menu
    
    multiplication:
        pusha
       
       call get_two_values ;provides values in ax and bx 
        mul bx  
        
        push ax;saving answer on stack         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop ax;getting answer back   
        call print_number
        popa
    call  clear_screen
    jmp   menu 
    
    division:
        pusha
     
       call get_two_values ;provides values in ax and bx
       div bx  
        
        push ax;saving answer on stack
        push dx         
        call print_nextline 
        
        lea dx,answer
        call print_line 
        
        pop dx;getting answer back   
        pop  ax
        push dx
        call print_number
        print 'R'
        print '='
        pop dx
        mov ax,dx
        
        call print_number
        
        popa
  call  clear_screen
  jmp   menu

 
;#####################################  
;#####these routines take input#####
;#####################################

 get_two_values:             
            ;printing nextline
            lea dx,nextline
            mov ah, 9
            int 21h
        lea dx,enter_number1
            ;printing the line
            mov ah, 9
            int 21h
            ;printing nextline
            lea dx,nextline
            mov ah, 9
            int 21h
    
        call get_operand
        push ax;saving first operand
            ;printing nextline
            lea dx,nextline
            mov ah, 9
            int 21h
        
        lea dx,enter_number2
            ;printing the line
            mov ah, 9
            int 21h
            ;printing nextline
            lea dx,nextline
            mov ah, 9
            int 21h
        xor bx,bx;clearing bx
        call get_operand
        pop bx;getting first operand
   
ret

;#####################################  
;#####this routine prints numbers#####
;#####################################
    print_number:   
        mov cx,0;cx keeps count of digits, it will be used while printing
        loop1:;loop1 stores each digit seperately in stack
            inc cx 
            mov dx,0
            
            div ten
            push dx
            cmp al,0
        jne loop1
        loop2:;loop2 pops all digits and prints them
            pop ax 
            add al,48 ;converting to ascii code for displaying.
            print al ; using macro to display
            dec cx
            jz print_complete
            jmp loop2
            print_complete:
    ret 

                                      
;#####################################
;#####this subroutine prints a line###
;#####################################    
    print_line: 
            ;printing the line
           mov bl,063  ;desired color
           mov ah, 9 
           mov al,0  
           int 21h 
           mov bx,0  ;avoding printing of color attribute
 ret 
;#####################################
;#####this subroutine prints a line###
;#####################################    
    print_nextline:;this subroutine prints a line
           lea dx,nextline
            mov ah, 9
            int 21h
    ret                               
;#####################################
;this subroutine takes input from keyboard#
;#####################################
    get_choice:
        ;get input from keyboard
        MOV     AH, 00h
        INT     16h
        ;print the input on screen
        MOV     AH, 0Eh
        INT     10h
    ret                               
    
;#####################################
;#####this subroutine takes number/operand from keyboard#####  
;#####################################
    get_operand:
        ;get input from keyboard
        MOV     AH, 00h
        INT     16h
        ;print the input on screen
        push ax
        MOV  AH, 0Eh
        INT  10h
        pop ax    
            cmp al,13;check if enter is pressed
        je input_complete
            xor ah,ah ;clearing ah
            sub al,30h;getting actual value
        push ax;storing ax
            mov ax,bx
            mul ten
            mov bx,ax
            pop ax
            add bx,ax 
        jmp get_operand
        input_complete: 
     
        mov ax,bx;value is returned in ax
       xor bx,bx
    ret          
  ;  #make seperate sub routine for subtraction because it will be used many times
  do_subtraction:
    
       cmp bx,ax
       jl  first_small
       sub bx,ax
       mov ax,bx
       jmp first_big
       
       first_small: 
        sub ax,bx 
        push ax;saving answer on stack         
        print '-'
        jmp ans
       first_big: 
        push ax;saving answer on stack      
             
            print '+'
        ans:
        pop ax;getting answer back   
        call print_number
   ret
ends
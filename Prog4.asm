;Program name: Prog4.asm
;Gaurav Palande (014861923)
include pcmac.inc
.model small
.stack 100h
.data
;this file has input with push/pop
str1 db "Enter the value for n: ","$"
str2 db " ",0dh,0ah,"Enter the value for r: ","$" 
str3 db " ",0dh,0ah,"Cannot be calculated with r > n","$"
                                               
str4 db "There are ","$"
output dw 10
init dw 0

.code
 
 
Begin:
 
mov ax,@data							; clear data from ax reg 
mov ds,ax							; clear data from dx reg 
call input 							; call input mechanism and the rest of program
mov ax,4c00h                                    		; exit from program
int 21h
 
input proc near
 
                mov dx,offset str1     				; ask the user to enter the value of n
                mov ah,09h 
                int 21h     
 
 
                mov ah,01h                                      ; accept the value for n from user
                int 21h 
                mov ah, 0h
                sub ax,48                                       ; convert input string to number by subtracting ASCII value of 1
                push ax
                mov dx,offset str2     				; ask the user to enter the value of r 
                mov ah,09h 
                int 21h     
 
 
                mov ah,01h                                      ; accept the value for r from user
                int 21h
                mov ah, 0h
                sub al,48                                       ; convert input string to number by subtracting ASCII value of 1
               
                push ax
                call check                                      ; call the function to check if n>r
               
               
                ret
input endp 

error_msg proc near
 
mov dx,offset str3     						; display error message
mov ah,09h 
int 21h
 
ret
error_msg endp

check proc near
                pop ax                                          ; retrieve value of r in al
                pop ax

                pop bx                                          ; retrieve value of n in bl
                cmp ax,bx					; compare operation conducted
                JG error					; jump to error statement if n<r
                push bx                                         ; push back n in stack
                push ax                                         ; push back r in stack
                call comb					; call procedure to handle combination process
                ret
                error: call error_msg				; display error message
                ret
check endp

printch proc near
mov bx,0
mov ah,0Eh                                                        ; funtion to Print character to screen
int 10h                                                 
ret
printch endp

comb proc near

                pop bx                                  	; retrieve value of r to bl
                pop bx
               
                push bx
                call fact					; call function to perform factorial to calculate r!

                mov cl,al
                pop bx
                mov al, bl                             		; mov bl(r) to al
                pop dx                                  	; pop n to dl
                mov bl, dl                            		; mov dl(n) to bl
                push dx
                sub bl,al                               	; subtract al(r) from bl(n)
                call fact					; call function to perform factorial to calculate (n-r)!
                mul cx
                mov cl,al
               
                pop bx
                call fact					; call function to perform factorial to calculate n!
                div cx
 
                call outax					; display the output which is in the ax register
                ret
comb endp
 
fact proc near
                cmp bx,1
                jg re_call              			; call factorial loop until bx = 1
                mov ax,1                	                ; initialization
                jmp done					; skip to done once base function is done
                re_call: push bx                                ; put parameter in stack
                dec bx                  			; N=N-1
                call fact               			; recursive call
                pop bx                  			; get parameter from stack
                mul bx                  			; compute F(N)=F(N-1)*N
                done: ret
fact endp
 
outax proc near
mov si,0                                                         ; segment pointer will count the num of digits
again4: mov dx,0
div output                                                   	 ; AX % output->DX
add dx,30h                                                       ; convert the numbers into characters
push dx                                                          ; Store in stack
inc si
cmp init,ax
mov cx,2
 
loopnz again4							 ; output gained if the quotient is zero otherwise loop again
                                                                 ; move to next line
mov cx,si                                                        ; counter for number of digits
mov al,10                                                        ; print and enter
call printch
mov al,13
call printch
again5: pop ax                                   		 ; get outputult from stack and print it
call printch
loop again5
ret
outax endp
end Begin							  ; End of program
section .bss

  digit0: resb 1
  digit1: resb 1
  digit2: resb 1
  digit3: resb 1
  digit4: resb 1
  temp: resb 1
  num: resb 1
  n: resw 1
  nod: resb 1
  num1: resb 1
  num2: resb 1
  factorial: resw 1


section .data

msg1: db "Enter the number : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
msg3: db "Sorted Array : "
size3: equ $-msg3


section .text
  global _start

_start:
  


;Printing the message to enter the number
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h
  
  ;Reading the number
  mov eax, 3
  mov ebx, 0
  mov ecx, digit1
  mov edx, 1
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx, digit0
  mov edx, 1
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  sub byte[digit1], 30h
  sub byte[digit0], 30h  

  mov al, byte[digit1]
  mov dl, 10
  mul dl
  mov byte[num], al
  mov al, byte[digit0]
  add byte[num], al
  mov al, byte[num]
  mov ah,0
  mov word[n], ax
  ;num contains the numbers


call fact

mov word[factorial], cx


  
mov ax, word[factorial]

  mov word[num], ax
  mov byte[nod], 0 ;No of digits...
 

extract_no:

  cmp word[num], 0
  je print_no
  inc byte[nod]
  mov dx, 0
  mov ax, word[num]
  mov bx, 10
  div bx
  push dx
  mov word[num], ax
  jmp extract_no

print_no:
  cmp byte[nod], 0
  je end_print
  dec byte[nod]
  pop dx
  mov byte[temp], dl
  add byte[temp], 30h


  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h

  jmp print_no
end_print:  


mov eax, 1
mov ebx, 0
int 80h



fact:
  
  mov ax, word[n]
  cmp ax, 1
  je terminate
  push word[n]

  dec word[n]
  call fact

  pop word[n]
  mov dx, word[n]

  mov ax, cx
  mul dx
  mov cx, ax
  jmp exit
  
terminate:
  mov cx, 1

exit:
  ret


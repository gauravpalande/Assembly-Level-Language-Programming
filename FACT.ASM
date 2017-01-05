.model small
.stack 64
.data
.code

start: mov cl,05h
mov ax,01h
again: mul cl
dec cl
jnz again
mov ax,4ch
int 21h
end start
.end
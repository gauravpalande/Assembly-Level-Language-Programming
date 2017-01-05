.data
n       DWORD   ?
r       DWORD   ?
result  DWORD   ?
answer  DWORD   ?
divisor DWORD   ?

.code
MAIN    PROC


push OFFSET divisor     ;BP+20
push n                  ;BP+16
push r                  ;BP+12
push OFFSET result      ;BP+8
call combinations

;***********************************************************************
;COMBINATION CALLS FACTORIAL (3 TIMES) TO CALCULATE N!, R! AND (N-R)!.
;COMBINATIONS CALCULATES N!/(R!(N-R)!), AND STORES THE VALUE IN RESULT.
;RECIEVES: ACCEPTS N AND R BY VALUE AND RESULT BY ADDRESS
;RETURNS: NONE
;PRECONDITIONS: NONE
;***********************************************************************
combinations    PROC
push    bp
mov     bp,sp

mov     ax, [bp+16]   ;FIND (N-R)!
sub     ax, [bp+12]
mov     bx, ax
push    bx
call    factorial
pop     bx
mov     dx,[bp+20]    ;MOVE (N-R)! INTO RESULT
mov     [dx],ax

mov     bx, [bp+12]   ;FIND R!
push    bx
call    factorial
pop     bx

mov     dx, [bp+20]
mov     bx, [dx]
mul     bx             ;R!*(N-R)!, STORE PRODUCT IN AX
mov     bx, [bp+20]
mov     [bx], ax      ;STORE PRODUCT IN DIVISOR VARIABLE

mov     bx, [bp+16]   ;FIND  N!
push    bx
call    factorial
pop     bx
mov     dx, [bp+20]
mov     bx, [dx]      ;MOVE VALUE OF DIVISOR INTO BX

mov     dx, 0
div     bx             ;DIVIDE N! BY DIVISOR (R!*(N-R)!)
mov     bx, [bp+8]
mov     [bx], ax      ;MOVE QUOTIENT INTO RESULT

pop     bp
ret     16
combinations    ENDP

;*******************************************************************
;CALCULATES FACTORIAL RECURSIVELY
;RECIEVES:
;RETURNS: FACTORIAL SOLUTION IN AX
;PRECONDITION: NONE
;*******************************************************************
factorial       PROC
mov     ax, dword ptr [sp+4]
cmp     ax,1
jle     endRecursive
dec     ax
push    ax
call    factorial
mov     si, dword ptr [sp+4]
mul     si
endRecursive:   ret 4
factorial ENDP
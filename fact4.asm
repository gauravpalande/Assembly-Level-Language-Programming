; fact.asm
SECTION .text		; program
global factorial	; linux
global _factorial	; windows
factorial:
_factorial:
   push ebp 		; save base pointer
   mov ebp, esp 	; store stack pointer
   push ecx 		; save ecx
   ;;; start function
   mov ecx, [ebp+8] 	; ecx = first argument
   mov eax, 1 		; eax = 1
mainloop:
   cmp ecx, 0 		; if(ecx == 0)
   jz done 		; goto done
   mul ecx 		; else eax = eax * ecx
   dec ecx 		; ecx = ecx - 1
   jmp mainloop
done:
   pop ecx 		; restore ecx
   pop ebp 		; restore ebp
   ret 			; return from function
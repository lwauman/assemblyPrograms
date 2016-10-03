; Example assembly language program -- swap values
; Author:  Lucas Auman
; Date:    9/14/2016

.586
.MODEL	FLAT
.STACK  4096            

.DATA                   
number1 BYTE   1		; reserve a byte of memory called number1 and place 01 in it
number2 BYTE   2		 
number3 BYTE   3		

.CODE                           
main    PROC
        mov     al, number1     ; move contents of number1 to the al portion of eax
        mov     ah, number2		; move contents of number2 to the ah portion of eax
        mov     number1, ah		; move the contents of the ah portion of eax to number1
		mov		ah, number3		; move contents of number3 to the ah portion of eax
		mov		number2, ah		; move the contents of the ah portion of eax to number2
		mov		number3, al		; move the contents of the al portion of eax to number3

        mov   eax, 0            ; exit with return code 0
        ret
main    ENDP

END                             ; end of source code

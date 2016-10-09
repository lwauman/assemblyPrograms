; Example assembly language program -- recursive solution to find the remainder of two numbers without divison
; Author:  Lucas Auman
; Date:    10/8/2016

.586
.MODEL FLAT
INCLUDE io.h								; header file for input/output
.STACK 4096

.DATA
prompt1		BYTE	"Enter a positive integer", 0
errPrompt	BYTE	"Invalid entry.", 0
errHeader	BYTE	"Error", 0
temp		BYTE	40 DUP(?), 0
num1		DWORD	?
num2		DWORD	?
header		BYTE	"Result", 0
oString		BYTE	11 DUP(?), 0

.CODE
_MainProc PROC
inLoop1:input	prompt1, temp, 40			; get first number. only accepts >=1.
		atod	temp
		cmp		eax, 1000
		jnle	error						
		cmp		eax, 0
		jle		error
		mov		num1, eax
		jmp		inLoop2
error:	output	errHeader, errPrompt
		jmp		inLoop1
		
inLoop2:input	prompt1, temp, 40			; get second number. only accepts >=1.
		atod	temp
		cmp		eax, 1000
		jnle	error2
		cmp		eax, 0
		jle		error2
		mov		num2, eax
		jmp		afterIn
error2:	output	errHeader, errPrompt
		jmp		inLoop2		       

afterIn:push	num2						; store values						
		push	num1			
		call	modulo
		add		esp, 8						; clean up. two dwords is 8 bytes

		dtoa	oString, eax				; answer is in eax
		output	header, oString

        mov     eax, 0						; exit with return code 0
        ret
_MainProc ENDP

modulo	PROC
		push	ebp							; storing/creating stack space
		mov		ebp, esp

		mov		eax, [ebp+8]				
		sub		eax, [ebp+12]
		cmp		eax, -1						; if eax contains a negative number then
		jle		answer						; the desired answer was one step before

		push	[ebp+12]					; storing values for next call
		push	eax
		call	modulo
		add		esp, 8						; cleaning up

done:	pop		ebp							; cleaning up
		ret

answer:	add		eax, [ebp+12]				; this is done because the desired answer	
		jmp		done						; is the current value + num2 (ebp+12)
modulo	ENDP

END											; end of source code


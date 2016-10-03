; Assembly language program -- gets two numbers from user and finds all common divisors 
; Author:  Lucas Auman
; Date:    10/2/2016

.586
.MODEL FLAT
INCLUDE io.h								; header file for input/output
.STACK 4096

.DATA
prompt1		BYTE	"Enter a positive integer value less than or equal to 1000", 0
errPrompt	BYTE	"Invalid entry.", 0
errHeader	BYTE	"Error", 0
temp		BYTE	40 DUP(?), 0
num1		DWORD	?
num2		DWORD	?
divisor		DWORD	0
result		DWORD	32 DUP(?)				; 840 has the max number of divisors (32) for nums 1 - 1000
succCount	DWORD	0						; represents the number of divisors that are shared between num1 and num2
header		BYTE	"Common divisors", 0
outstring	BYTE	352 DUP(?), 0			; DTOA produces an 11 BYTE result  32 * 11 = 352 

.CODE
_MainProc PROC
inLoop1:input	prompt1, temp, 40			; get first number. only accepts 0-1000.
		atod	temp
		cmp		eax, 1000
		jnle	error
		cmp		eax, 0
		jle		error
		mov		num1, eax
		jmp		inLoop2
error:	output	errHeader, errPrompt
		jmp		inLoop1
		
inLoop2:input	prompt1, temp, 40			; get second number. only accepts 0-1000.
		atod	temp
		cmp		eax, 1000
		jnle	error2
		cmp		eax, 0
		jle		error2
		mov		num2, eax
		jmp		afterIn
error2:	output	errHeader, errPrompt
		jmp		inLoop2	

afterIn:mov		esi, 0						; this will be used as an index for result
divLoop:mov		eax, num1					
		cmp		eax, divisor
		jl		prepOut						; if divisor is greater than num1 jump to prepOut
		cdq									; prepare for dividing. I'm pretty sure this isn't needed but not 100%
		inc		divisor						
		idiv	divisor						; divide eax by divisor.
		cmp		edx, 0						; edx holds the remainder
		jnz		divLoop						; if this jump occurs then divisor wasn't found for num1. go back and try next number
		mov		eax, num2
		cmp		eax, divisor
		jl		prepOut
		cdq
		idiv	divisor
		cmp		edx, 0
		jnz		divLoop
		mov		eax, divisor				; at this point a common divisor has been found
		mov		result[esi*4], eax			; place it into the array
		inc		esi							; manage variables
		inc		succCount
		jmp		divLoop

		
prepout:lea		edi, outString				; load first address of outString
		mov		esi, 0						; used as index of result
		mov		ecx, succCount				; this hold how many times it should loop
preOut2:mov		eax, result[esi*4]
		dtoa	[edi], eax		
		inc		esi
		add		edi, 11
		loop	preOut2

		output	header, outString


		mov     eax, 0						; exit with return code 0
        ret	
_MainProc ENDP
END											; end of source code


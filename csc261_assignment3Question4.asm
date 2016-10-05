; This program takes 3 numbers from user, swaps them around, and displays the result 
; Author:  Lucas Auman
; Date:    9/14/2016

.586
.MODEL FLAT
INCLUDE io.h								; header file for input/output
.STACK 4096

.DATA
number1	DWORD	?							; reserve a DWORD of memory that will have some value later
number2	DWORD	?							
number3 DWORD	?							
prompt1 BYTE    "Enter first number", 0		; used to display 1st prompt 
prompt2 BYTE    "Enter second number", 0	 
prompt3 BYTE    "Enter third number", 0		
header	BYTE	"The results", 0			; title bar of final window
temp	BYTE	40 DUP(?), 0				; this will be used to hold result after each prompt

string	BYTE	0ah,0dh						; this is what will be displayed on final window. 0ah,0dh is a new line
		BYTE	"number1 ="
n1		BYTE	11 DUP(?)					 			
		BYTE	0ah,0dh
		BYTE	"number2 ="
n2		BYTE	11 DUP(?)
		BYTE	0ah,0dh
		BYTE	"number3 ="
n3		BYTE	11 DUP(?), 0				; end of string

.CODE
_MainProc PROC
        input   prompt1, temp, 40			; take response from prompt and place in temp
		atod	temp						; convert ASCII to 2's complement DWORD and place in eax
		mov		number1, eax				; move from eax to number1
		dtoa	n3, number1					; convert 2's complement DWORD to ASCII and place in n3
											; 1 -> 3

		input	prompt2, temp, 40
		atod	temp
		mov		number2, eax
		dtoa	n1, number2					; 2 -> 1
											
		input	prompt3, temp, 40
		atod	temp
		mov		number3, eax	
		dtoa	n2, number3					; 3 -> 2

		output	header,string				; output result... finally
			
        mov     eax, 0						; exit with return code 0
        ret
_MainProc ENDP
END											; end of source code


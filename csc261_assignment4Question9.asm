; Example assembly language program -- takes grades and finds average
; Author:  Lucas Auman
; Date:    9/26/2016

.586
.MODEL FLAT
INCLUDE io.h														; header file for input/output
.STACK 4096

.DATA
prompt1				BYTE	"Enter first assignment grade", 0		; prompts to recieve data
prompt2				BYTE	"Enter second assignment grade", 0
prompt3				BYTE	"Enter third assignment grade", 0
prompt4				BYTE    "Enter first written test grade", 0
prompt5				BYTE    "Enter second written test grade", 0
prompt6				BYTE	"Enter final exam grade", 0				
header				BYTE	"Final Grade", 0						; header of final window
temp				BYTE	40 DUP(?), 0							; used to hold data after prompt
average				BYTE	11 DUP(?), 0							; used to hold dtoa for final ouput window
assignment1			DWORD	?										; variables to hold data
assignment2			DWORD	?
assignment3			DWORD	?
writtenTest1		DWORD	?
writtenTest2		DWORD	?
exam				DWORD	?									
assignmentWeight	DWORD	4										; weights for assignments, tests, exams, and total 
writtenTestWeight	DWORD	5
examWeight			DWORD	8
totalWeight			DWORD	30									

.CODE
_MainProc PROC
		input	prompt1, temp, 40									; get assignment 1, convert to double, multiply by weight, and store in variable
		atod	temp
		mul		assignmentWeight
		mov		assignment1, eax

		input	prompt2, temp, 40									; get assignment 2, convert to double, multiply by weight, and store in variable
		atod	temp
		mul		assignmentWeight
		mov		assignment2, eax

		input	prompt3, temp, 40									; get assignment 3, convert to double, multiply by weight, and store in variable	
		atod	temp
		mul		assignmentWeight
		mov		assignment3, eax

        input	prompt4, temp, 40									; get test 1, convert to double, multiply by weight, and store in variable
		atod	temp
		mul		writtenTestWeight
		mov		writtenTest1, eax

		input	prompt5, temp, 40									; get test 2, convert to double, multiply by weight, and store in variable
		atod	temp
		mul		writtenTestWeight
		mov		writtenTest2, eax

		input	prompt6, temp, 40									; get exam, convert to double, multiply by weight, and store in variable
		atod	temp
		mul		examWeight
		mov		exam, eax		

		mov		eax, assignment1									; add all weighted grades together and divide by total weight(30)
		add		eax, assignment2
		add		eax, assignment3
		add		eax, writtenTest1
		add		eax, writtenTest2
		add		eax, exam
		div		totalWeight
		dtoa	average, eax										; double to ASCII
		output	header, average										; output results
		

        mov     eax, 0												; exit with return code 0
        ret
_MainProc ENDP
END																	; end of source code
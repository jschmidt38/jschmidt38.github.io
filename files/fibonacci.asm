; ======================
; CS2110 TL2 Summer 2015
; Name: John Schmidt
; ======================

; Main
; Do not edit this function!

.orig x3000

	; Initialize stack
	LD R6, STACK

	; Call fibonacci(n)
	LD R0, N
	ADD R6, R6, -1
	STR R0, R6, 0
	JSR FIBONACCI

	; Pop return value and arg off stack
	LDR R0, R6, 0
	ADD R6, R6, 2

	; Save the answer
	ST R0, ANSWER

	HALT

STACK
	.fill xF000
N
	.fill 7
ANSWER
	.blkw 1

FIBONACCI

	ADD R6, R6, -4	; allocate space for new frame
	STR R5, R6, 1	; store old frame pointer
	ADD R5, R6, 0	; R5 -> first local variable
	STR R7, R5, 2 	; store return address

	LDR R0, R5, 4	; R0 = n
	BRZ GOZERO
	ADD R0, R0, -1
	BRZ GOONE
	ADD R0,R0,1
	BRNP NEXTSTEP

GOONE
	AND R0,R0,0
	ADD R0,R0,1
	BRNZP CLEAN

GOZERO
	AND R0,R0,0
	BRNZP CLEAN

NEXTSTEP
	ADD R6,R6,-1
	ADD R0,R0,-1
	STR R0,R6,0
	JSR FIBONACCI
	LDR R0,R6,0 ; R0 IS FIBONACCI N-1
	ADD R1,R0,0
	LDR R0,R5,4
	STR R1,R5,4
	ADD R0,R0,-2
	STR R0,R6,0
	JSR FIBONACCI
	LDR R0,R6,0
	LDR R1,R5,4
	ADD R0,R1,R0
	BR CLEAN
		



CLEAN 
	STR R0, R5, 3; STORE RETURN VALUE
	LDR R7, R5,2;LOAD MOD VALUE
	ADD R6,R5,3
	LDR R5,R5,1;LOAD OLD FRAME POINTER
	RET

.end

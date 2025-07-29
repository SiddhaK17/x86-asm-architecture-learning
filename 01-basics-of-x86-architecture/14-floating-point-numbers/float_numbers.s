section .data
	; Here the 'DD' registers are 32 bit registers
	x DD 3.14	; Define a 32-bit (Single-precision) floating-point number 3.14
	y DD 2.1	; Define another 32-bit floating-point number 2.1

section .text
global _start

_start:
	MOVSS xmm0, [x]		; Load scalar single-precision float from memory location 'x' into xmm0
	; The two 'SS' here stand for "scalar single precision". "Scalar" because we are moving a single decimal value. And "single precision" meaning that it's a 32-bit floating point number
	; We have a total of 15 "xmm" registers starting from "xmm0" to "xmm15". And these are used specifically for storing our floating point numbers
	MOVSS xmm1, [y]		; Load scalar single-precision float from 'y' into xmm1
	ADDSS xmm0, xmm1	; "ADDSS" is going to add two decimal values	; Add the values in xmm0 and xmm1, result stored in xmm0 (i.e., xmm0 = x + y)
	MOV ebx,1		; Set ebx to 1 (exit code)
	INT 80h			; Interrupt to exit program (Linux syscall)

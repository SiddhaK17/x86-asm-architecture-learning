section .text
global _start

_start:
	; MOV al,2
	; MOV bl,3
	; MUL bl	; The value 3 in bl got multiplied by the value 2 of al and the result got stored in al which is 6

	; (unsigned multiplication example)
	; MOV al,0xff
        ; MOV bl,2
        ; MUL bl


	; Now lets see what happens when the result of the multiplication is larger than the register:

	; (signed multiplication example)
	MOV al,0xFF	; -1 in signed 8-bit, 255 in unsigned 8-bit         ; Here we have 8 bit register al and the largest possible 8 bit number '0xFF'
	MOV bl,2	; We are going to multiply al by 2 which is going to create something much bigger than the actual register size
	IMUL bl
	INT 80h

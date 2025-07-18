section .bss		; bss is "Block starting symbol" used for reserving space in memory
			; Reserve uninitialized memory
	num RESB 3	; Reserve 3 bytes (not initialized)

section .data
	num2 DB 3 DUP(2)	; Reserve 3 bytes initialized with value 2 each (2,2,2)
				; This will write 2 into memory three times

section .text
global _start

_start:
	MOV bl,1	; Put 1 into BL (does nothing important here as its overwritten by 2)	Now BL = 1
	MOV bl,[num2]	; Load the first byte of num2 into BL (value 2)		 Now BL = 2, so 1 is lost
	MOV [num],bl	; Store BL (2) into the first byte of num		 Now num = 2
	MOV [num+1],bl	; Store BL (2) into the second byte of num
	MOV [num+2],bl	; Store BL (2) into the third byte of num

	MOV eax,1	; Exit syscall
	INT 80h

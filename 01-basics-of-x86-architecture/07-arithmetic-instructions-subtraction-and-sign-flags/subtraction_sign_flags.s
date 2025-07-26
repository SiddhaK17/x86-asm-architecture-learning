section .data		; Section for initialized data (not used in this program)

section .text		; Section for code
global _start		; Entry point for the program

_start:
	; MOV eax,5	; Load 5 into EAX
	; MOV ebx,3	; Load 3 into EBX

	MOV eax,3	; Load the value 3 into register EAX
	MOV ebx,5	; Load the value 5 into register EBX
	SUB eax,ebx	; Subtract EBX from EAX → EAX = 3 - 5 = -2 (0xFFFFFFFE in 32-bit)
	MOV ebx,2	; Load 2 into register EBX
	ADD eax,ebx	; Add EBX to EAX → EAX = -2 + 2 = 0
	INT 80h		; Make a system call (used here to end program execution)

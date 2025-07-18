section .data

section .text
global _start

_start:
	; MOV eax,1
	; MOV ebx,2
	; ADD eax,ebx	; Therefore this will add eax + ebx and store the value in eax
	; INT 80h

	MOV bl,0b11111111	; Therefore here the 0b says that the thing that follows is binary value.    bl = 255 in decimal 
        MOV al,0b0001   	; Here "0001" is a binary value.	al = 1 in decimal
        ADD al,bl	; al = al + bl = 1 + 255 = 256 (which overflows 8-bit)
	ADC ah,0	; ah = ah + 0 + CF (carry flag from previous addition)

	JMP $           ; <- add this if you want to pause for GDB

	MOV eax,1	; syscall: exit
	MOV ebx,0	; exit code 0
	INT 80h

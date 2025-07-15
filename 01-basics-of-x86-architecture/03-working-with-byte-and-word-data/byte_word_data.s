section .data
	num DB 1
	num2 DB 2

section .text
global _start

_start:
      ; MOV ebx,[num]
        MOV bl,[num]	; We are referencing 8 bit registers instead of 32 bit registers
      ; MOV ecx,[num2]
	MOV cl,[num2]	; We are referencing 8 bit registers instead of 32 bit registers
	MOV eax,1
	INT 80h

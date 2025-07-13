section .data
	num DD 5

section .text
global _start

_start:
	MOV eax,1
	; MOV ebx,num
	; To get 5 in the output we put num in sqare brackets "[num]"
	MOV ebx,[num]
	INT 80h

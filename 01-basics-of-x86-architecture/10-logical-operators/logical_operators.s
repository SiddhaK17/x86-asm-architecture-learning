section .data

section .text
global _start

_start:
	; AND operator example
      ;	MOV eax,0b1010		; EAX = 1010 (decimal 10)
      ; MOV ebx,0b1100		; EBX = 1100 (decimal 12)
      ;	AND eax,ebx		; Here eax is the destination	; EAX = EAX AND EBX → 1010 & 1100 = 1000 (decimal 8)

	; OR operator example
      ;	MOV eax,0b1010		; EAX = 1010 (decimal 10)
      ; MOV ebx,0b1100		; EBX = 1100 (decimal 12)
      ; OR eax,ebx		; EAX = EAX OR EBX → 1010 | 1100 = 1110 (decimal 14)

	; NOT operator example
      ;	MOV eax,0b1010		; EAX = 00000000 00000000 00000000 00001010
      ;	NOT eax			; EAX = bitwise NOT → flips all bits		; This will flip all the bits
				; EAX = 11111111 11111111 11111111 11110101
      ;	AND eax,0x0000000F	; Masking only the lower 4 bits: 11110101 & 00001111 = 0101 (decimal 5)		; You can also write 0xF instead of 0x0000000F

	; XOR operator example
      MOV eax,0b1010		; EAX = 1010 (decimal 10)
      MOV ebx,0b1100		; EBX = 1100 (decimal 12)
      XOR eax,ebx		; EAX = 1010 ^ 1100 = 0110 (decimal 6)
      INT 80h

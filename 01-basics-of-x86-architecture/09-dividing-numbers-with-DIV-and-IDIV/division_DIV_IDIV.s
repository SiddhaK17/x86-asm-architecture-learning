section .data		; No data section used in this program


section .text
global _start

_start:
	; MOV eax,11	; (Unsigned division example) Numerator = 11
	; MOV ecx,2	; Denominator = 2
	; DIV ecx	; Perform unsigned division: EAX = Quotient, EDX = Remainder


	; Example for signed division

	MOV eax,0xff	; Load EAX with 0xFF (255 in decimal) — numerator
	MOV ecx,2	; Load ECX with 2 — denominator
	IDIV ecx	; Signed division: EAX = Quotient, EDX = Remainder
	INT 80h		; Exit or syscall (for Linux; here just halts execution)

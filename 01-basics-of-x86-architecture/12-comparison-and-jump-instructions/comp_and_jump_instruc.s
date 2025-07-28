section .data	; No initialized data used in this program

section .text
global _start

_start:
	MOV eax,1	; Move the value 1 into the EAX register
	MOV ebx,2	; Move the value 2 into the EBX register
	CMP eax,ebx	; This will subtract these two registers from each other and it's going to discard the result that it gets but its going to use that result to set the eflags register
	; Compare EAX and EBX (does EAX - EBX internally)
	; This sets the flags (like Zero Flag, Sign Flag, Carry Flag) based on the result
	; The result is not stored anywhere, just affects the EFLAGS register
	JL lesser	; Jump to label 'lesser' if EAX < EBX (signed comparison)
	JMP end		; If not less, jump to 'end' (to skip the 'lesser' block)

lesser:
	MOV ecx,1	; If jumped to 'lesser', this line will execute
	            ; Move the value 1 into ECX (you can treat this as a marker for 'lesser' case)

end:
	INT 80h		; Make a system call (used here to gracefully end the program in Linux)

	; ---------------------------------------------------------
	; Few more of the jump commands that exist

      ;	JE	; Jump if Equal. We do it when eax is equal to ebx
      ;	JNE	; Jump if Not Equal. We do it when eax is not equal to ebx
      ;	JG	; Jump if Greater (signed comparison). We do it when eax is greater than ebx
      ;	JGE	; Jump if Greater or Equal (signed).
      ;	JL	; Jump if Less (signed).
      ;	JLE	; Jump if Less or Equal (signed).
      ;	JZ	; Jump if Zero (used for equality, same as JE).
      ;	JNZ	; Jump if Not Zero (used when values are not equal).

	; NOTE : JE and JZ are equivalent to each other. They are functionally the same. Use JZ when checking result of a CMP with zero.

section .data
	x DD 3.14	; Define a 32-bit (single precision) floating point number 3.14
	y DD 2.1	; Define another 32-bit (single precision) floating point number 2.1

section .text
global _start

_start:
	MOVSS xmm0, [x]		; Load single-precision float x (3.14) into XMM0 register
	MOVSS xmm1, [y]		; Load single-precision float y (2.1) into XMM1 register
	UCOMISS	xmm0, xmm1	; Unordered Compare Scalar Single Precision Floats. This sets the EFLAGS (ZF, PF, CF) based on comparison of XMM0 > XMM1	
	; We cannot use "CMP" instruction because that only works with normal decimal values. Therefore "UCOMISS" is used to compare floating point numbers
	JA greater		; Jump if Above (i.e., if XMM0 > XMM1). Only jumps if x > y. This will jump to the greater label
	JMP end		; If not greater, jump to end label

greater:
	MOV ecx,1	; If x > y, store 1 in ECX (can be used later or for debugging)

end:
	MOV eax,1	; Syscall number for exit()
	MOV ebx,1	; Exit status = 1
	INT 80h		; Make syscall (Linux 32-bit system call to exit)


	; Therefore we use the jump instructions differently as well when we are using "UCOMISS"
      ;	JB 		; "JB" is jump below and its the same idea as jump less than.
      ;	JBE		; "JBE" is jump below or equals and its the same idea as jump less than or equals
      ;	JAE		; "JAE" is above equals or greater than or equals.
      ;	JA 		; "JA" is jump above which is going to be greater than
      ;	JE		; "JE" is still going to be used for equals so that is unchanged

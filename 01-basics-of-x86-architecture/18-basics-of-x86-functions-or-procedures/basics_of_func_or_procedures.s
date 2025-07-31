section .data
; No data is defined here, but this section is reserved for static/global data
; You might place strings, constants, etc., in this section later.

section .text
global main		; Make 'main' available to the linker as the program's entry point

addTwo:
	ADD eax,ebx	; Add the values in registers eax and ebx, store result in eax (eax = eax + ebx)
	RET		; "RET" keyword is used to return back to the location where the function was called from
			; Return to the instruction after the CALL that called this function

main:
	MOV eax,4	; Move the value 4 into register eax
	MOV ebx,1	; Move the value 1 into register ebx
	CALL addTwo	; This will call our function using the same "CALL" keyword that we saw for our C functions
	; Call the 'addTwo' function (this pushes the return address onto the stack)

	MOV ebx,eax	; Move the result (5) into ebx to use as exit status
	MOV eax,1	; System call number for 'exit' in Linux
	INT 80h		; Interrupt 0x80 to invoke a Linux syscall (eax=1 → exit, ebx=status code)

; Therefore the main reason why we would want to pass data through the stack is because the registers are really precious resources for us. We dont always have the luxury of being able to overwrite registers to pass them into a function. In some cases, that data may need to be placed on the stack either because it's too big to be placed in registers or because we dont have any registers available to store that data 
section .data	; No data is used in this example, but this section is reserved for static or global variables.

section .text
global main		; Declare 'main' as the entry point of the program.


; ----------------------
; Function: addTwo
; Description: Adds two integers passed via the stack and returns the result in EAX.
; Arguments:
;   [ebp+8]  - First integer
;   [ebp+12] - Second integer
; ----------------------

addTwo:
	PUSH ebp	; Therefore we push ebp onto the stack and now our stack pointer is pointing at "ebp". Why do we do this? -> "ebp" essentially acts as the base of our stack frame. The idea is that if we called multiple functions inside of a function, we would need to have some wort of way of distinguishing between everything that's associated with their first function and everything that's associated with our second function. and the way that we do that is we say this "ebp" is like a divider. So everything above this "ebp" is something else, and everything below it is a part of our function. 
    ; Save the old base pointer (caller’s ebp) onto the stack.
    ; This is done to preserve the previous stack frame,
    ; so we can restore it when returning from the function.
    ; This "old ebp" acts like a marker to know where our stack frame begins.

	MOV ebp,esp	; We move "esp" into "ebp" just to make sure that both of these register are pointing to the same location
    ; Establish a new stack frame for this function.
    ; EBP now points to the base of the current function's stack frame.
    ; ESP is used for pushing/popping, but EBP remains constant
    ; within the function and is used to access arguments.

	MOV eax,[ebp+8]		; So i add 8 to it to get to the adress where that argument actually is		; Get the first argument from the stack (pushed last).
	MOV ebx,[ebp+12]	; Get the second argument from the stack (pushed first).
    		                ; These values were pushed in reverse order in main.
	; Therefore now we have these values inside of the registers and now we can add them together

	ADD eax,ebx	; Add the two integers and store the result in EAX.
	POP ebp		; We do this because our stack pointer at this point was pointing at "ebp" which is a problem because when we return using the "RET" keyword, its going to return to what the stack pointer is pointing at. So we actually have to remove "ebp" from the stack and get the stack pointer back at our return address. Asthis is a simple operation, we "POP" the value off into "ebp" and then we return
    ; Restore the caller’s base pointer (old ebp).
    ; At this point, the stack pointer (ESP) is pointing to old ebp.
    ; We must clean this up so RET knows where to return correctly.

	RET	; Return to the address that was pushed by CALL.
                ; This pops the return address from the stack and jumps to it.


; ----------------------
; Main Function
; Description: Pushes two integers onto the stack and calls addTwo.
; ----------------------

main:
	PUSH 4		; We are going to push 4 onto the stack		; Push second argument (4) onto the stack.
	PUSH 1		; We are going to push 1 onto the stack		; Push first argument (1) onto the stack.
			; These will be accessible as [ebp+8] and [ebp+12] in addTwo.
	CALL addTwo	; Call the addTwo function.
                   	; This pushes the return address onto the stack.
	MOV ebx,eax	; Store the result of the addition into EBX (exit status).
	MOV eax,1	; System call number for 'exit'.
	INT 80h		; Trigger Linux interrupt to exit the program.

extern test		; Declaring external C function "test" so NASM knows it will be linked later
extern exit		; Declaring external C function "exit" from libc for exiting the program

section .data	; Data section (not used here, but good practice to include)

section .text
global main		; Tells the linker that "main" is the entry point

main:
	PUSH 1		; Therefore integer b, the second argument is 1		; Push second argument (b = 1) as per CDECL (right-to-left)
	PUSH 2		; Therefore integer a, the first argument is 2		; Push first argument (a = 2)
	CALL test	; Call the C function "test", returns result in EAX

	; Push the return value (a + b = 3) to use as argument to exit()		; This is how we exit with status 3, dynamically based on result
	PUSH eax	; When the function is called, the return value is automatically stored in the register eax. So if i want to exit with a status code equivalent to the sum of these numbers which is 3, i would "push eax" to use it as the argument for exit 
			; Generally if you want to access what was returned to the function, then "eax" is where you would find that value
	CALL exit	; Call C library's exit() with return value

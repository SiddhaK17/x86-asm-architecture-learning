; Declare external functions used from the C standard library
extern printf	; "extern" tells NASM that these are external functions that we're going to link in later through GCC. Therfore these are external references
extern exit

section .data	; When we use printf in C, it needs two arguments. 1-format, 2-some sort of value to print : "print(fmt,val)". So we will define these in our Data section
	msg DD "Hello World",0		; This will be the value that we are printing. And since its a text we add a 0 which is a null terminator
	fmt DB "Output is: %s",10,0	; We will make sure that we add %s as we are printing the message. 10 is a new line character so it puts a new line after the print. 0 will null terminate the format so C knows where it actually ends

section .text
global main

main:	; This is "main" and even our global is "main" because we need a "main" function in order to work with GCC
	PUSH msg 	; The "PUSH" instruction will take the data and it will place it onto the stack for us. Therfore the last thing i put on the stack is the first thing removed from the stack as stack follows LIFO structure. 
	PUSH fmt	; Therefore printf expects the argument to be presented like this "printf(fmt,msg)" first the format string then the message. So if i want this to be removed from the stack in this way, the last thing i add to the stack should be the first thing that comes out. So the last thing that i should add is "format" since it's the first argument. Therefore "msg" will go on first then the "fmt". SO when these are removed, format goes first and gets placed in the fmt which is the first argument in "print(fmt,msg)" and message gets removed second and gets placed in the msg argument 
	CALL printf	; This will call the printf function
	; To end the prpgram we will call the exit code like we call in C i.e., "exit(1)" 
	PUSH 1		; Therfore we push 1 for our exit code
	CALL exit	; And here we call our exit





; Another example with one more "msg" string

; Declare external functions used from the C standard library
; extern printf     ; We're telling NASM that printf is an external function (from libc)
; extern exit       ; Same for exit()

; section .data
    ; Define our strings in the data section

      ;	msg DD "Hello World,"0          ; 'DD' (Define Double word) reserves 4 bytes per element (used here for compatibility, but DB is actually sufficient for strings)
                                        ; Null-terminated (0) because C expects strings to end with '\0'
                                        ; NOTE: You can also use DB for strings; DD here creates pointer alignment
      ;	msg2 DD "This is a test!",0     ; Another message string, null terminated
      ;	fmt DB "Output is: %s %s",10,0  ; Format string: expects two %s (string) arguments
                                        ; 10 is ASCII for newline '\n', and 0 null terminates the string

; section .text
; global main       ; Make the `main` function visible to the linker (needed for linking with C runtime)    ; Define 'main' as entry point for GCC (it expects 'main')

; main:
    ; We need to push the arguments in "reverse order" onto the stack (because of CDECL)
	; Therefore to match the ordering, the "PUSH fmt" string has to be the first as it represents [printf("%s %s")] which is why its the last thing we push onto the stack. The second thing is the "PUSH msg" as it will represent the first "%s" and then "PUSH msg2" is the first which represents the second "%s" so that is the last thing that comes off of the stack and the last thing that's printed on the screen 
      ;	PUSH msg2       ; This will be second %s — last one to be popped, so it's printed second
      ;	PUSH msg        ; This will be first %s — popped second, printed first
      ;	PUSH fmt        ; This is the format string — popped first, becomes first argument to printf
      ;	CALL printf     ; Call printf — will pop the arguments from the stack   ; Call the C function printf(fmt, msg, msg2)
      ; Exit the program by calling exit(10)
      ;	PUSH 10		; This represents our exit code which now is 10
      ;	CALL exit	; Call exit

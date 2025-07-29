section .data
	list DB 1,2,3,4		; Define a list (array) of 4 bytes: [1, 2, 3, 4]

section .text
global _start

_start:
	MOV eax, 0	; Initialize index register EAX to 0 (acts like 'i' in a loop)
	MOV cl, 0	; Initialize CL (a byte-sized register) to 0 to store the sum
			; As the sum of the numbers are small, we use the smaller register 'cl'. There is no problem to use ecx

loop:
	MOV bl,[list + eax]	; Load the byte at list[eax] into BL (access element at current index)
	ADD cl,bl	; Add the value in BL to CL (i.e., add current list item to sum)
	INC eax		; Increment EAX to move to the next element in the list. This will increment the eax by 1
	CMP eax,4	; Compare index (EAX) with 4 (the length of the list)
	; Since we knew the length we used the value 4 but if we didnt knew the length, we could add some sort of null terminator at the end of the list or some sort of predictable value at the end and we could just check to see if i hit that predictable null terminator value
	JE end		; If EAX == 4, jump to 'end' label (loop done)
	JMP loop	; Else, go back to loop

end:
	MOV eax,1	; Prepare to exit the program (exit syscall)
        MOV ebx, 1      ; Return code (can be anything, we use 1)
        INT 80h         ; Make syscall to terminate the program

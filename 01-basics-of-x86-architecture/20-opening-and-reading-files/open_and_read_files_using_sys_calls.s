; Refer to the table given at "https://faculty.nps.edu/cseagle/assembly/sys_call.html"
section .data
	pathname DD "/home/sid/asm-learning/01-basics-of-x86-architecture"
	; Declare a 32-bit pointer DD to the string path (stored in .rodata implicitly).
 	; This is the file we are going to open for reading.
	; "~/" will NOT expand automatically in Linux syscalls. You should give full path like "/home/username/asm-learning/..." instead.

section .bss
	buffer: resb 1024	; We are gonna reserve some bytes inside of our buffer. We can put more amounf of bytes than what are insdie the file or we can put the same amount of bytes that are inside the file but we cannot put less amount of bytes than what the file has because if we put less amount of bytes than what is inside the file then we wont be able to read the whole file. This really depends on our goal. If you want to read like 10 characters from your file, you can make this 10. If you want to make it 20 characters, you can make it 20. I you want to read the whole file, then just make it something that is large enough to contain the whole file. This creates our buffer 
	; Reserve 1024 bytes of memory to read file contents into.
        ; This is our read buffer. It must be large enough to hold the file content.
	; It's like saying: “I’ll read up to 1024 bytes from the file and store them here.”

section .text
global main

main:

    ; ------------------------------
    ; Step 1: Code to Open the File 
    ; ------------------------------

	MOV eax,5	; This instruction is used to make an open system call and then according to the table to make this functional, we need to put certain values in certain registers and we can figure that out by taking a look at the manual page of the open system call by simply writing "open man" in the brower. For eg: "https://www.man7.org/linux/man-pages/man2/open.2.html" 
	; Syscall number 5 = sys_open (Tells Linux you want to open a file.) (see Linux syscall table for 32-bit: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

	MOV ebx,pathname	; Specifically this moves the address of the pathname variable at the top into the register "ebx". It's giving it a pointer of exactly what we're expecting based on that system call 
	; ebx = pointer to the file path (string). (const char *pathname)	; The kernel reads this string to find the file.

	MOV ecx,0	; Here we need to put in the flag. So we want to read the file therefore a read-only flag would be perfect. But if i take a look at the manual file, i will find that inside of here, it gives me all the different flags that we could possibly have and one of the flags is "O_RDONLY" which is an access mode which will open the file in read only mode. Now the problem here is that "O_RDONLY" is really like a C constant so we want to be able to convert it into an integer because that's what we really need to provide. To do that we have to go to the fcntl.h file which is : "https://sites.uclouvain.be/SystInfo/usr/include/asm-generic/fcntl.h.html", which is where all these differnet values are defined and we see that "O_RDONLY" is defined as 0. How did i know that the file is fcntl.h?  ->   Every information is inside the manual itself
	; ecx = flags for file access. 0 = O_RDONLY (read-only).
        ; You can check the flags in `/usr/include/asm-generic/fcntl.h`.

	; Our program now has everything it needs to do the system call. When it does a system call, it returns the result back to us in "eax". So "eax" is going to have the result of this system call. The result from this system call is an integer. That integer is what we call a file descriptor. It's a unique identifier associated with the file that we can use in other system calls to be able to manipulate that file in some way
	INT 80h
	; Interrupt 0x80 triggers the syscall.
        ; Return value is stored in EAX → this is the file descriptor (e.g., 3, 4, etc.). or -1 if there was an error.


    ; ------------------------------
    ; Step 2: Code to Read the File
    ; ------------------------------

	MOV ebx,eax	; Here we are moving the file descriptor into "ebx" to read the file using "sys_read"
	; Move the file descriptor from eax to ebx for the read syscal

	MOV eax,3 	; The number 3 is our system call for "sys_read"
	; Syscall number 3 = sys_read. Tells the kernel: “I want to read from a file.”
        ; Signature: ssize_t read(int fd, void *buf, size_t count)

	; Therefore the manual says that we need a "buffer" as well as a "count". The "count" is the number of bytes that we want to read from the file and when it reads those bytes from the file it puts them into the buffer 
	MOV ecx,buffer	; We will move into ecx the buffer
	; ecx = pointer to the buffer where file contents will be stored.

	MOV edx,1024	; This will fill up the whole buffer if there is that much data to read. If there isnt that much data to read, then it will just fill as much as it needs to and then move on
	; edx = number of bytes to read (max read size)

	INT 80h
	; Now when we do the system interrupt here, what's gonna happen is it's going to do the read and it's going to return back to me the number of characters that it read from the file. That should be usually equal to the value "1024". The situations where it's not equal to the value is if we read less than that from the file because there wasnt that much in the file or if we reach the end of the file in which case we'll get back a value of 0. SO if you ever wanna iterate a whole file, what you would do is you would iterate untill that value is equal to 0 
	; Perform the read syscall.
        ; After this call:
        ; - The buffer (memory) contains the file content.
    	; - EAX = actual number of bytes read.


    ; ---------------------------------
    ; Step 3: Code to Exit the Program
    ; ---------------------------------

	MOV eax,1	; Syscall number 1 = sys_exit. This system call terminates the program.	
	MOV ebx,0	; Exit status = 0 (success). Successful exit.
	INT 80h	; Exit the program

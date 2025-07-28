section .data

section .text
global _start

_start:
	; Example of "SHR" -> Shift Right (Division)
      ;	MOV eax,2	; Initialize EAX with binary 0010 (decimal 2)
      ;	SHR eax,1	; This will shift the values to the right i.e: 0010 -> 0001	And the 0 in the end will go into the carry flag. Therefore last values always goes into carry flags
      ; Shift Right by 1 bit → 0010 becomes 0001 (i.e., 2 / 2 = 1).      And the rightmost bit (0) is moved into the Carry Flag (CF)
      ; SHR will basically divide the value in 'eax' by 2. So if MOV eax is 12 and SHR eax is 1 then we get the output as 6. If SHR eax is 2, we get the output as 3. So 6 gets further divided to 3
      ; SHR divides the value by 2^n (n = number of shifts)
      ;	INT 80h

	; Example of "SHL" -> Shift Left (Multiplication)
        MOV eax,2       ; EAX = 2 (binary: 0010)
        SHL eax,1	      ; This will shift the values to the left i.e: 0010 -> 0100  ; Shift Left by 1 → 0010 becomes 0100 (i.e., 2 * 2 = 4)
      ; SHL will basically multiply the value in 'eax' by 2.  SHL multiplies the value by 2^n (n = number of shifts)
	INT 80h

	; Other types of shifts
      ; SAR - Shift Arithmetic Right
      ;	SAR		; Arithmetic shift to the right
      ; Similar to SHR, but preserves the sign bit (for signed division).
      ; It fills the leftmost bit (MSB) with the original sign bit (0 for +, 1 for -).

      ; SAL - Shift Arithmetic Left
      ;	SAL 		; Arithmetic shift to the left
      ; Therefore it does the shifts but it preserves the sign bit for us
      ; Same effect as SHL (logical left shift), but conceptually used for signed numbers.

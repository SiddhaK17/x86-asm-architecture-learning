# 🧮 Passing Data to Functions on the Stack – x86 Assembly

This program demonstrates how to **pass arguments to a function using the stack** and access them using **frame pointers (EBP)** in **x86 32-bit Assembly (NASM)**. It follows the standard calling convention and clearly illustrates how the stack behaves during a function call.

---

## 📌 Objective

✔️ Understand how arguments are pushed to the stack  
✔️ Set up a stack frame using `EBP`  
✔️ Access parameters using `[EBP+8]`, `[EBP+12]`  
✔️ Clean up stack and return control properly  
✔️ Visualize ESP/EBP and stack transitions

---

## 🧮 Flow of Execution

1. `main` pushes arguments: `PUSH 4`, `PUSH 1`
2. `CALL addTwo` pushes return address
3. `addTwo` sets up its own stack frame
4. After computation, restores frame and returns
5. Result is stored in `EBX`

---

## ⚙️ Functionality Overview

- Manually pushes two integer arguments onto the stack.
- Calls a function (`addTwo`) that:
  - Creates a new stack frame.
  - Retrieves arguments using offsets from `EBP`.
  - Returns the result via `EAX`.
- Result is passed to `EBX` and program exits using Linux syscall.

---

## 📦 Code Structure

```
section .text
global main

addTwo:
    push ebp              ; Save base pointer of main
    mov ebp, esp          ; Set new base pointer
    mov eax, [ebp+8]      ; First argument (1)
    add eax, [ebp+12]     ; Second argument (4)
    pop ebp               ; Restore previous base pointer
    ret                   ; Return to main

main:
    push 4                ; Push second argument
    push 1                ; Push first argument
    call addTwo           ; Call function
    add esp, 8            ; Clean up arguments from the stack
    mov ebx, eax          ; Store result in ebx
    mov eax, 1            ; syscall: exit
    int 0x80              ; make syscall
```

---

# 🧠 x86 Stack Frame Visualization – `addTwo` Function

---

## 🧱 Stack Representation (Before `CALL addTwo`)

ESP →
┌────────────┐
│ arg1 = 1   │ ← ESP (after PUSH 1)
├────────────┤
│ arg2 = 4   │
├────────────┤

---

## 🧱 Stack After `CALL addTwo` (Inside `addTwo`)

ESP →
┌────────────┐
│ Old EBP    │ ← Saved base pointer from main
├────────────┤
│ Return 🢀   │ ← Address to return to after RET [EBP+4]
├────────────┤
│ arg1 = 1   │ ← [EBP+8]
├────────────┤
│ arg2 = 4   │ ← [EBP+12]
├────────────┤

---

### 📌 Stack Frame Details:

- **EBP** → Points to **Old EBP**
- **ESP** → Points to top of stack (changes as needed)
- Function accesses arguments using `[EBP + offset]`

---

## 🛠️ Function Stack Frame Breakdown

```
addTwo:
    push ebp              ; Save caller's EBP
    mov ebp, esp          ; Establish new frame pointer
    mov eax, [ebp+8]      ; Load first argument into EAX
    add eax, [ebp+12]     ; Add second argument
    pop ebp               ; Restore previous EBP
    ret                   ; Return to caller
```

---

## 🔁 Return Flow

- `RET` pops the return address from the stack.

- Execution resumes in `main` after the `CALL`.

```
mov ebx, eax  ; Store result for syscall exit
```

---

## 🧾 Final Notes

- **ESP** → Points to the top of the stack (last pushed item).

- **EBP** → Provides a stable frame to access function arguments.

- Adheres to the standard **cdecl calling convention**.

---

## ✅ Output

The program will return an **exit status of 5** (`1 + 4`), stored in **EBX** and passed to the exit syscall.

---
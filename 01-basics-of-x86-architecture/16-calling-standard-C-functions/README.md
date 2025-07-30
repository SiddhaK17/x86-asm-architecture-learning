# 🧵 NASM: Calling C Library Functions (printf, exit)

This program demonstrates how to write a NASM x86 (32-bit) assembly program that calls standard C library functions like `printf` and `exit` using the **CDECL calling convention**.

---

## 📌 Objective

To use external functions from the C standard library (`libc`) inside NASM by:

- Linking external functions like `printf` and `exit`
- Passing null terminated strings using the stack
- Respecting CDECL calling convention (caller cleans the stack)
- Demonstrating a clean exit with a return code

---

## 🗝️ Key Concepts

### 🧩 CDECL Calling Convention
- **Definition**: A standard calling convention used in C for x86 platforms.
- **Behavior**:
  - Function arguments are pushed onto the stack **right to left**.
  - The **caller** is responsible for cleaning up the stack after the function call.
- **Why It Matters**: NASM must follow this convention when calling C functions like `printf` and `exit`, or it will lead to unexpected behavior or crashes.

---

### 📡 External Symbol Linking (Extern Declarations)
- **`extern printf`, `extern exit`**: These directives tell NASM that these functions are not defined in the current file but will be resolved at link time from the standard C library (`libc`).
- **Linker Role**: During the GCC compilation, the linker connects these external symbols to their actual addresses in `libc`.

---

### 🧵 Null Terminated Format Strings
- **`DB "Output is: %s %s", 10, 0`**: This defines a format string ending with a null terminator (`0`), which is required by `printf` to determine where the string ends.
- **Importance**: Without null termination, `printf` may access unintended memory, leading to crashes or garbage output.

---

### 🧮 Manual Stack Cleanup
- **`ADD ESP, 12`**: After calling `printf`, we remove the three 4-byte arguments (3 × 4 = 12) from the stack.
- **Why?**: In the CDECL convention, **the caller** must restore the stack pointer (`ESP`) after the call. Failing to do so causes stack imbalance.

---

### 📌 Data vs Text Segments
- **`.data` section**: Used for storing initialized data such as strings and format specifiers.
- **`.text` section**: Contains executable instructions like function calls and arithmetic operations.
- **Separation of concerns**: Keeping data and code separate is essential in assembly to maintain program structure and memory layout.

---

### 🧠 Low-Level to High-Level Bridging
- This program demonstrates how **low level assembly code** can interface seamlessly with **high level C functions**, combining performance control with the convenience of C libraries.

---

### 📤 Exit Status Handling
- **`exit(10)`**: The `exit` function is called with a status code (`10`), which can be retrieved by the shell using `echo $?`.
- **Use Case**: Useful for signaling the outcome of a program to the OS or calling scripts.

---
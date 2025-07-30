# 🧵 NASM: Calling C Library Functions (printf, exit)

This program demonstrates how to write a NASM x86 (32 bit) assembly program that calls standard C library functions like `printf` and `exit` using the **CDECL calling convention**.

---

## 📌 Objective

To use external functions from the C standard library (`libc`) inside NASM by:

- Linking external functions like `printf` and `exit`
- Passing null terminated strings using the stack
- Respecting CDECL calling convention (caller cleans the stack)
- Demonstrating a clean exit with a return code

---
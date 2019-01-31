;Author Name: Lewis Lam
;Program Title: Integer IO
;Files In This Program: integerIO.asm, integerIO.c, integerIO.sh
;Course Number: CPSC240
;Assignment Number: 1
;Required Delivery Date: Feb 4, 2019 Before 11:59 PM
;Purpose: Learn how to embed C library function calls in an X86 module.
;Language of this module: X86 with intel syntax
;Compile this module:

extern printf
extern scanf

global _integerIO

segment .data

stringformat db "%s", 0

prompt1 db "Please enter the first integer: ", 0
prompt2 db "Please enter the second integer: ", 0
product db "The product of these two integers is: %lf", 10, 0
quotient db "The quotient if the first divided by the second is %lf with a remainder of %0.10lf", 10, 0
remainder db "The assembly function will now return the remainder to the driver", 10, 0

segment .bss

segment .text

_integerIO:

push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rsi
push rdi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

mov rax, 0
mov rdi, stringformat
mov rsi, prompt1
call printf

push qword 0
mov qword rax, 0
mov rdi, "%lf"
mov rsi, rsp
call scanf
mov r13, [rsp]
pop rax

mov rax, 0
mov rdi, stringformat
mov rsi, prompt2
call printf

push qword 0
mov qword rax, 0
mov rdi, "%lf"
mov rsi, rsp
call scanf
mov r14, [rsp]
pop rax

mov rax, r13
imul r13, r14
push r13
mov rax, 0
mov rdi, stringformat
mov rsi, product
call printf

idiv r14
push rax
mov rax, 0
mov rdi, stringformat
mov rsi, quotient
call printf

mov rax, 0
mov rdi, stringformat
mov rsi, remainder
call printf

popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rdi
pop rsi
pop rdx
pop rcx
pop rbx
pop rbp

ret

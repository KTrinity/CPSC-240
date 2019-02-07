;Author name: Lewis Lam
;Program name: End of Transmission
;Names of files in this programming: EoTDriver.cpp, EoT.asm, EoTRun.sh
;Course number: CPSC 240
;Assignment Number: 2
;Scheduled delivery date: February 18, 2019
;Status: In Progress
;Date of last modification: Feb 7, 2019

;Information about this module:
;This module purpose: Assembler for computing sum of user inputs
;File name of this module: EoTDriver.asm
;Compile this module: nasm -f elf64 -l EoT.lis -o EoT.o EoT.asm
;Link this module with other objects: g++ -m64 -std=c++99 -o EoT.out EoTDriver.o EoT.o
;Execute: ./EoT.out

extern printf
extern scanf

global EoT

segment .data

stringformat db "%s", 0

eight_byte_format db "%ld", 0

welcome db "The fast accumulator program written in X86 Intel language has begun.", 10, 0

instruction db "Instructions: Enter a sequence of integers. Include white space between each number. ", 10, 0

exitInstruction db "To terminate press 'Enter' followed by Control+D.", 10, 0

numberPrompt db "Enter an integer: %ld", 10, 0

result db "Thank you. You entered %ld numbers with a sum equal to %ld", 10, 0

exit db "The X86 function will now return the sum to the caller program. Bye."

segment .bss

segment .text

EoT:

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

mov qword rax, 0
mov rdi, stringformat
mov rsi, welcome
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, instruction
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, exitInstruction
call printf

mov r15, 0
mov r14, 0
mov r13, 0

startloop:
cmp r14, -1
je done
mov qword rax, 0
mov rdi, stringformat
mov rsi, numberPrompt
call printf

mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, r14
call scanf
mov r14, [rsp]

inc r15
add r13, r14
jmp startloop
done:

mov qword rax, 0
mov rdi, result
mov rsi, r15
mov rdx, r13
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, exit
call printf

mov rax, r13

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

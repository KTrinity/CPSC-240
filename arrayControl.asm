;Author Name: Lewis Lam
;Program Name: Arrays
;Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
;Course Number: CPSC 240
;Assignment Number: 3
;Scheduled delivery date: March 7, 2019
;Status: In Progress
;Date of last modification: Feb 14, 2019

;Information about this module:
;This module's purpose: Control module for Arrays
;File name of this module: arrayControl.asm
;Compile this module: nasm -f elf64 -l array.lis -o arrayControl.o arrayControl.asm
;Link this module with other objects:
;Execute: ./array.out

extern printf

extern scanf

extern display

global array

segment .savedata

welcome db "The control module has begun", 10, 0

instruction db "Instructions: Enter a sequence of integers. Include the white space between each number.", 10, 0

exitInstruction db "To terminate, press 'Enter' followed by Control + D.", 10, 0

dataReceived db "Here are the data as received:", 10 ,0

mean db "The total of these %ld numbers is %ld and the mean is %lf", 10, 0

square db "Here are the squares of the data: ", 10, 0

exit db "The control module is now returning to the caller module. Bye.", 10, 0

stringformat db "%s", 0

integerformat db "%ld", 0

eight_byte_format db "%lf", 0

segment .bss

myArray resq 100

segment .text

array:

push rbp
mov rbp, rsp

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

mov qword rax, 0
mov rdi, integerformat
mov rsi, rsp
call scanf

cdq
shl rdx, 32
or rax, rdx
cmp rax, -1
je done

mov r14, [rsp]

mov [myArray + r15 * 8], r14

inc r15
add r13, r14
jmp startloop

done:

mov qword rax, 0
mov rdi, stringformat
mov rsi, dataReceived
call printf

mov rdi, myArray
mov rsi, r15
call display

mov qword rax, 0
mov rdi, stringformat
mov rsi, mean
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, square
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, exit
call printf

mov rax, r15

pop rbp

ret

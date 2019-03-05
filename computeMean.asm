;Author Name: Lewis Lam
;Program Name: Arrays
;Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
;Course Number: CPSC 240
;Assignment Number: 3
;Scheduled delivery date: March 7, 2019
;Status: In Progress
;Date of last modification: Feb 14, 2019

;Information about this module:
;This module's purpose: Module computes mean for Arrays
;File name of this module: computeMean.asm
;Compile this module: nasm -f elf64 -l computeMean.lis -o computeMean.o computeMean.asm
;Link this module with other objects: g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o square.o -fno-pie -no-pie
;Execute: ./array.out

extern printf

global computeMean

segment .data
string_format db "%s", 0

eight_byte_format db "%lf", 0

integer_format db "%ld", 0

segment .bss

segment .text

computeMean:

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

mov r15, rsi
mov r14, rdi
mov r13, 0
mov r12, 0

startloop:
add r12, [r14 + r13 * 8]

cmp r13, r15
je done

inc r13
jmp startloop

done:

cvtsi2sd xmm3, r12
cvtsi2sd xmm4, r15
divsd xmm3, xmm4
movsd xmm0, xmm3

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

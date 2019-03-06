;****************************************************************************************************************************
;Author Name: Lewis Lam
;Program Name: Arrays
;Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
;Course Number: CPSC 240
;Assignment Number: 3
;Scheduled delivery date: March 7, 2019
;Status: Complete
;Date of last modification: March 5, 2019

;Information about this module:
;This module's purpose: Module computes mean for Arrays
;File name of this module: computeMean.asm
;Compile this module: nasm -f elf64 -l computeMean.lis -o computeMean.o computeMean.asm
;Link this module with other objects: g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o square.o -fno-pie -no-pie
;Execute: ./array.out
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing the standard output device

global computeMean                                                  ;Enable this program to be called from outside this file

segment .data                                                       ;Place initialized data here

;===== Declare some messages ======================================================================================================

string_format db "%s", 0                                            ;general string format

eight_byte_format db "%lf", 0                                       ;general 8-byte float format

integer_format db "%ld", 0                                          ;general 8-byte integer format

segment .bss

;This segment is empty

;==================================================================================================================================
;===== Begin the application here: show how to accumulate user inputs =============================================================
;==================================================================================================================================

segment .text                                                       ;Place executalbe intructions in this segment

computeMean:                                                        ;Entry point, execution begins here

push rbp                                                            ;Save a copy of the stack base pointer
mov rbp, rsp                                                        ;We do this in order to be 100% compatible with C and C++
push rbx                                                            ;Backup rbx
push rcx                                                            ;Backup rcx
push rdx                                                            ;Backup rdx
push rsi                                                            ;Backup rsi
push rdi                                                            ;Backup rdi
push r8                                                             ;Backup r8
push r9                                                             ;Backup r9
push r10                                                            ;Backup r10
push r11                                                            ;Backup r11
push r12                                                            ;Backup r12
push r13                                                            ;Backup r13
push r15                                                            ;Backup r14
push r14                                                            ;Backup r15
pushf                                                               ;Backup rflags

mov r15, rsi                                                        ;Copies counter from array in control to a safer register
mov r14, rdi                                                        ;Copies array from array in control to a safer register
mov r13, 0                                                          ;Set the new counter to 0
mov r12, 0                                                          ;Set the sum to 0

startloop:                                                          ;Marks the start of the loop
add r12, [r14 + r13 * 8]                                            ;Adds the elements of the array to the sum

cmp r13, r15                                                        ;Compares the local counter with the number of elements in the array
je done                                                             ;If r13 == r15, exit the loop

inc r13                                                             ;Increment the counter
jmp startloop                                                       ;Jump the start of the loop

done:                                                               ;Marks the end of the loop

cvtsi2sd xmm3, r12                                                  ;Converts the sum to a double from an integer to xmm3
cvtsi2sd xmm4, r15                                                  ;Converts the counter to a double from an integer to xmm4
divsd xmm3, xmm4                                                    ;Divide scalar double xmm3 by xmm4
movsd xmm0, xmm3                                                    ;Copies the mean to xmm0 to be returned to control

popf                                                                ;Restore rflags
pop r15                                                             ;Restore r15
pop r14                                                             ;Restore r14
pop r13                                                             ;Restore r13
pop r12                                                             ;Restore r12
pop r11                                                             ;Restore r11
pop r10                                                             ;Restore r10
pop r9                                                              ;Restore r9
pop r8                                                              ;Restore r8
pop rdi                                                             ;Restore rdi
pop rsi                                                             ;Restore rsi
pop rdx                                                             ;Restore rdx
pop rcx                                                             ;Restore rcx
pop rbx                                                             ;Restore rbx

;===== Restore the pointer to the start of the stack frame before exiting from this function =======================================

pop rbp                                                             ;Now the system stack is in the same state it was when this
                                                                    ;function began execution.

ret                                                                 ;Pop a qword from stack into rip and continue executing..
;========== End of program computeMean.asm =========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

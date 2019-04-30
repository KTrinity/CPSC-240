;****************************************************************************************************************************
;Author Name: Lewis Lam
;Program Name: Electric Circuit Processing
;Names of files in this program: ecpDriver.cpp, ecpControl.asm, ecpRun.sh
;Course Number: CPSC 240
;Assignment Number: 5
;Scheduled delivery date: April 23, 2019
;Status: Incomplete
;Date of last modification: April 29, 2019

;Information about this module:
;This module's purpose: Control module for ECP program
;File name of this module: ecpControl.asm
;Compile this module: nasm -f elf64 -l array.lis -o ecpControl.o ecpControl.asm
;Link this module with other objects: g++ -m64 -std=c++98 -o ecp.out ecpControl.o ecpDriver.o -fno-pie -no-pie
;Execute: ./ecp.out

;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing to standard output device

extern scanf                                                        ;External C++ function for reading from the standard input device

global ecp                                                          ;Enable this program to be called from outside this file

segment .data                                                       ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================

welcome db "This program will compute the resistance of a circuit configured with parallel sub-circuits.", 10, 0

instruction db "Enter the resistance of a circuit: ", 0

totalSubs db "Thank you. The number of sub-circuits is %d.", 10, 0

totalResistance db "The total resistance in this system is R = %lf Ω", 10, 0

exit db "Thank you for using ECP. The total resistance will now be returned to the driver program.", 10, 0

newline db "", 10, 0

stringformat db "%s", 0                                             ;general string format

integerformat db "%ld", 0                                           ;general 8-byte integer format

eight_byte_format db "%lf", 0                                       ;general 8-byte float format

zero dq 0.0

one dq 1.0

segment .bss                                                        ;Place uninitialized data here

;===== Begin executable instructions here =================================================================================================================================

segment .text                                                       ;Place executable instructions in this segment

ecp:

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
push r14                                                            ;Backup r14
push r15                                                            ;Backup r15
pushf                                                               ;Backup rflags

;==========================================================================================================================================================================
startapplication: ;===== Begin the application here: demonstrate clock module =============================================================================================
;==========================================================================================================================================================================

;=========== Show the initial message =====================================================================================================================================

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, welcome                                                    ;"This program will compute the resistance of a circuit configured with parallel sub-circuits."
call printf                                                         ;Call a library function to make the output

movsd xmm15, [zero]
movsd xmm14, [one]
movss xmm13, [zero]
mov r15, 0

startloop:

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, instruction                                                ;"Enter the resistance of a circuit: "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, eight_byte_format                                          ;"%lf"
mov rsi, rsp                                                        ;Give scanf a pointer to the reserved storage
call scanf                                                          ;Call a library function to do the input work

cdq                                                                 ;Place into rdx sign-extension of that 32-bit number
shl rdx, 32                                                         ;Shift the sign extension 32 bits to the left
or rax, rdx                                                         ;Perfrom the operation rax = rax or rdx
cmp rax, -1                                                         ;Compare rax with -1
je done                                                             ;If rax == -1 then exit from the loop

movsd xmm15, [rsp]

inc r15
divsd xmm14, xmm15
addsd xmm13, xmm14
movsd xmm14, [one]

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, newline                                                    ;""
call printf   

jmp startloop

done:

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, newline                                                    ;""
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, totalSubs                                                  ;"Thank you. The number of sub-circuits is %d."
mov rsi, r15                                                        ;Holds total number of sub-circuits
call printf                                                         ;Call a library function to make the output

divsd xmm14, xmm13
movsd xmm0, xmm14

mov qword rax, 1                                                    ;One value from xmm0 will be printed
mov rdi, totalResistance                                            ;"The total resistance in this system is R = %lf Ω"
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exit                                                       ;"The clock function will now return the time to the caller."
call printf                                                         ;Call a library function to make the output

movsd xmm0, xmm14                                                   ;Copies total resistance to be returned to the caller.

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
;========== End of program clockControl.asm =========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

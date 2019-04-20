;****************************************************************************************************************************
;Author Name: Lewis Lam
;Program Name: Clock
;Names of files in this program: clockDriver.cpp, clockControl.asm, clockRun.sh
;Course Number: CPSC 240
;Assignment Number: 4
;Scheduled delivery date: April 23, 2019
;Status: Complete
;Date of last modification: April 9, 2019 (Was Working on Start Loop)

;Information about this module:
;This module's purpose: Control module for Clock program
;File name of this module: clockControl.asm
;Compile this module: nasm -f elf64 -l array.lis -o clockControl.o clockControl.asm
;Link this module with other objects: g++ -m64 -std=c++98 -o clock.out clockControl.o clockDriver.o -fno-pie -no-pie
;Execute: ./clock.out

;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing to standard output device

extern scanf                                                        ;External C++ function for reading from the standard input device

global clock                                                        ;Enable this program to be called from outside this file

segment .data                                                       ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================

welcome db "The clock module has started and the time is %ld tics.", 10, 0

instruction db "Please enter the number of desired iterations: ", 0

prompt db "Thank you. The iterations will be from 1 through the number inputted.", 10, 0

iteration db "Iteration number: %ld           Sqrt: %lf", 10, 0

totalTime db "Total time for computing square roots: %ld tics = %lf seconds.", 10, 0

exit db "The clock function will now return the time to the caller.", 10, 0

stringformat db "%s", 0                                             ;general string format

integerformat db "%ld", 0                                           ;general 8-byte integer format

eight_byte_format db "%lf", 0                                       ;general 8-byte float format

segment .bss                                                        ;Place uninitialized data here

myArray resq 100                                                    ;Create an array for backup storage having 100 quad words

;===== Begin executable instructions here =================================================================================================================================

segment .text                                                       ;Place executable instructions in this segment

clock:

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
mov rax, 0                                                          ;Sets rax to 0
mov rdx, 0                                                          ;Sets rdx to 0
cpuid                                                               ;Pauses all processes
rdtsc                                                               ;Copies the counter into edx:eax
shl rdx, 32                                                         ;edx:eax holds the # of tics
or rax, rdx                                                         ;rax holds the # of tics since computer powered on
mov r15, rax                                                        ;Copy # of tics to safer register

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, welcome                                                    ;"The clock module has started and the time is %ld tics."
mov rdx, r15                                                        ;Copies the start time to rdx
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, instruction                                                ;"Please enter the number of desired iterations: "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, integerformat                                              ;"%ld"
mov rsi, rsp                                                        ;Give scanf a pointer to the reserved storage
call scanf                                                          ;Call a library function to do the input work

mov r15, [rsp]                                                      ;Total number of iterations held in a safer register

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, prompt                                                     ;"Thank you. The iterations will be from 1 through the number inputted."
call printf                                                         ;Call a library function to make the output

startloop:
mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, iteration                                                  ;"Iteration number: %ld           Sqrt: %lf"
call printf                                                         ;Call a library function to make the output

done:

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, totalTime                                                  ;"Total time for computing square roots: %ld tics = %lf seconds."
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exit                                                       ;"The clock function will now return the time to the caller."
call printf                                                         ;Call a library function to make the output

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

global clockMod                                                        ;Enable this program to be called from outside this file

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

clockMod:

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
mov rdi, welcome                                                    ;"The clock module has started and the time is %ld tics."
mov rsi, r15                                                        ;Copies the start time to rdx
call printf                                                         ;Call a library function to make the output

cvtsi2sd xmm5, r15                                                  ;Convert the start time to a double in xmm5 for safe keeping

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, instruction                                                ;"Please enter the number of desired iterations: "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, integerformat                                              ;"%ld"
mov rsi, rsp                                                        ;Give scanf a pointer to the reserved storage
call scanf                                                          ;Call a library function to do the input work

mov r15, [rsp]                                                      ;Total number of iterations held in a safer register
mov r14, 10                                                         ;Constant number to divide by

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, prompt                                                     ;"Thank you. The iterations will be from 1 through the number inputted."
call printf                                                         ;Call a library function to make the output

mov r13, 1                                                          ;r13 is a counter
mov r12, 1                                                          ;r12 is the temporary iteration number

cmp r15, 10                                                         ;Checks if number of iterations is 10
jl shortloop                                                        ;If r15 < 10, jump to shortloop

mov rax, r15                                                        ;copy first input number to rax
push r15                                                            ;Pushes r15 into stack for safekeeping
cqo                                                                 ;convert quad word to octal word and extend rdi:rax
idiv r14                                                            ;divide first input number by the constant 10;
mov r15, rax                                                        ;copy the quotient to r15
mov r14, rdx                                                        ;copy the remainder to r14

startloop:                                                          ;Beginning of startloop

cmp r13, 10                                                         ;Check if counter equals 10
jg done                                                             ;Jump to done if r13 == 10

mov rax, r15                                                        ;Copies r15 to rax
imul r13                                                            ;Multiplies quotient by counter
mov r12, rax                                                        ;Moves product to r12 (temporary iteration number)

push qword rax                                                      ;Push 8 bytes to realign stack

cvtsi2sd xmm15, r12                                                 ;Converts r12 to scalar double in xmm15
sqrtsd xmm0, xmm15                                                  ;Square roots xmm10 and places value in xmm15

mov qword rax, 1                                                    ;One value from xmm0 will be printed
mov rdi, iteration                                                  ;"Iteration number: %ld           Sqrt: %lf"
mov rsi, r12                                                        ;Temporary iteration number
call printf                                                         ;Call a library function to make the output

pop qword rax                                                       ;Pop 8 bytes to realign stack

inc r13                                                             ;Increment counter

jmp startloop                                                       ;Jump to startloop

shortloop:                                                          ;Beginning of shortloop
cmp r13, r15                                                        ;Compares counter to total iteration number
jg nomore                                                           ;Jump to nomore if counter > total iteration number

cvtsi2sd xmm15, r13                                                 ;Converts r13 to scalar double in xmm15
sqrtsd xmm0, xmm15                                                  ;Square roots xmm10 and places value in xmm15

mov qword rax, 1                                                    ;One value from xmm0 will be printed
mov rdi, iteration                                                  ;"Iteration number: %ld           Sqrt: %lf"
mov rsi, r13                                                        ;Temporary iteration number
call printf                                                         ;Call a library function to make the output

inc r13                                                             ;Increment counter

jmp shortloop                                                       ;Jump to shortloop

done:                                                               ;Beginning of done
pop r15                                                             ;Pop r15 which should hold the total number of iterations
mov r15, [rsp]                                                      ;Copy r15 to the stack pointer which should be the total number of iterations
cmp r12, r15                                                        ;Compares temporary iteration number to total iteration number
je nomore                                                           ;If r12 == r15, jump to nomore

add r12, r14                                                        ;Add remainder to temporary iteration number (should equal total by doing this)

cvtsi2sd xmm15, r12                                                 ;Converts r12 to scalar double in xmm10
sqrtsd xmm0, xmm15                                                  ;Square roots xmm10 and places value in xmm10

mov qword rax, 1                                                    ;No data from SSE will be printed
mov rdi, iteration                                                  ;"Iteration number: %ld           Sqrt: %lf"
mov rsi, r12                                                        ;Temporary iteration number
call printf                                                         ;Call a library function to make the output

nomore:                                                             ;Beginning of nomore
cvtsd2si r15, xmm5                                                  ;Converts xmm5 (holds start time) back to an integer at r15
mov rax, 0                                                          ;Sets rax to 0
mov rdx, 0                                                          ;Sets rdx to 0
cpuid                                                               ;Pauses all processes
rdtsc                                                               ;Copies the counter into edx:eax
shl rdx, 32                                                         ;edx:eax holds the # of tics
or rax, rdx                                                         ;rax holds the # of tics since computer powered on
mov r14, rax                                                        ;Copy # of tics to safer register
sub r14, r15                                                        ;Subtract end time by start time to get duration (held in r14)
mov r13, 3000000000                                                 ;Copy speed of computer (3.0 GHz) to r13

cvtsi2sd xmm3, r14                                                  ;Converts duration to double in xmm3
cvtsi2sd xmm4, r13                                                  ;Converts speed of computer to double in xmm4
divsd xmm3, xmm4                                                    ;Divides duration by speed to get seconds
movsd xmm15, xmm3                                                   ;Copies seconds to xmm15 for safekeeping
movsd xmm0, xmm3                                                    ;Copies seconds to xmm0 for printing in next line

mov qword rax, 1                                                    ;One value from xmm0 will be printed
mov rdi, totalTime                                                  ;"Total time for computing square roots: %ld tics = %lf seconds."
mov rsi, r14                                                        ;Holds the duration in tics
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exit                                                       ;"The clock function will now return the time to the caller."
call printf                                                         ;Call a library function to make the output


movsd xmm0, xmm15                                                   ;Copies duration in seconds to be returned to the caller

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

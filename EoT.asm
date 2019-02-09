;****************************************************************************************************************************
;Author name: Lewis Lam                                                                                                     *
;Program name: End of Transmission                                                                                          *
;Names of files in this programming: EoTDriver.cpp, EoT.asm, EoTRun.sh                                                      *
;Course number: CPSC 240                                                                                                    *
;Assignment Number: 2                                                                                                       *
;Scheduled delivery date: February 18, 2019                                                                                 *
;Status: In Progress                                                                                                        *
;Date of last modification: Feb 7, 2019                                                                                     *
;                                                                                                                           *
;Information about this module:                                                                                             *
;This module purpose: Assembler for computing sum of user inputs                                                            *
;File name of this module: EoTDriver.asm                                                                                    *
;Compile this module: nasm -f elf64 -l EoT.lis -o EoT.o EoT.asm                                                             *
;Link this module with other objects: g++ -m64 -std=c++99 -o EoT.out EoTDriver.o EoT.o                                      *
;Execute: ./EoT.out                                                                                                         *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing to standard output device

extern scanf                                                        ;External C++ function fro reading from the standard input device

global EoT                                                          ;Enable this program to be called from outside this file

segment .data                                                       ;Place initialized data here

;===== Declare some messages ======================================================================================================

welcome db "The fast accumulator program written in X86 Intel language has begun.", 10, 0

instruction db "Instructions: Enter a sequence of integers. Include white space between each number. ", 10, 0

exitInstruction db "To terminate press 'Enter' followed by Control+D.", 10, 0

numberPrompt db "Enter an integer: ", 0

result db "Thank you. You entered %ld numbers with a sum equal to %ld", 10, 0

exit db "The X86 function will now return the sum to the caller program. Bye.", 10, 0

stringformat db "%s", 0                                             ;general string format

eight_byte_format db "%ld", 0                                       ;genereal 8-byte integer format

segment .bss                                                        ;Declare pointers to un-initialized space in this segment.

;This segment is empty.

;==================================================================================================================================
;===== Begin the application here: show how to accumulate user inputs =============================================================
;==================================================================================================================================

segment .text                                                       ;Place executable instructions in this segment.

EoT:                                                                ;Entry point. Execution begins here.

push rbp                                                            ;This marks the start of a new stack frame belonging to this
                                                                    ;execution of this function
mov rbp, rsp                                                        ;rbp holds the address of the start of this new stack frame.
                                                                    ;When this function returns to its caller, rbp must hold the
                                                                    ;same value it holds now.
push rbx                                                            ;Back up rbx
push rcx                                                            ;Back up rcx
push rdx                                                            ;Back up rdx
push rsi                                                            ;Back up rsi
push rdi                                                            ;Back up rdi
push r8                                                             ;Back up r8
push r9                                                             ;Back up r9
push r10                                                            ;Back up r10
push r11                                                            ;Back up r11
push r12                                                            ;Back up r12
push r13                                                            ;Back up r13
push r14                                                            ;Back up r14
push r15                                                            ;Back up r15
pushf                                                               ;Back up rflags

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, welcome                                                    ;"The fast accumulator program written in X86 Intel language.. "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, instruction                                                ;"Instructions: Enter a sequence of integers. Include white.. "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exitInstruction                                            ;"To terminate press 'Enter' followed by Control+D."
call printf                                                         ;Call a library function to make the output

mov r15, 0                                                          ;Set the counter for input numbers to 0
mov r14, 0                                                          ;Set the temporary number holder to 0
mov r13, 0                                                          ;Set the sum to 0

startloop:

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, numberPrompt                                               ;"Enter an integer: "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, eight_byte_format                                          ;"%ld"
mov rsi, rsp                                                        ;Give scanf a pointer to the reserved storage
call scanf                                                          ;Call a library function to do the input work

cdq                                                                 ;Place into rdx sign-extention of that 32-bit number
shl rdx, 32                                                         ;Shift the sign extension 32 bits to the left
or rax, rdx                                                         ;Perform the operation rax = rax or rdx
cmp rax, -1                                                         ;Compare rax with -1
je done                                                             ;If rax == -1 then exit from the loop

mov r14, [rsp]                                                      ;Copy the inputted number into r14

inc r15                                                             ;Increment the total inputs by 1
add r13, r14                                                        ;Add the inputted number to the total sum
jmp startloop                                                       ;Repeat the loop one more time.

done:

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, result                                                     ;"Thank you. You entered %ld numbers with a sum equal to %ld"
mov rsi, r15                                                        ;Copy the number of inputs from r15
mov rdx, r13                                                        ;Copy the sum from r13
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;no data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exit                                                       ;"The X86 function will now return the sum to the caller.. "
call printf                                                         ;Call a library function to make the output

mov rax, r13                                                        ;Copy the sum into rax to be sent to the driver

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
pop rcx                                                             ;Restore rbx
pop rbx                                                             ;Restore rbx

;===== Restore the pointer to the start of the stack frame before exiting from this function ======================================

pop rbp                                                             ;Now the system stack is in the same state it was when this
                                                                    ;function began execution.

ret                                                                 ;Pop a qword from stack into rip and continue executing..
;========== End of program EoT.asm =================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

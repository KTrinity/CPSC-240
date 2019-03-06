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
;This module's purpose: Control module for Arrays
;File name of this module: arrayControl.asm
;Compile this module: nasm -f elf64 -l array.lis -o arrayControl.o arrayControl.asm
;Link this module with other objects: g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o square.o -fno-pie -no-pie
;Execute: ./array.out

;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing to standard output device

extern scanf                                                        ;External C++ function for reading from the standard input device

extern display                                                      ;External C function for displaying input

extern computeMean                                                  ;External ASM function for computing mean of inputs

extern square                                                       ;External C++ function for squaring functions

global array                                                        ;Enable this program to be called from outside this file

segment .data                                                       ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================

welcome db "The control module has begun", 10, 0

instruction db "Instructions: Enter a sequence of integers. Include the white space between each number.", 10, 0

exitInstruction db "To terminate, press 'Enter' followed by Control + D.", 10, 0

dataReceived db "Here are the data as received:", 10 ,0

mean db "The total of these %ld numbers is %ld and the mean is %lf", 10, 0

squareResult db "Here are the squares of the data: ", 10, 0

exit db "The control module is now returning to the caller module. Bye.", 10, 0

stringformat db "%s", 0                                             ;general string format

integerformat db "%ld", 0                                           ;general 8-byte integer format

eight_byte_format db "%lf", 0                                       ;general 8-byte float format

segment .bss                                                        ;Place uninitialized data here

myArray resq 100                                                    ;Create an array for backup storage having 100 quad words

;===== Begin executable instructions here =================================================================================================================================

segment .text                                                       ;Place executable instructions in this segment

array:                                                              ;Entry point, execution begins here

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
startapplication: ;===== Begin the application here: demonstrate floating point i/o =======================================================================================
;==========================================================================================================================================================================

;=========== Show the initial message =====================================================================================================================================

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, welcome                                                    ;"The control module has begun"
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, instruction                                                ;"Instructions: Enter a sequence of integers. Include the white space between each number."
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exitInstruction                                            ;"To terminate, press 'Enter' followed by Control + D."
call printf                                                         ;Call a library function to make the output

mov r15, 0                                                          ;Set the counter for input numbers to 0
mov r14, 0                                                          ;Set the temporary number holder to 0
mov r13, 0                                                          ;Set the sum to 0

startloop:                                                          ;Beginning of loop

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, integerformat                                              ;"%ld"
mov rsi, rsp                                                        ;Give scanf a pointer to the reserved storage
call scanf                                                          ;Call a library function to do the input work

cdq                                                                 ;Place into rdx sign-extension of that 32-bit number
shl rdx, 32                                                         ;Shift the sign extension 32 bits to the left
or rax, rdx                                                         ;Perfrom the operation rax = rax or rdx
cmp rax, -1                                                         ;Compare rax with -1
je done                                                             ;If rax == -1 then exit from the loop

mov r14, [rsp]                                                      ;Copy the inputted number into r14

mov [myArray + r15 * 8], r14                                        ;Place the inputted number into the array

inc r15                                                             ;Increment the total inputs by 1
add r13, r14                                                        ;Add the inputted number to the total sum
jmp startloop                                                       ;Repeat the loop one more time

done:                                                               ;Location when exiting the loop

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, dataReceived                                               ;"Here are the data as received:"
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, myArray                                                    ;Place myArray into rdi
mov rsi, r15                                                        ;Place the counter into rsi
call display                                                        ;Call C function to display inputted numbers

mov rdi, myArray                                                    ;Place myArray into rdi to be used in computeMean
mov rsi, r15                                                        ;Place the counter into rsi to be used in computeMean
call computeMean                                                    ;Call ASM function to compute the mean

movsd xmm15, xmm0                                                   ;Copies double received from computeMean to a safer register

mov qword rax, 1                                                    ;1 double from SSE will be printed
mov rdi, mean                                                       ;"The total of these %ld numbers is %ld and the mean is %lf"
mov rsi, r15                                                        ;Copy the number of inputs to rdi
mov rdx, r13                                                        ;Copy the sum to rdx
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, squareResult                                               ;"Here are the squares of the data: "
call printf                                                         ;Call a library function to make the output

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, myArray                                                    ;Place myArray into rdi
mov rsi, r15                                                        ;Place the counter into rsi
call square                                                         ;Call C++ function to square the inputs and print them

mov qword rax, 0                                                    ;No data from SSE will be printed
mov rdi, stringformat                                               ;"%s"
mov rsi, exit                                                       ;"The control module is now returning to the caller module. Bye."
call printf                                                         ;Call a library function to make the output

movsd xmm0, xmm15                                                   ;Copy double called from computeMean to be retunred to the driver

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
pop rbx
                                                        ;Restore rbx
;===== Restore the pointer to the start of the stack frame before exiting from this function ==============================================================================

pop rbp                                                             ;Now the system stack is in the same state it was when this
                                                                    ;function began execution

ret                                                                 ;Pop a qword from stack into rip and continue executing..
;========== End of program arrayControl.asm ===============================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

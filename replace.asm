;****************************************************************************************************************************
;Author Name: Lewis Lam
;Program Name: Even Only
;March 28, 2019
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

extern printf                                                       ;External C++ function for writing the standard output device

global replace                                                      ;Enable this program to be called from outside this file

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

replace:                                                            ;Entry point, execution begins here

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
mov r12, 2                                                          ;Used for dividing by 2

startloop:                                                          ;Marks the start of the loop
cmp r13, r15
je done

mov rax, [r14 + r13 * 8]                                            ;Place the element in the array in rax
cqo                                                                 ;Used for division
idiv r12                                                            ;Divide the first element by 2
cmp rdx, 1                                                          ;Check to see if remainder is 1 or -1, if so, jump to change
je change
cmp rdx, -1
je change

inc r13                                                             ;Increment the local counter
jmp startloop                                                       ;Jump to start of the loop

change:                                                             ;Marks start of change
mov rax, [r14 + r13 * 8]                                            ;Place element in array in rax
imul rax, r12                                                       ;Multiply odd element by 2
mov [r14 + r13 * 8], rax                                            ;Move new element back into array

inc r13                                                             ;Increment the local counter
jmp startloop                                                       ;Jump to start of the loop

done:                                                               ;Marks the end of the loop

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

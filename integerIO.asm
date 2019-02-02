;Author Name: Lewis Lam
;Program Title: Integer IO
;Files In This Program: integerIO.asm, integerIO.c, integerIO.sh
;Course Number: CPSC240
;Assignment Number: 1
;Required Delivery Date: Feb 4, 2019 Before 11:59 PM
;Purpose: Learn how to embed C library function calls in an X86 module.
;Language of this module: X86 with intel syntax
;Compile this module: nasm -f elf64 -l intIO.lis -o intIO.o integerIO.asm

;===== Begin code area ====================================================================================================================================================

extern printf                                         ;External C function for writing to standard output device
extern scanf                                          ;External C function for reading from the standard input device

global _integerIO                                     ;This makes _integerIO callable by functions outside of this file.

segment .data                                         ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================

stringformat db "%s", 0                               ;general string format

eight_byte_format db "%ld", 0                         ;general 8-byte-long-int format

prompt1 db "Please enter the first integer: ", 0

prompt2 db "Please enter the second integer: ", 0

product db "The product of these two integers is: %ld", 10, 0

quotient db "The quotient of the first divided by the second is %ld", 10, 0

remainder db "The assembly function will now return the remainder to the driver", 10, 0


segment .bss                                          ;Place un-initialized data here.

align 64                                              ;Insure that the next data declaration starts on a 64-byte boundary.
backuparea resb 832                                   ;Create an array for backup storage having 832 bytes.

segment .text                                         ;Place executable instructions in this segment

_integerIO:                                           ;Entry point. Execution begins here.

push rbp                                              ;Save a copy of the stack base pointer
mov rbp, rsp                                          ;We do this in order to be 100% compatible with C and C++
push rbx                                              ;Back up rbx
push rcx                                              ;Back up rcx
push rdx                                              ;Back up rdx
push rsi                                              ;Back up rsi
push rdi                                              ;Back up rdi
push r8                                               ;Back up r8
push r9                                               ;Back up r9
push r10                                              ;Back up r10
push r11                                              ;Back up r11
push r12                                              ;Back up r12
push r13                                              ;Back up r13
push r14                                              ;Back up r14
push r15                                              ;Back up r15
pushf                                                 ;Back up rflags

;=========== Prompt for first integer number ==============================================================================================================================

mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, stringformat                                 ;"%s"
mov rsi, prompt1                                      ;"Please enter the first integer: "
call printf                                           ;call a library function to do the hard work

;=========== Obtain an integer number from the standard input device and store a copy in r8 ===============================================================================

mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, eight_byte_format                            ;"%ld"
mov rsi, rsp                                          ;Give scanf a point to the reserved storage
call scanf                                            ;call a library function to do the input work
mov r8, [rsp]                                         ;copy the inputted number to r8

;=========== Prompt for second integer number =============================================================================================================================

mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, stringformat                                 ;"%s"
mov rsi, prompt2                                      ;"Please enter the second integer: "
call printf                                           ;call a library function to do the hard work

;=========== Obtain an integer number from the standard input device and store a copy in r9 ===============================================================================

mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, eight_byte_format                            ;"%ld"
mov rsi, rsp                                          ;Give scanf a point to the reserved storage
call scanf                                            ;call a library function to do the input work
mov r9, [rsp]                                         ;copy the inputted number to r9

;=========== Multiply the two inputted numbers and prints the product =====================================================================================================

mov rax, r8                                           ;copy first input number to rax
imul r9                                               ;multiply the first input number by the second input number
mov r10, rax                                          ;copy the product to r10
mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, product                                      ;"The quotient of the first divided by the second is %ld"
mov rsi, r10                                          ;moves the product to be inserted into %ld of the string above
call printf                                           ;call a library function to do the hard work

;=========== Divide the two inputted numbers and prints the quotient ======================================================================================================

; divide
mov rax, r8                                           ;copy first input number to rax
cqo                                                   ;convert quad word to octal word and extend rdi:rax
idiv r9                                               ;divide first input number by second input number;
mov r14, rax                                          ;copy the quotient to r14
mov r13, rdx                                          ;copy the remainder to r13
mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, quotient                                     ;"The quotient of the first divided by the second is %ld"
mov rsi, r14                                          ;moves the quotient to be inserted into %ld of the string above
call printf                                           ;call a library function to do the hard work

;=========== Conclusion ===================================================================================================================================================

mov qword rax, 0                                      ;no data from SSE will be printed
mov rdi, stringformat                                 ;"%s"
mov rsi, remainder                                    ;"The assembly function will now return the remainder to the driver"
call printf                                           ;call a library function to do the hard work

;=========== Set the value to be returned to the caller ===================================================================================================================

push r13                                              ;r13 continues to hold the the remainder
movsd xmm0, [rsp]                                     ;The value of the remainder is copied to xmm0[63-0]
pop r13                                               ;Reverse the push from two lines earlier.

;=========== Restore GPR values and return to the caller ==================================================================================================================

popf                                                  ;Restore rflags
pop r15                                               ;Restore r15
pop r14                                               ;Restore r14
pop r13                                               ;Restore r13
pop r12                                               ;Restore r12
pop r11                                               ;Restore r11
pop r10                                               ;Restore r10
pop r9                                                ;Restore r9
pop r8                                                ;Restore r8
pop rdi                                               ;Restore rdi
pop rsi                                               ;Restore rsi
pop rdx                                               ;Restore rdx
pop rcx                                               ;Restore rcx
pop rbx                                               ;Restore rbx
pop rbp                                               ;Restore rbp

ret                                                   ;No parameter with this instruction.  This instruction will pop 8 bytes from
                                                      ;the integer stack, and jump to the address found on the stack.

;========== End of program IntegerIO.asm ==================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7*

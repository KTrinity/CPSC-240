/*
Author Name: Lewis Lam
Program TItle: Integer IO
Files In This Program: integerIO.c, integerIO.asm, integerIO.sh
Course Number: CPSC 240
Assignment Number: 1
Required Delivery Date: Feb 4, 2019 Before 11:59 PM
Purpose: Learn how to embed C library function calls in an X86 module.
Language of this module: C
Compile This Module: gcc -c -m64 -Wall -l intIODriver.lis -o intIODriver.o integerIO.c -fno-pie -no-pie
Link Object Files: gcc
Execute:
*/
#include <stdio.h>

extern double _integerIO();

int main(int argc, const char* argv[]) {

  double remain = -99.99;

  printf("%s", "Welcome to Integer IO\n");
  printf("%s", "This program was created by Lewis Lam\n");
  printf("%s\n", "and completed on Feb 2, 2019");
  remain = _integerIO();
  printf("%s%1.5f\n%s\n", "The driver function has received this number: ", remain,
  ". The driver will now return 0 to the operating system. Have a nice day.");
  return 0;
}

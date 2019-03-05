/*
Author Name: Lewis Lam
Program Name: Arrays
Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
Course Number: CPSC 240
Assignment Number: 3
Scheduled delivery date: March 7, 2019
Status: Complete
Date of last modification: March 5, 2019

Information about this module:
This module's purpose: Module for displaying values for Arrays
File name of this module: display.c
Compile this module: gcc -c -m64 -Wall -l display.lis -o display.o display.c -fno-pie -no-pie
Link this module with other projects: g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o square.o -fno-pie -no-pie
Execute: ./array.out
*/

#include <stdio.h>

void display(long arr[], long size) {
  for(int i = 0; i < size; i = i + 1) {
    printf("%ld\n", arr[i]);
  }
}

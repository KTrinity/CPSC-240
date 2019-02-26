/*
Author Name: Lewis Lam
Program Name: Arrays
Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
Course Number: CPSC 240
Assignment Number: 3
Scheduled delivery date: March 7, 2019
Status: In Progress
Date of last modification: Feb 19, 2019

Information about this module:
This module's purpose: Driver module for Arrays
File name of this module: arrayDriver.cpp
Compile this module: g++ -c -m64 -std=c++98 -o arrayDriver.o arrayDriver.cpp -fno-pie -no-pie
Link this module with other projects: g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o square.o -fno-pie -no-pie
Execute: ./array.out
*/

#include <iostream>

extern "C" float array();

int main(int argc, const char* argv[]) {

  std::cout << "Welcome to an array of long integers\n";
  std::cout << "This program is brought to you by Lewis Lam\n";

  float result = array();

  std::cout << "The driver received this unknown number: " << result << std::endl;
  std::cout << "The driver will now return 0 to the operating system\n";
  return 0;
}

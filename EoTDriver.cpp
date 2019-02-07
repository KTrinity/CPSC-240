/*
Author name: Lewis Lam
Program name: End of Transmission
Names of files in this programming: EoTDriver.cpp, EoT.asm, EoTRun.sh
Course number: CPSC 240
Scheduled delivery date: February 18, 2019
Status: In Progress
Date of last modification: Feb 7, 2019
Information about this module:
This module purpose: Driver for returning the sum of user inputs
File name of this module: EoTDriver.cpp
Compile this module: g++ -c -m64 -std=c++99 -o EoTDriver.o EoT.cpp
Link this module with other objects: g++ -m64 -std=c++99 -o EoT.out EoTDriver.o EoT.o
*/

#include <iostream>

extern int EoT();

int main(int argc, const char* argv[]) {
  int result = -99;
  
  std::cout << "Welcome to summing a sequence of integers. \n";
  std::cout << "This program is brought to you by Lewis Lam. \n";

  result = EoT();

  std::cout << "This main program received this number: " << result << ".\n";
  std::cout << "Main will return 0 to the operating system. Have a nice day.\n";

  return 0;
}

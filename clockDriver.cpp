/*
Author Name: Lewis Lam
Program Name: Clock
Names of files in this program: clockDriver.cpp, clockControl.asm, clockRun.sh
Course Number: CPSC 240
Assignment Number: 4
Scheduled delivery date: April 23, 2019
Status: Complete
Date of last modification: April 19, 2019

Information about this module:
This module's purpose: Driver module for Clock program
File name of this module: clockDriver.cpp
Compile this module: g++ -c -m64 -std=c++98 -o clockDriver.o clockDriver.cpp -fno-pie -no-pie
Link this module with other projects: g++ -m64 -std=c++98 -o clock.out clockControl.o clockDriver.o -fno-pie -no-pie
Execute: ./clock.out
*/

#include <iostream>

extern "C" float clock();

int main(int argc, const char* argv[]) {
  std::cout << "Welcome to Clock created by Lewis Lam.\n"
  std::cout << "The main program will now call the clock module.\n"

  double result = clock();

  std::cout << "The clock main program received this number " << result << std::endl;
  std::cout << "Have a nice day. Bye.\n";
  return 0;
}

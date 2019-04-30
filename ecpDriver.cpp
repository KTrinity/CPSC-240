/*
Author Name: Lewis Lam
Program Name: Electric Circuit Processing
Names of files in this program: ecpDriver.cpp, ecpControl.asm, ecpRun.sh
Course Number: CPSC 240
Assignment Number: 5
Scheduled delivery date: April 23, 2019
Status: Incomplete
Date of last modification: April 29, 2019

Information about this module:
This module's purpose: Driver module for ECP program
File name of this module: clockDriver.cpp
Compile this module: g++ -c -m64 -std=c++98 -o ecpDriver.o ecpDriver.cpp -fno-pie -no-pie
Link this module with other projects: g++ -m64 -std=c++98 -o ecp.out ecpControl.o ecpDriver.o -fno-pie -no-pie
Execute: ./ecp.out
*/

#include <iostream>

extern "C" double ecp();

int main(int argc, const char* argv[]) {
  std::cout << "Welcome to Electric Circuit Processing (ECP) by Lewis Lam.\n";

  double result = ecp();

  std::cout << "The driver received this number " << result << "." << std::endl;
  std::cout << "The driver will now return 0 to the operating system. Have a nice day\n";
  return 0;
}

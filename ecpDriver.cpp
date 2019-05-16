/*
Author Name: Lewis Lam
Program Name: Final Exam Part 2
Scheduled delivery date: May 6, 2019

*/

#include <iostream>

extern "C" double ecp();

int main(int argc, const char* argv[]) {
  std::cout << "Welcome to Final Exam Part 2 by Lewis Lam.\n";

  double result = ecp();

  std::cout << "The driver received this number " << result << "." << std::endl;
  std::cout << "The driver will now return 0 to the operating system. Have a nice day\n";
  return 0;
}

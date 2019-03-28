/*
Author Name: Lewis Lam
Program Name: Even Only
March 28, 2019
*/

#include <iostream>

extern "C" long array(); //Allows calling to control file

int main(int argc, const char* argv[]) {

  std::cout << "Welcome to an array of long integers\n";
  std::cout << "This program is brought to you by Lewis Lam\n";

  long result = array(); //Set result to the mean created from the control file

  std::cout << "The driver received this unknown number: " << result << std::endl;
  std::cout << "The driver will now return 0 to the operating system\n";
  return 0;
}

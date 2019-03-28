/*
Author Name: Lewis Lam
Program Name: Even Only
March 28, 2019
*/

#include <iostream>
extern "C" void display(long arr[], long size);

extern "C" void square(long arr[], long size) {
  for(int i = 0; i < size; ++i) {
    arr[i] *= arr[i]; //Squares each element in the array (Doesn't change original array)
  }
  display(arr, size); //Calls display function with new array
}

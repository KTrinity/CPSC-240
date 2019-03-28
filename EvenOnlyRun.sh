#Author Name: Lewis Lam
#Program Name: Even Only
#March 28, 2019
#/bin/bash

rm *.o
rm *.out

echo "This is program <Even Only>"

echo "Compile the C++ module EvenOnlyDriver.cpp"
g++ -c -m64 -std=c++98 -o EvenOnlyDriver.o EvenOnlyDriver.cpp -fno-pie -no-pie

echo "Assemble the module arrayControl.asm"
nasm -f elf64 -l array.lis -o EvenOnlyControl.o EvenOnlyControl.asm

echo "Compile the C module display.c"
gcc -c -m64 -Wall -l display.lis -o display.o display.c -fno-pie -no-pie

echo "Assemble the module computeMean.asm"
nasm -f elf64 -l replace.lis -o replace.o replace.asm

echo "Compile the C++ module square.cpp"
g++ -c -m64 -std=c++98 -o square.o square.cpp -fno-pie -no-pie

echo "Link the five object files already created"
g++ -m64 -std=c++98 -o EvenOnly.out EvenOnlyControl.o EvenOnlyDriver.o display.o replace.o square.o -fno-pie -no-pie

echo "The bash script file is now closing."

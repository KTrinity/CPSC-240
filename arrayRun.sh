#Author Name: Lewis Lam
#Program Name: Arrays
#Names of files in this program: arrayDriver.cpp, arrayControl.asm, computeMean.asm, display.c, square.cpp, arrayRun.sh
#Course Number: CPSC 240
#Assignment Number: 3
#Scheduled delivery date: March 7, 2019
#Status: In Progress
#Date of last modification: Feb 14, 2019

#Information about this module:
#This module purpose: Bash module for Arrays
#File name of this module: arrayRun.sh
#Compile this module: N/A
#Link this module with other objects: N/A
#Execute: ./EoT.out
#/bin/bash

rm *.o
rm *.out

echo "This is program <Passing An Array>"

echo "Compile the C++ module arrayDriver.cpp"
g++ -c -m64 -std=c++98 -o arrayDriver.o arrayDriver.cpp -fno-pie -no-pie

echo "Assemble the module arrayControl.asm"
nasm -f elf64 -l array.lis -o arrayControl.o arrayControl.asm

echo "Compile the C module display.c"
gcc -c -m64 -Wall -l display.lis -o display.o display.c -fno-pie -no-pie

echo "Assemble the module computeMean.asm"
nasm -f elf64 -l computeMean.lis -o computeMean.o computeMean.asm

echo "Compile the C++ module square.cpp"
g++ -c -m64 -std=c++98 -o square.o square.cpp -fno-pie -no-pie

echo "Link the five object files already created"
g++ -m64 -std=c++98 -o array.out arrayControl.o arrayDriver.o display.o computeMean.o square.o -fno-pie -no-pie

echo "The bash script file is now closing."
